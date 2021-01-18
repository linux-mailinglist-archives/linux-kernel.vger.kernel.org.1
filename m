Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FAC2FA35B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393164AbhAROnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:43:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:49802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405020AbhAROmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:42:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0761DB814;
        Mon, 18 Jan 2021 14:41:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BBE6F1E0816; Mon, 18 Jan 2021 15:41:23 +0100 (CET)
Date:   Mon, 18 Jan 2021 15:41:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: release buffer head before return
Message-ID: <20210118144123.GC19606@quack2.suse.cz>
References: <20210118120455.118955-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118120455.118955-1-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-01-21 04:04:55, Pan Bian wrote:
> Release the buffer header before returning error code.
> 
> Fixes: 2deb1acc653c ("isofs: fix access to unallocated memory when reading corrupted filesystem")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

OK, good spotting. But the other hunk in commit 2deb1acc653c seems to have
the same problem so we might fix it as well when we are at it?

								Honza

> ---
>  fs/isofs/dir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index f0fe641893a5..b9e6a7ec78be 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -152,6 +152,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
>  			       " in block %lu of inode %lu\n", block,
>  			       inode->i_ino);
> +			brelse(bh);
>  			return -EIO;
>  		}
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
