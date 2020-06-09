Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03B31F346A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgFIGxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 02:53:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbgFIGxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:53:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3EA53834E9FF4BC3AA4;
        Tue,  9 Jun 2020 14:53:01 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 9 Jun 2020
 14:52:56 +0800
Subject: Re: [PATCH v2] f2fs: allow writeback on error status filesystem
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200608120107.6336-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f981a95d-8ec3-4992-478a-1dc1f910f497@huawei.com>
Date:   Tue, 9 Jun 2020 14:52:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200608120107.6336-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Let's consider this patch in next Linux version.

BTW, do you still encounter consistency problem w/o this version?

On 2020/6/8 20:01, Chao Yu wrote:
>     71.07%     0.01%  kworker/u256:1+  [kernel.kallsyms]  [k] wb_writeback
>             |
>              --71.06%--wb_writeback
>                        |
>                        |--68.96%--__writeback_inodes_wb
>                        |          |
>                        |           --68.95%--writeback_sb_inodes
>                        |                     |
>                        |                     |--65.08%--__writeback_single_inode
>                        |                     |          |
>                        |                     |           --64.35%--do_writepages
>                        |                     |                     |
>                        |                     |                     |--59.83%--f2fs_write_node_pages
>                        |                     |                     |          |
>                        |                     |                     |           --59.74%--f2fs_sync_node_pages
>                        |                     |                     |                     |
>                        |                     |                     |                     |--27.91%--pagevec_lookup_range_tag
>                        |                     |                     |                     |          |
>                        |                     |                     |                     |           --27.90%--find_get_pages_range_tag
> 
> If filesystem was injected checkpoint errror, before umount, kworker will
> always hold one core in order to writeback a large number of node pages,
> that looks not reasonable, to avoid that, we can allow data/node write in
> such case, since we can force all data/node writes with OPU mode, and
> clear recovery flag on node, and checkpoint is not allowed as well, so we
> don't need to worry about writeback's effect on data/node in previous
> checkpoint, then with this way, it can decrease memory footprint cost by
> node/data pages and avoid looping into data/node writeback process.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c |  7 +++++++
>  fs/f2fs/data.c       | 22 +++++++++++++++-------
>  fs/f2fs/node.c       |  7 +++++--
>  3 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 236064930251..1bb8278a1c4a 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1238,6 +1238,13 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		goto retry_flush_nodes;
>  	}
>  
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		up_write(&sbi->node_write);
> +		up_write(&sbi->node_change);
> +		f2fs_unlock_all(sbi);
> +		return -EIO;
> +	}
> +
>  	/*
>  	 * sbi->node_change is used only for AIO write_begin path which produces
>  	 * dirty node blocks and some checkpoint values by block allocation.
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 267b5e76a02b..808e7734db19 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2508,6 +2508,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		return true;
>  	if (f2fs_lfs_mode(sbi))
>  		return true;
>  	if (S_ISDIR(inode->i_mode))
> @@ -2691,13 +2693,19 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  	/* we should bypass data pages to proceed the kworkder jobs */
>  	if (unlikely(f2fs_cp_error(sbi))) {
>  		mapping_set_error(page->mapping, -EIO);
> -		/*
> -		 * don't drop any dirty dentry pages for keeping lastest
> -		 * directory structure.
> -		 */
> -		if (S_ISDIR(inode->i_mode))
> -			goto redirty_out;
> -		goto out;
> +
> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE))
> +			goto out;
> +
> +		if (has_not_enough_free_secs(sbi, 0, 0)) {
> +			/*
> +			 * don't drop any dirty dentry pages for keeping lastest
> +			 * directory structure.
> +			 */
> +			if (S_ISDIR(inode->i_mode))
> +				goto redirty_out;
> +			goto out;
> +		}
>  	}
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 03e24df1c84f..372c04efad38 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1527,7 +1527,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  			unlock_page(page);
>  			return 0;
>  		}
> -		goto redirty_out;
> +		if (has_not_enough_free_secs(sbi, 0, 0))
> +			goto redirty_out;
> +		set_fsync_mark(page, 0);
> +		set_dentry_mark(page, 0);
>  	}
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> @@ -1568,7 +1571,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  		goto redirty_out;
>  	}
>  
> -	if (atomic && !test_opt(sbi, NOBARRIER))
> +	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_cp_error(sbi))
>  		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>  
>  	/* should add to global list before clearing PAGECACHE status */
> 
