# google-bucket-downloader

### A downloader for downloading large number of large files from a single bucket in a way that accounts for the common issues with just using gsutil cp command.

The common issues this script solves: 

- not downloading all files due to various error messages
- some files are downloaded only partially

#### HOW TO USE IT

1) copy the script to the folder you want to download files to and 

    chmod +x dowloader.sh
    
2) execute 

    ./downloader.sh
    
3) input path to the folder and number of files in the folder

If you don't know the number of files in the folder, you can get the number easily by: 

    gsutil ls gs://PATH_TO_FILES | sed '1d' | wc -l 
