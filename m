Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFF2C4ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbgKZGfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbgKZGfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:35:44 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF0CC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 22:35:44 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so1121699ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 22:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kswQN8hylvVmj1dloD7oCUNsk0sKwNoCfEAJ+XvkODA=;
        b=seijIfZpT2YT3SjNKAre5f3jBenXZXAQK9kvmcbylUKf1iuG1tQ5eJTOwTblYfz9q2
         P4gLQlY8IjUtnpgppoztdv4EXhR8XmofqcFtnV+iRKGr/CLQF+YItn7QMXHRcIRhqgUB
         mIBkC0H99xQxAzRDskoarLQ4SR7w7NGmlK+DAbj6mh7ZJiaVsUFI3DUoh2qug8KeFdMl
         OwOjWCkpko8qAfclRGmw92+SFZmoUEdTgcg3BHxyV2+gH1A8wTKSKSPJGBLI3nfCO8cF
         e9ZmA0eExi8gtSq/jFbdeRy1SUfdU5L3hG/Ti9eY3QH8777B797dagiN0Ca/RN08lcZj
         28RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kswQN8hylvVmj1dloD7oCUNsk0sKwNoCfEAJ+XvkODA=;
        b=kj67lFn+0EyZWjdRCnUvSTPEaTM/UlY3S8/bfGHU3PZL99ftXgLJ8kADPRS4FzqrH/
         fekkPvObncizqP6OqSR8d+/ji8VVu/4ME93DwAygWUGT393h61//dHWAD91G5yZZ51zY
         0BhIAU4jR1Kz1E6UqfBCzgqqTwcPModXZvzQNBCgkyqvOmJJFBheoGRyNwaIXfu6vJGY
         o9RgnvRKHMr/NCzy6Uzv8/9kvhIZKb6fzu5IBNYmB9trx+D1v4H6q84c9piQaQbFNyrw
         c/SJhFxXjfpHHaHo0p85XEL8FxbV6L/5kxmOhFQdDf3iP6DoOzvt65t2SIFdv2KI+10M
         Aj+g==
X-Gm-Message-State: AOAM530+MA+z6dIAjTwqPrtx7Efr+ea2Diq2MThTqXzORZ0EJCOHjOao
        hJzntHvtIJWlc4UV3gY8Tai3Wi8YQ+jois1eLCQ=
X-Google-Smtp-Source: ABdhPJz8jT2sDRQd5l6UwXbael3ft2llBXIO5gm3mtifE7AdOK2sXpE+zEDjsWcZiPTclUKQLuUtXmxH1J9Vdh1MfSo=
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr669611ljn.250.1606372542585;
 Wed, 25 Nov 2020 22:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com> <20201123031751.36811-2-daeho43@gmail.com>
 <5b3cb83d-5d0f-c1ca-2cff-f28372dec48e@huawei.com> <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
In-Reply-To: <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 26 Nov 2020 15:35:31 +0900
Message-ID: <CACOAw_yRD5uQiZLXj2X_MjamCQSK+WHRDuvdvVeEeAFJqDpbMw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao,

> A little bit wired, why not failing cluster_may_compress() for user mode,=
 and
> let writepages write cluster as raw blocks, in-where we can update i_comp=
r_blocks
> and global compr block stats correctly.

For decompression ioctl, I've made f2fs_need_compress_data() return
"false" to prevent compression write, so we don't use
f2fs_write_compressed_pages() anymore in this case.
Because of this, I manually updated i_compr_blocks. Do you have any
suggestions on this?

2020=EB=85=84 11=EC=9B=94 26=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 2:04, =
Daeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Eric,
>
> do_page_cache_ra() is defined in mm/internal.h for internal use
> between in mm, so we cannot use this one right now.
> So, I think we could use page_cache_ra_unbounded(), because we already
> check i_size boundary on our own.
> What do you think?
>
> 2020=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 12:0=
5, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On 2020/11/23 11:17, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > Added two ioctl to decompress/compress explicitly the compression
> > > enabled file in "compress_mode=3Duser-based" mount option.
> > >
> > > Using these two ioctls, the users can make a control of compression
> > > and decompression of their files.
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > >   fs/f2fs/file.c            | 181 +++++++++++++++++++++++++++++++++++=
++-
> > >   include/uapi/linux/f2fs.h |   2 +
> > >   2 files changed, 182 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index be8db06aca27..e8f142470e87 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -4026,6 +4026,180 @@ static int f2fs_ioc_set_compress_option(struc=
t file *filp, unsigned long arg)
> > >       return ret;
> > >   }
> > >
> > > +static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int=
 len)
> > > +{
> > > +     DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
> > > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > > +     struct address_space *mapping =3D inode->i_mapping;
> > > +     struct page *page;
> > > +     pgoff_t redirty_idx =3D page_idx;
> > > +     int i, page_len =3D 0, ret =3D 0;
> > > +
> > > +     page_cache_ra_unbounded(&ractl, len, 0);
> > > +
> > > +     for (i =3D 0; i < len; i++, page_idx++) {
> > > +             page =3D read_cache_page(mapping, page_idx, NULL, NULL)=
;
> > > +             if (IS_ERR(page)) {
> > > +                     ret =3D PTR_ERR(page);
> > > +                     f2fs_warn(sbi, "%s: inode (%lu) : page_index (%=
lu) "
> > > +                             "couldn't be read (errno:%d).\n",
> > > +                             __func__, inode->i_ino, page_idx, ret);
> >
> > This is a common error case during calling read_cache_page(), IMO, this=
 looks
> > more like a debug log, so I prefer to print nothing here, or at least u=
sing
> > f2fs_debug() instead.
> >
> > > +                     break;
> > > +             }
> > > +             page_len++;
> > > +     }
> > > +
> > > +     for (i =3D 0; i < page_len; i++, redirty_idx++) {
> > > +             page =3D find_lock_page(mapping, redirty_idx);
> > > +             if (!page) {
> > > +                     ret =3D -ENOENT;
> > > +                     f2fs_warn(sbi, "%s: inode (%lu) : page_index (%=
lu) "
> > > +                             "couldn't be found (errno:%d).\n",
> > > +                             __func__, inode->i_ino, redirty_idx, re=
t);
> >
> > Ditto.
> >
> > > +             }
> > > +             set_page_dirty(page);
> > > +             f2fs_put_page(page, 1);
> > > +             f2fs_put_page(page, 0);
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int f2fs_ioc_decompress_file(struct file *filp, unsigned long=
 arg)
> > > +{
> > > +     struct inode *inode =3D file_inode(filp);
> > > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > > +     struct f2fs_inode_info *fi =3D F2FS_I(inode);
> > > +     pgoff_t page_idx =3D 0, last_idx;
> > > +     int cluster_size =3D F2FS_I(inode)->i_cluster_size;
> > > +     int count, ret;
> > > +
> > > +     if (!f2fs_sb_has_compression(sbi))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     if (!(filp->f_mode & FMODE_WRITE))
> > > +             return -EBADF;
> > > +
> > > +     if (!f2fs_compressed_file(inode))
> > > +             return -EINVAL;
> >
> > Before compressubg/decompressing file, should we check whether current =
inode's
> > compress algorithm backend is available in f2fs module?
> >
> > > +
> > > +     f2fs_balance_fs(F2FS_I_SB(inode), true);
> > > +
> > > +     file_start_write(filp);
> > > +     inode_lock(inode);
> > > +
> > > +     if (f2fs_is_mmap_file(inode)) {
> > > +             ret =3D -EBUSY;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret =3D filemap_write_and_wait_range(inode->i_mapping, 0, LLONG=
_MAX);
> > > +     if (ret)
> > > +             goto out;
> > > +
> > > +     if (!atomic_read(&fi->i_compr_blocks))
> > > +             goto out;
> > > +
> > > +     last_idx =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > > +
> > > +     count =3D last_idx - page_idx;
> > > +     while (count) {
> > > +             int len =3D min(cluster_size, count);
> > > +
> > > +             ret =3D redirty_blocks(inode, page_idx, len);
> > > +
> >
> > unneeded blank line..
> >
> > > +             if (ret < 0)
> > > +                     break;
> > > +
> > > +             page_idx +=3D len;
> > > +             count -=3D len;
> >
> > Considering there isn't so many memory in low-end device, how about cal=
ling
> > filemap_fdatawrite() to writeback cluster after redirty several cluster=
s
> > or xxMB?
> >
> > > +     }
> > > +
> > > +     if (!ret)
> > > +             ret =3D filemap_write_and_wait_range(inode->i_mapping, =
0,
> > > +                                                     LLONG_MAX);
> > > +
> > > +     if (!ret) {
> > > +             stat_sub_compr_blocks(inode, atomic_read(&fi->i_compr_b=
locks));
> > > +             atomic_set(&fi->i_compr_blocks, 0);
> > > +             f2fs_mark_inode_dirty_sync(inode, true);
> >
> > A little bit wired, why not failing cluster_may_compress() for user mod=
e, and
> > let writepages write cluster as raw blocks, in-where we can update i_co=
mpr_blocks
> > and global compr block stats correctly.
> >
> > > +     } else {
> > > +             f2fs_warn(sbi, "%s: The file might be partially decompr=
essed "
> > > +                             "(errno=3D%d). Please delete the file.\=
n",
> > > +                             __func__, ret);
> > > +     }
> > > +out:
> > > +     inode_unlock(inode);
> > > +     file_end_write(filp);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int f2fs_ioc_compress_file(struct file *filp, unsigned long a=
rg)
> > > +{
> > > +     struct inode *inode =3D file_inode(filp);
> > > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > > +     pgoff_t page_idx =3D 0, last_idx;
> > > +     int cluster_size =3D F2FS_I(inode)->i_cluster_size;
> > > +     int count, ret;
> > > +
> > > +     if (!f2fs_sb_has_compression(sbi))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     if (!(filp->f_mode & FMODE_WRITE))
> > > +             return -EBADF;
> > > +
> > > +     if (!f2fs_compressed_file(inode))
> > > +             return -EINVAL;
> >
> > algorithm backend check?
> >
> > > +
> > > +     f2fs_balance_fs(F2FS_I_SB(inode), true);
> > > +
> > > +     file_start_write(filp);
> > > +     inode_lock(inode);
> > > +
> > > +     if (f2fs_is_mmap_file(inode)) {
> > > +             ret =3D -EBUSY;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret =3D filemap_write_and_wait_range(inode->i_mapping, 0, LLONG=
_MAX);
> > > +     if (ret)
> > > +             goto out;
> > > +
> > > +     set_inode_flag(inode, FI_ENABLE_COMPRESS);
> > > +
> > > +     last_idx =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > > +
> > > +     count =3D last_idx - page_idx;
> > > +     while (count) {
> > > +             int len =3D min(cluster_size, count);
> > > +
> > > +             ret =3D redirty_blocks(inode, page_idx, len);
> > > +
> >
> > Ditto.
> >
> > Thanks,
> >
> > > +             if (ret < 0)
> > > +                     break;
> > > +
> > > +             page_idx +=3D len;
> > > +             count -=3D len;
> > > +     }
> > > +
> > > +     if (!ret)
> > > +             ret =3D filemap_write_and_wait_range(inode->i_mapping, =
0,
> > > +                                                     LLONG_MAX);
> > > +
> > > +     clear_inode_flag(inode, FI_ENABLE_COMPRESS);
> > > +
> > > +     if (ret)
> > > +             f2fs_warn(sbi, "%s: The file might be partially compres=
sed "
> > > +                             "(errno=3D%d). Please delete the file.\=
n",
> > > +                             __func__, ret);
> > > +out:
> > > +     inode_unlock(inode);
> > > +     file_end_write(filp);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >   static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsig=
ned long arg)
> > >   {
> > >       switch (cmd) {
> > > @@ -4113,6 +4287,10 @@ static long __f2fs_ioctl(struct file *filp, un=
signed int cmd, unsigned long arg)
> > >               return f2fs_ioc_get_compress_option(filp, arg);
> > >       case F2FS_IOC_SET_COMPRESS_OPTION:
> > >               return f2fs_ioc_set_compress_option(filp, arg);
> > > +     case F2FS_IOC_DECOMPRESS_FILE:
> > > +             return f2fs_ioc_decompress_file(filp, arg);
> > > +     case F2FS_IOC_COMPRESS_FILE:
> > > +             return f2fs_ioc_compress_file(filp, arg);
> > >       default:
> > >               return -ENOTTY;
> > >       }
> > > @@ -4352,7 +4530,8 @@ long f2fs_compat_ioctl(struct file *file, unsig=
ned int cmd, unsigned long arg)
> > >       case F2FS_IOC_SEC_TRIM_FILE:
> > >       case F2FS_IOC_GET_COMPRESS_OPTION:
> > >       case F2FS_IOC_SET_COMPRESS_OPTION:
> > > -             break;
> > > +     case F2FS_IOC_DECOMPRESS_FILE:
> > > +     case F2FS_IOC_COMPRESS_FILE:
> > >       default:
> > >               return -ENOIOCTLCMD;
> > >       }
> > > diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> > > index f00199a2e38b..352a822d4370 100644
> > > --- a/include/uapi/linux/f2fs.h
> > > +++ b/include/uapi/linux/f2fs.h
> > > @@ -40,6 +40,8 @@
> > >                                               struct f2fs_comp_option=
)
> > >   #define F2FS_IOC_SET_COMPRESS_OPTION        _IOW(F2FS_IOCTL_MAGIC, =
22,      \
> > >                                               struct f2fs_comp_option=
)
> > > +#define F2FS_IOC_DECOMPRESS_FILE     _IO(F2FS_IOCTL_MAGIC, 23)
> > > +#define F2FS_IOC_COMPRESS_FILE               _IO(F2FS_IOCTL_MAGIC, 2=
4)
> > >
> > >   /*
> > >    * should be same as XFS_IOC_GOINGDOWN.
> > >
