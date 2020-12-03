Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4205E2CCDD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 05:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgLCEOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 23:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCEOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 23:14:17 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB17C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 20:13:30 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so731968lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 20:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aseGkQ7TOR7j+AgdfktY0VympPNE4y15l1Lys5HsjW4=;
        b=GrDcTcM2enqr7mkPd95t9+xaQlCHm+FvHf4uMmDaIIGSiTwl90dkZ0RCygptug3pq2
         u0+R71XCsNvSjGwjfgYoKq75B40Vv3AsLSJkqIn3DImFi5Duiv5PCPg5e8SSfFZYg4EH
         XTCSN04tXhiepzmwZEVtLUiPAAwiNbdKuBkbkHj7cTQ0YjHolW/WkvpyWS1ZgT1GJ0Tq
         z3DkDktDws7IttjN9u8FWWUnJElEm/iRpaHL+SDQeR/q0WDsG53hW8z2gm3rFGtvowpM
         CaLCU55UPoGGdjBDEjj9kTysFa6e3LjFuT+wcj/HVnU7N41/FaPPzoNCC3n+1nTpOKFk
         X5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aseGkQ7TOR7j+AgdfktY0VympPNE4y15l1Lys5HsjW4=;
        b=lUPINevxImyZyXuUMN+XRCMUjKHebbyZUqTRMGgkdM1xu5NrRXcyfzsQ5CUIp9pWtD
         REzjftgSRnhZuNnvzQLwn+EV/0YlrakdXpQvcNPAfDGF465a3nivnFuyKPIGGisX0Lc/
         AOTn615sZn27ZN7OD/a/9F2XOyb6V8l5wD/JPaCi8oyMz/wZOTZjXAP14fssB1XyiKvv
         xDZWYAG31DlrSjq/zdDr9qh4ABv9Za4hKxTLM2GdLPPTLNgHYhRNOLlDgm3h58Bp3bTt
         asDWDe2potGdZMv+OIvYa5BiIZ88/grxwCVwO8gHcno2Lpj5YFJ5bXNbclU2/9Ihl3//
         sfUw==
X-Gm-Message-State: AOAM530Bvt5SWGHSMhtxKjnuhsHMrplH4khOx4NRpNRIZzhsySbt0svl
        sRpKhCvLD01c2b3ekcaoylVR5nEIdqZOpqfCysE=
X-Google-Smtp-Source: ABdhPJw7847rdzLF6L52Majjl4iornSZoHf07BxD4MpNHpI9BjjggF4LqV0dHjTjnPRTy88RytxIB3TYvqLKtU65q0c=
X-Received: by 2002:a05:6512:3a6:: with SMTP id v6mr492830lfp.90.1606968809348;
 Wed, 02 Dec 2020 20:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20201030041035.394565-1-daeho43@gmail.com> <20201030041035.394565-2-daeho43@gmail.com>
 <dcf074e3-821c-6858-eb17-63dcc05e7039@huawei.com>
In-Reply-To: <dcf074e3-821c-6858-eb17-63dcc05e7039@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 3 Dec 2020 13:13:18 +0900
Message-ID: <CACOAw_z1D5X0noO7dBq+b_KJ756sKsKpihAkqz=L5W0GazWVpw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v7 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, by the control logic changed in the previous patch, we don't need
to use f2fs_is_compress_algorithm_valid() anymore.
Looks good~

2020=EB=85=84 12=EC=9B=94 3=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:49, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Jaegeuk, not sure, is it too late to merge this cleanup into original pat=
ch?
>
>  From a5c63ec58e0cda6eb5d186b46942eea46422b7a9 Mon Sep 17 00:00:00 2001
> From: Chao Yu <yuchao0@huawei.com>
> Date: Thu, 3 Dec 2020 10:04:26 +0800
> Subject: [PATCH] f2fs: remove f2fs_is_compress_algorithm_valid() for clea=
nup
>
> No logic changes.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/compress.c | 5 -----
>   fs/f2fs/f2fs.h     | 5 -----
>   fs/f2fs/file.c     | 2 +-
>   3 files changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index dfadbc78946c..869b047a4801 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -574,11 +574,6 @@ bool f2fs_is_compress_backend_ready(struct inode *in=
ode)
>         return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
>   }
>
> -bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
> -{
> -       return f2fs_cops[algorithm] !=3D NULL;
> -}
> -
>   static mempool_t *compress_page_pool;
>   static int num_compress_pages =3D 512;
>   module_param(num_compress_pages, uint, 0444);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b70c8d553439..17b45c2d2b04 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3882,7 +3882,6 @@ bool f2fs_compress_write_end(struct inode *inode, v=
oid *fsdata,
>   int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool l=
ock);
>   void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
>   bool f2fs_is_compress_backend_ready(struct inode *inode);
> -bool f2fs_is_compress_algorithm_valid(unsigned char algorithm);
>   int f2fs_init_compress_mempool(void);
>   void f2fs_destroy_compress_mempool(void);
>   void f2fs_do_decompress_pages(struct decompress_io_ctx *dic, bool verit=
y);
> @@ -3927,10 +3926,6 @@ static inline bool f2fs_is_compress_backend_ready(=
struct inode *inode)
>         /* not support compression */
>         return false;
>   }
> -static inline bool f2fs_is_compress_algorithm_valid(unsigned char algori=
thm)
> -{
> -       return false;
> -}
>   static inline struct page *f2fs_compress_control_page(struct page *page=
)
>   {
>         WARN_ON_ONCE(1);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 300355fe25f0..0453b441228d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4016,7 +4016,7 @@ static int f2fs_ioc_set_compress_option(struct file=
 *filp, unsigned long arg)
>         F2FS_I(inode)->i_cluster_size =3D 1 << option.log_cluster_size;
>         f2fs_mark_inode_dirty_sync(inode, true);
>
> -       if (!f2fs_is_compress_algorithm_valid(option.algorithm))
> +       if (!f2fs_is_compress_backend_ready(inode))
>                 f2fs_warn(sbi, "compression algorithm is successfully set=
, "
>                         "but current kernel doesn't support this algorith=
m.");
>   out:
> --
> 2.26.2
>
>
>
>
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
