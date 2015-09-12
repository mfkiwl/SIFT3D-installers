#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the SIFT3D-1.0.0-Linux subdirectory
  --exclude-subdir  exclude the SIFT3D-1.0.0-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "SIFT3D Installer Version: 1.0.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
The MIT License (MIT)

Copyright (c) 2015 Blaine Rister et al.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the SIFT3D will be installed in:"
    echo "  \"${toplevel}/SIFT3D-1.0.0-Linux\""
    echo "Do you want to include the subdirectory SIFT3D-1.0.0-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/SIFT3D-1.0.0-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +164 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the SIFT3D-1.0.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� ��U �Ymo�F�g���/�tq�$����|`r�P�TW)r�%�g��/��Q�{g_llC�/I�;5+E�evvfg��Y߻<p�'ry���=��{�aw?��+G�uh0�4N�ÃF��h�����q�n5��:>9:i�A��<l� ��m�u#�PU%�4��n��e従�j��Cy�$ �:g�$ |�Œ�1�<���� )AJ�������q�],���`a�  (EL�S@�!��v�Iᮚ���9�?���xdZ�^`L7�I4�f�q�����Hb�W����M�!]�0^�,�<5,@��a��hl�� 64���h�럞���{N`8u�L���HT��$��1Q`�k�~����a��_ߙ��4Ӕ+�I�Ա���|{i;��������sB�縳��-O��]���c{�>��� ��$�f'�)Ԃ��?��U��ř�9LFC��ȭ/S��}/�k�t��t��Sa�Ij��=�̩&��ȜJ�*��6��ݯp>��ɜO�{��	��EK�X�@Y��R�j���U$�j�\}�����l�x=��B��$H>Ԋ(B��*ُ)V�x�r�t�lY��$+`��{,���i��x3U�@u�󿿽��<��ˍ�_�\�5O���/��s�WO<x�,W�w5���ԡ�h�;��&F"	����7�~�N|.�mϏ�.|z��[�{�+R�XV�j�%32�e���k/���v�ٗ>��"�|;��1���	�C?p��%�z!qb"��3�D��$�GO�k.���Z<zތ���vW�8'����Ȃu^�#���I�j{7�:�i-Thb1�oK�Eu��7��A�!��g'����a,s�H&�a��sH-e��������{��w���v��Q��7�[���������Y�	��0�#�X�|�Os���5D9'�'��Ɛ�cH�JH�z(�^�͖b������"����M���
����	�(�n�5�oogc,���郉�p�G��/��s#�EvIk�v���{���G�c���y�I�}����[w�1�?r���n7N���q�����1���˕lප�fKk)�4,tE�w���7�4,�l�?�M������(\�(B���tKL����M~���Z�C�ͮ�Ս
���������'�KS),"��t������n�8�1^:���ŰH��[�DT���4�3�kޝ�a�e�'ظ���C���!�lE����C�ɗ%
F\K�^WP=b;��/iGUV��
Rh۔X��Mi�-A��]e�Ӕo�~ǲ�3�&ؠw���Q]�^���2��Y>�-w�� ��5����I��A(Os�|ía>��.�X^<�z�`^ �f(=�/�ϯ	s:鑮�H�R�˭�¦4k"��
y���k#}i�`�_��-��m��$&<�Y,�΢��q�<b��3a1����ڱ�S`/Ȕ�y4 �!�76�^�#�[/�̲h��#+3*�|3����	� I"���4}�U�,6y��F7kו�yE�:۹�ѱF�!���e��+L��}��+�"���.[e����"eM��Rn>+<N��]+�#���+�XC�}��#��Oli�t0z�B<p����-�eu��f�@��"K	�j{7���3C���%Ą��u
�����ؑ'C�@�j`(��!�yಂ�slދ[���	Ү�1Ye�J����rL�L7��_�\����f�bU����x���[����b�7}�B�x_��3�X���-2e/�.T���n��Dd
��0�QĮ��ʎh�z��K��k;´���2���<w^��ȓ���{z��&#M��F�C�$dc�^Ĝ�q�(qP�h��u4)A1���hfc���&FϏY��M��˹�Ȝ���SS�{]�<@&�]�/y��Uҽ�+[�vr�Y`)
�7�UQ����\�lE]�B ��b�c��'+���X��Xx,mV��
���6˯���2^���� O��g *  