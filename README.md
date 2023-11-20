# download-brightwheel-photos

A simple Bash script to download all of your child's photos from [Brightwheel](https://mybrightwheel.com/), using cURL.

## Usage

1. Open a web browser and navigate to your child's profile, via [this URL](https://schools.mybrightwheel.com/children/list)
2. Select "Feed", then select "Photo" in the filter dropdown, then click "Apply"
3. Copy and paste the JavaScript script into the browser's console to get all of the photo URLS:
```bash
cat js/get-all-photo-urls.js | pbcopy
```
4. Follow the progress of the JavaScript code in the console, and when it's finished running, copy and paste the
   `PHOTO_URLS` Bash array variable definiton printed into the `photo-urls.env` file:
```bash
cp bash/photo-urls.env.example bash/photo-urls.env && pbpaste >> bash/photo-urls.env
```
5. Run the `download-all-photos.sh` script to download the photos to the "photos" directory:
```bash
./bash/download-all-photos.sh
```
