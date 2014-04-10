-- Remove a file extension from a file name
function removeExtension( filename )
    return string.sub( filename, 0, string.len(filename) - 4 )
end