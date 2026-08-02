# 🔗 Hard Links & Soft Links (Symbolic Links)

## 📖 Introduction

In Linux, a **link** is a pointer that allows multiple filenames to reference the same file or another file.

Linux provides two types of links:

- 🔗 Hard Link
- 🔗 Soft Link (Symbolic Link)

Links help avoid duplicate files, save disk space, and make file management easier.

---

# 🤔 Why Do We Need Links?

Suppose you have a file:

```text
/home/sejal/projects/report.txt
```

Instead of creating multiple copies of the file, you can create a **link**.

Benefits:

- Save disk space
- Easier file management
- Multiple access paths to the same file
- Commonly used in software installation and configuration

---

# 🔗 Hard Link

## 📖 What is a Hard Link?

A **Hard Link** is another name (directory entry) for the **same physical file**.

Both the original file and the hard link point to the **same inode** and share the same data.

If one file is modified, the changes are reflected in the other because they are actually the same file.

---

## 📝 Syntax

```bash
ln source_file hardlink_name
```

---

## 💡 Example

Create a file.

```bash
touch report.txt
```

Create a hard link.

```bash
ln report.txt report_hard
```

List inode numbers.

```bash
ls -li
```

Output

```text
12345 report.txt
12345 report_hard
```

Notice that **both files have the same inode number**.

---

## Verify

Write data.

```bash
echo "Linux Notes" > report.txt
```

Read using the hard link.

```bash
cat report_hard
```

Output

```text
Linux Notes
```

---

## Delete Original File

```bash
rm report.txt
```

Now check.

```bash
cat report_hard
```

Output

```text
Linux Notes
```

The data is still available because the inode still exists.

---

## Advantages

- Saves disk space
- Faster than copying files
- File remains accessible even if the original filename is deleted
- Both files always stay synchronized

---

## Limitations

- Cannot link directories (normally)
- Cannot cross different file systems
- Shares the same inode

---

# 🔗 Soft Link (Symbolic Link)

## 📖 What is a Soft Link?

A **Soft Link** (also called a **Symbolic Link** or **Symlink**) is a shortcut that stores the **path of another file**.

Unlike a hard link, it has its own inode and simply points to the original file.

If the original file is deleted, the soft link becomes broken.

---

## 📝 Syntax

```bash
ln -s source_file symlink_name
```

---

## 💡 Example

Create file.

```bash
touch report.txt
```

Create symbolic link.

```bash
ln -s report.txt report_soft
```

Check.

```bash
ls -l
```

Output

```text
lrwxrwxrwx report_soft -> report.txt
```

Notice:

```text
l
```

The letter **l** indicates a symbolic link.

---

## Verify

Write data.

```bash
echo "AWS Notes" > report.txt
```

Read through symbolic link.

```bash
cat report_soft
```

Output

```text
AWS Notes
```

---

## Delete Original File

```bash
rm report.txt
```

Now check.

```bash
cat report_soft
```

Output

```text
No such file or directory
```

The symbolic link becomes a **broken link** because its target no longer exists.

---

## Advantages

- Can link directories
- Can cross different file systems
- Easy to identify
- Flexible and widely used

---

## Limitations

- Breaks if the original file is removed
- Slightly slower because Linux follows the stored path

---

# 🔍 Checking Links

List files with inode numbers.

```bash
ls -li
```

---

Show symbolic links.

```bash
ls -l
```

---

Display inode information.

```bash
stat filename
```

---

# 🗑️ Delete a Link

Delete Hard Link

```bash
rm report_hard
```

Delete Soft Link

```bash
rm report_soft
```

Deleting a **link does not delete the original file**, unless it is the last remaining hard link.

---

# 🌍 Real-world Uses

## Hard Links

- File backups
- Version control
- Efficient storage
- Duplicate filenames

---

## Soft Links

- `/bin` → `/usr/bin`
- Shared configuration files
- Shortcut to applications
- Web server document roots
- Software installation paths

---

# 📌 Example Directory

```text
Documents/

report.txt

report_hard

report_soft -> report.txt
```

After deleting **report.txt**

```text
report_hard      ✅ Still Works

report_soft      ❌ Broken Link
```

---

# ⚡ Hard Links vs Soft Links

| Feature | Hard Link | Soft Link |
|---------|-----------|-----------|
| Points To | Same inode | File path |
| Inode Number | Same as original | Different |
| Can Link Directories | ❌ No | ✅ Yes |
| Cross File Systems | ❌ No | ✅ Yes |
| Works After Original Deleted | ✅ Yes | ❌ No |
| File Type | Regular File | Symbolic Link |
| Command | `ln` | `ln -s` |
| Speed | Faster | Slightly slower |
| Link Indicator | Normal file | `l` in `ls -l` |

---

# 📝 Quick Summary

| Link Type | Command |
|-----------|---------|
| Hard Link | `ln source destination` |
| Soft Link | `ln -s source destination` |
| Check Links | `ls -li` |
| View Symbolic Link | `ls -l` |
| Detailed Information | `stat file` |
| Delete Link | `rm linkname` |

---

# ⭐ Best Practices

- ✔ Use **Soft Links** when linking directories.
- ✔ Use **Hard Links** to save disk space for duplicate files.
- ✔ Avoid moving or deleting original files if symbolic links depend on them.
- ✔ Use `ls -li` to verify hard links.
- ✔ Use `ls -l` to identify symbolic links.
- ✔ Use descriptive names for links.
- ✔ Remove broken symbolic links periodically.

---