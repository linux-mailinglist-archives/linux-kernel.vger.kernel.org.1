Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A172A7BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgKEKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:32:26 -0500
Received: from 212-129-56-80.ip.rebuild.sh ([212.129.56.80]:54944 "EHLO
        rebuild.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKEKcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:32:25 -0500
Received: from [192.168.97.21] (81-67-152-104.rev.numericable.fr [81.67.152.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by rebuild.sh (Postfix) with ESMTPSA id 7043720498;
        Thu,  5 Nov 2020 11:27:17 +0100 (CET)
From:   =?UTF-8?B?VGhvbWFzIOKAnGlsbHdpZWNreuKAnCBEZWJlc3Nl?= 
        <dev@illwieckz.net>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "drm/radeon: disable AGP by default"
Message-ID: <c441a37f-086f-7d0c-7141-121097743421@illwieckz.net>
Date:   Thu, 5 Nov 2020 11:27:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2tKqIl9hIcXdOKJS6GnPM1EvXl7KxNZbn"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2tKqIl9hIcXdOKJS6GnPM1EvXl7KxNZbn
Content-Type: multipart/mixed; boundary="qia2RKnvrEvVjTMwRRYfA7F1VqPc4YzmH";
 protected-headers="v1"
From: =?UTF-8?B?VGhvbWFzIOKAnGlsbHdpZWNreuKAnCBEZWJlc3Nl?= <dev@illwieckz.net>
To: LKML <linux-kernel@vger.kernel.org>
Message-ID: <c441a37f-086f-7d0c-7141-121097743421@illwieckz.net>
Subject: [PATCH] Revert "drm/radeon: disable AGP by default"

--qia2RKnvrEvVjTMwRRYfA7F1VqPc4YzmH
Content-Type: multipart/mixed;
 boundary="------------3D6A9B5D22EB1D14AD70577C"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------3D6A9B5D22EB1D14AD70577C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I wish to be personally CC'ed the answers/comments posted to the list in
response to my posting.

This reverts commit ba806f98f868ce107aa9c453fef751de9980e4af.

Disabling AGP leaves some hardware without working alternative
on some platforms. For example, PCI GPUs are known to be broken
on K8 and K10 platforms since years: the breakage was reproduced
from Linux 4.4 on Ubuntu 16.04 Xenial to Linux 5.10-rc1 on Ubuntu
20.04 Focal, and it is expected to be older than Linux 4.4.

Also, there may be some bugs specific to AGP GPUs being driven
as PCI ones since fixing some PCI bugs introduces newer bugs
that are very specific to AGP GPUs driven as PCI ones and not
to PCI native ones.

Some AGP GPUs are still relevant to this day, like the high-end
ATI Radeon HD 4670 AGP (RV730 XT), a very capable TeraScale GPU
designed for OpenGL 3.3 and OpenCL 1.0 and featuring HDMI port
and 1GB of VRAM. This GPU was distributed by various manufacturers
and was still sold as brand new in 2012, for example this one:
http://www.hisdigital.com/un/product2-448.shtml
https://web.archive.org/web/2012/https://www.amazon.com/gp/product/B003CY=
KCG8/

As an example, this AGP GPU still gets 140+ fps on the competitive
Xonotic game in 2020, as verified during the XDWC 2020 event, also
when compared to other games on the Unvanquished GPU compatibility
matrix, we can notice that to outperform such AGP GPU, Intel users
have to acquire an UHD 600 graphic chip from 2016, and Nvidia users
relying on the free open source nouveau driver have to acquire a
GTX 1060 from 2016:
https://wiki.unvanquished.net/wiki/GPU_compatibility_matrix

Motherboards compatible with powerful CPUs like the quad core AMD
AM3 Phenom II CPU X4 970 (3.5GHz) supporting virtualization, 16GB
of RAM and featuring AGP and PCI slots (not PCI Express ones) were
sold, like this motherboard from 2006 supporting this CPU from 2010:
https://www.asrock.com/mb/nvidia/am2nf3-vsta/
https://www.cpu-world.com/cgi-bin/IdentifyPart.pl?PART=3DHDZ970FBK4DGM

This is basically among the best the market had to offer in 2012
for AGP users. Disabling AGP turns such very capable computers and
their AGP GPUs into paperweights.

Even if PCI and AGP-as-PCI issues are fixed, disabling AGP is
expected to strongly affect performance of such GPUs, and disabling
AGP may hide bugs that may be introduced after the disablement.

A boot command line switch to disable AGP to rely on PCI fallback
may be welcome to help testing the PCI code and prevent it to rot
as it is easier to find AGP cards than PCI ones.

I have access to some AGP GPUs by ATI and Nvidia and some
computers that can be purposed for testing any patches written
by others that would improve AGP support.
See related bugs for details about GPUs, host platforms, and a
a lot of details and logs about issues faced:

- https://bugs.launchpad.net/bugs/1899304
> AGP disablement leaves GPUs without working alternative
> (PCI fallback is broken), makes very-capable ATI TeraScale GPUs
> unusable

- https://bugs.launchpad.net/bugs/1902981
> AGP GPUs driven as PCI ones (when AGP is disabled at kernel build
> time) are known to fail on K8 and K10 platforms

- https://bugs.launchpad.net/bugs/1902795
> PCI graphics broken on AMD K8/K10 platform (while it works on Intel)
> verified from Linux 4.4 to 5.10-rc1

--=20
Thomas =E2=80=9Cillwieckz=E2=80=9D Debesse

--------------3D6A9B5D22EB1D14AD70577C
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Revert-drm-radeon-disable-AGP-by-default.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-Revert-drm-radeon-disable-AGP-by-default.patch"

=46rom 3c6acab35f7a210357dfbc909e089245823d4c5a Mon Sep 17 00:00:00 2001
From: Thomas Debesse <dev@illwieckz.net>
Date: Thu, 5 Nov 2020 03:26:05 +0100
Subject: [PATCH] Revert "drm/radeon: disable AGP by default"

This reverts commit ba806f98f868ce107aa9c453fef751de9980e4af.

Disabling AGP leaves some hardware without working alternative
on some platforms. For example, PCI GPUs are known to be broken
on K8 and K10 platforms since years: the breakage was reproduced
from Linux 4.4 on Ubuntu 16.04 Xenial to Linux 5.10-rc1 on Ubuntu
20.04 Focal, and it is expected to be older than Linux 4.4.

Also, there may be some bugs specific to AGP GPUs being driven
as PCI ones since fixing some PCI bugs introduces newer bugs
that are very specific to AGP GPUs driven as PCI ones and not
to PCI native ones.

Even if PCI and AGP-as-PCI issues are fixed, disabling AGP is
expected to strongly affect performance of GPUs that were still
sold brand new in 2012 and disabling AGP may hide bugs that may
be introduced after the disablement.

Signed-off-by: Thomas Debesse <dev@illwieckz.net>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
index 4cd30613fa1d..62b5069122cc 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -171,7 +171,12 @@ int radeon_no_wb;
 int radeon_modeset =3D -1;
 int radeon_dynclks =3D -1;
 int radeon_r4xx_atom =3D 0;
+#ifdef __powerpc__
+/* Default to PCI on PowerPC (fdo #95017) */
 int radeon_agpmode =3D -1;
+#else
+int radeon_agpmode =3D 0;
+#endif
 int radeon_vram_limit =3D 0;
 int radeon_gart_size =3D -1; /* auto */
 int radeon_benchmarking =3D 0;
--=20
2.25.1


--------------3D6A9B5D22EB1D14AD70577C
Content-Type: application/pgp-keys;
 name="OpenPGP_0xE06292933E2CA275.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xE06292933E2CA275.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFoIzM8BEACsz1Oq3vmJpnOoAvNVBF5DMG5X/TsKCinf01zutc9o9ca9xcI2m1n3yoFGi=
+0V
keBUORt2XsuNPvj8Q6NNPjaHRw0rlWIAJ3kMp/Nizej90P+ItMgdj2R9cj+/spLDAUcvdZT11=
39d
jJD31ozbHrthgJnzE1CLEv3GdpHztp4uftjoY6Vh+K2PF4aLh6ILnBvZZiajfm0AddrDQv+Jc=
k3U
5egMs9TJ59qtuRNeOJXbCnlvzUW7ZkqOg3M4c77IbvCcmsellIdRbKgY9Dpp04MtTOxDXqF7l=
j/h
6pc9TWgwBDlpDPOYg4HXGuCD/04FJmF5+IEB6O9/okhSSIbR/x0X/ApfbwtS9MgZD4temgEc/=
M++
ws7oYxXAINo3nca+PY3wchIAGMhqEiGL0/t6J9Y2itJX9kfhpzaUidc0m/ICUORkgRmoqeOPC=
RvE
H49L95KHAQNuWS9Qrz+hqmAfzycQB02eg58yzjm90nY9+dcAl9FVAFpyx8ELFjVrFqU6vopXY=
6Ma
2vcfVP4Oogiwa/dMs0cljXqvQBkzS0dVG6O9DBdun821J98wEZc8GbJ2H47kp+fWnvNnNtc10=
L9x
iOahbxchUfltOE3enQYwJ9Bbhj6ksaF3EVZi1qAbW/aISwei3oQYaVnC31SpfYvNaLVi/8J+N=
HR9
lA6aio8wpZRVZQARAQABzSVUaG9tYXMgRGViZXNzZSA8dGhvbWFzQGlsbHdpZWNrei5uZXQ+w=
sF6
BBMBCAAkAhsjBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAhkBBQJaCfLLAAoJEOBikpM+LKJ1f=
wsP
/2BbSu341rWPX/hmTFFE05UXy5bEeGYNvDLUyTiRkb97wZowYcu1s3i7eEiy6SjDUDx9e9Cy1=
+60
UshKvueEBPljQMv3w7SjJc4YHEgJBwIEWkjWUuVqXztt4mF1pAAIMFzSqhW2tJa4Y1MTWlNRy=
A/f
lPTRnWQm45orzNcxXxvsERc091QfSwLdYXp/pT1nmA+mFO8U+73XntF+2tZUtdMLy2cvGwc7f=
cdG
sZW7bg9QQu63Zjo9hWJpHHD57YRpE+9ZTCTKonQE1vupgoon3hT9zfq1++VRnIzBLvt99roQW=
FWJ
DU1iIqyxyOVB6rU/VzU3WVJsxBroExJ+WW/FYZKL+ppn/Yw7QPmSWemyNZGCsb9voTJ8oCP/l=
Ux3
4uuHtIwaFGBqg5GElafC/kzqg8xbbJD2AVunemgQrO1sqRvt4SnJ5o9YhyI0BkyfoKyTuJn68=
Ur3
mkjmCFD7uECpGS6c6uv9Gss0S96q+9BA38obIsllxtQFjeywKkqUdQ1MFf5vn7CToYh2zzFEP=
mSL
iqNgYSk+1OG2L6KB4Ix/O3N51R8ZdEw1+Ql2YWEwuhPIRIB6ixLxvVgZa0wHGljsfC0fAN7Kg=
FlL
N3B4N1Z2Xdrgr8k7zIvlc0SNSQITgGf+BfWFCQw/h4Jto8kL1aEv/tRJbrG8sdd15tzdx3pJy=
eMp
zSlUaG9tYXMgRGViZXNzZSA8dGhvbWFzLmRlYmVzc2VAZ21haWwuY29tPsLBdwQTAQgAIQIbI=
wUL
CQgHAgYVCAkKCwIEFgIDAQIeAQIXgAUCWgny0QAKCRDgYpKTPiyidUnMD/9md3BAlM5JCP/3s=
xCh
BuC7jcNU15qv+NNTBPWh/seuQvcNd4DEE3oFIm0dB4jUeqGLH7AroTLPt1y4BWOZr4GY8x+7f=
Wyd
hSD4iJ6PO9kLCBapbJMuIaiMW2DqgjVMxwB98Id0MFKN6RQLjQ8iXRFHRwTpU12aZXEK2OrnH=
h43
sdcZHtwwIdeXCraclytyhOCbY6Vlte1W8g7id9aDdObq1xDqVTekcARvIE/0Vn8Xkzxxt13xg=
Mlg
Wwd7tgcMUj/mt0K5g/3e8FNiko2uvMMJQhXu3fCLjY9lBxdeIydn0KiS1CGHx5x0L12V3IY9z=
Lot
Arcjr1ocEXSKVHmjxA/N24Sb4F30okBTib4WOv88dJgqpB4Wy0T9+CR7rSfgv2UQQlbd//YTF=
XLn
BcLROMQzEe/nx27ecaXb+nZEBZc0QtHENYMbVWOEDupKIYIW4sa2thUBkFBcHw1Ygx8gMcO2C=
ddt
1ovjoYKcEDXZ8l4MEs7jUFCswi3jkrig741GLR4FM7wrrd2GWT6lS/9DAGHkIcqh+rSV4A/u5=
Xcw
7irjkS479o4l7JwKWutIOl3Xe3Li6bht2NO3pHNWJ2NMzykCC2zaKQn0Sksm6klcz0tA8H8lz=
Rl5
RJQ04FCIu4EclstqVF6/WdghtloX3aAsRZcBQNypzG4M3o4VDg377qfjS80iVGhvbWFzIERlY=
mVz
c2UgPGRldkBpbGx3aWVja3oubmV0PsLBdwQTAQgAIQIbIwULCQgHAgYVCAkKCwIEFgIDAQIeA=
QIX
gAUCWgny0QAKCRDgYpKTPiyidUgbD/9+G/9TFAVUDMM7TRDQDiRMs7Npn4d6M/IWqyQSMQVQc=
VCz
471GOKTML0nVPN98eguv0MBzSdn6zHp8zUuuRUWGWbQclr+SEzTszrc9TRMeNVnc0ZTsEEZTV=
2l2
LzrCVozxzkp7LxPCePUhGivZHASOFmxsaGit9VGH1bIYXrbGQfdQmQ+cp/883k/KBDZ24lVlg=
3+r
M3i14rQvyl86pTP5V3MPMu9ZCCuFHQ6+wJspwi3wO+Q9UzlYnt6m9xtMVMf0qd2J6af0mhnFK=
3Nh
Uke+my06sCItTqu2xUI2DSDNny0Svneq2WBcJjP29xAWjy2ATkGbcxcO8n59W4EDJaCOZAcAt=
cYb
1/qPPM31KP31EIGT3ea9pf9eYffQXm6LSt2ZPlwupM7MIf6CVXscy2+txZ1yaECMerqFUYyZj=
xZj
Ph8OXUkOCC0HicnafeYWu++beqG0EHsFlPqbzCiMvPHvpoc/7oSaJSoj4bRuhSKSOsSB6Wvos=
cXY
b9vb2xQjAWUyaaccH2m0xNTl4T/fEE9RgthevZiqLe/zpbMRNpBVcSpx3liTQb3DpZuS2hBXT=
K8X
GsFVmJ+9jXHlB+R1fcXIxvCZYu5Mk2BUuPFZihpc7nJZ39jik6BvufQ3PVEn5K3F6bvuy56Q2=
kul
/kXGDLM/wGg08pu891LXZn+GLaoZo80mVGhvbWFzIERlYmVzc2UgPGpvdXJuYWxAaWxsd2llY=
2t6
Lm5ldD7CwXcEEwEIACECGyMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AFAloJ8tEACgkQ4GKSk=
z4s
onU8SA//aUPYie9gkLwnV4Xw1JhesFsTDwF007OH1x5Tnxeh8L72PppiOhfa1x4BR/ld4JK+5=
lyF
J9vXYvxAw34rRt1thk5hO6dXahOD0xQhj3lY8BugRjtDGST7SwmK8TAbU42xrmGu1dCylwKf3=
Ya2
ovLzhR7tAiBOImYs3CBIL00P4H4zfpXoTILMgFr9azQMlYxrclL8tbfWT1ePx9CW/mDDD6A0b=
90q
uGc2vjyFVHmdN51pe2zPZHG7XqnCTzwkAAPfTMjoVLe88VkYshZDyyXzd2fwL9+p6haZwUfg/=
1ZT
6wY1FKn8kVutzgA/8Tvt09gF1OD1Q+NQjRlMMK9w2zX5952s95J1F0+7i6uqfoLSYHSf6WgDR=
yfb
fBPx13JsrHMb8w5UYLbm+T2xdyRlGGQQOq6p5C+ISXg+L7CjWb7uRyFQgYjetSBlUAknOUb34=
Lg7
fkhmiJYB2cLQFuIy7moqL/rLfxKtx+VSr2FLQ+ll0+wu6v0ouSvnITpc0REhueGYm1xwk5FzH=
XoV
VxvAyqkE5KS2FkbUYRB4aH60iq8JLUJbdXyqlDqPE4fP4KGl+82UMYB973sYxXFydR2mFloAg=
XnZ
fLO7iyuaEIqlDrNpGizSxumwRSQDVpTtO0LTVz36ycQmJIvnyFnSvosVhlQ1ba98+iOrkJSY+=
Xsb
M09+rGXNJ1Rob21hcyBEZWJlc3NlIDx0aG9tYXNAcGFwYW1hbWFuLnBob3RvPsLBjgQTAQoAO=
BYh
BPMTNhKC43Di1ifno+BikpM+LKJ1BQJccDd0AhsjBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAA=
AoJ
EOBikpM+LKJ171IP/jOwY3y54fhJwo8izhO7FBDvGfNJiMcq0d2jM1yNEuJnvH0X10yEZSZVf=
EY3
k9pn5dPw3j+BTdl2bbFmI9ZeM7wKWNdVvfHPS6qcVvTVvMBV8tEu+UMpCfYob6241F92/rAPp=
znO
hWXC3DVLqJ8LcFSphhJTQXoAFfKUKGeXWOUE9ZwFlZ/ynyqR7+PITMXso9CvUN0HQ/mXgO4K2=
Oea
zZmMjahWveQtbXjce4nSRmdNNN1J6lmVgMYAw24ZUb+CpWpGALAWMUZFJXDjB/HflOwIdiV7P=
MZM
T2OBq5WLlW02K13Yb9lOz7m1EoURwF0+utHISa0gPrDe3k5viFrVhg9xNDb4Kgdz7TX3xrgCR=
b0G
1FIxFJuCzIBfsN1rZo/bWOASbG5g/GAEidKG86OjCdBJeTD1hbGuXRrOI/HbHh9geVmgq4hZ6=
1ZJ
DI+3YXhNJjW3snoxsjUG0IwuHlAZoQHOMgE+323Q2ET3lc5dSkaGw09KH35hmT4oyKUTGWEhZ=
Z1F
YAHb3wYLS+cvMeoZ7e1k0UVaOU+sB8W7oK2KNg0xuHpAKcpFB3XLuOjhqkRukMKpmbbl16BF9=
9WY
NmqaC60O/nKm3iSbHihU+sTneIZx51e8EkQ9VFf6sL8ztMS7WCtjQbgion/J9YnHOj5oEDarR=
M1O
8ldp8vodFY/88YZbzS1UaG9tYXMgRGViZXNzZSA8dGhvbWFzLmRlYmVzc2VAaWxsd2llY2t6L=
m5l
dD7CwY4EEwEKADgWIQTzEzYSguNw4tYn56PgYpKTPiyidQUCX0bl8wIbIwULCQgHAgYVCgkIC=
wIE
FgIDAQIeAQIXgAAKCRDgYpKTPiyidbPOD/4yXzl2X+UW21DF7sdKAH+WYIkMOoEvJAQuPdBq3=
4Dx
J5aFGmvDq6JJiLtHxYigqI5EUbbTNGY6C1BqNndBaQV1XRdUDeWtAyf1muJJlE73j4GbSvwHB=
nq6
vZ5xWjC5/e1+YDfZ6ps2XWhe75Gy7xlIoFMBV/aNuVTbD0yVxYiUeaPQufFWnE0CId1f3vBXy=
vO3
zRqLOkzHYjv0ZSJe6MmtmhrOwg95jA0tPCWbD45A05pgaTeBAUVtYv5taCWEsVT6h/aZ6XwXD=
qbV
M/U7OucCc3PXwfxMj+kjvXoYV8rZ+lNHz1BBB4DN5LRLRYsboKiypko3QwgoA7as8JjnGR7CY=
w1+
eDG3Ij2vaqTqg2lwoGEybub48Ko13SsbAgq3Y0pOr3fyIQKUALUpJO0VYS8+omDi1zGDro0LK=
p9V
5IYhpH75xwAkt8H8I1T2QQL2Ng0LUnOT1/L9nP10HXFVL9fnjnMqE4Pw+VPkjVyrQqI+gOZ6Z=
4hs
1JSLiNwKQjuRJwWGgxVwvW15IDe0uG0kfkgZDxJLR4IwVEJ3HSVb3bYvhOCE3nAHXqIyopVjK=
Awu
qfrpaFwzwPMERt3dVn8lJ4UzKqGt5jUdDBSh+mAVviGtYEHUS/bScfCYYWwL0r3+2PRqhj6l+=
c4+
8zVJv1wKYwAQu4k5o/JnOO7Aaus0ahtPjc7BTQRaCMzPARAAyIoMYOE0w/QtAIZyz2ssuy60M=
z56
8PpsMjj76tHEad4+hp+OVsX2D5rM+FIiZhHb2aIu3zpRgs8ojeTBZYraGT/wJBdyQ0L279mO2=
4pg
jySwUS3ZKS74C2Ih8Ds0JPHJ7j/ZizJzbsjxHMa9nVmJuZI+GvXrR8g/6tSCHpB1rwpZ3p7q9=
4Tv
QfdH+k1jbeKMfp96s0sxeH22XOvURSXL/cMgPHXeAETJD+1lQbtHgF6BOwGF7z780bv73zt6L=
XKq
Unlx8WwHqJejS944l+7OtThIbMxj1rA3MnOkNzShI2GLTkFlumLeYqqf43glolSaO+bjDbBtQ=
Gir
T79FAK1BGs8lweKn4VLUc6H+UghpgDN8ZfcDmzFMMGWv+9EDxHbQK6KFYDKIhasfUMUs1Z6WS=
XUe
O0If8Zts7A3R2MhVZEwH2S2WQfZ9G6waSEhHXESImQ6q40UP7vQzJDVMducFkQUGh6B4EYAOU=
UV4
unvNmz9dQj4pAiTK9+hMBJTIjUMfICHApnIpX9AC8ZAEW7MHzNCyWlbsgNMbQlI42AXPnYTl8=
WG/
semKF29CfQtZtXFds6ADT5ntnZm0ggOwbMNxhiqXN0QWViRGRnHGGPwmiSdf2wamGiPqQhs2k=
QaU
ckr0njypCib3ixz1abPsGqOafx3bXM+JIYgZGzPOc1yXv/8AEQEAAcLBXwQYAQgACQIbDAUCW=
gny
0gAKCRDgYpKTPiyidXiBD/0UTwTKktPOQ1qXmRujS3EREC5RngvIMI+YVJWcmg1Y8xjxazBIC=
aC2
sZ+KSu+ZyaUpyKgSCtsR+EEe5z/e+9hRen98D1f+CM+ZHkDgqWk88RSd/rVmwQ3lliP6V5osv=
UsW
hlQuP6qSm0ZcPxAV6aLZnnQQ1DLDFBiiu7wSP08RcPZhOGovJU3YxIIiPyI6oVZlGdBKRFA9Z=
LRl
ktSFH4rHt5hAvxaFRH3/rvdJPnLEmkzElZjN3Ap4tS3I8MX/HZzzxOwIusU2cArYB4Ba582La=
qIw
pSZ1MKZpXHtrTy7vgSW5DTA7iGYFzDFKL2+OgmNKksOzJ9zsWYBr8cFSlDaqrLzob897F27TN=
lgm
G1ytjspPReCqIMIO5OdUr+e/ny0NvK1+d/yD8cuZ+GRe9d7OIxFkl4OszrQRbAOqi3YwECbuR=
8Vo
K0AgDLmifjMYqYgG4ikxwYg2ETdvtz8kjXY3nc4LkCMsCZTX5pYa2hjTXC9BRgIRiF44rnhfn=
9YG
PqP9a/0+RndkuvlJJgtWzaMveBFgZuWy3C4Y9Y0zYIIt/keHtK/n6atI/BliERNK4z05KeeA9=
tjx
QeHyLgKjZYlEB/K+ykAUXXZlO6cSz9y3mXBN4omI+d7IrS2Glxcbvj+wBGs/uOFyM8pRytRfP=
P49
78zIlthhvkhCPmtFUa1Z4w=3D=3D
=3D1br1
-----END PGP PUBLIC KEY BLOCK-----

--------------3D6A9B5D22EB1D14AD70577C--

--qia2RKnvrEvVjTMwRRYfA7F1VqPc4YzmH--

--2tKqIl9hIcXdOKJS6GnPM1EvXl7KxNZbn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE8xM2EoLjcOLWJ+ej4GKSkz4sonUFAl+j04QFAwAAAAAACgkQ4GKSkz4sonUG
Vg/+PRo7MHjuoPPK7OQyRKdYbfzJv6ZgWQFZue8mlajtdQQ93ZuzXPe/yfOqL90yGF7u99fJ+UVC
l2+vtPftVEj8MYxIALwRJ6LmkxMeFiDWeG4csRFbDnlkSBgB+XWXv1/LoDR5cItUqAfR2wGCvB/w
vd5o4E1ccpEvr9hXNZxja2ANF9Mm4oRx6VCRbdCp9qKjkHiDaZWUylt3AiY9Wku791XlQiS2eU8n
iQojQirY/bEUgd/0c3YhcrCGoxPTc+/gzVz1t6ipIYqbn/knuYvtEf00JqWUIv1h+NJsv7+ZN4Xk
DVapnOeKgnfj/c2Hi7kq63NBcNxLHL3PT46fQR//4RDfefK2uZKbL7zkMpm6LJrj85RCQ4NKm4Hz
PQ+oG29GKTQT4J/1vqO8WWjkv+8hPqIIaW4w3d8J14yciTFm0ytucczzsuMQszj6OLneFpoGhuJO
pyssaIzVnTQmIB4tdPH9TS/hnTIz/gRHH7Q0UVXUqH8xYhltStDBu2+h/d21u24rD9NeKu9YwssG
SgC5yfj8qj0xlclPUCO39IyeW7UEjsWi8mfh3IvuFUvXuGG+FX63CQP27w17TlQ98SVsuVawvp/x
DFrs9ib6tFo/gmAYNBRIvqmpZmLfd7HQ4CL2Om6+oeWFk/WQA1+31DWi1mcaKtA4CQrca6uUd/Aa
LxE=
=XKt5
-----END PGP SIGNATURE-----

--2tKqIl9hIcXdOKJS6GnPM1EvXl7KxNZbn--
