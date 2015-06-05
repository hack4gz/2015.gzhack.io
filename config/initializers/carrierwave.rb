# https://github.com/carrierwaveuploader/carrierwave#filenames-and-unicode-chars

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
