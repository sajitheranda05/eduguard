import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/blog/blog_repository.dart';
import 'package:eduguard/src/features/blogs/model/blogmodel.dart';
import 'package:eduguard/src/features/blogs/widget/blog.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBlogController extends GetxController {
  static AddBlogController get instance => Get.find();
  final blogRepository = Get.put(BlogRepository());

  final isLoading = true.obs;
  final RxList<BlogModel> allblogs = <BlogModel>[].obs;

  final RxList<BlogModel> paginatedblogs = <BlogModel>[].obs;
  final int itemsPerPage = 10;
  final RxInt currentPage = 0.obs;

  @override
  void onInit() {
    // Pass the blogId as an argument
    fetchPaginatedBlogs();
    super.onInit();
  }

  final RxString searchQuery = ''.obs;
  // Reactive variables for form fields
  final blogName = ''.obs;
  final bloggerName = ''.obs;
  final blogContent = ''.obs;
  final blogImage = ''.obs;
  final Category = ''.obs;
  // Form key
  final GlobalKey<FormState> blogFormKey = GlobalKey<FormState>();

  // Controllers for each form field
  final TextEditingController blogNameController = TextEditingController();
  final TextEditingController bloggerNameController = TextEditingController();
  final TextEditingController blogContentController = TextEditingController();
  final TextEditingController blogImageController = TextEditingController();
  final TextEditingController CatogaryController = TextEditingController();

  // Method to add a new blog using BlogModel
  Future<void> addBlog() async {
    if (!blogFormKey.currentState!.validate()) {
      return; // If form is not valid, return early
    }

    try {
      isLoading.value = true;

      // Create a BlogModel instance
      final blog = BlogModel(
        ID: '', // Manually Passed ID
        BlogName: blogName.value,
        Blog: blogContent.value,
        BloggerName: bloggerName.value,
        BlogImage: blogImage.value,
        Catogary: Category.value,
      );

      // Save the blog
      await blogRepository.saveBlogRecord(blog.toJson());
      AppSnackBars.successSnackBar(
          title: 'Success', message: 'Blog added successfully!');

      // Clear the form after saving
      clearForm();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Method to update an existing blog
  /* Future<void> updateBlog(BlogModel updatedBlog) async {
    try {
      isLoading.value = true;

      await blogRepository.updateBlogDetails(
          updatedBlog.ID, updatedBlog.toJson());
      Get.snackbar('Success', 'Blog updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }*/

  Future<void> updateBlog(BlogModel updatedBlog) async {
    if (updatedBlog.ID == null || updatedBlog.ID.isEmpty) {
      print('Error: Blog ID is null or empty');
      Get.snackbar('Error', 'Invalid Blog ID');
      return;
    }
    try {
      isLoading.value = true;
      print('Updating blog with ID: ${updatedBlog.ID}');
      print('Blog data: ${updatedBlog.toJson()}');
      await blogRepository.updateBlogDetails(
          updatedBlog.ID, updatedBlog.toJson());
      Get.snackbar('Success', 'Blog updated successfully');
    } catch (e) {
      print('Error during blog update: ${e.toString()}');
      Get.snackbar('Error', 'Failed to update blog: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to delete a blog by blog ID
  Future<void> deleteBlog(String blogId) async {
    try {
      isLoading.value = true;

      await blogRepository.removeBlogDetails(blogId);
      Get.snackbar('Success', 'Blog deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch blog details by ID
  Future<BlogModel> fetchBlogDetails(String blogId) async {
    try {
      final documentSnapshot = await blogRepository.fetchBlogDetails(blogId);
      return BlogModel.fromSnapshot(
          documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return BlogModel.empty();
    }
  }

  // Method to update a single field of the blog
  Future<void> updateSingleField(
      String blogId, Map<String, dynamic> updatedField) async {
    try {
      await blogRepository.updateSingleBlogField(blogId, updatedField);
      // **MODIFICATION: Added success message**
      Get.snackbar('Success', 'Field updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Clear the form fields
  void clearForm() {
    blogFormKey.currentState?.reset();
    blogName.value = '';
    bloggerName.value = '';
    blogContent.value = '';
    blogImage.value = '';
  }

  // Fetch blogs by category
  // Updated the parameter name for better clarity
  Future<void> fetchPaginatedBlogs({String? category}) async {
    try {
      isLoading.value = true;
      final blogs = await blogRepository.getallblogs();

      // **MODIFICATION: Filter blogs based on the selected category**
      if (category != null && category.isNotEmpty) {
        allblogs.assignAll(blogs.where((blog) => blog.Catogary == category));
      } else {
        allblogs.assignAll(blogs); // If no category, show all blogs
      }
      paginateBlogs();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void paginateBlogs() {
    final startIndex = currentPage.value * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    // **MODIFICATION: Handle empty blogs gracefully**
    if (allblogs.isEmpty) {
      paginatedblogs.clear(); // Clear the paginated list if there are no blogs
    } else {
      paginatedblogs.assignAll(allblogs.sublist(
          startIndex, endIndex > allblogs.length ? allblogs.length : endIndex));
    }
  }

  // Navigate to the next page
  void nextPage() {
    if ((currentPage.value + 1) * itemsPerPage < allblogs.length) {
      currentPage.value++;
      paginateBlogs();
    }
  }

  // Navigate to the previous page
  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      paginateBlogs();
    }
  }

  void filterBlogs() {
    if (searchQuery.value.isEmpty) {
      paginateBlogs(); // Show all STDs if search is empty
    } else {
      paginatedblogs.assignAll(allblogs.where((blog) =>
          blog.BlogName.toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          blog.BloggerName.toLowerCase()
              .contains(searchQuery.value.toLowerCase())));
    }
  }

  // Update the search query and filter the list
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterBlogs();
  }

  getBlogById(blog) {}
}
