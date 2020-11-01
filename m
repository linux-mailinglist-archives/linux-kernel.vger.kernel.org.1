Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93EA2A2269
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgKAXmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgKAXmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:42:13 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA24C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 15:42:13 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id y184so13150956lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 15:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hodiMZOr93BdBLterfeyv8enR8PxXJe7WYyAmUeOaZM=;
        b=TWU6xNubS7vO1B6LPXr2KI8PDpAtsXz02cdYKQCyuDmMFyD48tIxVKCnGcTsYGaQRS
         sfugwQKvjj5MK78jhpRaKfd77j4J4hgD0LNIRH7EteiUttGkUqyKN9jsXLPXqBSo8xxU
         Pa0nlkB5mKguTjNEMxiNdLmuOsysIxaTFAkSwRstgENMGi7TNYw3qXh/vw7unHOescbp
         DI6l1v5KLU3wkNdZ466o+z7bQ95X4td22N8oMPZxPLDIWrq20Cq++4G9CVue7IA0ENfd
         prDCcpew6rZq6NuvmNl/yQnhMxNzQYbLFQH/VZJ7WRoQdHx3QmtlqvBujLK4qesH67JS
         2M5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hodiMZOr93BdBLterfeyv8enR8PxXJe7WYyAmUeOaZM=;
        b=E8l371jxmkynjOvIGnqEaIAzDrHWCex2iaqtMUCSpCQkGfQlA6LUBAVXh5R40EVMA+
         5shw/YjTLNYC9VvfyQDOijuI/SnuKINkMvxFKLSZdBetuqW10QHE1MJ1o7yQWC4sYtKJ
         uCXiUE0nHoILhcVEf5a9zPvZCQfGQhjUbDFbfexbLAQXc6/+hB/YplkYvux5kiEs1XOi
         +4PWknA9Sr1U16YmUDO1TwVPCipCrycjlIfrvY3mT2kxBRe5DWE0G2CqiXSGPxUhP0Nj
         g58ujnFTQH/Z1HuDLG8d1Z9YT0ss/nHWhwwkWoYsRpRsSeyRCcA17zBpf7WSQ/z5io8G
         ulEQ==
X-Gm-Message-State: AOAM532UXG5laFWgV8oc0KKDG88uTWis/SG1zS20HFaxqis/Du3HRd0e
        AKkZZpr8Ye9sbA4r4T+vcckE1iPgR3P4A3HIzdU=
X-Google-Smtp-Source: ABdhPJwiG/NQQuWNR9Y0SqF/BbXqlHsxrTYjHByqBwZI2gFwsHqe/jOOECHWmEcHphcpHWXMTxd3BwGPVaHtzVcMlGY=
X-Received: by 2002:a19:4ad1:: with SMTP id x200mr1371408lfa.539.1604274131876;
 Sun, 01 Nov 2020 15:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20201030041035.394565-1-daeho43@gmail.com> <20201030041035.394565-2-daeho43@gmail.com>
 <25d164b5-278a-1065-e9ab-4da3232b3b97@huawei.com>
In-Reply-To: <25d164b5-278a-1065-e9ab-4da3232b3b97@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 2 Nov 2020 08:42:00 +0900
Message-ID: <CACOAw_wMBeMjQaXCyueX4m4+Xun-k-7kg2QYqe9svMAdVoE3Pg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v7 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, even if those are patchset, then I have to send just changed ones?
Got it.

2020=EB=85=84 10=EC=9B=94 30=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:13, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Daeho,
>
> If there is no change, we are used to not resend the patch with updated
> version.
>
> Thanks,
>
> On 2020/10/30 12:10, Daeho Jeong wrote:
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
> > v6: changed the function name of checking compression algorithm validit=
y.
> > v5: allowed to set algorithm which is not currently enabled by kernel.
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
> > index 7895186cc765..b0144670d320 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *=
inode)
> >       return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
> >   }
> >
> > +bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
> > +{
> > +     return f2fs_cops[algorithm] !=3D NULL;
> > +}
> > +
> >   static mempool_t *compress_page_pool;
> >   static int num_compress_pages =3D 512;
> >   module_param(num_compress_pages, uint, 0444);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a33c90cf979b..70a8a2196888 100644
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
> > +bool f2fs_is_compress_algorithm_valid(unsigned char algorithm);
> >   int f2fs_init_compress_mempool(void);
> >   void f2fs_destroy_compress_mempool(void);
> >   void f2fs_decompress_pages(struct bio *bio, struct page *page, bool v=
erity);
> > @@ -3945,6 +3948,10 @@ static inline bool f2fs_is_compress_backend_read=
y(struct inode *inode)
> >       /* not support compression */
> >       return false;
> >   }
> > +static inline bool f2fs_is_compress_algorithm_valid(unsigned char algo=
rithm)
> > +{
> > +     return false;
> > +}
> >   static inline struct page *f2fs_compress_control_page(struct page *pa=
ge)
> >   {
> >       WARN_ON_ONCE(1);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index bd52df84219d..be56702e4939 100644
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
> > +
> > +     F2FS_I(inode)->i_compress_algorithm =3D option.algorithm;
> > +     F2FS_I(inode)->i_log_cluster_size =3D option.log_cluster_size;
> > +     F2FS_I(inode)->i_cluster_size =3D 1 << option.log_cluster_size;
> > +     f2fs_mark_inode_dirty_sync(inode, true);
> > +
> > +     if (!f2fs_is_compress_algorithm_valid(option.algorithm))
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
