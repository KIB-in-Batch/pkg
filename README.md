# KIB in Batch Packages

This is the official package repository for "[KIB in Batch](https://github.com/Kali-in-Batch/kali-in-batch)".

## Adding a new package

Packages in [`./packages`](./packages) have the following structure:

```bash
package-name/
    INSTALL.sh
    UNINSTALL.sh
    README.md
    LICENSE.txt
    DEPENDENCIES.txt # Every line is a dependency name
    VERSION.txt # Has to be a semantic version (e.g. 2.5.8)
    DESCRIPTION.txt # Optional, kib-pkg info displays the Lorem Ipsum text if not provided
    files/
        # Files the package can access without downloading remote files go here
        # For example, a shell script
        hello-world
        # This however is optional
```

We generously provide a hello-world package, which is structured like what you see above. You can copy that package and transform it into your own package.

If you don't know how to create a pull request, follow these steps:

* [Fork this repository](https://github.com/Kali-in-Batch/pkg/fork).
* Clone the repository to your local machine:

```bash
git clone https://github.com/your-username/pkg.git # Replace your-username with your username
```

* Create a new branch for your package:

```bash
git checkout -b package-name # Replace package-name with your package name
```

* Make your changes. For example:

```bash
cp -r ./packages/hello-world ./packages/package-name # Replace package-name with your package name
mv ./packages/package-name/files/hello-world.sh ./packages/package-name/files/your-file-name # Replace your-file-name with your file name
your-text-editor ./packages/package-name/INSTALL.sh # Edit the INSTALL.sh file (replace your-text-editor with your text editor)
your-text-editor ./packages/package-name/README.md # Edit the README.md file (replace your-text-editor with your text editor)
your-text-editor ./packages/package-name/LICENSE.txt # Edit the LICENSE.txt file (replace your-text-editor with your text editor)
your-text-editor ./packages/package-name/DEPENDENCIES.txt # Edit the DEPENDENCIES.txt file (replace your-text-editor with your text editor)
your-text-editor ./packages/package-name/VERSION.txt # Edit the VERSION.txt file (replace your-text-editor with your text editor)
your-text-editor ./packages/package-name/files/your-file-name # Edit your file (replace your-text-editor with your text editor)
# You can also add more files to the package
your-text-editor ./packages/package-name/files/another-file # Replace another-file with your file name (replace your-text-editor with your text editor)
```

* Run the following command to add your changes:

```bash
git add .
```

* Review git diff to make sure nothing unwanted got added:

```bash
git diff
```

* Commit your changes:

```bash
git commit -a -m "Added package-name" # Replace package-name with your package name
```

* Push your changes to your forked repository:

```bash
git push origin package-name # Replace package-name with your package name
```

* Create a pull request to the [original repository](https://github.com/Kali-in-Batch/pkg) to merge your branch into main.

* Alternatively, you can use the GitHub web interface.
