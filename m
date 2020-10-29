Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5C29E05E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgJ2BVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391051AbgJ2BVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:21:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:21:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 184so1228806lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PdxytuMJd08mN1AzD2gP5MclpEosgGEzK8SkNxNwB1w=;
        b=ZWJfIoTFHaVeVMsy9oaYt+M/lxGRVTqf7eQy6Z0fR9Rd+L9h9dLeI+K/BWd07bIUL7
         mBEtLbEAO+MbDBRrWQtsJsL9kGracj+BVs2Nxh+aCScFNQN298HLYUVSF8p5nhkWLwX6
         DaedG/3MrsyvS7hBaqvfxIAkBbaa/C8+P4jMQu/z9O830ifulMcc/f5dG4DSxw8XSj8m
         CdBOwHAqrojsbH2KQnClboGlUh96s5k1mEpB1nvnWRT2eWDIBxWYor5WucBhaNoIzzXH
         strsUTw20gdr1zG5c3hHqWyyqAXpCc9T45EfSVM9f3rlzUCKRFHeZpV0yvQ6nU9B0O0Q
         Cg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PdxytuMJd08mN1AzD2gP5MclpEosgGEzK8SkNxNwB1w=;
        b=ctTyJDWV1pxZsMyRlPFf3jI37MMpZeMBVYZtfSu+ER3odzqFQ6Kdqfhkw06HZ1QjM4
         3bxg43oXUMW53CO+/6W8k3kV8Xk7kYsgdd8X3dqK0hI1wHXF1ocntVHPSU4PxRiHFI2V
         L+EYKGESfRlGiYQQAL+c0DQF5k3p1LwAkVLPfT783NF5lFt2nmJoTp7YVfrAMHN/LPlX
         YfvWrQMXhBrot9CXIUPT/mbWiyQmj7XV2342FMcp2/5ogZqlDfXEdq6TeshF2tTlBC2/
         GivokTZU5OvjvXGraIfqWNZWCBvlU3P0A/X8vxY4yOBG0uBfqDheUGzg4a7AcZoF1Vz2
         fAqw==
X-Gm-Message-State: AOAM532rw1mDuyctJkL0ipcnPMlzmRYQeBvR7fLv4YSfS4p2bP3x8Vv3
        gtgHVy006f2CuZYWXMTr7gaC2sOQfpnUAPYAnNY=
X-Google-Smtp-Source: ABdhPJx0/1WXqjeOh5EvimgfLVgi4qiyfhefc9GJ/kSeBWY/XnwDSnm+pmGKayZ2vNr5kgOeF7HXqU5WkbCNUOYPCCk=
X-Received: by 2002:a19:f71a:: with SMTP id z26mr584684lfe.90.1603934499574;
 Wed, 28 Oct 2020 18:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201027053818.3291747-1-daeho43@gmail.com> <20201027053818.3291747-2-daeho43@gmail.com>
 <290cd375-704e-9315-a035-ab4c1ce1f6f2@huawei.com>
In-Reply-To: <290cd375-704e-9315-a035-ab4c1ce1f6f2@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 29 Oct 2020 10:21:28 +0900
Message-ID: <CACOAw_ycvV9_O_tb=axgT2Pu9ySvdKfVjBv+Fe90+XObKGjjTg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
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

Do you want to print out a kernel warning message in this case? like
"XX compression algorithm is set for this inode, but current mount
option doesn't support this algorithm."?

2020=EB=85=84 10=EC=9B=94 28=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:47, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/10/27 13:38, Daeho Jeong wrote:
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
> > v4: changed commit message.
> > v3: changed the error number more specific.
> >      folded in fix for build breakage reported by kernel test robot
> >      <lkp@intel.com> and Dan Carpenter <dan.carpenter@oracle.com>.
> > v2: added ioctl description.
> > ---
> >   fs/f2fs/compress.c |  5 +++++
> >   fs/f2fs/f2fs.h     |  7 +++++++
> >   fs/f2fs/file.c     | 52 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 64 insertions(+)
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
> > index 8922ab191a9d..8048b150e43b 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3963,6 +3963,55 @@ static int f2fs_ioc_get_compress_option(struct f=
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
> > +                     option.log_cluster_size > MAX_COMPRESS_LOG_SIZE)
> > +             return -EINVAL;
> > +
> > +     if (!f2fs_is_compress_algorithm_ready(option.algorithm))
> > +             return -ENOPKG;
>
> As we allow to mount image with different kernel which supports different=
 compress
> algorithms, so I guess we can support to change algorithm to one other wh=
ich current
> kernel doesn't support, since we have add f2fs_is_compress_backend_ready(=
) in all
> foreground operations to disallow user to operate such inode's data.
>
> IMO, just add to print one warnning message is fine.
>
> Thanks,
>
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
> > @@ -4053,6 +4102,8 @@ long f2fs_ioctl(struct file *filp, unsigned int c=
md, unsigned long arg)
> >               return f2fs_sec_trim_file(filp, arg);
> >       case F2FS_IOC_GET_COMPRESS_OPTION:
> >               return f2fs_ioc_get_compress_option(filp, arg);
> > +     case F2FS_IOC_SET_COMPRESS_OPTION:
> > +             return f2fs_ioc_set_compress_option(filp, arg);
> >       default:
> >               return -ENOTTY;
> >       }
> > @@ -4224,6 +4275,7 @@ long f2fs_compat_ioctl(struct file *file, unsigne=
d int cmd, unsigned long arg)
> >       case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
> >       case F2FS_IOC_SEC_TRIM_FILE:
> >       case F2FS_IOC_GET_COMPRESS_OPTION:
> > +     case F2FS_IOC_SET_COMPRESS_OPTION:
> >               break;
> >       default:
> >               return -ENOIOCTLCMD;
> >
