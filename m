Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA24A2CDF02
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgLCTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgLCTdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:33:17 -0500
Date:   Thu, 3 Dec 2020 11:32:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607023956;
        bh=G81b7sAQkDFZGaWOTLOclHTz9c5GLdvtf0TzZVW7prg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdJ+jcDzFI72yCDHKCUEwqPWu7KQONp/q26z8c0MOUsVFnfSnaiSnDuRfScnIR8G6
         V5yZK8sti/fes59TgG+MqANLcXzDFwwqAmtrjgGUmDCw7Qo4AU6xGcBgZhpFN6M5Tv
         PBxjOxlrga5pI/Q9AnPGqkChZFQAfpoUIVyRwsk5/jl2kLGFehgm4QkYHGZ+We/8pS
         yhd+lA3U68dwZI86furD8bDekC5Pt3rarIrgGyAfj158PfGNk+0obf4j0wRv+qKrJg
         F159Ga6F6tRstcpPGtqEt6OuauGSh3BKOVNEbjIZKwf276zl26BSHsnOM0osmiy+u2
         m3vv0vM2bWRDw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
Message-ID: <X8k9UoUKcyThlJNU@gmail.com>
References: <20201203061715.60447-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203061715.60447-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:17:15PM +0800, Chao Yu wrote:
> +config F2FS_FS_LZ4HC
> +	bool "LZ4HC compression support"
> +	depends on F2FS_FS_COMPRESSION
> +	depends on F2FS_FS_LZ4
> +	select LZ4HC_COMPRESS
> +	default y
> +	help
> +	  Support LZ4HC compress algorithm, if unsure, say Y.
> +

It would be helpful to mention that LZ4HC is on-disk compatible with LZ4.

>  static int lz4_compress_pages(struct compress_ctx *cc)
>  {
>  	int len;
>  
> +#ifdef CONFIG_F2FS_FS_LZ4HC
> +	return lz4hc_compress_pages(cc);
> +#endif

This looks wrong; it always calls lz4hc compression even for regular lz4.

>  static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -886,10 +939,22 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			if (!strcmp(name, "lzo")) {
>  				F2FS_OPTION(sbi).compress_algorithm =
>  								COMPRESS_LZO;
> -			} else if (!strcmp(name, "lz4")) {
> +			} else if (!strncmp(name, "lz4", 3)) {

strcmp() is fine, no need for strncmp().

> @@ -1547,6 +1612,9 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
>  	}
>  	seq_printf(seq, ",compress_algorithm=%s", algtype);
>  
> +	if (!F2FS_OPTION(sbi).compress_level)
> +		seq_printf(seq, ":%d", F2FS_OPTION(sbi).compress_level);
> +

This looks wrong; it only prints compress_level if it is 0.

> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 55be7afeee90..2dcc63fe8494 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -275,6 +275,9 @@ struct f2fs_inode {
>  			__u8 i_compress_algorithm;	/* compress algorithm */
>  			__u8 i_log_cluster_size;	/* log of cluster size */
>  			__le16 i_compress_flag;		/* compress flag */
> +						/* 0 bit: chksum flag
> +						 * [10,15] bits: compress level
> +						 */

What is the use case for storing the compression level on-disk?

Keep in mind that compression levels are an implementation detail; the exact
compressed data that is produced by a particular algorithm at a particular
compression level is *not* a stable interface.  It can change when the
compressor is updated, as long as the output continues to be compatible with the
decompressor.

So does compression level really belong in the on-disk format?

- Eric
