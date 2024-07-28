#!/bin/zsh

# Tokyo Night theme colors converted to RGB format
BASE_DARK_BLUE="38;2;31;35;53"        # #1f2335
BASE_MIDNIGHT_BLUE="38;2;36;40;59"    # #24283b
BASE_DEEP_BLUE="38;2;41;46;66"        # #292e42
BASE_PURPLE_BLUE="38;2;59;66;97"      # #3b4261
BASE_SLATE_BLUE="38;2;65;72;104"      # #414868
BASE_GRAY_BLUE="38;2;84;92;126"       # #545c7e
BASE_SOFT_BLUE="38;2;86;95;137"       # #565f89
BASE_LIGHT_BLUE="38;2;115;122;162"    # #737aa2
BASE_PALE_BLUE="38;2;169;177;214"     # #a9b1d6
BASE_VERY_LIGHT_BLUE="38;2;192;202;245"  # #c0caf5
BASE_DARKER_BLUE="38;2;57;75;112"     # #394b70
BASE_BRIGHT_BLUE="38;2;61;89;161"     # #3d59a1
BASE_SKY_BLUE="38;2;122;162;247"      # #7aa2f7
BASE_AQUA_BLUE="38;2;125;207;255"     # #7dcfff
BASE_MINT_GREEN="38;2;180;249;248"    # #b4f9f8
BASE_LAVENDER="38;2;187;154;247"      # #bb9af7
BASE_SOFT_PURPLE="38;2;157;124;216"   # #9d7cd8
BASE_ORANGE="38;2;255;158;100"        # #ff9e64
BASE_GOLD="38;2;255;199;119"          # #ffc777
BASE_LIGHT_GREEN="38;2;195;232;141"   # #c3e88d
BASE_TEAL="38;2;79;214;190"           # #4fd6be
BASE_SEA_GREEN="38;2;65;166;181"      # #41a6b5
BASE_SOFT_RED="38;2;255;117;127"      # #ff757f
BASE_CRIMSON="38;2;197;59;83"         # #c53b53
BASE_HOT_PINK="38;2;255;0;124"        # #ff007c

THEME_DIRECTORY="01;$BASE_SKY_BLUE"
THEME_SYMLINK="00;$BASE_AQUA_BLUE"      
THEME_PIPE="00;$BASE_TEAL"             
THEME_SOCKET="00;$BASE_LAVENDER"      
THEME_EXECUTABLE="01;$BASE_TEAL"
THEME_ARCHIVE="00;$BASE_SOFT_RED"       
THEME_IMAGE="00;$BASE_ORANGE"         
THEME_VIDEO="00;$BASE_GOLD"         
THEME_AUDIO="00;$BASE_SEA_GREEN"        
THEME_DOCUMENT="00;$BASE_GOLD"        
THEME_CONFIG="00;$BASE_PALE_BLUE"    
THEME_SOURCE="00;$BASE_LAVENDER"    

THEME_NORMAL="00"                      
THEME_DOOR="00;$BASE_LAVENDER"        
THEME_BLOCK="00;$BASE_TEAL"          
THEME_CHAR="00;$BASE_TEAL"          
THEME_ORPHAN="00;$BASE_SOFT_RED"   
THEME_SETUID="00;$BASE_SOFT_RED"  
THEME_SETGID="00;$BASE_SOFT_RED" 
THEME_STICKY_OTHER_WRITABLE="00;$BASE_CRIMSON"
THEME_OTHER_WRITABLE="00;$BASE_GOLD"      
THEME_STICKY="00;$BASE_CRIMSON"           
THEME_MISSING="00;$BASE_SOFT_RED"     
THEME_LEFTCODE="00"                    # Default
THEME_RIGHTCODE="00"                   # Default
THEME_ENDCODE="00"                     # Default


# Define file type groups
declare -A file_type_groups

file_type_groups=(
  "*.bashrc *.bash_profile *.fish *.zsh *.gitconfig *.gitignore *.gitmodules *.hgrc"
  "*.config *.conf"
  "*.swift *.h *.m *.a *.c *.cpp *.cc *.h++ *.hpp *.m *.mm *.ps1 *.ts *.tsx *.js *.jsx *.json *.go *.git *.gitmodules"
  "*.plist *.pbxproj *.xcodeproj *.xcworkspace"
  "*.gz *.zip *.rar *.7z *.xz *.tar *.tgz *.tbz *.tbz2 *.bz *.bz2 *.zst *.deb *.dmg *.rpm *.apk *.jar *.nix *.xz *.iso"
  "*.md *.markdown *.txt *.rst *.html *.xml *.json *.yml *.yaml *.ini *.cfg *.sql *.log *.pdf *.doc *.docx *.xls *.xlsx *.ppt *.pptx *.odt *.odp *.ods *.rtf *.epub *.info *.yaml *.conf *.csv *.xmp *.psd1 *.psm1 *.toml *.purs README INSTALL LICENSE COPYING CHANGELOG CONTRIBUTING"
  "*.jpg *.jpeg *.png *.gif *.bmp *.tiff *.tif *.webp *.svg *.ico *.avif *.mp3 *.wav *.flac *.ogg *.m4a *.mp4 *.mov *.avi *.mkv *.webm *.mpeg *.mpg *.mid *.midi *.aif *.aiff *.3gp *.3g2 *.ai *.psd *.eps *.kra"
  "*.sh *.bash *.zsh *.bat *.cmd *.exe *.com *.ps1 *.py *.rb *.php *.pl *.pm *.js *.jsx *.ts *.tsx *.java *.class *.scala *.kt *.go *.rs *.swift *.cpp *.h *.hpp *.c *.m *.mm *.cs *.fs *.fsx *.clj *.cljs *.lisp *.lua *.tcl *.elm *.nim *.nimble *.raku *.hack *.erl *.el *.asm *.s *.psm1 *.psd1 *.inc *.hx *.hxx *.vert *.frag *.glsl *.shader *.vb *.vbs *.vue *.dart *.html *.xml *.yaml *.toml *.json *.cfg *.ini *.cfg *.inf *.conf"
)

# Construct the LS_COLORS variable
LS_COLORS=""

# Set file type colors
LS_COLORS+="no=${THEME_NORMAL}:"        # Normal
LS_COLORS+="fi=${THEME_NORMAL}:"        # Normal file
LS_COLORS+="di=${THEME_DIRECTORY}:"     # Directory
LS_COLORS+="ln=${THEME_SYMLINK}:"       # Symlink
LS_COLORS+="pi=${THEME_PIPE}:"          # Pipe
LS_COLORS+="so=${THEME_SOCKET}:"        # Socket
LS_COLORS+="ex=${THEME_EXECUTABLE}:"    # Executable
LS_COLORS+="bd=${THEME_BLOCK}:"         # Block device
LS_COLORS+="cd=${THEME_CHAR}:"          # Character device
LS_COLORS+="or=${THEME_ORPHAN}:"        # Orphan symlink
LS_COLORS+="do=${THEME_DOOR}:"          # Door
LS_COLORS+="su=${THEME_SETUID}:"        # Setuid
LS_COLORS+="sg=${THEME_SETGID}:"        # Setgid
LS_COLORS+="tw=${THEME_STICKY_OTHER_WRITABLE}:"  # Sticky and other-writable
LS_COLORS+="ow=${THEME_OTHER_WRITABLE}:"         # Other-writable
LS_COLORS+="st=${THEME_STICKY}:"        # Sticky
LS_COLORS+="mi=${THEME_MISSING}:"       # Missing

# Map file extensions to their respective theme colors
for file_types in ${(@k)file_type_groups}; do
  file_types=(${=file_types})
  for file_type in $file_types; do
    case $file_type in
      "*.tar"|"*.tgz"|"*.arj"|"*.taz"|"*.lzh"|"*.lzma"|"*.tlz"|"*.txz"|"*.zip"|"*.z"|"*.Z"|"*.dz"|"*.gz"|"*.lz"|"*.xz"|"*.bz2"|"*.bz"|"*.tbz"|"*.tbz2"|"*.tz"|"*.deb"|"*.rpm"|"*.jar"|"*.rar"|"*.ace"|"*.zoo"|"*.cpio"|"*.7z"|"*.rz"|"*.dmg"|"*.apk"|"*.nix"|"*.iso"|"*.zst")
        LS_COLORS+="$file_type=${THEME_ARCHIVE}:"
        ;;
      "*.jpg"|"*.jpeg"|"*.gif"|"*.bmp"|"*.pbm"|"*.pgm"|"*.ppm"|"*.tga"|"*.xbm"|"*.xpm"|"*.tif"|"*.tiff"|"*.png"|"*.svg"|"*.svgz"|"*.mng"|"*.pcx"|"*.webp"|"*.ico"|"*.avif"|"*.ai"|"*.psd"|"*.eps"|"*.kra")
        LS_COLORS+="$file_type=${THEME_IMAGE}:"
        ;;
      "*.mov"|"*.mpg"|"*.mpeg"|"*.m2v"|"*.mkv"|"*.ogm"|"*.mp4"|"*.m4v"|"*.mp4v"|"*.vob"|"*.qt"|"*.nuv"|"*.wmv"|"*.asf"|"*.rm"|"*.rmvb"|"*.flc"|"*.avi"|"*.fli"|"*.flv"|"*.gl"|"*.dl"|"*.xcf"|"*.xwd"|"*.yuv"|"*.cgm"|"*.emf"|"*.axv"|"*.anx"|"*.ogv"|"*.ogx"|"*.webm"|"*.3gp"|"*.3g2")
        LS_COLORS+="$file_type=${THEME_VIDEO}:"
        ;;
      "*.aac"|"*.au"|"*.flac"|"*.mid"|"*.midi"|"*.mka"|"*.mp3"|"*.mpc"|"*.ogg"|"*.ra"|"*.wav"|"*.axa"|"*.oga"|"*.spx"|"*.xspf"|"*.m4a"|"*.aif"|"*.aiff")
        LS_COLORS+="$file_type=${THEME_AUDIO}:"
        ;;
      "*.md"|"*.markdown"|"*.txt"|"*.rst"|"*.html"|"*.xml"|"*.json"|"*.yml"|"*.yaml"|"*.ini"|"*.cfg"|"*.sql"|"*.log"|"*.pdf"|"*.doc"|"*.docx"|"*.xls"|"*.xlsx"|"*.ppt"|"*.pptx"|"*.odt"|"*.odp"|"*.ods"|"*.rtf"|"*.epub"|"*.info"|"*.yaml"|"*.conf"|"*.csv"|"*.xmp"|"*.psd1"|"*.psm1"|"*.toml"|"*.purs"|"README"|"INSTALL"|"LICENSE"|"COPYING"|"CHANGELOG"|"CONTRIBUTING")
        LS_COLORS+="$file_type=${THEME_DOCUMENT}:"
        ;;
      "*.bashrc"|"*.bash_profile"|"*.fish"|"*.zsh"|"*.gitconfig"|"*.gitignore"|"*.gitmodules"|"*.hgrc"|"*.config"|"*.conf"|"*.plist"|"*.pbxproj"|"*.xcodeproj"|"*.xcworkspace")
        LS_COLORS+="$file_type=${THEME_CONFIG}:"
        ;;
      "*.sh"|"*.bash"|"*.zsh"|"*.bat"|"*.cmd"|"*.exe"|"*.com"|"*.ps1"|"*.py"|"*.rb"|"*.php"|"*.pl"|"*.pm"|"*.js"|"*.jsx"|"*.ts"|"*.tsx"|"*.java"|"*.class"|"*.scala"|"*.kt"|"*.go"|"*.rs"|"*.swift"|"*.cpp"|"*.h"|"*.hpp"|"*.c"|"*.m"|"*.mm"|"*.cs"|"*.fs"|"*.fsx"|"*.clj"|"*.cljs"|"*.lisp"|"*.lua"|"*.tcl"|"*.elm"|"*.nim"|"*.nimble"|"*.raku"|"*.hack"|"*.erl"|"*.el"|"*.asm"|"*.s"|"*.psm1"|"*.psd1"|"*.inc"|"*.hx"|"*.hxx"|"*.vert"|"*.frag"|"*.glsl"|"*.shader"|"*.vb"|"*.vbs"|"*.vue"|"*.dart"|"*.html"|"*.xml"|"*.yaml"|"*.toml"|"*.json"|"*.cfg"|"*.ini"|"*.cfg"|"*.inf"|"*.conf")
        LS_COLORS+="$file_type=${THEME_SOURCE}:"
        ;;
    esac
  done
done

# Export the LS_COLORS variable
export LS_COLORS
