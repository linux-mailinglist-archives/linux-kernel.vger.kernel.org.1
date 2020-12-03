Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66602CCB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLCBZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgLCBZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:25:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31013C061A4C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:24:10 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so679924ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4SJOEtqsaS+XLaLMbp05LdTVwUl6vet5pIdjenlMFeA=;
        b=RVoEywYsYNQyBkVwT07o2Jl8wcDSETRQDxIc5BMa4qLrCAzAlt8SNdGUg3iQPPpF4d
         5A7RCgs8JWyokrRCO85/8deesP1mjeiJR5KYQwU41pqKt0A/6jDyik4farWqFChqdHsu
         p4WuLy1HgnU0ZUtD/AdgVggVVowzlIZ3E2EUPc8YB5v01CcLHaND+1PDRK2vNdiKxryQ
         d165/rqTlHjJcjpLkwMXHsaRMS+ppoajdfzrG3/5Orc+BuEBUWTTM4DR5FJ6xkj4hNDc
         1zIcFI1nf0iBLksZCt3Zud02VfQU99KO3RP9mHOVrPiX3ozV5A8ZioZU/LVKIu6RAUOP
         FYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4SJOEtqsaS+XLaLMbp05LdTVwUl6vet5pIdjenlMFeA=;
        b=qRcFt5CmzLlvn7SP2R7FNvg/U6l9O1kqAG7lIxzbjPj+k+LbUM0nw/J8cIFu1XRnPW
         ltZrkSv9QwvHL7CkC05/2tR8KI6ImJn0FnXWYY+vi+3Q+NIZZZcRhapT7JmTVD9glHoA
         58vGlYHwkHBgD7+wXZjWmrrohvOcbVrR+4bWX0jzCHgVflgEUAZEJvR7phm5T9MrD+mf
         XOiuv74IvcM6jYkyGfYU+afmIZfOT3+gQ1BJjAIIuSqkUW2mQyew+fOAHIDiL3BmVNbN
         EfB0NDmeYtA/wx86FeI62Ad+8Tt/FYsYjxniXBE8kMT4pIFpynYu8S1Gp04quHRbqUzn
         6mbA==
X-Gm-Message-State: AOAM533GcfzUUvNUCRa0x6wfdZAGtjeNoulvmrNUmDNAXzg0k2wIIEyM
        npA9ZE88LwtuW6WoTnIpZAW1GeO26Z91eC1gjg0=
X-Google-Smtp-Source: ABdhPJzKv1yCSL5psUql2O4FeNlHYSxZe1hHtkl4vE4Eys0ER9E7iN2FDtPrfehPPpP2UNwrVJSD149Dc8GJnaO1CU4=
X-Received: by 2002:a2e:bc16:: with SMTP id b22mr257198ljf.166.1606958648472;
 Wed, 02 Dec 2020 17:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20201201040803.3590442-1-daeho43@gmail.com> <b8d99522-f63a-1866-9bb4-1a4d640d7495@huawei.com>
 <CACOAw_xafxyUZe1g-nXjTrkisbUqCvSk7js7amhqw3zADAq22Q@mail.gmail.com> <a5c13e8d-38cd-8945-d232-92d3725f7685@huawei.com>
In-Reply-To: <a5c13e8d-38cd-8945-d232-92d3725f7685@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 3 Dec 2020 10:23:57 +0900
Message-ID: <CACOAw_xh01cjjWHw_43qhaGiWg0VAC7HMT__dxDEgVxok6wv9A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add compress_mode mount option
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, you're right~ :)

2020=EB=85=84 12=EC=9B=94 3=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:16, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/12/2 18:54, Daeho Jeong wrote:
> > We might use compress_extension=3D*,compress_option=3Duser.
> > In this option, we're gonna allocate all the writes in cold zone.
>
> Oh, so all files in data partition will be tagged as compressed file,
> but the compressing time will be controlled by user, then, only blocks
> belong to in-compress-process inode will go to cold area, right?
>
> Thanks,
>
> >
> >
> > 2020=EB=85=84 12=EC=9B=94 2=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:3=
1, Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawei.com>>=EB=8B=98=EC=9D=
=B4 =EC=9E=91=EC=84=B1:
> >
> >     On 2020/12/1 12:08, Daeho Jeong wrote:
> >      > From: Daeho Jeong <daehojeong@google.com <mailto:daehojeong@goog=
le.com>>
> >      >
> >      > We will add a new "compress_mode" mount option to control file
> >      > compression mode. This supports "fs" and "user". In "fs" mode (d=
efault),
> >      > f2fs does automatic compression on the compression enabled files=
.
> >      > In "user" mode, f2fs disables the automaic compression and gives=
 the
> >      > user discretion of choosing the target file and the timing. It m=
eans
> >      > the user can do manual compression/decompression on the compress=
ion
> >      > enabled files using ioctls.
> >      >
> >      > Signed-off-by: Daeho Jeong <daehojeong@google.com <mailto:daehoj=
eong@google.com>>
> >      > ---
> >      > v2: changed mount option name and added more explanation of moun=
t option
> >      > ---
> >      >   Documentation/filesystems/f2fs.rst | 35 ++++++++++++++++++++++=
++++++++
> >      >   fs/f2fs/compress.c                 |  2 +-
> >      >   fs/f2fs/data.c                     |  2 +-
> >      >   fs/f2fs/f2fs.h                     | 30 ++++++++++++++++++++++=
+++
> >      >   fs/f2fs/segment.c                  |  2 +-
> >      >   fs/f2fs/super.c                    | 23 ++++++++++++++++++++
> >      >   6 files changed, 91 insertions(+), 3 deletions(-)
> >      >
> >      > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/=
filesystems/f2fs.rst
> >      > index b8ee761c9922..5eb8d63439ec 100644
> >      > --- a/Documentation/filesystems/f2fs.rst
> >      > +++ b/Documentation/filesystems/f2fs.rst
> >      > @@ -260,6 +260,13 @@ compress_extension=3D%s     Support adding =
specified extension, so that f2fs can enab
> >      >                        For other files, we can still enable comp=
ression via ioctl.
> >      >                        Note that, there is one reserved special =
extension '*', it
> >      >                        can be set to enable compression for all =
files.
> >      > +compress_mode=3D%s      Control file compression mode. This sup=
ports "fs" and "user"
> >      > +                      modes. In "fs" mode (default), f2fs does =
automatic compression
> >      > +                      on the compression enabled files. In "use=
r" mode, f2fs disables
> >      > +                      the automaic compression and gives the us=
er discretion of
> >      > +                      choosing the target file and the timing. =
The user can do manual
> >      > +                      compression/decompression on the compress=
ion enabled files using
> >      > +                      ioctls.
> >      >   inlinecrypt          When possible, encrypt/decrypt the conten=
ts of encrypted
> >      >                        files using the blk-crypto framework rath=
er than
> >      >                        filesystem-layer encryption. This allows =
the use of
> >      > @@ -810,6 +817,34 @@ Compress metadata layout::
> >      >       | data length | data chksum | reserved |      compressed d=
ata       |
> >      >       +-------------+-------------+----------+------------------=
----------+
> >      >
> >      > +Compression mode
> >      > +--------------------------
> >      > +
> >      > +f2fs supports "fs" and "user" compression modes with "compressi=
on_mode" mount option.
> >      > +With this option, f2fs provides a choice to select the way how =
to compress the
> >      > +compression enabled files (refer to "Compression implementation=
" section for how to
> >      > +enable compression on a regular inode).
> >      > +
> >      > +1) compress_mode=3Dfs
> >      > +This is the default option. f2fs does automatic compression in =
the writeback of the
> >      > +compression enabled files.
> >      > +
> >      > +2) compress_mode=3Duser
> >      > +This disables the automaic compression and gives the user discr=
etion of choosing the
> >      > +target file and the timing. The user can do manual compression/=
decompression on the
> >      > +compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2=
FS_IOC_COMPRESS_FILE
> >      > +ioctls like the below.
> >      > +
> >      > +To decompress a file,
> >      > +
> >      > +fd =3D open(filename, O_WRONLY, 0);
> >      > +ret =3D ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
> >      > +
> >      > +To compress a file,
> >      > +
> >      > +fd =3D open(filename, O_WRONLY, 0);
> >      > +ret =3D ioctl(fd, F2FS_IOC_COMPRESS_FILE);
> >      > +
> >      >   NVMe Zoned Namespace devices
> >      >   ----------------------------
> >      >
> >      > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >      > index 3957a84a185e..87090da8693d 100644
> >      > --- a/fs/f2fs/compress.c
> >      > +++ b/fs/f2fs/compress.c
> >      > @@ -926,7 +926,7 @@ int f2fs_is_compressed_cluster(struct inode =
*inode, pgoff_t index)
> >      >
> >      >   static bool cluster_may_compress(struct compress_ctx *cc)
> >      >   {
> >      > -     if (!f2fs_compressed_file(cc->inode))
> >      > +     if (!f2fs_need_compress_data(cc->inode))
> >      >               return false;
> >      >       if (f2fs_is_atomic_file(cc->inode))
> >      >               return false;
> >      > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >      > index be4da52604ed..42254d3859c7 100644
> >      > --- a/fs/f2fs/data.c
> >      > +++ b/fs/f2fs/data.c
> >      > @@ -3164,7 +3164,7 @@ static inline bool __should_serialize_io(s=
truct inode *inode,
> >      >       if (IS_NOQUOTA(inode))
> >      >               return false;
> >      >
> >      > -     if (f2fs_compressed_file(inode))
> >      > +     if (f2fs_need_compress_data(inode))
> >      >               return true;
> >      >       if (wbc->sync_mode !=3D WB_SYNC_ALL)
> >      >               return true;
> >      > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >      > index e0826779a101..94d16bde5e24 100644
> >      > --- a/fs/f2fs/f2fs.h
> >      > +++ b/fs/f2fs/f2fs.h
> >      > @@ -149,6 +149,7 @@ struct f2fs_mount_info {
> >      >       unsigned char compress_algorithm;       /* algorithm type =
*/
> >      >       unsigned compress_log_size;             /* cluster log siz=
e */
> >      >       unsigned char compress_ext_cnt;         /* extension count=
 */
> >      > +     int compress_mode;                      /* compression mod=
e */
> >      >       unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_=
LEN]; /* extensions */
> >      >   };
> >      >
> >      > @@ -677,6 +678,7 @@ enum {
> >      >       FI_VERITY_IN_PROGRESS,  /* building fs-verity Merkle tree =
*/
> >      >       FI_COMPRESSED_FILE,     /* indicate file's data can be com=
pressed */
> >      >       FI_MMAP_FILE,           /* indicate file was mmapped */
> >      > +     FI_ENABLE_COMPRESS,     /* enable compression in "user" co=
mpression mode */
> >      >       FI_MAX,                 /* max flag, never be used */
> >      >   };
> >      >
> >      > @@ -1243,6 +1245,18 @@ enum fsync_mode {
> >      >       FSYNC_MODE_NOBARRIER,   /* fsync behaves nobarrier based o=
n posix */
> >      >   };
> >      >
> >      > +enum {
> >      > +     COMPR_MODE_FS,          /*
> >      > +                              * automatically compress compress=
ion
> >      > +                              * enabled files
> >      > +                              */
> >      > +     COMPR_MODE_USER,        /*
> >      > +                              * automatical compression is disa=
bled.
> >      > +                              * user can control the file compr=
ession
> >      > +                              * using ioctls
> >      > +                              */
> >      > +};
> >      > +
> >      >   /*
> >      >    * this value is set in page as a private data which indicate =
that
> >      >    * the page is atomically written, and it is in inmem_pages li=
st.
> >      > @@ -2752,6 +2766,22 @@ static inline int f2fs_compressed_file(st=
ruct inode *inode)
> >      >               is_inode_flag_set(inode, FI_COMPRESSED_FILE);
> >      >   }
> >      >
> >      > +static inline bool f2fs_need_compress_data(struct inode *inode)
> >      > +{
> >      > +     int compress_mode =3D F2FS_OPTION(F2FS_I_SB(inode)).compre=
ss_mode;
> >      > +
> >      > +     if (!f2fs_compressed_file(inode))
> >      > +             return false;
> >      > +
> >      > +     if (compress_mode =3D=3D COMPR_MODE_FS)
> >      > +             return true;
> >      > +     else if (compress_mode =3D=3D COMPR_MODE_USER &&
> >      > +                     is_inode_flag_set(inode, FI_ENABLE_COMPRES=
S))
> >      > +             return true;
> >      > +
> >      > +     return false;
> >      > +}
> >      > +
> >      >   static inline unsigned int addrs_per_inode(struct inode *inode=
)
> >      >   {
> >      >       unsigned int addrs =3D CUR_ADDRS_PER_INODE(inode) -
> >      > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >      > index 1596502f7375..5d6c9d6f237b 100644
> >      > --- a/fs/f2fs/segment.c
> >      > +++ b/fs/f2fs/segment.c
> >      > @@ -3254,7 +3254,7 @@ static int __get_segment_type_6(struct f2f=
s_io_info *fio)
> >      >                       else
> >      >                               return CURSEG_COLD_DATA;
> >      >               }
> >      > -             if (file_is_cold(inode) || f2fs_compressed_file(in=
ode))
> >      > +             if (file_is_cold(inode) || f2fs_need_compress_data=
(inode))
> >
> >     Can we keep consistent about writting compressed file to code data =
area?
> >
> >     Or there is other concern about this?
> >
> >     Thanks,
> >
> >      >                       return CURSEG_COLD_DATA;
> >      >               if (file_is_hot(inode) ||
> >      >                               is_inode_flag_set(inode, FI_HOT_DA=
TA) ||
> >      > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >      > index 87f7a6e86370..cc6eb4ed80a2 100644
> >      > --- a/fs/f2fs/super.c
> >      > +++ b/fs/f2fs/super.c
> >      > @@ -146,6 +146,7 @@ enum {
> >      >       Opt_compress_algorithm,
> >      >       Opt_compress_log_size,
> >      >       Opt_compress_extension,
> >      > +     Opt_compress_mode,
> >      >       Opt_atgc,
> >      >       Opt_err,
> >      >   };
> >      > @@ -214,6 +215,7 @@ static match_table_t f2fs_tokens =3D {
> >      >       {Opt_compress_algorithm, "compress_algorithm=3D%s"},
> >      >       {Opt_compress_log_size, "compress_log_size=3D%u"},
> >      >       {Opt_compress_extension, "compress_extension=3D%s"},
> >      > +     {Opt_compress_mode, "compress_mode=3D%s"},
> >      >       {Opt_atgc, "atgc"},
> >      >       {Opt_err, NULL},
> >      >   };
> >      > @@ -934,10 +936,25 @@ static int parse_options(struct super_bloc=
k *sb, char *options, bool is_remount)
> >      >                       F2FS_OPTION(sbi).compress_ext_cnt++;
> >      >                       kfree(name);
> >      >                       break;
> >      > +             case Opt_compress_mode:
> >      > +                     name =3D match_strdup(&args[0]);
> >      > +                     if (!name)
> >      > +                             return -ENOMEM;
> >      > +                     if (!strcmp(name, "fs")) {
> >      > +                             F2FS_OPTION(sbi).compress_mode =3D=
 COMPR_MODE_FS;
> >      > +                     } else if (!strcmp(name, "user")) {
> >      > +                             F2FS_OPTION(sbi).compress_mode =3D=
 COMPR_MODE_USER;
> >      > +                     } else {
> >      > +                             kfree(name);
> >      > +                             return -EINVAL;
> >      > +                     }
> >      > +                     kfree(name);
> >      > +                     break;
> >      >   #else
> >      >               case Opt_compress_algorithm:
> >      >               case Opt_compress_log_size:
> >      >               case Opt_compress_extension:
> >      > +             case Opt_compress_mode:
> >      >                       f2fs_info(sbi, "compression options not su=
pported");
> >      >                       break;
> >      >   #endif
> >      > @@ -1523,6 +1540,11 @@ static inline void f2fs_show_compress_opt=
ions(struct seq_file *seq,
> >      >               seq_printf(seq, ",compress_extension=3D%s",
> >      >                       F2FS_OPTION(sbi).extensions[i]);
> >      >       }
> >      > +
> >      > +     if (F2FS_OPTION(sbi).compress_mode =3D=3D COMPR_MODE_FS)
> >      > +             seq_printf(seq, ",compress_mode=3D%s", "fs");
> >      > +     else if (F2FS_OPTION(sbi).compress_mode =3D=3D COMPR_MODE_=
USER)
> >      > +             seq_printf(seq, ",compress_mode=3D%s", "user");
> >      >   }
> >      >
> >      >   static int f2fs_show_options(struct seq_file *seq, struct dent=
ry *root)
> >      > @@ -1672,6 +1694,7 @@ static void default_options(struct f2fs_sb=
_info *sbi)
> >      >       F2FS_OPTION(sbi).compress_algorithm =3D COMPRESS_LZ4;
> >      >       F2FS_OPTION(sbi).compress_log_size =3D MIN_COMPRESS_LOG_SI=
ZE;
> >      >       F2FS_OPTION(sbi).compress_ext_cnt =3D 0;
> >      > +     F2FS_OPTION(sbi).compress_mode =3D COMPR_MODE_FS;
> >      >       F2FS_OPTION(sbi).bggc_mode =3D BGGC_MODE_ON;
> >      >
> >      >       sbi->sb->s_flags &=3D ~SB_INLINECRYPT;
> >      >
> >
