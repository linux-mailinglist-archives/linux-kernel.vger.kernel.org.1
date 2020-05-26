Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42A51B654B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDWUTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 16:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDWUTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:19:23 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C0920724;
        Thu, 23 Apr 2020 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587673163;
        bh=3B7rm8CALXCymxZMrU1vXmKnavJAvKdXmx+44ZjrMRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlXKqUtYSaZ7thtrlvu3u5iKkHqrjOlrbI0Q/nNAFW+nSjbOuZHIHQRTxk+obmoxq
         Aud695RzDE+eJ/PJ9o4OgSCA7A0K5lZnIpL0yF/pF/y/yS98ebMX44BTdd9798j5Kn
         2FlyouW0JJRI04xYim0ciZSmXWrhLxzyegDOKfvw=
Date:   Thu, 23 Apr 2020 13:19:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        stummala@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Avoid double lock for cp_rwsem
Message-ID: <20200423201922.GB99191@google.com>
References: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Sayali Lokhande wrote:
> Call stack :
> f2fs_write_checkpoint()
> -> block_operations(sbi)
>     f2fs_lock_all(sbi);
>      down_write(&sbi->cp_rwsem); => write lock held
> <>
> -> f2fs_sync_node_pages()
>     if (is_inline_node(page))
>      flush_inline_data()
> 	page = f2fs_pagecache_get_page()
>          if (!page)
>            goto iput_out;
> 	iput_out:
> 	 iput(inode);
>           -> f2fs_evict_inode()
> 	      f2fs_truncate_blocks()
> 	       f2fs_lock_op()
> 	        down_read(&sbi->cp_rwsem); => read lock fail

How about this, since we don't actually need to flush inline_data?

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4da0d8713df5c..9af8d5319fdd3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1871,7 +1871,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
                        }

                        /* flush inline_data */
-                       if (is_inline_node(page)) {
+                       if (is_inline_node(page) && io_type != FS_CP_NODE_IO) {
                                clear_inline_node(page);
                                unlock_page(page);
                                flush_inline_data(sbi, ino_of_node(page));

> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  fs/f2fs/checkpoint.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 5ba649e..5c504cf 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		goto retry_flush_quotas;
>  	}
>  
> -retry_flush_nodes:
>  	down_write(&sbi->node_write);
>  
>  	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
>  		up_write(&sbi->node_write);
> +		f2fs_unlock_all(sbi);
>  		atomic_inc(&sbi->wb_sync_req[NODE]);
>  		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
>  		atomic_dec(&sbi->wb_sync_req[NODE]);
> -		if (err) {
> -			up_write(&sbi->node_change);
> -			f2fs_unlock_all(sbi);
> +		up_write(&sbi->node_change);
> +		if (err)
>  			goto out;
> -		}
>  		cond_resched();
> -		goto retry_flush_nodes;
> +		goto retry_flush_quotas;
>  	}
>  
>  	/*
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
