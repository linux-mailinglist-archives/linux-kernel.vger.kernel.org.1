Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C082AB756
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgKILkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:40:35 -0500
Received: from 212-129-56-80.ip.rebuild.sh ([212.129.56.80]:55664 "EHLO
        rebuild.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbgKILke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:40:34 -0500
Received: from [192.168.97.21] (81-67-152-104.rev.numericable.fr [81.67.152.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by rebuild.sh (Postfix) with ESMTPSA id 6CA2E20029;
        Mon,  9 Nov 2020 12:40:31 +0100 (CET)
From:   =?UTF-8?B?VGhvbWFzIOKAnGlsbHdpZWNreuKAnCBEZWJlc3Nl?= 
        <dev@illwieckz.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: On disabling AGP without working alternative (PCI fallback is broken
 for years)
Message-ID: <6941f046-d9a6-7603-0338-e7831917a540@illwieckz.net>
Date:   Mon, 9 Nov 2020 12:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rJKBYLqzJuzFKTKmOqxrAzFyxR2EYdY1L"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rJKBYLqzJuzFKTKmOqxrAzFyxR2EYdY1L
Content-Type: multipart/mixed; boundary="GjpsWN3pGh5kV10HvqfLUk7QdTuk2MYmQ";
 protected-headers="v1"
From: =?UTF-8?B?VGhvbWFzIOKAnGlsbHdpZWNreuKAnCBEZWJlc3Nl?= <dev@illwieckz.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Message-ID: <6941f046-d9a6-7603-0338-e7831917a540@illwieckz.net>
Subject: On disabling AGP without working alternative (PCI fallback is broken
 for years)

--GjpsWN3pGh5kV10HvqfLUk7QdTuk2MYmQ
Content-Type: multipart/mixed;
 boundary="------------833AE2493D508E0A75DEC9C2"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------833AE2493D508E0A75DEC9C2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, on May 12 2020, a commit (ba806f9) was merged disabling AGP
in default build.

It was signed-off by Christian K=C3=B6nig and Reviewed by Alex Deucher.
Distributions started to backport this commit, and it seems to have
happened with 5.4.0-48-generic on Ubuntu 20.04 LTS side, which was
built on Sep 10 2020.

Around that time I noticed AGP computers experiencing lock-ups and
other problems making them unusable after the upgrade. After
investigating what was happening bisecting Linux versions,
I reverted the commit and those computers were working again.

Commit message was:

> This means a performance regression for some GPUs,
> but also a bug fix for some others.

Unfortunately, this commit does not only introduce a performance
regression but makes some computers unusable, maybe all computers
with AMD CPUs.

One of the root cause may be that PCI GPUs are broken for years on
AMD platforms, it was tested and verified on:

- K8-based computer with AGP
- K8-based computer with PCI Express
- K10-based computer with AGP
- Piledriver-based computer with PCI Express

The breakage was tested and reproduced from Linux 4.4 to Linux
5.10-rc2 (I have not tried older than 4.4).

PCI GPUs may be broken on some other platforms, but I have found
that testing on an Intel PC (with PCI Express) does not reproduce
the issue when the PCI GPU hardware is plugged in.

There is two patches I'm requesting comments for:

## drm/radeon: make all PCI GPUs use 32 bits DMA bit mask

https://lkml.org/lkml/2020/11/5/307

This one is not enough to fix PCI GPUs but it is enough to prevent
to fail r600_ring_test on ATI PCI devices. Note that Nvidia PCI GPUs
can't be fixed by this, and this uncovers other bug with AGP GPUs when
AGP is disabled at build time. Also, this patch may makes PCI GPUs
working on a non-optimal way on platform that accepts them with 40-bit
DMA bit mask (like Intel-based computers that already work without any
patch).

This patch is inspired from the patch made to solve that issue from
2012 on kernel 3.5: https://bugzilla.redhat.com/show_bug.cgi?id=3D785375

At the time, such change may have been enough to fix the issue, it's
not true any more. More breakage may have been introduced since.

Also, maybe this patch becomes useless when other PCI bugs are fixed,
who knows? At least, this is an entry-point for investigations.

## Revert "drm/radeon: disable AGP by default"

https://lkml.org/lkml/2020/11/5/308

This is the simple fix but currently only solution to make AMD hosts
with AGP port to get a display again, as without this reverts, those
computers do not have any alternative to run a display (even not PCI
GPUs).

I'm asking for comments on those patches. I may have reached my own
skill cap on kernel development anyway. I can repurpose hardware to
test any other patch and can contribute time for such testing. Unlike
AGP GPUs, PCI GPUs are hard to find, so you may appreciate the time and
availability offered.

The PCI GPU on AMD CPU issue was verified with both Nvidia
(GS 8400GS rev.2) and ATI (Radeon HD 4350) PCI GPUs, such GPU
sample not being old cards from the previous millennial but capable
ones: TeraScale RV710 architecture on ATI side and Tesla 1.0 NV98
on Nvidia side. They can both do OpenGL 3.3 and feature both
512M of VRAM. The ATI one had HDMI port, and it is known some variant
of the Nvidia one (not the one I own but same specification) had HDMI
port too.

Also, fixing PCI GPUs may not be enough to fix AGP GPUs running
as PCI ones, since fixing some issues (not all) on PCI side raises
new issues with AGP GPUs running as PCI ones but not on native PCI
GPUs (see below).

Bugs aside, one thing that is important to consider against the AGP
disablement is that there is such hardware that is very capable and
not that old out there. For example the ATI Radeon HD 4670 AGP
(RV730 XT) was still sold brand new after 2010 and is a powerful
and featureful GPUs with 1GB of VRAM and HDMI port. Performance with
it is still pretty decent on competitive games. To compare with other
=C2=A0open source drivers mainlined in Linux, to outperform this GPU an
=C2=A0user has to get an Intel UHD 600 or an Nvidia GTX 1060 from 2016.

Also, yet another thing that is important to consider against AGP
disablement is that if PCI Express was introduced in 2004, there
was still AGP compatible hardware being designed, produced and sold
very lately, especially on AMD side. Computers with quad core 64-bit
CPUs with virtualisation, 16GB of RAM and AGPs exist, and this is
widely distributed consumer hardware, not specific esoteric hardware.

So, not only powerful AGP GPUs were still sold brand new in the current
decade, but there was also very capable computers to host them. Because
of those AGP computers, fixing PCI GPUs fallback is not a solution
because PCI fallback is not a solution.

All that range of hardware became unusable with that commit disabling
AGP, without alternative.

Not only those AGP GPUs don't work with kernel's PCI fallback, but
unplugging those AGP GPUs and plugging physical PCI-native GPUs
instead does not work.

You'll find more details about the various issues on those bugs, I've
invested multiple full time day to test and reproduce bugs on a wide
range of hardware, I've attached, quoted and commented a lot of logs:

- https://bugs.launchpad.net/bugs/1899304
> AGP disablement leaves GPUs without working alternative
> (PCI fallback is broken), makes very-capable ATI TeraScale GPUs
> unusable

- https://bugs.launchpad.net/bugs/1902981
> AGP GPUs driven as PCI ones (when AGP is disabled at kernel build
> time) are known to fail on K8 and K10 platforms

- https://bugs.launchpad.net/bugs/1902795
> PCI graphics broken on AMD K8/K10/Piledriver platform (while it
> works on Intel) verified from Linux 4.4 to 5.10-rc2

I wish to be personally CC'ed the answers/comments posted to the list
in response to my posting.

Thank you for your attention.

--=E2=80=AF
Thomas =E2=80=9Cillwieckz=E2=80=9D Debesse

--------------833AE2493D508E0A75DEC9C2
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

--------------833AE2493D508E0A75DEC9C2--

--GjpsWN3pGh5kV10HvqfLUk7QdTuk2MYmQ--

--rJKBYLqzJuzFKTKmOqxrAzFyxR2EYdY1L
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE8xM2EoLjcOLWJ+ej4GKSkz4sonUFAl+pKq4FAwAAAAAACgkQ4GKSkz4sonWB
Eg//dYG4cDxknqNuXstGxZ/nGwXyscsklQ91MweKyfE7uqGiy/I6V8j16SL8TFl/DhOx5H3I4GPW
U7KIngwq1Upc53lexuzpPwYfFt1WZ2AjwYYnupqCn3fUsio39+/7oEbnnnEx1haO0FarP4iXvTKf
IoAOD3x95GTafsYdni3AuiIPaeYFgM5LmcL7dqmy9w4qaRetkhap+WZ2ackbJc+VjHs3XENE0Xrg
RqLqs4U86CpqvZu8seHC1k3gXtWOEqCatSF5bei/2PuMvQE9gPtKV9varozVUMBQGLibJpv0F9RN
muxLVAtm6oNm2q0wv0tTrGd4oAx867iDFdtcn3iJD6LBHxKpHpPhLFxogbsBQiS2w195lJoYhua8
2QF4PMRydAmLIgEXajbmEBUVvxg+LMJvoYAE4z+g/yfwDzpDhu0/BIWj2jMWL69WjRzNcxv1qo8F
qJ8vImxgr8GgpxQjNwHFED27mPAwTTBMlCLg4bBWFc+3pbjRhYLY8haalgGDWM4u2DOTe43ghUWp
RO0fHwRgwFhJDjF1W7bBl1CVh/piqdCQasXolLDkulctDDs7U+hex3i0k4EMwL9mPBcA9E7rd5qt
egJGs8GF/lLp5MLMC3diufNL5WgD7jYgVRm5EkgDRLxbk/n4Og47BvzZpfLxnYxmJmAA8hIe7PpY
eo4=
=Pnbd
-----END PGP SIGNATURE-----

--rJKBYLqzJuzFKTKmOqxrAzFyxR2EYdY1L--
