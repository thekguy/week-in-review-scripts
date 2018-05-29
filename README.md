# Week-In-Review Scripts

Bash scripts for creating collages for my "Week-In-Review" LinkedIn articles. Collage images are 2160 pixels wide by 1080 pixels tall. On weeks in which I publish five images, the collage consists of four 540 by 540 pixel images stacked vertically on each side of a 1080 by 1080 pixel image. The `week_in_review.sh` script generates all 120 permutations of this collage in the working directory. Images are resized and cropped before adding to the collage, so there is no size or shape requirement on input images except that they be at least 1080 pixels wide and at least 1080 pixels tall.

## Getting Started

Install the two prerequisites so that their commands are in your PATH. Clone this repository into a directory of your choosing. I like to put it under a directory called `WeekInReview/Scripts`. Once per week, run the `mkdir_and_add_links.sh` script, passing it the name of a directory you want to create for your input images and collage. I like to name this directory with the date that Monday fell on that week using `yyyymmdd` format. This script will create the directory and link the `week_in_review.sh` and `contact_sheet.sh` scripts into this directory. When you have collected all five images for the week, convert them into jpeg format and give them a JPG extension. Run `week_in_review.sh` and it will generate 120 files named from `WeekInReview12345.JPG` to `WeekInReview54321.JPG`.

If you would like to be able to look at all these collages at once, you can run the `contact_sheet.sh` script to generate a file named `contactsheet.JPG`. This image is a 3216 by 1490 pixel image consisting of all 120 collages to make it easier to choose the most aesthetically-pleasing collage for the article. The file name of each image is directly below the image to make it easy to find the file once you've chosen your favorite collage.

### Prerequisites

* [ImageMagick](https://www.imagemagick.org/script/index.php) - Resizes images and combines for collage. Overlays text and combines images for contact sheet.
* [smartcrop-cli](https://github.com/jwagner/smartcrop-cli) - Crops the images so that the subject is kept in the image.

## Authors

* **Keith McDonald** - *Initial work* - [thekguy](https://github.com/thekguy)
