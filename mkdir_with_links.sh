# Usage: mkdir_with_links.sh <directory to create>

if [ -z "${1}" ]; then
  echo "Usage: mkdir_with_links.sh <directory to create>"
  exit 1
fi

mkdir "${1}"
pushd "${1}"
ln -s ../Scripts/week_in_review.sh week_in_review.sh
ln -s ../Scripts/contact_sheet.sh contact_sheet.sh
popd
