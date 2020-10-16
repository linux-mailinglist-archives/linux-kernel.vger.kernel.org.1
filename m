Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C09A28FC62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393719AbgJPCYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393686AbgJPCYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:24:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEF4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:24:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d24so832651ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tHQr2iuUUuKS6ZqLQFzBOpeZW+ePtyM/Tpt0/nOhWSg=;
        b=hPEuUDwLiIvi9stOqZSvKWqYrVJlDOmIRwXHdFp4t7OkJdBIpaw5LeV5s3oY7eiDFF
         d9BgKOjbsQRpTIHYAFjrhSvdSZnjFmju+QpnSDQ9Ygn0golCdMoQtL9YdYWAbcX/NIAH
         u+ziV6ohy7T8e47F5s1dGBcZxHQG54pqiYAn33ytUj5jHq4mF4UCz9GMb41bAUGkrP5D
         q8vZodnJYSJe1lB4i02B6uMPpsWbo9C6huV7wfBAHCL9zsc3JaRKuyN0vYY9VFqM6IL2
         LQYYo28x6y1n4sZjn8o/60OsQd5zflEafkDampFvVXppdK18F2jE2Rx4AvfMBZI6edBT
         Jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tHQr2iuUUuKS6ZqLQFzBOpeZW+ePtyM/Tpt0/nOhWSg=;
        b=Lw6IDyXHdjU5PxlgjsqqkAcscqIY8nTgsuViW3apkmoaaQ8mc4RfDfkbmoKAfRY6to
         aRRDy71hNtFZt2u9BrD3q64JYa5m+BYEjWofmqvDWJKiIgxdZ0ehh56ay30Lg3/DcJDK
         s1iF72YgEd9xH5TdtZMNVWvfJA8LdKOiUp0RkgruOLT8Xy2HmDSS0ZLaGtdnsA5zccLl
         7pgD5DAkoJYV/miAR9qv/UMGkaUbvYhmwm5/Os2sq2GFdHJQ05HCbtum8x0+qUdyq6fh
         AmGXcYPAacGwFlc2wkTYs5HYtthRB1MyFqeDUr8Q5OlZT+/fE9bPcGhlwJhQ6OlTJ7pg
         Hh5g==
X-Gm-Message-State: AOAM532sfhTAWA36PgvdN4/zRg3ADrbufkOZ9ktxa8Ffz0Rwxp0DJetk
        57irZJRlO+7yTGl1zaFnN+SGYY8/DZYlCdhKSgyXiiHXzo82+A==
X-Google-Smtp-Source: ABdhPJwDPLOrvRnXPi+NPgbt826KelE2x5kzV7+p59dS7vXsDBw3/HHPgHo3+3uzuQZnvtLipwyqV4PzeU/vCqDb+vw=
X-Received: by 2002:a2e:584e:: with SMTP id x14mr518341ljd.335.1602815057503;
 Thu, 15 Oct 2020 19:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201013022429.454161-1-daeho43@gmail.com> <20201013022429.454161-2-daeho43@gmail.com>
 <20201013061150.GC1062@sol.localdomain> <CACOAw_y31yAu=AGAEqvyo2Ankt-ux80E6g6m_sWnz6LyUgBXSg@mail.gmail.com>
 <20201015040441.GA834@sol.localdomain>
In-Reply-To: <20201015040441.GA834@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 16 Oct 2020 11:24:06 +0900
Message-ID: <CACOAw_wNWw2bcZy5kg0hoo1GQhrst6bEe87Dp4Q_uR+p7ZBkyA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> mnt_want_write_file() checks for write permission to the mount, not to th=
e file.
>
> I think this ioctl wants what f2fs_sec_trim_file() does:
>
>         if (!(filp->f_mode & FMODE_WRITE))
>                 return -EBADF;
>
>         file_start_write(filp);
>         inode_lock(inode);
>         ...
>         inode_unlock(inode);
>         file_end_write(filp);
>
>
> After all you shouldn't be able to change the compression options of a fi=
le
> given only read access to it, right?

Yep, this looks more accurate.

> Well, as I said, i_writecount =3D=3D 1 doesn't guarantee that other threa=
ds aren't
> mmap'ing or writing to the file.  It just guarantees that there aren't an=
y other
> writable file descriptors.  (Actually, file descriptions.)  Multiple thre=
ads can
> be using the same file descriptor (or the same file description) concurre=
ntly.

Yep, I agree this is not a proper way. I think we don't need this
check here, because
compress routine doesn't compress any file data when it detects the
file is mmaped
using f2fs_is_mmap_file().

Thanks~


2020=EB=85=84 10=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1:04, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Oct 14, 2020 at 11:27:30AM +0900, Daeho Jeong wrote:
> > > f2fs_readonly() is redundant with mnt_want_write_file().
> > >
> > > Also, shouldn't this require a writable file descriptor?  As-is, this=
 ioctl can
> > > be called on a file owned by another user, as long as the caller has =
read
> > > access.
> > >
> > > Note: if you change this to require a writable file descriptor, then
> > > f2fs_readonly(), mnt_want_write_file(), and IS_IMMUTABLE() all would =
no longer
> > > be needed.
> >
> > I agree that f2fs_readonly() is redundant.
> > But, sorry, I don't get the rest. I thought mnt_want_write_file() is a
> > way to check whether the caller has a proper write permission or not.
> > I think just using mnt_want_write_file() is enough for this ioctl. Am
> > I missing something?
>
> mnt_want_write_file() checks for write permission to the mount, not to th=
e file.
>
> I think this ioctl wants what f2fs_sec_trim_file() does:
>
>         if (!(filp->f_mode & FMODE_WRITE))
>                 return -EBADF;
>
>         file_start_write(filp);
>         inode_lock(inode);
>         ...
>         inode_unlock(inode);
>         file_end_write(filp);
>
>
> After all you shouldn't be able to change the compression options of a fi=
le
> given only read access to it, right?
>
> > > I don't think the check for i_writecount =3D=3D 1 accomplishes anythi=
ng because it
> > > just means there are no *other* writable file descriptors.  It doesn'=
t mean that
> > > some other thread isn't concurrently trying to write to this same fil=
e
> > > descriptor.  So the lock needs to be enough.  Is it?
> >
> > This is to detect any possibility of other threads mmap-ing and
> > writing the file.
> > Using only inode lock is not enough to prevent them from making dirty p=
ages.
>
> Well, as I said, i_writecount =3D=3D 1 doesn't guarantee that other threa=
ds aren't
> mmap'ing or writing to the file.  It just guarantees that there aren't an=
y other
> writable file descriptors.  (Actually, file descriptions.)  Multiple thre=
ads can
> be using the same file descriptor (or the same file description) concurre=
ntly.
>
> - Eric
