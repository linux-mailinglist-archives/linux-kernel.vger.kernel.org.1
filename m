Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B892C11BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390248AbgKWRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgKWRSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:18:42 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D703B20728;
        Mon, 23 Nov 2020 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606151921;
        bh=48B9rctbWKvyvXUQEAiSb4Sa3gBgHM3LrUa8Pn8ZT90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2fLxp2nFvj4QyLkmZ98T9fPix0Jbyqo0H/+gxTmo8Hu3TMATFqjEOztQSLtXPQmK
         s2Ap7Q3uBT5i9TfXse+z3UhbvNYefNGPafgQiiMPjXqCnWQF8JPqBOcyxMWFsS/Cie
         K+WOKJu3hrAUBhr6JXuUoM4ZfRH5hRrTXgZXYSWU=
Date:   Mon, 23 Nov 2020 09:18:39 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add compress_mode mount option
Message-ID: <20201123171839.GB413620@google.com>
References: <20201123031751.36811-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123031751.36811-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We will add a new "compress_mode" mount option to control file
> compression mode. This supports "fs-based" and "user-based".
> In "fs-based" mode (default), f2fs does automatic compression on
> the compression enabled files. In "user-based" mode, f2fs disables
> the automaic compression and gives the user discretion of choosing
> the target file and the timing. It means the user can do manual
> compression/decompression on the compression enabled files using ioctls.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/filesystems/f2fs.rst |  7 +++++++
>  fs/f2fs/data.c                     | 10 +++++-----
>  fs/f2fs/f2fs.h                     | 30 ++++++++++++++++++++++++++++++
>  fs/f2fs/segment.c                  |  2 +-
>  fs/f2fs/super.c                    | 23 +++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index b8ee761c9922..0679c53d5012 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -260,6 +260,13 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
>  			 For other files, we can still enable compression via ioctl.
>  			 Note that, there is one reserved special extension '*', it
>  			 can be set to enable compression for all files.
> +compress_mode=%s	 Control file compression mode. This supports "fs-based" and
> +			 "user-based". In "fs-based" mode (default), f2fs does

I think "fs" and "user" would be enough.

> +			 automatic compression on the compression enabled files.
> +			 In "user-based" mode, f2fs disables the automaic compression
> +			 and gives the user discretion of choosing the target file and
> +			 the timing. The user can do manual compression/decompression
> +			 on the compression enabled files using ioctls.
>  inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
>  			 files using the blk-crypto framework rather than
>  			 filesystem-layer encryption. This allows the use of
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index be4da52604ed..69370f0073dd 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2896,7 +2896,7 @@ static int f2fs_write_data_page(struct page *page,
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>  		goto out;
>  
> -	if (f2fs_compressed_file(inode)) {
> +	if (f2fs_need_compress_write(inode)) {
>  		if (f2fs_is_compressed_cluster(inode, page->index)) {
>  			redirty_page_for_writepage(wbc, page);
>  			return AOP_WRITEPAGE_ACTIVATE;
> @@ -2988,7 +2988,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  readd:
>  			need_readd = false;
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> -			if (f2fs_compressed_file(inode)) {
> +			if (f2fs_need_compress_write(inode)) {
>  				ret = f2fs_init_compress_ctx(&cc);
>  				if (ret) {
>  					done = 1;
> @@ -3067,7 +3067,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				goto continue_unlock;
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> -			if (f2fs_compressed_file(inode)) {
> +			if (f2fs_need_compress_write(inode)) {
>  				get_page(page);
>  				f2fs_compress_ctx_add_page(&cc, page);
>  				continue;
> @@ -3120,7 +3120,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	}
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	/* flush remained pages in compress cluster */
> -	if (f2fs_compressed_file(inode) && !f2fs_cluster_is_empty(&cc)) {
> +	if (f2fs_need_compress_write(inode) && !f2fs_cluster_is_empty(&cc)) {
>  		ret = f2fs_write_multi_pages(&cc, &submitted, wbc, io_type);
>  		nwritten += submitted;
>  		wbc->nr_to_write -= submitted;
> @@ -3164,7 +3164,7 @@ static inline bool __should_serialize_io(struct inode *inode,
>  	if (IS_NOQUOTA(inode))
>  		return false;
>  
> -	if (f2fs_compressed_file(inode))
> +	if (f2fs_need_compress_write(inode))
>  		return true;
>  	if (wbc->sync_mode != WB_SYNC_ALL)
>  		return true;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e0826779a101..88e012d07ad5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -149,6 +149,7 @@ struct f2fs_mount_info {
>  	unsigned char compress_algorithm;	/* algorithm type */
>  	unsigned compress_log_size;		/* cluster log size */
>  	unsigned char compress_ext_cnt;		/* extension count */
> +	int compress_mode;			/* compression mode */
>  	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
>  };
>  
> @@ -677,6 +678,7 @@ enum {
>  	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
>  	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
>  	FI_MMAP_FILE,		/* indicate file was mmapped */
> +	FI_ENABLE_COMPRESS,	/* enable compression in user-based compression mode */
>  	FI_MAX,			/* max flag, never be used */
>  };
>  
> @@ -1243,6 +1245,18 @@ enum fsync_mode {
>  	FSYNC_MODE_NOBARRIER,	/* fsync behaves nobarrier based on posix */
>  };
>  
> +enum {
> +	COMPR_MODE_FS,		/*
> +				 * automatically compress compression
> +				 * enabled files
> +				 */
> +	COMPR_MODE_USER,	/*
> +				 * automatical compression is disabled.
> +				 * user can control the file compression
> +				 * using ioctls
> +				 */
> +};
> +
>  /*
>   * this value is set in page as a private data which indicate that
>   * the page is atomically written, and it is in inmem_pages list.
> @@ -2752,6 +2766,22 @@ static inline int f2fs_compressed_file(struct inode *inode)
>  		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>  }
>  
> +static inline int f2fs_need_compress_write(struct inode *inode)
> +{
> +	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
> +
> +	if (!f2fs_compressed_file(inode))
> +		return 0;
> +
> +	if (compress_mode == COMPR_MODE_FS)
> +		return 1;
> +	else if (compress_mode == COMPR_MODE_USER &&
> +			is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static inline unsigned int addrs_per_inode(struct inode *inode)
>  {
>  	unsigned int addrs = CUR_ADDRS_PER_INODE(inode) -
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1596502f7375..652ca049bb7e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3254,7 +3254,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  			else
>  				return CURSEG_COLD_DATA;
>  		}
> -		if (file_is_cold(inode) || f2fs_compressed_file(inode))
> +		if (file_is_cold(inode) || f2fs_need_compress_write(inode))
>  			return CURSEG_COLD_DATA;
>  		if (file_is_hot(inode) ||
>  				is_inode_flag_set(inode, FI_HOT_DATA) ||
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 87f7a6e86370..ea2385aa7f48 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -146,6 +146,7 @@ enum {
>  	Opt_compress_algorithm,
>  	Opt_compress_log_size,
>  	Opt_compress_extension,
> +	Opt_compress_mode,
>  	Opt_atgc,
>  	Opt_err,
>  };
> @@ -214,6 +215,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_compress_algorithm, "compress_algorithm=%s"},
>  	{Opt_compress_log_size, "compress_log_size=%u"},
>  	{Opt_compress_extension, "compress_extension=%s"},
> +	{Opt_compress_mode, "compress_mode=%s"},
>  	{Opt_atgc, "atgc"},
>  	{Opt_err, NULL},
>  };
> @@ -934,10 +936,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			F2FS_OPTION(sbi).compress_ext_cnt++;
>  			kfree(name);
>  			break;
> +		case Opt_compress_mode:
> +			name = match_strdup(&args[0]);
> +			if (!name)
> +				return -ENOMEM;
> +			if (!strcmp(name, "fs-based")) {
> +				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
> +			} else if (!strcmp(name, "user-based")) {
> +				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
> +			} else {
> +				kfree(name);
> +				return -EINVAL;
> +			}
> +			kfree(name);
> +			break;
>  #else
>  		case Opt_compress_algorithm:
>  		case Opt_compress_log_size:
>  		case Opt_compress_extension:
> +		case Opt_compress_mode:
>  			f2fs_info(sbi, "compression options not supported");
>  			break;
>  #endif
> @@ -1523,6 +1540,11 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
>  		seq_printf(seq, ",compress_extension=%s",
>  			F2FS_OPTION(sbi).extensions[i]);
>  	}
> +
> +	if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_FS)
> +		seq_printf(seq, ",compress_mode=%s", "fs-based");
> +	else if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
> +		seq_printf(seq, ",compress_mode=%s", "user-based");
>  }
>  
>  static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> @@ -1672,6 +1694,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
>  	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
>  	F2FS_OPTION(sbi).compress_ext_cnt = 0;
> +	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
>  	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
>  
>  	sbi->sb->s_flags &= ~SB_INLINECRYPT;
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
