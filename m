Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1426529E486
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgJ2Hkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgJ2HjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:39:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D5C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:39:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 184so2050947lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=he7/Q0EWUd1O2tBuvy1gbDcXslQq/wQhIAmuZ2iZjGU=;
        b=skgRDXixAfoNPdaIrWu0fEaa2JrzRyG3RQlf9zr50ZMkN/dqnvPiY5HC/VhB308BUU
         SjRO3tC8rRHkPaefd572Myu6NGuviOCxA9QdvuucAWGrVVQnXx5o1Y5M0/pLEmbbAPum
         FLTNdpkFmNINEv0C1NiE2FJIbLVc9n3brc7EbnxKgG7rmC5Lb/oHzEKDZR8vId9HpSoG
         rFiV10Lb64UR1/Ki8Mv0eKaS1ivENKk2pmBobvaDcDJ0QI0ggLTtHo6qEbGo+7DBis2F
         5EtRmUV5VbfGQyJwY2uN6eonw+PLJQFtpNbucf7JBAre895Fwlwp282lqadizR09u9Hg
         OZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=he7/Q0EWUd1O2tBuvy1gbDcXslQq/wQhIAmuZ2iZjGU=;
        b=sd2w0esKHdnbMcRmGEKw+uVwZ33yavKMik7hGPs2Ze9UKxVDQ4xtlbBk56/qIVxcaJ
         66IZVq3sbYvD+/VBJck38KG4oN6D/7eJh1o5rNRACzrdbZndCBx9KCQgfytnOakFMPOo
         zmbciL4WFy7FMzNBRjILL6XPb40pcUlXF6K8CAX1GZ3P5NFdYqx3TD7OdEeFgY6p+h+l
         7iMGp6Ty/uoUfIqEGheOtRZDkIQBIDvPXyjxJkLZyE/0ymH9+kQjwH7elVHMmAFCB35Z
         WqMyHaWsnDWRs7zxAlZ0Zd/G01CUzAEeSa2A9ElLCI3MSDWBHFcjCEsUyJ6HOMULG/Ae
         lilw==
X-Gm-Message-State: AOAM531pAZc1HF5zXIBw+ivm7rRroYeUGqdArARMJcxAtg66g+gvuKWS
        FgvQCFHsyhzuvNhbIQxiqMi7MgazQGfI2fgyRjI=
X-Google-Smtp-Source: ABdhPJxV5XUy8QBXcyu3nV2a8jqQOFvsw50T6Hfv20oOYHlOwpkojWKn2GzEAv2P/nRkagye+yhAtxf9HUivxZsNHcA=
X-Received: by 2002:a19:e342:: with SMTP id c2mr971416lfk.539.1603957156591;
 Thu, 29 Oct 2020 00:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201029041538.4165209-1-daeho43@gmail.com> <20201029041538.4165209-2-daeho43@gmail.com>
 <92f4da8e-27a1-7577-84f9-39038eaa88cb@huawei.com>
In-Reply-To: <92f4da8e-27a1-7577-84f9-39038eaa88cb@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 29 Oct 2020 16:39:05 +0900
Message-ID: <CACOAw_xz=n21-Pmot2aMCCwPWzMpTUHM_rshYBgVsuGM+S_uuw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_cops is a static variable. Do you wanna change this to global
variable (extern)?

2020=EB=85=84 10=EC=9B=94 29=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 4:29, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/10/29 12:15, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a new F2FS_IOC_SET_COMPRESS_OPTION ioctl to change file
> > compression option of a file.
> >
> > struct f2fs_comp_option {
> >      u8 algorithm;         =3D> compression algorithm
> >                            =3D> 0:lzo, 1:lz4, 2:zstd, 3:lzorle
> >      u8 log_cluster_size;  =3D> log scale cluster size
> >                            =3D> 2 ~ 8
> > };
> >
> > struct f2fs_comp_option option;
> >
> > option.algorithm =3D 1;
> > option.log_cluster_size =3D 7;
> >
> > ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION, &option);
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >
> > v5: allowed to set algorithm which is not currently enabled by kernel
> > v4: changed commit message.
> > v3: changed the error number more specific.
> >      folded in fix for build breakage reported by kernel test robot
> >      <lkp@intel.com> and Dan Carpenter <dan.carpenter@oracle.com>.
> > v2: added ioctl description.
> > ---
> >   fs/f2fs/compress.c |  5 +++++
> >   fs/f2fs/f2fs.h     |  7 ++++++
> >   fs/f2fs/file.c     | 54 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 66 insertions(+)
> >
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 7895186cc765..816d7adc914c 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *=
inode)
> >       return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
> >   }
> >
> > +bool f2fs_is_compress_algorithm_ready(unsigned char algorithm)
> > +{
> > +     return algorithm < COMPRESS_MAX && f2fs_cops[algorithm] !=3D NULL=
;
> > +}
> > +
> >   static mempool_t *compress_page_pool;
> >   static int num_compress_pages =3D 512;
> >   module_param(num_compress_pages, uint, 0444);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a33c90cf979b..cc38afde6c04 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -435,6 +435,8 @@ static inline bool __has_cursum_space(struct f2fs_j=
ournal *journal,
> >                                               struct f2fs_sectrim_range=
)
> >   #define F2FS_IOC_GET_COMPRESS_OPTION        _IOR(F2FS_IOCTL_MAGIC, 21=
,      \
> >                                               struct f2fs_comp_option)
> > +#define F2FS_IOC_SET_COMPRESS_OPTION _IOW(F2FS_IOCTL_MAGIC, 22,      \
> > +                                             struct f2fs_comp_option)
> >
> >   /*
> >    * should be same as XFS_IOC_GOINGDOWN.
> > @@ -3915,6 +3917,7 @@ bool f2fs_compress_write_end(struct inode *inode,=
 void *fsdata,
> >   int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool=
 lock);
> >   void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
> >   bool f2fs_is_compress_backend_ready(struct inode *inode);
> > +bool f2fs_is_compress_algorithm_ready(unsigned char algorithm);
> >   int f2fs_init_compress_mempool(void);
> >   void f2fs_destroy_compress_mempool(void);
> >   void f2fs_decompress_pages(struct bio *bio, struct page *page, bool v=
erity);
> > @@ -3945,6 +3948,10 @@ static inline bool f2fs_is_compress_backend_read=
y(struct inode *inode)
> >       /* not support compression */
> >       return false;
> >   }
> > +static inline bool f2fs_is_compress_algorithm_ready(unsigned char algo=
rithm)
> > +{
> > +     return false;
> > +}
> >   static inline struct page *f2fs_compress_control_page(struct page *pa=
ge)
> >   {
> >       WARN_ON_ONCE(1);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 8922ab191a9d..a0f31d8ebcfd 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3963,6 +3963,57 @@ static int f2fs_ioc_get_compress_option(struct f=
ile *filp, unsigned long arg)
> >       return 0;
> >   }
> >
> > +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned lo=
ng arg)
> > +{
> > +     struct inode *inode =3D file_inode(filp);
> > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > +     struct f2fs_comp_option option;
> > +     int ret =3D 0;
> > +
> > +     if (!f2fs_sb_has_compression(sbi))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (!(filp->f_mode & FMODE_WRITE))
> > +             return -EBADF;
> > +
> > +     if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg=
,
> > +                             sizeof(option)))
> > +             return -EFAULT;
> > +
> > +     if (!f2fs_compressed_file(inode) ||
> > +                     option.log_cluster_size < MIN_COMPRESS_LOG_SIZE |=
|
> > +                     option.log_cluster_size > MAX_COMPRESS_LOG_SIZE |=
|
> > +                     option.algorithm >=3D COMPRESS_MAX)
> > +             return -EINVAL;
> > +
> > +     file_start_write(filp);
> > +     inode_lock(inode);
> > +
> > +     if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
> > +             ret =3D -EBUSY;
> > +             goto out;
> > +     }
> > +
> > +     if (inode->i_size !=3D 0) {
> > +             ret =3D -EFBIG;
> > +             goto out;
> > +     }
>
> Hmm...
>
> Shouldn't it be:
>
> if (algorithm >=3D COMPRESS_MAX) {
>         ret =3D -ENOPKG;
>         goto out;
> }
>
> if (!f2fs_cops[algorithm])
>         f2fs_warn(...);
>
> > +
> > +     F2FS_I(inode)->i_compress_algorithm =3D option.algorithm;
> > +     F2FS_I(inode)->i_log_cluster_size =3D option.log_cluster_size;
> > +     F2FS_I(inode)->i_cluster_size =3D 1 << option.log_cluster_size;
> > +     f2fs_mark_inode_dirty_sync(inode, true);
> > +
> > +     if (!f2fs_is_compress_algorithm_ready(option.algorithm))
> > +             f2fs_warn(sbi, "compression algorithm is successfully set=
, "
> > +                     "but current kernel doesn't support this algorith=
m.");
> > +out:
> > +     inode_unlock(inode);
> > +     file_end_write(filp);
> > +
> > +     return ret;
> > +}
> > +
> >   long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long ar=
g)
> >   {
> >       if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> > @@ -4053,6 +4104,8 @@ long f2fs_ioctl(struct file *filp, unsigned int c=
md, unsigned long arg)
> >               return f2fs_sec_trim_file(filp, arg);
> >       case F2FS_IOC_GET_COMPRESS_OPTION:
> >               return f2fs_ioc_get_compress_option(filp, arg);
> > +     case F2FS_IOC_SET_COMPRESS_OPTION:
> > +             return f2fs_ioc_set_compress_option(filp, arg);
> >       default:
> >               return -ENOTTY;
> >       }
> > @@ -4224,6 +4277,7 @@ long f2fs_compat_ioctl(struct file *file, unsigne=
d int cmd, unsigned long arg)
> >       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >       case F2FS_IOC_SEC_TRIM_FILE:
> >       case F2FS_IOC_GET_COMPRESS_OPTION:
> > +     case F2FS_IOC_SET_COMPRESS_OPTION:
> >               break;
> >       default:
> >               return -ENOIOCTLCMD;
> >
