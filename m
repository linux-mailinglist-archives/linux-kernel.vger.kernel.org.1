Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954732C8765
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgK3PFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:05:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgK3PFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:05:48 -0500
Received: from [192.168.0.113] (unknown [49.77.180.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A220206D8;
        Mon, 30 Nov 2020 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606748707;
        bh=19bKj2nvufajNmxbblRlprgH0MBleMF9z+mA43UKseQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CoL9rPluXLoBbupX/R8wqXk1xMQI1/I7XaOZVGmTyVOx8eG7dJ+hd8BtJOsgfUsMQ
         PoNhITbPxTL7DvnczWqXQYuPkkW5CqRmWXZQDokANHbqu0ogELC4LVzXUy7IsPBT1U
         QjHamTejM2FxlcLElSmg04jF35ccP1/qvs0hHPNM=
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: support lz4hc compression
To:     Ju Hyung Park <qkrwngud825@gmail.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20201130112648.95504-1-yuchao0@huawei.com>
 <CAD14+f0b5ZqK8EPP+rgMf-NmJXCcOYnqX71QMjViOkF0Q2xsaQ@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2b9f01e0-577b-b462-d6e8-777380588542@kernel.org>
Date:   Mon, 30 Nov 2020 23:04:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAD14+f0b5ZqK8EPP+rgMf-NmJXCcOYnqX71QMjViOkF0Q2xsaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ju Hyung,

On 2020/11/30 19:35, Ju Hyung Park wrote:
> Hi Chao.
> 
> On Mon, Nov 30, 2020 at 8:28 PM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> Add a new mount option "compress_lz4hc_clevel=%u" to enable lz4hc compress
>> algorithm and specify the compress level of lz4hc.
> 
> Wouldn't it be better to introduce a generic mount option like
> "compress_level=%u" to allow other algorithms to use it as well?
> 
> Or retire compress_algorithm altogether and follow btrfs format, which
> I quite like:
> compress=lzo:1, compress=zstd:4, etc.

Agreed, the implementation looks better, let me try to implement latter one.

Thanks,

> 
> Just my two cents.
> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   Documentation/filesystems/f2fs.rst |  2 ++
>>   fs/f2fs/compress.c                 | 22 +++++++++++++++++-----
>>   fs/f2fs/f2fs.h                     |  8 ++++++++
>>   fs/f2fs/inode.c                    |  4 ++++
>>   fs/f2fs/super.c                    | 15 +++++++++++++++
>>   5 files changed, 46 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index 8830a11a11be..cda30ea124ee 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -264,6 +264,8 @@ compress_chksum              Support verifying chksum of raw data in compressed cluster.
>>   compress_cache          Support to use address space of inner inode to cache
>>                           compressed block, in order to improve cache hit ratio of
>>                           random read.
>> +compress_lz4hc_clevel   Support to enable LZ4 high compression algorithm, compress
>> +                        level range is [3, 16].
>>   inlinecrypt             When possible, encrypt/decrypt the contents of encrypted
>>                           files using the blk-crypto framework rather than
>>                           filesystem-layer encryption. This allows the use of
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 2ec34168adbb..233be7f71e48 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -253,17 +253,24 @@ static const struct f2fs_compress_ops f2fs_lzo_ops = {
>>   #ifdef CONFIG_F2FS_FS_LZ4
>>   static int lz4_init_compress_ctx(struct compress_ctx *cc)
>>   {
>> -       cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
>> -                               LZ4_MEM_COMPRESS, GFP_NOFS);
>> +       unsigned int size;
>> +
>> +       size = F2FS_I(cc->inode)->i_lz4hc_clevel ?
>> +                       LZ4HC_MEM_COMPRESS : LZ4_MEM_COMPRESS;
>> +
>> +       cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode), size, GFP_NOFS);
>>          if (!cc->private)
>>                  return -ENOMEM;
>>
>>          /*
>>           * we do not change cc->clen to LZ4_compressBound(inputsize) to
>>           * adapt worst compress case, because lz4 compressor can handle
>> -        * output budget properly.
>> +        * output budget properly; for lz4hc case, keep it as it is.
>>           */
>> -       cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>> +       if (F2FS_I(cc->inode)->i_lz4hc_clevel)
>> +               cc->clen = LZ4_compressBound(cc->rlen);
>> +       else
>> +               cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>>          return 0;
>>   }
>>
>> @@ -275,9 +282,14 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
>>
>>   static int lz4_compress_pages(struct compress_ctx *cc)
>>   {
>> +       unsigned char clevel = F2FS_I(cc->inode)->i_lz4hc_clevel;
>>          int len;
>>
>> -       len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>> +       if (clevel)
>> +               len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>> +                                               cc->clen, clevel, cc->private);
>> +       else
>> +               len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>>                                                  cc->clen, cc->private);
>>          if (!len)
>>                  return -EAGAIN;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index d32065417616..d3d5583ea9e5 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -149,6 +149,7 @@ struct f2fs_mount_info {
>>          /* For compression */
>>          unsigned char compress_algorithm;       /* algorithm type */
>>          unsigned char compress_log_size;        /* cluster log size */
>> +       unsigned char lz4hc_clevel;             /* lz4hc compress level */
>>          bool compress_chksum;                   /* compressed data chksum */
>>          unsigned char compress_ext_cnt;         /* extension count */
>>          unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
>> @@ -736,6 +737,10 @@ struct f2fs_inode_info {
>>          unsigned char i_log_cluster_size;       /* log of cluster size */
>>          unsigned short i_compress_flag;         /* compress flag */
>>          unsigned int i_cluster_size;            /* cluster size */
>> +       unsigned char i_lz4hc_clevel;           /*
>> +                                                * lz4hc compress level,
>> +                                                * range: 3-16, disable: 0
>> +                                                */
>>   };
>>
>>   static inline void get_extent_info(struct extent_info *ext,
>> @@ -3932,6 +3937,9 @@ static inline void set_compress_context(struct inode *inode)
>>                                  1 << COMPRESS_CHKSUM : 0;
>>          F2FS_I(inode)->i_cluster_size =
>>                          1 << F2FS_I(inode)->i_log_cluster_size;
>> +       if (F2FS_I(inode)->i_compress_algorithm == COMPRESS_LZ4 &&
>> +                       F2FS_OPTION(sbi).lz4hc_clevel)
>> +               F2FS_I(inode)->i_lz4hc_clevel = F2FS_OPTION(sbi).lz4hc_clevel;
>>          F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
>>          set_inode_flag(inode, FI_COMPRESSED_FILE);
>>          stat_inc_compr_inode(inode);
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 39fad324ca52..98be4d87e067 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -461,6 +461,10 @@ static int do_read_inode(struct inode *inode)
>>                          fi->i_compress_algorithm = ri->i_compress_algorithm;
>>                          fi->i_log_cluster_size = ri->i_log_cluster_size;
>>                          fi->i_compress_flag = le16_to_cpu(ri->i_compress_flag);
>> +                       if (fi->i_compress_algorithm == COMPRESS_LZ4 &&
>> +                                       F2FS_OPTION(sbi).lz4hc_clevel)
>> +                               fi->i_lz4hc_clevel =
>> +                                       F2FS_OPTION(sbi).lz4hc_clevel;
>>                          fi->i_cluster_size = 1 << fi->i_log_cluster_size;
>>                          set_inode_flag(inode, FI_COMPRESSED_FILE);
>>                  }
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index b0c6ef2df7b8..2cd7fcc400b8 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/quota.h>
>>   #include <linux/unicode.h>
>>   #include <linux/part_stat.h>
>> +#include <linux/lz4.h>
>>
>>   #include "f2fs.h"
>>   #include "node.h"
>> @@ -148,6 +149,7 @@ enum {
>>          Opt_compress_extension,
>>          Opt_compress_chksum,
>>          Opt_compress_cache,
>> +       Opt_compress_lz4hc_clevel,
>>          Opt_atgc,
>>          Opt_err,
>>   };
>> @@ -218,6 +220,7 @@ static match_table_t f2fs_tokens = {
>>          {Opt_compress_extension, "compress_extension=%s"},
>>          {Opt_compress_chksum, "compress_chksum"},
>>          {Opt_compress_cache, "compress_cache"},
>> +       {Opt_compress_lz4hc_clevel, "compress_lz4hc_clevel=%u"},
>>          {Opt_atgc, "atgc"},
>>          {Opt_err, NULL},
>>   };
>> @@ -944,12 +947,20 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>                  case Opt_compress_cache:
>>                          set_opt(sbi, COMPRESS_CACHE);
>>                          break;
>> +               case Opt_compress_lz4hc_clevel:
>> +                       if (args->from && match_int(args, &arg))
>> +                               return -EINVAL;
>> +                       if (arg < LZ4HC_MIN_CLEVEL || arg > LZ4HC_MAX_CLEVEL)
>> +                               return -EINVAL;
>> +                       F2FS_OPTION(sbi).lz4hc_clevel = arg;
>> +                       break;
>>   #else
>>                  case Opt_compress_algorithm:
>>                  case Opt_compress_log_size:
>>                  case Opt_compress_extension:
>>                  case Opt_compress_chksum:
>>                  case Opt_compress_cache:
>> +               case Opt_compress_lz4hc_clevel:
>>                          f2fs_info(sbi, "compression options not supported");
>>                          break;
>>   #endif
>> @@ -1543,6 +1554,10 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
>>
>>          if (test_opt(sbi, COMPRESS_CACHE))
>>                  seq_puts(seq, ",compress_cache");
>> +
>> +       if (F2FS_OPTION(sbi).lz4hc_clevel)
>> +               seq_printf(seq, ",compress_lz4hc_clevel=%u",
>> +                               F2FS_OPTION(sbi).lz4hc_clevel);
>>   }
>>
>>   static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>> --
>> 2.26.2
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
