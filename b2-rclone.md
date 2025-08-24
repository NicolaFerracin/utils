Variables
```
KEY_ID and APP_KEY from the Backblaze website Application Keys
BUCKET_NAME has to be globally unique and at least 6 characters long
REMOTE_NAME it's the name of the rclone local configuration for the bucket
FOLDER_NAME it's an optional folder inside the bucket, where to store the backup
```

Create b2 account remote
```
rclone config create b2 b2 account <KEY_ID> key <APP_KEY>`
```

Create bucket
```
rclone mkdir b2:<BUCKET_NAME>
```

Generate password and salt
```
openssl rand -base64 15
```

Create crypt wrapper for the new bucket
```
rclone config create <REMOTE_NAME> crypt \
  remote b2:<BUCKET_NAME>/.vault \
  filename_encryption standard \
  directory_name_encryption true \
  password <STRONG_PASSWORD> \
  password2 <STRONG_SALT_PASSWORD> \
  --obscure
```

Check config
```
rclone config show <REMOTE_NAME>
```

Upload to bucket
```
rclone copy <PATH_TO_DATA> <REMOTE_NAME>:<FOLDER_NAME> \
  --progress \
  --transfers 16 --checkers 16 \
  --b2-chunk-size 128M --b2-upload-concurrency 8 \
  --fast-list \
  --retries 10 --low-level-retries 10
```

Verify
```
rclone cryptcheck <PATH_TO_DATA> <REMOTE_NAME>:<FOLDER_NAME> --one-way --checkers 16

rclone size <PATH_TO_DATA>
rclone size <REMOTE_NAME>:<FOLDER_NAME>
```

Sync
```
// Makes remote match local (deletes extras on remote)
// (Use copy instead of sync if you never want deletes.)
rclone sync <PATH_TO_DATA> <REMOTE_NAME>:<FOLDER_NAME> \
  --progress \
  --transfers 16 --checkers 16 \
  --b2-chunk-size 128M --b2-upload-concurrency 8 \
  --fast-list \
  --retries 10 --low-level-retries 10
```

Download
```
// List and inspect
rclone size <REMOTE_NAME>:<FOLDER_NAME>
rclone lsl <REMOTE_NAME>:<FOLDER_NAME> | head

// Download to local folder
rclone copy  <REMOTE_NAME>:<FOLDER_NAME> <PATH_TO_LOCAL_FOLDER> -P --stats 5s --transfers 16 --checkers 16 --local-no-set-modtime
```
