# Personal Git Cheat Sheet

## What is git 
 - It is an version control system that keeps track of every change you have made and allows you to back to them. 
    - which changes 
    - who made them 
    - when 
    - why 

# What is a repository 
- It encompass all of the files and folders that make up a project.

## Documentation 

https://git-scm.com/docs 
https://docs.github.com/en/get-started/using-git/about-git
https://www.atlassian.com/git/ 


## configuring git

- in the command line 
    - git config --username 'yourusername'
    - git config --password 'yourpassword'

## The process to Add a file 

- git pull (to get the latest version of the project if you are collaborating)
- git add 
    - . for all files that have changes
    - <specific file or files> file1.extension file2.extension
    - p for portions of the file 
        - y to stage chunk 
        - n to ignore the chunk
        - s to split the chunk 
        - e to manually edit
        - q to exit
- git commit -m "..."
    - a adds a snapshot of all messages
    - am combines a and m
    - amend will change the last commit by opening it up and all staged changes will be added the previous
- git push

## Important git commands 

 - git status - Show the working tree status
 - git branch - List, create, or delete branches
 - git switch - Switch branches
 - git fetch -  Download objects and refs from another repository
 - git merge - Join two or more development histories together
 - git restore - discard changes in the working directory

## Making changes 
- be in the right derectory
- cd <file path>

#### The process 
- git add -- tell what file to add. the '.' will add all files that have been changed. 
- git commit - Record changes to the repository
- git push - Update remote refs along with associated objects

## How to make a branch 
- git branch <name of branch>

## switching to a branch 
- git checkout <name of branch>

## Branching and Merging
- branch 
- merge
- stash -  Stash the changes in a dirty working directory away


## Sharing and Updating projects
- fetch
- pull
- push

## gitignore

#### Purpose 
- lets Git know that it should ignore certain files and not track them.
#### What it is? 
- a file is a plain text file where each line contains a pattern for files/directories to ignore.

## Example of contributing to a project. 
# download a repository on GitHub to our machine
# Replace `owner/repo` with the owner and name of the repository to clone
git clone https://github.com/owner/repo.git

# change into the `repo` directory
cd repo

# create a new branch to store any new changes
git branch my-branch

# switch to that branch (line of development)
git checkout my-branch

# make changes, for example, edit `file1.md` and `file2.md` using the text editor

# stage the changed files
git add file1.md file2.md

# take a snapshot of the staging area (anything that's been added)
git commit -m "my snapshot"

# push changes to github
git push --set-upstream origin my-branch

# removing a file 
git rm -r <file>

# Adding a folder 
git add <foldername>/