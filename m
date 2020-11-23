Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6CD2C191C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbgKWXCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgKWXCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:02:34 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:02:34 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id w8so17447251ilg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g091FaNOSxFZQQwxRMAWnvSLOv1Y43ybwdCbChtVCSY=;
        b=VhphtZiPS5uIM9CyBYpJSbis1m2ju9qFsNxb3qnv/tJmrRTG+3+TRLTvzPqLwVPM10
         vIVy6Ubku+D0DejQz/Yya6Pi/7qdAFA4hzWdaIeecZBVhJUleWqH32sLgHA/cCASjz1v
         GfDWEURP7+fQhxI8X7tS3+hgtIRJkFUs/Xiz7fSidGQPrh+jH3CDJORF99CpBFW8vtj5
         YLJn/b49i4EixON5wt79Oke10yjhv+GUuidKh6H1dFe99mZGydzHIthwseWPh1Cki0Ay
         EwGN9k3KbXaMr+61Jw7oUP/FBwoqi3Ru88qsVrtLlfFzAPnsFIlQzio7KfAT+VPZrM/e
         aPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g091FaNOSxFZQQwxRMAWnvSLOv1Y43ybwdCbChtVCSY=;
        b=ddTyuoytnK5QFfhqbn0v2c1/C2rq0woaf0zLtLY7yFTYDDbz7wE5raqlhiy16UlgGv
         iX6P3ceu/R+UsG+3PL8NxarhU2vY50ix2b1PdpwUCJZnNf5mNbGuueh4VnS8ZZdV1/Pf
         Zno8pSLkUPRJumQnYR29e7g/aNmNT7CoTrdmIdkGEAybEHsu3FB5M83F9evnabDFy/6y
         s6VldgZMi3Yp/z3TyOw/0+gcco4kts5xnJf9eAXInn8W2a76ecKPlsADAjqJEvaG8vQL
         EwfNBaomjD8YT6E82tkL+DtkdKwlHt3/wH9aGErYCVwfW7qeh7NobCUef1DGKYWe7XN4
         fANA==
X-Gm-Message-State: AOAM533VZ5JIjGlktg+nPlFqCvbFYCfBN6UVzPwRFilmkdntQ1xjffd/
        JyyJb2aKPmj+r05DIeMLl00DJ/dsqY7CCa8fEgE=
X-Google-Smtp-Source: ABdhPJw0Vs1IksMBSb6srHXJX02eeoKM3MjgEMh0HLC1Rh5LHjrZpnYzpNxAUvf3Ey26edb2ngKCtMY/2X2rXrtnMOM=
X-Received: by 2002:a92:c941:: with SMTP id i1mr1820033ilq.158.1606172553905;
 Mon, 23 Nov 2020 15:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com> <20201123031751.36811-2-daeho43@gmail.com>
 <20201123184821.GB3694916@gmail.com>
In-Reply-To: <20201123184821.GB3694916@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 24 Nov 2020 08:02:21 +0900
Message-ID: <CACOAw_xEe=3H60njSfwJSToFnVbOHabUd2Nt=uZJLvCfxFgM4Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

My mistake~

Eric,

What I want is like do_page_cache_ra(), but I used
page_cache_ra_unbounded() directly, because we already checked that
read is within i_size.
Or we could use do_page_cache_ra(), but it might do the same check in it ag=
ain.
What do you think?

I could add some description about these in
Documentation/filesystems/f2fs.rst and I implemented tests internally.

2020=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 3:48, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Nov 23, 2020 at 12:17:51PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added two ioctl to decompress/compress explicitly the compression
> > enabled file in "compress_mode=3Duser-based" mount option.
> >
> > Using these two ioctls, the users can make a control of compression
> > and decompression of their files.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/file.c            | 181 +++++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/f2fs.h |   2 +
> >  2 files changed, 182 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index be8db06aca27..e8f142470e87 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4026,6 +4026,180 @@ static int f2fs_ioc_set_compress_option(struct =
file *filp, unsigned long arg)
> >       return ret;
> >  }
> >
> > +static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int l=
en)
> > +{
> > +     DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
> > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > +     struct address_space *mapping =3D inode->i_mapping;
> > +     struct page *page;
> > +     pgoff_t redirty_idx =3D page_idx;
> > +     int i, page_len =3D 0, ret =3D 0;
> > +
> > +     page_cache_ra_unbounded(&ractl, len, 0);
>
> Using page_cache_ra_unbounded() here looks wrong.  See the comment above
> page_cache_ra_unbounded().
>
> >  static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned=
 long arg)
> >  {
> >       switch (cmd) {
> > @@ -4113,6 +4287,10 @@ static long __f2fs_ioctl(struct file *filp, unsi=
gned int cmd, unsigned long arg)
> >               return f2fs_ioc_get_compress_option(filp, arg);
> >       case F2FS_IOC_SET_COMPRESS_OPTION:
> >               return f2fs_ioc_set_compress_option(filp, arg);
> > +     case F2FS_IOC_DECOMPRESS_FILE:
> > +             return f2fs_ioc_decompress_file(filp, arg);
> > +     case F2FS_IOC_COMPRESS_FILE:
> > +             return f2fs_ioc_compress_file(filp, arg);
> >       default:
> >               return -ENOTTY;
> >       }
>
> Where is the documentation and tests for these new ioctls?
>
> - Eric
