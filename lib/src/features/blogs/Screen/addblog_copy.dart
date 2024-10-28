import 'package:eduguard/src/features/blogs/controllers/blogcontroller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBlogCopy extends StatelessWidget {
  const AddBlogCopy({super.key});

  @override
  Widget build(BuildContext context) {
    final blogController = Get.put(AddBlogController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Blog'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: blogController.blogFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blog Title
                const Text(
                  'New Blog Post',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),

                // Blog Name Input Field
                TextFormField(
                  controller: blogController.blogNameController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blog Name', value),
                  decoration: const InputDecoration(
                    labelText: 'Blog Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => blogController.blogName.value = value,
                ),
                const SizedBox(height: 12.0),

                // Blogger Name Input Field
                TextFormField(
                  controller: blogController.bloggerNameController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blogger Name', value),
                  decoration: const InputDecoration(
                    labelText: 'Blogger Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      blogController.bloggerName.value = value,
                ),
                const SizedBox(height: 12.0),

                // Blog Content Input Field
                TextFormField(
                  controller: blogController.blogContentController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blog Content', value),
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Blog Content',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      blogController.blogContent.value = value,
                ),
                const SizedBox(height: 12.0),

                // Blog Image URL Input Field
                TextFormField(
                  controller: blogController.blogImageController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blog Image URL', value),
                  decoration: const InputDecoration(
                    labelText: 'Blog Image URL',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => blogController.blogImage.value = value,
                ),
                const SizedBox(height: 24.0),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (blogController.blogFormKey.currentState!.validate()) {
                        blogController
                            .addBlog(); // Passing an empty string for blogID
                      }
                    },
                    child: const Text('Submit Blog'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
