Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14FE2C964B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgLAEKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 23:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgLAEKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:10:17 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D236920796;
        Tue,  1 Dec 2020 04:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606795777;
        bh=IDSdg+guasLBTGEvPlqfaxTayjeUYhY516Z8N9vIwFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yW0yy1dUB3OUyKbX0TGGC6bn4IixF3TN4vPNqoRlbzJ147/dyQs91/q/qwAza0c2Z
         cU5Wf2QutdXkdWMYyAftvxdWP+vEfBgCIWsbP/XkVeTze9QwEvI7eJtIheAOdMZbZv
         KIxj7MQigS30NaeDTbg8OG8fY5Ie7buw4kWimqFM=
Date:   Mon, 30 Nov 2020 20:09:35 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 3/4] f2fs: fix wrong block count instead of bytes
Message-ID: <20201201040935.GC3858797@google.com>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
 <20201126022416.3068426-3-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126022416.3068426-3-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25, Jaegeuk Kim wrote:
> We should convert cur_lblock, a block count, to bytes for len.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a84e5bc09337..e49c14ccfafe 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3893,7 +3893,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>  	sector_t highest_pblock = 0;
>  	int nr_extents = 0;
>  	unsigned long nr_pblocks;
> -	unsigned long len;
> +	u64 len;
>  	int ret;
>  
>  	/*
> @@ -3911,7 +3911,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>  		cond_resched();
>  
>  		memset(&map_bh, 0, sizeof(struct buffer_head));
> -		map_bh.b_size = len - cur_lblock;
> +		map_bh.b_size = len - blks_to_bytes(inode, cur_lblock);
>  
>  		ret = get_data_block(inode, cur_lblock, &map_bh, 0,
>  					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
> -- 
> 2.29.2.454.gaff20da3a2-goog
