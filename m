Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713D128DCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgJNJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbgJNJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA4C0F26DC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 19:27:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x16so1547192ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 19:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qDBAWibsVMpL9uDkJTD6UsuRe4btwTbpHEP5BT5fyh4=;
        b=SIY5SpAHAN72HhJ/xUnnLQ8qiguN3XROjuCYGqZDhegyDOIuk5n1rAJdptUhOjAczb
         763QYE6+1ratG+ilSLA4Iqi2vdBJJdWGymz2znSjTU90zJZ9JS5p8dhLobzG7spmLVZT
         LVX6vJcVBBvEmI2UVnaz1FsbWRpa4JvN3bgOS30EvdXVzpji2alGacgIsS0375TqTn3n
         V8AREtecq+6+RbPkE8DCjt1JX94okEzrDICGX8gO3RSr8tonlTDvC4WZEG96mc5qI/Bl
         9G5QyMc3eBzI+h8/1V5wgvlwwkUQV9DQsb3LW8VZlC35s3Z3UiZQL5hyAe3FpVb82rt6
         EyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qDBAWibsVMpL9uDkJTD6UsuRe4btwTbpHEP5BT5fyh4=;
        b=QPUgQDZ0qf5Doyo/T0CP4Wcfg4SMottDL3mh/Nz4b5UPNRmLr9GXkQkYN8B9xaEke/
         XYlvr88XnIBH3byCf82iT7JKNUX12ydnjxZPHLTB663PbNzCW2rBiVgPOzgcF8Pckqos
         jZs7gDbzHG0bQAcnH+Ure8n1K6XbRV7E9Iw8WKx0GMNfVExE1R32XEnqtBXdPJbiK9qW
         pjtdtauPZ40dH5IPSNOnIB2gK6nNBH40DfWQepci1ncmXnArbH39fimhrGTIfw5/8EqL
         jjFNE7VmomPkUhiqAFnI0MVR5xyzDOWn14asD2hlDqXbiFkiDNRhNjaeIhfJ84sycQ/3
         CzeA==
X-Gm-Message-State: AOAM5307dR7urwxMvgVBxe6SboTyfaR0wsF1sf7Zui1pDojHplAGqI4X
        26e/9xo95CeVBQaneiMtWzHHVxK59V5xnQCk8Lg=
X-Google-Smtp-Source: ABdhPJyS3IRl6z4QTbEwQtI350xF9azP/uv0HbGKCKHNW9yiGO5w4R6/PDo8gvGZnhDbl+3AruygB/bfgFnqwMCU9TM=
X-Received: by 2002:a2e:b61a:: with SMTP id r26mr923956ljn.166.1602642461301;
 Tue, 13 Oct 2020 19:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201013022429.454161-1-daeho43@gmail.com> <20201013022429.454161-2-daeho43@gmail.com>
 <20201013061150.GC1062@sol.localdomain>
In-Reply-To: <20201013061150.GC1062@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 14 Oct 2020 11:27:30 +0900
Message-ID: <CACOAw_y31yAu=AGAEqvyo2Ankt-ux80E6g6m_sWnz6LyUgBXSg@mail.gmail.com>
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

> f2fs_readonly() is redundant with mnt_want_write_file().
>
> Also, shouldn't this require a writable file descriptor?  As-is, this ioc=
tl can
> be called on a file owned by another user, as long as the caller has read
> access.
>
> Note: if you change this to require a writable file descriptor, then
> f2fs_readonly(), mnt_want_write_file(), and IS_IMMUTABLE() all would no l=
onger
> be needed.

I agree that f2fs_readonly() is redundant.
But, sorry, I don't get the rest. I thought mnt_want_write_file() is a
way to check whether the caller has a proper write permission or not.
I think just using mnt_want_write_file() is enough for this ioctl. Am
I missing something?

> What if f2fs_cops[options.algorithm] =3D=3D NULL, e.g. COMPRESS_LZ4 witho=
ut
> CONFIG_F2FS_FS_LZ4?  Shouldn't the caller get an error then?

Good point!

> I don't think the check for i_writecount =3D=3D 1 accomplishes anything b=
ecause it
> just means there are no *other* writable file descriptors.  It doesn't me=
an that
> some other thread isn't concurrently trying to write to this same file
> descriptor.  So the lock needs to be enough.  Is it?

This is to detect any possibility of other threads mmap-ing and
writing the file.
Using only inode lock is not enough to prevent them from making dirty pages=
.



2020=EB=85=84 10=EC=9B=94 13=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:11, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Oct 13, 2020 at 11:24:29AM +0900, Daeho Jeong wrote:
> > +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned lo=
ng arg)
> > +{
> > +     struct inode *inode =3D file_inode(filp);
> > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > +     struct f2fs_comp_option option;
> > +     int ret;
> > +     int writecount;
> > +
> > +     if (!f2fs_sb_has_compression(sbi))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (!f2fs_compressed_file(inode) || IS_IMMUTABLE(inode))
> > +             return -EINVAL;
> > +
> > +     if (f2fs_readonly(sbi->sb))
> > +             return -EROFS;
>

>
> > +
> > +     if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg=
,
> > +                             sizeof(option)))
> > +             return -EFAULT;
> > +
> > +     if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> > +                     option.log_cluster_size > MAX_COMPRESS_LOG_SIZE |=
|
> > +                     option.algorithm >=3D COMPRESS_MAX)
> > +             return -EINVAL;
>
> What if f2fs_cops[options.algorithm] =3D=3D NULL, e.g. COMPRESS_LZ4 witho=
ut
> CONFIG_F2FS_FS_LZ4?  Shouldn't the caller get an error then?
>
> > +
> > +     ret =3D mnt_want_write_file(filp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     inode_lock(inode);
> > +
> > +     writecount =3D atomic_read(&inode->i_writecount);
> > +     if ((filp->f_mode & FMODE_WRITE && writecount !=3D 1) ||
> > +                     (!(filp->f_mode & FMODE_WRITE) && writecount)) {
> > +             ret =3D -EBUSY;
> > +             goto out;
> > +     }
>
> I don't think the check for i_writecount =3D=3D 1 accomplishes anything b=
ecause it
> just means there are no *other* writable file descriptors.  It doesn't me=
an that
> some other thread isn't concurrently trying to write to this same file
> descriptor.  So the lock needs to be enough.  Is it?
>
> - Eric
