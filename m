Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6625B2C4E29
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 06:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgKZFEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 00:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgKZFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 00:04:54 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 21:04:54 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so895162ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 21:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mr3M1d7Ya09mmBd3mIMV36AOJTbJZ2AUv7On7VuvZMU=;
        b=h/62M8sU3UOxjLgc+vBM2+wz/Q84zR3ff4HEJtjVR03ogQykCuuLy3p9pfkxPD+NoY
         CCPytUNGT8YfiemZw2uUaKx+ueYkQhSpfjQJa7g/b84AbtS4dQyt2f0TSRwn3whjvIh1
         9RevpJAuQg6m3YseXJaSq2bRMTlNwJwlat7tZI9SN9Zheenlt+NBGx70CyxlQhKs21fB
         sOiyakUT75dDpMe3Zke0sli6rm7VH1dpL/ziH9CssuYvQz8eZ9D6xapfhDD+BClcW388
         qmodGWlPR1SUwEn2GYPiURHIFayPGE33Xdj8WCjqbby9flQ0uywpTZmi1bTc99gc3x3e
         HQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mr3M1d7Ya09mmBd3mIMV36AOJTbJZ2AUv7On7VuvZMU=;
        b=CAvsIhkpmvUl/EL9vsAORosR0aIBj9xwDE+peD1DSJJP3FtoSc09rtAlRH4o9N8k3j
         19ynx8AoI0DFCFglQHnkA4uiXan9wdWfu7eh/Jy2jqH8+QtoozWUbpOBdU5COXtNS9Xk
         Wn0UIebC0fjpkE7xszpXEFGIDerAvArVjhOLj0eMGd7hbluuMD4+mlImuPsvxibBtkOz
         UXJbxkLeaXilthXdWIpP1a9C8+3r7SrpJ4q7zQazWQH/JIwZMR/FBdsy2t9hUo74BmCm
         H6iV4wlaM0OWSI5BF1vM9D80KzN1el9IPEFZedoczDhc/MdgfxyrmgEtO1SYIaFBKq5t
         NIjg==
X-Gm-Message-State: AOAM5310Td+GKI3ptNdamh8Yc0uQOrz7+qi8r7XMx/bcXnDUxmpSOhN0
        4U38tSTiZOdEoZy2EFDxaJ9VTHNGpSFvFfcNQec=
X-Google-Smtp-Source: ABdhPJwjVuQc61XMORu7AUTTxJMiEc5ih+wtpxWk2GC1VJ+qApPujEh+mNysVmCrPMC4Rp5hsZK/8bxC6nag+l9vkkA=
X-Received: by 2002:a2e:9707:: with SMTP id r7mr531976lji.265.1606367092479;
 Wed, 25 Nov 2020 21:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com> <20201123031751.36811-2-daeho43@gmail.com>
 <5b3cb83d-5d0f-c1ca-2cff-f28372dec48e@huawei.com>
In-Reply-To: <5b3cb83d-5d0f-c1ca-2cff-f28372dec48e@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 26 Nov 2020 14:04:41 +0900
Message-ID: <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
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

Eric,

do_page_cache_ra() is defined in mm/internal.h for internal use
between in mm, so we cannot use this one right now.
So, I think we could use page_cache_ra_unbounded(), because we already
check i_size boundary on our own.
What do you think?

2020=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 12:05,=
 Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/11/23 11:17, Daeho Jeong wrote:
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
> >   fs/f2fs/file.c            | 181 +++++++++++++++++++++++++++++++++++++=
-
> >   include/uapi/linux/f2fs.h |   2 +
> >   2 files changed, 182 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index be8db06aca27..e8f142470e87 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4026,6 +4026,180 @@ static int f2fs_ioc_set_compress_option(struct =
file *filp, unsigned long arg)
> >       return ret;
> >   }
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
> > +
> > +     for (i =3D 0; i < len; i++, page_idx++) {
> > +             page =3D read_cache_page(mapping, page_idx, NULL, NULL);
> > +             if (IS_ERR(page)) {
> > +                     ret =3D PTR_ERR(page);
> > +                     f2fs_warn(sbi, "%s: inode (%lu) : page_index (%lu=
) "
> > +                             "couldn't be read (errno:%d).\n",
> > +                             __func__, inode->i_ino, page_idx, ret);
>
> This is a common error case during calling read_cache_page(), IMO, this l=
ooks
> more like a debug log, so I prefer to print nothing here, or at least usi=
ng
> f2fs_debug() instead.
>
> > +                     break;
> > +             }
> > +             page_len++;
> > +     }
> > +
> > +     for (i =3D 0; i < page_len; i++, redirty_idx++) {
> > +             page =3D find_lock_page(mapping, redirty_idx);
> > +             if (!page) {
> > +                     ret =3D -ENOENT;
> > +                     f2fs_warn(sbi, "%s: inode (%lu) : page_index (%lu=
) "
> > +                             "couldn't be found (errno:%d).\n",
> > +                             __func__, inode->i_ino, redirty_idx, ret)=
;
>
> Ditto.
>
> > +             }
> > +             set_page_dirty(page);
> > +             f2fs_put_page(page, 1);
> > +             f2fs_put_page(page, 0);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int f2fs_ioc_decompress_file(struct file *filp, unsigned long a=
rg)
> > +{
> > +     struct inode *inode =3D file_inode(filp);
> > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > +     struct f2fs_inode_info *fi =3D F2FS_I(inode);
> > +     pgoff_t page_idx =3D 0, last_idx;
> > +     int cluster_size =3D F2FS_I(inode)->i_cluster_size;
> > +     int count, ret;
> > +
> > +     if (!f2fs_sb_has_compression(sbi))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (!(filp->f_mode & FMODE_WRITE))
> > +             return -EBADF;
> > +
> > +     if (!f2fs_compressed_file(inode))
> > +             return -EINVAL;
>
> Before compressubg/decompressing file, should we check whether current in=
ode's
> compress algorithm backend is available in f2fs module?
>
> > +
> > +     f2fs_balance_fs(F2FS_I_SB(inode), true);
> > +
> > +     file_start_write(filp);
> > +     inode_lock(inode);
> > +
> > +     if (f2fs_is_mmap_file(inode)) {
> > +             ret =3D -EBUSY;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_M=
AX);
> > +     if (ret)
> > +             goto out;
> > +
> > +     if (!atomic_read(&fi->i_compr_blocks))
> > +             goto out;
> > +
> > +     last_idx =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > +
> > +     count =3D last_idx - page_idx;
> > +     while (count) {
> > +             int len =3D min(cluster_size, count);
> > +
> > +             ret =3D redirty_blocks(inode, page_idx, len);
> > +
>
> unneeded blank line..
>
> > +             if (ret < 0)
> > +                     break;
> > +
> > +             page_idx +=3D len;
> > +             count -=3D len;
>
> Considering there isn't so many memory in low-end device, how about calli=
ng
> filemap_fdatawrite() to writeback cluster after redirty several clusters
> or xxMB?
>
> > +     }
> > +
> > +     if (!ret)
> > +             ret =3D filemap_write_and_wait_range(inode->i_mapping, 0,
> > +                                                     LLONG_MAX);
> > +
> > +     if (!ret) {
> > +             stat_sub_compr_blocks(inode, atomic_read(&fi->i_compr_blo=
cks));
> > +             atomic_set(&fi->i_compr_blocks, 0);
> > +             f2fs_mark_inode_dirty_sync(inode, true);
>
> A little bit wired, why not failing cluster_may_compress() for user mode,=
 and
> let writepages write cluster as raw blocks, in-where we can update i_comp=
r_blocks
> and global compr block stats correctly.
>
> > +     } else {
> > +             f2fs_warn(sbi, "%s: The file might be partially decompres=
sed "
> > +                             "(errno=3D%d). Please delete the file.\n"=
,
> > +                             __func__, ret);
> > +     }
> > +out:
> > +     inode_unlock(inode);
> > +     file_end_write(filp);
> > +
> > +     return ret;
> > +}
> > +
> > +static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg=
)
> > +{
> > +     struct inode *inode =3D file_inode(filp);
> > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > +     pgoff_t page_idx =3D 0, last_idx;
> > +     int cluster_size =3D F2FS_I(inode)->i_cluster_size;
> > +     int count, ret;
> > +
> > +     if (!f2fs_sb_has_compression(sbi))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (!(filp->f_mode & FMODE_WRITE))
> > +             return -EBADF;
> > +
> > +     if (!f2fs_compressed_file(inode))
> > +             return -EINVAL;
>
> algorithm backend check?
>
> > +
> > +     f2fs_balance_fs(F2FS_I_SB(inode), true);
> > +
> > +     file_start_write(filp);
> > +     inode_lock(inode);
> > +
> > +     if (f2fs_is_mmap_file(inode)) {
> > +             ret =3D -EBUSY;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_M=
AX);
> > +     if (ret)
> > +             goto out;
> > +
> > +     set_inode_flag(inode, FI_ENABLE_COMPRESS);
> > +
> > +     last_idx =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > +
> > +     count =3D last_idx - page_idx;
> > +     while (count) {
> > +             int len =3D min(cluster_size, count);
> > +
> > +             ret =3D redirty_blocks(inode, page_idx, len);
> > +
>
> Ditto.
>
> Thanks,
>
> > +             if (ret < 0)
> > +                     break;
> > +
> > +             page_idx +=3D len;
> > +             count -=3D len;
> > +     }
> > +
> > +     if (!ret)
> > +             ret =3D filemap_write_and_wait_range(inode->i_mapping, 0,
> > +                                                     LLONG_MAX);
> > +
> > +     clear_inode_flag(inode, FI_ENABLE_COMPRESS);
> > +
> > +     if (ret)
> > +             f2fs_warn(sbi, "%s: The file might be partially compresse=
d "
> > +                             "(errno=3D%d). Please delete the file.\n"=
,
> > +                             __func__, ret);
> > +out:
> > +     inode_unlock(inode);
> > +     file_end_write(filp);
> > +
> > +     return ret;
> > +}
> > +
> >   static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigne=
d long arg)
> >   {
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
> > @@ -4352,7 +4530,8 @@ long f2fs_compat_ioctl(struct file *file, unsigne=
d int cmd, unsigned long arg)
> >       case F2FS_IOC_SEC_TRIM_FILE:
> >       case F2FS_IOC_GET_COMPRESS_OPTION:
> >       case F2FS_IOC_SET_COMPRESS_OPTION:
> > -             break;
> > +     case F2FS_IOC_DECOMPRESS_FILE:
> > +     case F2FS_IOC_COMPRESS_FILE:
> >       default:
> >               return -ENOIOCTLCMD;
> >       }
> > diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> > index f00199a2e38b..352a822d4370 100644
> > --- a/include/uapi/linux/f2fs.h
> > +++ b/include/uapi/linux/f2fs.h
> > @@ -40,6 +40,8 @@
> >                                               struct f2fs_comp_option)
> >   #define F2FS_IOC_SET_COMPRESS_OPTION        _IOW(F2FS_IOCTL_MAGIC, 22=
,      \
> >                                               struct f2fs_comp_option)
> > +#define F2FS_IOC_DECOMPRESS_FILE     _IO(F2FS_IOCTL_MAGIC, 23)
> > +#define F2FS_IOC_COMPRESS_FILE               _IO(F2FS_IOCTL_MAGIC, 24)
> >
> >   /*
> >    * should be same as XFS_IOC_GOINGDOWN.
> >
