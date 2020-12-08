Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4122D21AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgLHD7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLHD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:59:53 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCABEC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 19:59:12 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f11so5293926ljm.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 19:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qZ3sT96+VaeWT9VitA7FsIMHux1rYKs7g2DqKKiiN3E=;
        b=RsbzU4sGnz6t/Szy1M4PvE8spsRqzZ/20pYbEvVr59TaK7F6NezcB8ZWbF827mAJ5P
         q/wnbd11Qf8tqrcjpb7i1M8VfsQLXhOjnMpi6SkKomDYbdKT7fMoW4/DTa5oHpAWvx3/
         2YJYllYDw93ukact1Z23YCH8SBFVAcMXQ4h/Tc/i1Crf1114Kbmykd77gVMFzDfqPXx4
         e1epz7sR8fJ7uI8F7ihHzFmcCX7etHkgm5tKhN0fkS4Ejw0XVUzhc14PjpXti/70wMmY
         BNRkCetdBl3EAScmPRaJYsGxoKlQ3bNDhycDiL8028tnHGqKUeSp1Q4uPeCET23rv8gX
         emEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qZ3sT96+VaeWT9VitA7FsIMHux1rYKs7g2DqKKiiN3E=;
        b=mz0WLB7DZW7ZzLFQ6Qi7b5vlz+4KHCejrvNRM2KGubtgDDA66fUz20aUpQaFtDYjq9
         +YOBs81eps6Hl/6OPQt2ZrB4ELXREVLo7H71uW26sipD2+isLUHbAUDFFYH9JBALs6Ka
         TYF4xS8ztccRLPBHCzC63ZqO+bSgZ5TfSdIcWOBcm2hkCKeDEd4W2sQ1WjLBgsCdoFZA
         URfHIX+I0GjeHHXVBexMqAgueUk3pwkOh6sKFG3+fdLaibmr+rBPsUklNVu898Fncf+E
         OLKDrpzFOE/RErWNDVvjp/eeijsYsmK2LWf2UFurMyeFgBAwpbE7t/AfvVHZVgfKGN2Z
         VDGA==
X-Gm-Message-State: AOAM530mubKlBwY4VRFApdujTeptrIs1vPyZpEav2n11lUrZo/AcdIKu
        fepVOHBlQl61+dpCyOSx0Vb7joLTcSrkK8flqQPvTweV/o4=
X-Google-Smtp-Source: ABdhPJxlXzN73dX72TWO+dei0zl1RDf8jnUnx5NKLSs/3jJWZQDr4zagOWcVd9TYXCnqZ/yrzrXxx1cwFyBMUAsUs+0=
X-Received: by 2002:a2e:a0cb:: with SMTP id f11mr2943869ljm.363.1607399951348;
 Mon, 07 Dec 2020 19:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20201201040803.3590442-1-daeho43@gmail.com> <X874P2evu7SUgjBA@gmail.com>
In-Reply-To: <X874P2evu7SUgjBA@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 8 Dec 2020 12:59:00 +0900
Message-ID: <CACOAw_zgytk-a4uGBfZGgEKy5SLzG=nFyL832FiV3hx85cXG3Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add compress_mode mount option
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compression enabled regular files have different formats of node
metadata on disk. So, using the
"compress_mode=3Duser,compress_extension=3D*" mount option, we want to
make the metadata of files ready for compression and make them
compressed whenever the user wants using new ioctls.

2020=EB=85=84 12=EC=9B=94 8=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 12:51, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Dec 01, 2020 at 01:08:02PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We will add a new "compress_mode" mount option to control file
> > compression mode. This supports "fs" and "user". In "fs" mode (default)=
,
> > f2fs does automatic compression on the compression enabled files.
> > In "user" mode, f2fs disables the automaic compression and gives the
> > user discretion of choosing the target file and the timing. It means
> > the user can do manual compression/decompression on the compression
> > enabled files using ioctls.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2: changed mount option name and added more explanation of mount optio=
n
> > ---
> >  Documentation/filesystems/f2fs.rst | 35 ++++++++++++++++++++++++++++++
> >  fs/f2fs/compress.c                 |  2 +-
> >  fs/f2fs/data.c                     |  2 +-
> >  fs/f2fs/f2fs.h                     | 30 +++++++++++++++++++++++++
> >  fs/f2fs/segment.c                  |  2 +-
> >  fs/f2fs/super.c                    | 23 ++++++++++++++++++++
> >  6 files changed, 91 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesys=
tems/f2fs.rst
> > index b8ee761c9922..5eb8d63439ec 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -260,6 +260,13 @@ compress_extension=3D%s     Support adding specifi=
ed extension, so that f2fs can enab
> >                        For other files, we can still enable compression=
 via ioctl.
> >                        Note that, there is one reserved special extensi=
on '*', it
> >                        can be set to enable compression for all files.
> > +compress_mode=3D%s      Control file compression mode. This supports "=
fs" and "user"
> > +                      modes. In "fs" mode (default), f2fs does automat=
ic compression
> > +                      on the compression enabled files. In "user" mode=
, f2fs disables
> > +                      the automaic compression and gives the user disc=
retion of
> > +                      choosing the target file and the timing. The use=
r can do manual
> > +                      compression/decompression on the compression ena=
bled files using
> > +                      ioctls.
> >  inlinecrypt           When possible, encrypt/decrypt the contents of e=
ncrypted
> >                        files using the blk-crypto framework rather than
> >                        filesystem-layer encryption. This allows the use=
 of
> > @@ -810,6 +817,34 @@ Compress metadata layout::
> >       | data length | data chksum | reserved |      compressed data    =
   |
> >       +-------------+-------------+----------+-------------------------=
---+
> >
> > +Compression mode
> > +--------------------------
> > +
> > +f2fs supports "fs" and "user" compression modes with "compression_mode=
" mount option.
> > +With this option, f2fs provides a choice to select the way how to comp=
ress the
> > +compression enabled files (refer to "Compression implementation" secti=
on for how to
> > +enable compression on a regular inode).
> > +
> > +1) compress_mode=3Dfs
> > +This is the default option. f2fs does automatic compression in the wri=
teback of the
> > +compression enabled files.
> > +
> > +2) compress_mode=3Duser
> > +This disables the automaic compression and gives the user discretion o=
f choosing the
> > +target file and the timing. The user can do manual compression/decompr=
ession on the
> > +compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_=
COMPRESS_FILE
> > +ioctls like the below.
> > +
> > +To decompress a file,
> > +
> > +fd =3D open(filename, O_WRONLY, 0);
> > +ret =3D ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
> > +
> > +To compress a file,
> > +
> > +fd =3D open(filename, O_WRONLY, 0);
> > +ret =3D ioctl(fd, F2FS_IOC_COMPRESS_FILE);
> > +
>
> Why doesn't compress_mode=3Duser just cause regular files to not inherit =
the
> compression flag?  Then users could set or clear the compression flag usi=
ng
> FS_IOC_SETFLAGS, without any need for these new ioctls.
>
> - Eric
