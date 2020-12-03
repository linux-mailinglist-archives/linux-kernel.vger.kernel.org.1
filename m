Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333922CCB7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgLCBQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:16:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9095 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgLCBQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:16:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CmdDl6ys1zLxjq;
        Thu,  3 Dec 2020 09:15:19 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 3 Dec 2020
 09:15:52 +0800
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add compress_mode mount option
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Daeho Jeong <daehojeong@google.com>
References: <20201201040803.3590442-1-daeho43@gmail.com>
 <b8d99522-f63a-1866-9bb4-1a4d640d7495@huawei.com>
 <CACOAw_xafxyUZe1g-nXjTrkisbUqCvSk7js7amhqw3zADAq22Q@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a5c13e8d-38cd-8945-d232-92d3725f7685@huawei.com>
Date:   Thu, 3 Dec 2020 09:15:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_xafxyUZe1g-nXjTrkisbUqCvSk7js7amhqw3zADAq22Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/2 18:54, Daeho Jeong wrote:
> We might use compress_extension=*,compress_option=user.
> In this option, we're gonna allocate all the writes in cold zone.

Oh, so all files in data partition will be tagged as compressed file,
but the compressing time will be controlled by user, then, only blocks
belong to in-compress-process inode will go to cold area, right?

Thanks,

> 
> 
> 2020년 12월 2일 (수) 오후 3:31, Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawei.com>>님이 작성:
> 
>     On 2020/12/1 12:08, Daeho Jeong wrote:
>      > From: Daeho Jeong <daehojeong@google.com <mailto:daehojeong@google.com>>
>      >
>      > We will add a new "compress_mode" mount option to control file
>      > compression mode. This supports "fs" and "user". In "fs" mode (default),
>      > f2fs does automatic compression on the compression enabled files.
>      > In "user" mode, f2fs disables the automaic compression and gives the
>      > user discretion of choosing the target file and the timing. It means
>      > the user can do manual compression/decompression on the compression
>      > enabled files using ioctls.
>      >
>      > Signed-off-by: Daeho Jeong <daehojeong@google.com <mailto:daehojeong@google.com>>
>      > ---
>      > v2: changed mount option name and added more explanation of mount option
>      > ---
>      >   Documentation/filesystems/f2fs.rst | 35 ++++++++++++++++++++++++++++++
>      >   fs/f2fs/compress.c                 |  2 +-
>      >   fs/f2fs/data.c                     |  2 +-
>      >   fs/f2fs/f2fs.h                     | 30 +++++++++++++++++++++++++
>      >   fs/f2fs/segment.c                  |  2 +-
>      >   fs/f2fs/super.c                    | 23 ++++++++++++++++++++
>      >   6 files changed, 91 insertions(+), 3 deletions(-)
>      >
>      > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>      > index b8ee761c9922..5eb8d63439ec 100644
>      > --- a/Documentation/filesystems/f2fs.rst
>      > +++ b/Documentation/filesystems/f2fs.rst
>      > @@ -260,6 +260,13 @@ compress_extension=%s     Support adding specified extension, so that f2fs can enab
>      >                        For other files, we can still enable compression via ioctl.
>      >                        Note that, there is one reserved special extension '*', it
>      >                        can be set to enable compression for all files.
>      > +compress_mode=%s      Control file compression mode. This supports "fs" and "user"
>      > +                      modes. In "fs" mode (default), f2fs does automatic compression
>      > +                      on the compression enabled files. In "user" mode, f2fs disables
>      > +                      the automaic compression and gives the user discretion of
>      > +                      choosing the target file and the timing. The user can do manual
>      > +                      compression/decompression on the compression enabled files using
>      > +                      ioctls.
>      >   inlinecrypt          When possible, encrypt/decrypt the contents of encrypted
>      >                        files using the blk-crypto framework rather than
>      >                        filesystem-layer encryption. This allows the use of
>      > @@ -810,6 +817,34 @@ Compress metadata layout::
>      >       | data length | data chksum | reserved |      compressed data       |
>      >       +-------------+-------------+----------+----------------------------+
>      >
>      > +Compression mode
>      > +--------------------------
>      > +
>      > +f2fs supports "fs" and "user" compression modes with "compression_mode" mount option.
>      > +With this option, f2fs provides a choice to select the way how to compress the
>      > +compression enabled files (refer to "Compression implementation" section for how to
>      > +enable compression on a regular inode).
>      > +
>      > +1) compress_mode=fs
>      > +This is the default option. f2fs does automatic compression in the writeback of the
>      > +compression enabled files.
>      > +
>      > +2) compress_mode=user
>      > +This disables the automaic compression and gives the user discretion of choosing the
>      > +target file and the timing. The user can do manual compression/decompression on the
>      > +compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
>      > +ioctls like the below.
>      > +
>      > +To decompress a file,
>      > +
>      > +fd = open(filename, O_WRONLY, 0);
>      > +ret = ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
>      > +
>      > +To compress a file,
>      > +
>      > +fd = open(filename, O_WRONLY, 0);
>      > +ret = ioctl(fd, F2FS_IOC_COMPRESS_FILE);
>      > +
>      >   NVMe Zoned Namespace devices
>      >   ----------------------------
>      >
>      > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>      > index 3957a84a185e..87090da8693d 100644
>      > --- a/fs/f2fs/compress.c
>      > +++ b/fs/f2fs/compress.c
>      > @@ -926,7 +926,7 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
>      >
>      >   static bool cluster_may_compress(struct compress_ctx *cc)
>      >   {
>      > -     if (!f2fs_compressed_file(cc->inode))
>      > +     if (!f2fs_need_compress_data(cc->inode))
>      >               return false;
>      >       if (f2fs_is_atomic_file(cc->inode))
>      >               return false;
>      > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>      > index be4da52604ed..42254d3859c7 100644
>      > --- a/fs/f2fs/data.c
>      > +++ b/fs/f2fs/data.c
>      > @@ -3164,7 +3164,7 @@ static inline bool __should_serialize_io(struct inode *inode,
>      >       if (IS_NOQUOTA(inode))
>      >               return false;
>      >
>      > -     if (f2fs_compressed_file(inode))
>      > +     if (f2fs_need_compress_data(inode))
>      >               return true;
>      >       if (wbc->sync_mode != WB_SYNC_ALL)
>      >               return true;
>      > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>      > index e0826779a101..94d16bde5e24 100644
>      > --- a/fs/f2fs/f2fs.h
>      > +++ b/fs/f2fs/f2fs.h
>      > @@ -149,6 +149,7 @@ struct f2fs_mount_info {
>      >       unsigned char compress_algorithm;       /* algorithm type */
>      >       unsigned compress_log_size;             /* cluster log size */
>      >       unsigned char compress_ext_cnt;         /* extension count */
>      > +     int compress_mode;                      /* compression mode */
>      >       unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
>      >   };
>      >
>      > @@ -677,6 +678,7 @@ enum {
>      >       FI_VERITY_IN_PROGRESS,  /* building fs-verity Merkle tree */
>      >       FI_COMPRESSED_FILE,     /* indicate file's data can be compressed */
>      >       FI_MMAP_FILE,           /* indicate file was mmapped */
>      > +     FI_ENABLE_COMPRESS,     /* enable compression in "user" compression mode */
>      >       FI_MAX,                 /* max flag, never be used */
>      >   };
>      >
>      > @@ -1243,6 +1245,18 @@ enum fsync_mode {
>      >       FSYNC_MODE_NOBARRIER,   /* fsync behaves nobarrier based on posix */
>      >   };
>      >
>      > +enum {
>      > +     COMPR_MODE_FS,          /*
>      > +                              * automatically compress compression
>      > +                              * enabled files
>      > +                              */
>      > +     COMPR_MODE_USER,        /*
>      > +                              * automatical compression is disabled.
>      > +                              * user can control the file compression
>      > +                              * using ioctls
>      > +                              */
>      > +};
>      > +
>      >   /*
>      >    * this value is set in page as a private data which indicate that
>      >    * the page is atomically written, and it is in inmem_pages list.
>      > @@ -2752,6 +2766,22 @@ static inline int f2fs_compressed_file(struct inode *inode)
>      >               is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>      >   }
>      >
>      > +static inline bool f2fs_need_compress_data(struct inode *inode)
>      > +{
>      > +     int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>      > +
>      > +     if (!f2fs_compressed_file(inode))
>      > +             return false;
>      > +
>      > +     if (compress_mode == COMPR_MODE_FS)
>      > +             return true;
>      > +     else if (compress_mode == COMPR_MODE_USER &&
>      > +                     is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
>      > +             return true;
>      > +
>      > +     return false;
>      > +}
>      > +
>      >   static inline unsigned int addrs_per_inode(struct inode *inode)
>      >   {
>      >       unsigned int addrs = CUR_ADDRS_PER_INODE(inode) -
>      > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>      > index 1596502f7375..5d6c9d6f237b 100644
>      > --- a/fs/f2fs/segment.c
>      > +++ b/fs/f2fs/segment.c
>      > @@ -3254,7 +3254,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>      >                       else
>      >                               return CURSEG_COLD_DATA;
>      >               }
>      > -             if (file_is_cold(inode) || f2fs_compressed_file(inode))
>      > +             if (file_is_cold(inode) || f2fs_need_compress_data(inode))
> 
>     Can we keep consistent about writting compressed file to code data area?
> 
>     Or there is other concern about this?
> 
>     Thanks,
> 
>      >                       return CURSEG_COLD_DATA;
>      >               if (file_is_hot(inode) ||
>      >                               is_inode_flag_set(inode, FI_HOT_DATA) ||
>      > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>      > index 87f7a6e86370..cc6eb4ed80a2 100644
>      > --- a/fs/f2fs/super.c
>      > +++ b/fs/f2fs/super.c
>      > @@ -146,6 +146,7 @@ enum {
>      >       Opt_compress_algorithm,
>      >       Opt_compress_log_size,
>      >       Opt_compress_extension,
>      > +     Opt_compress_mode,
>      >       Opt_atgc,
>      >       Opt_err,
>      >   };
>      > @@ -214,6 +215,7 @@ static match_table_t f2fs_tokens = {
>      >       {Opt_compress_algorithm, "compress_algorithm=%s"},
>      >       {Opt_compress_log_size, "compress_log_size=%u"},
>      >       {Opt_compress_extension, "compress_extension=%s"},
>      > +     {Opt_compress_mode, "compress_mode=%s"},
>      >       {Opt_atgc, "atgc"},
>      >       {Opt_err, NULL},
>      >   };
>      > @@ -934,10 +936,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>      >                       F2FS_OPTION(sbi).compress_ext_cnt++;
>      >                       kfree(name);
>      >                       break;
>      > +             case Opt_compress_mode:
>      > +                     name = match_strdup(&args[0]);
>      > +                     if (!name)
>      > +                             return -ENOMEM;
>      > +                     if (!strcmp(name, "fs")) {
>      > +                             F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
>      > +                     } else if (!strcmp(name, "user")) {
>      > +                             F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
>      > +                     } else {
>      > +                             kfree(name);
>      > +                             return -EINVAL;
>      > +                     }
>      > +                     kfree(name);
>      > +                     break;
>      >   #else
>      >               case Opt_compress_algorithm:
>      >               case Opt_compress_log_size:
>      >               case Opt_compress_extension:
>      > +             case Opt_compress_mode:
>      >                       f2fs_info(sbi, "compression options not supported");
>      >                       break;
>      >   #endif
>      > @@ -1523,6 +1540,11 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
>      >               seq_printf(seq, ",compress_extension=%s",
>      >                       F2FS_OPTION(sbi).extensions[i]);
>      >       }
>      > +
>      > +     if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_FS)
>      > +             seq_printf(seq, ",compress_mode=%s", "fs");
>      > +     else if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
>      > +             seq_printf(seq, ",compress_mode=%s", "user");
>      >   }
>      >
>      >   static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>      > @@ -1672,6 +1694,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>      >       F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
>      >       F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
>      >       F2FS_OPTION(sbi).compress_ext_cnt = 0;
>      > +     F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
>      >       F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
>      >
>      >       sbi->sb->s_flags &= ~SB_INLINECRYPT;
>      >
> 
