Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE352A8B19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbgKFAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgKFAFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:05:52 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB85420759;
        Fri,  6 Nov 2020 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604621152;
        bh=GopOboKX48Vi0577YtxhvXzwzmNNcbiW/DXzmt2YRyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJUAgFFxsomGeKRDsqkPvTl10ieWoHnI53gAbkmNITqavukLvtAaBYdFJS4gCo93T
         KbphgajLNbDle8mGVn8KSnV/z2VtoaPcr2R0ho+k+amGkhhmiwJeCcqGcYvHFPkW8/
         +RljiNOBxc5452dh/5GaT8hff7sS0F2L87LEe7jw=
Date:   Thu, 5 Nov 2020 16:05:50 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
Message-ID: <20201106000550.GD2555324@gmail.com>
References: <20201105010934.16018-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105010934.16018-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is marked 2/2, but it seems you sent it out on its own.  Patch series
are supposed to be resend in full; otherwise people can see just one patch and
have no context.

On Thu, Nov 05, 2020 at 09:09:34AM +0800, Chao Yu wrote:
> Eric reported a ioctl bug in below link:
> 
> https://lore.kernel.org/linux-f2fs-devel/20201103032234.GB2875@sol.localdomain/
> 
> That said, on some 32-bit architectures, u64 has only 32-bit alignment,
> notably i386 and x86_32, so that size of struct f2fs_gc_range compiled
> in x86_32 is 20 bytes, however the size in x86_64 is 24 bytes, binary
> compiled in x86_32 can not call F2FS_IOC_GARBAGE_COLLECT_RANGE successfully
> due to mismatched value of ioctl command in between binary and f2fs
> module, similarly, F2FS_IOC_MOVE_RANGE will fail too.
> 
> In this patch we introduce two ioctls for compatibility of above special
> 32-bit binary:
> - F2FS_IOC32_GARBAGE_COLLECT_RANGE
> - F2FS_IOC32_MOVE_RANGE
> 

It would be good to add a proper reported-by line, otherwise it's not clear who
"Eric" is (there are lots of Erics):

Reported-by: Eric Biggers <ebiggers@google.com>

> +static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
>  {
> -	struct inode *inode = file_inode(filp);
> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct f2fs_gc_range range;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
>  	u64 end;
>  	int ret;
>  
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		return -EIO;
> +	if (!f2fs_is_checkpoint_ready(sbi))
> +		return -ENOSPC;

These two checkpoint-related checks weren't present in the original version.
Is that intentional?

> +static int __f2fs_ioc_move_range(struct file *filp,
> +				struct f2fs_move_range *range)
>  {
> -	struct f2fs_move_range range;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
>  	struct fd dst;
>  	int err;
>  
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		return -EIO;
> +	if (!f2fs_is_checkpoint_ready(sbi))
> +		return -ENOSPC;
> +

Likewise here.

> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index f00199a2e38b..8c14e88a9645 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -5,6 +5,10 @@
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
>  
> +#ifdef __KERNEL__
> +#include <linux/compat.h>
> +#endif
> +
>  /*
>   * f2fs-specific ioctl commands
>   */
> @@ -65,6 +69,16 @@ struct f2fs_gc_range {
>  	__u64 len;
>  };
>  
> +#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> +struct compat_f2fs_gc_range {
> +	u32 sync;
> +	compat_u64 start;
> +	compat_u64 len;
> +};
> +#define F2FS_IOC32_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,\
> +						struct compat_f2fs_gc_range)
> +#endif
> +
>  struct f2fs_defragment {
>  	__u64 start;
>  	__u64 len;
> @@ -77,6 +91,17 @@ struct f2fs_move_range {
>  	__u64 len;		/* size to move */
>  };
>  
> +#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> +struct compat_f2fs_move_range {
> +	u32 dst_fd;
> +	compat_u64 pos_in;
> +	compat_u64 pos_out;
> +	compat_u64 len;
> +};
> +#define F2FS_IOC32_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
> +					struct compat_f2fs_move_range)
> +#endif
> +
>  struct f2fs_flush_device {
>  	__u32 dev_num;		/* device number to flush */
>  	__u32 segments;		/* # of segments to flush */
> -- 

Did you consider instead putting these compat definitions in an internal kernel
header, or even just in the .c file, to avoid cluttering up the UAPI header?

- Eric
