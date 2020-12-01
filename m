Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16A22C9648
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLAEJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 23:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgLAEJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:09:48 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949F3206F9;
        Tue,  1 Dec 2020 04:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606795746;
        bh=yTT1WYFhXIaKG2neZB72+2e2pwf7+UMUsEInFXo4pSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzrH+W+lga4QzFg6HFd5f7UCVvoITNS7x8pvYd3+5zCpEvBBGhNVwIVe9PEYPr/UB
         l04Zhsl+xLX1+apwOx1BD6xOYeJLEp3SziQbJl8Fe7c5UNHu0wklTKom8zj8S0kHnY
         bCPS6E3Syw8b1kG7XeEDgnx/nHo/4iPi5LsGbRH8=
Date:   Mon, 30 Nov 2020 20:09:04 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 1/4] f2fs: rename logical_to_blk and blk_to_logical
Message-ID: <20201201040904.GA3858797@google.com>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126022416.3068426-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add f2fs mailing list.

On 11/25, Jaegeuk Kim wrote:
> This patch renames two functions like below having u64.
>  - logical_to_blk to bytes_to_blks
>  - blk_to_logical to blks_to_bytes
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index be4da52604ed..a8612c6f40ab 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1808,14 +1808,14 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
>  						NO_CHECK_TYPE, create);
>  }
>  
> -static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
> +static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
>  {
> -	return (offset >> inode->i_blkbits);
> +	return (bytes >> inode->i_blkbits);
>  }
>  
> -static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
> +static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
>  {
> -	return (blk << inode->i_blkbits);
> +	return (blks << inode->i_blkbits);
>  }
>  
>  static int f2fs_xattr_fiemap(struct inode *inode,
> @@ -1843,7 +1843,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>  			return err;
>  		}
>  
> -		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
> +		phys = blks_to_bytes(inode, ni.blk_addr);
>  		offset = offsetof(struct f2fs_inode, i_addr) +
>  					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
>  					get_inline_xattr_addrs(inode));
> @@ -1875,7 +1875,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>  			return err;
>  		}
>  
> -		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
> +		phys = blks_to_bytes(inode, ni.blk_addr);
>  		len = inode->i_sb->s_blocksize;
>  
>  		f2fs_put_page(page, 1);
> @@ -1945,18 +1945,18 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			goto out;
>  	}
>  
> -	if (logical_to_blk(inode, len) == 0)
> -		len = blk_to_logical(inode, 1);
> +	if (bytes_to_blks(inode, len) == 0)
> +		len = blks_to_bytes(inode, 1);
>  
> -	start_blk = logical_to_blk(inode, start);
> -	last_blk = logical_to_blk(inode, start + len - 1);
> +	start_blk = bytes_to_blks(inode, start);
> +	last_blk = bytes_to_blks(inode, start + len - 1);
>  
>  next:
>  	memset(&map_bh, 0, sizeof(struct buffer_head));
>  	map_bh.b_size = len;
>  
>  	if (compr_cluster)
> -		map_bh.b_size = blk_to_logical(inode, cluster_size - 1);
> +		map_bh.b_size = blks_to_bytes(inode, cluster_size - 1);
>  
>  	ret = get_data_block(inode, start_blk, &map_bh, 0,
>  					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
> @@ -1967,7 +1967,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	if (!buffer_mapped(&map_bh)) {
>  		start_blk = next_pgofs;
>  
> -		if (blk_to_logical(inode, start_blk) < blk_to_logical(inode,
> +		if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
>  						max_inode_blocks(inode)))
>  			goto prep_next;
>  
> @@ -1993,9 +1993,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		compr_cluster = false;
>  
>  
> -		logical = blk_to_logical(inode, start_blk - 1);
> -		phys = blk_to_logical(inode, map_bh.b_blocknr);
> -		size = blk_to_logical(inode, cluster_size);
> +		logical = blks_to_bytes(inode, start_blk - 1);
> +		phys = blks_to_bytes(inode, map_bh.b_blocknr);
> +		size = blks_to_bytes(inode, cluster_size);
>  
>  		flags |= FIEMAP_EXTENT_ENCODED;
>  
> @@ -2013,14 +2013,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		goto prep_next;
>  	}
>  
> -	logical = blk_to_logical(inode, start_blk);
> -	phys = blk_to_logical(inode, map_bh.b_blocknr);
> +	logical = blks_to_bytes(inode, start_blk);
> +	phys = blks_to_bytes(inode, map_bh.b_blocknr);
>  	size = map_bh.b_size;
>  	flags = 0;
>  	if (buffer_unwritten(&map_bh))
>  		flags = FIEMAP_EXTENT_UNWRITTEN;
>  
> -	start_blk += logical_to_blk(inode, size);
> +	start_blk += bytes_to_blks(inode, size);
>  
>  prep_next:
>  	cond_resched();
> @@ -3903,7 +3903,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>  	 * to be very smart.
>  	 */
>  	cur_lblock = 0;
> -	last_lblock = logical_to_blk(inode, i_size_read(inode));
> +	last_lblock = bytes_to_blks(inode, i_size_read(inode));
>  	len = i_size_read(inode);
>  
>  	while (cur_lblock <= last_lblock && cur_lblock < sis->max) {
> @@ -3925,7 +3925,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>  			goto err_out;
>  
>  		pblock = map_bh.b_blocknr;
> -		nr_pblocks = logical_to_blk(inode, map_bh.b_size);
> +		nr_pblocks = bytes_to_blks(inode, map_bh.b_size);
>  
>  		if (cur_lblock + nr_pblocks >= sis->max)
>  			nr_pblocks = sis->max - cur_lblock;
> -- 
> 2.29.2.454.gaff20da3a2-goog
