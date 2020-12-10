Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228962D636F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392282AbgLJRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:24:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391441AbgLJRY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:24:26 -0500
Date:   Thu, 10 Dec 2020 09:23:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607621025;
        bh=OMwkssHcKty+vlzemDTI48/lgSqmwlzZ/YXqxVTg4bA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=taTDBWeFKykbXbevMBubrEKPlSoLeWeAy3gTI1wXDOgHRSw02CTTfmreMrSKKKi2w
         itbIWalYWUD6ayXJiBwBC+Qf3U+pjwVy1D28G/XlADxnj22qyXjJmfhobC71TMaGr1
         B8gGkWbJkv8W2d/Q/GnDyBYy1tMdpCT99kREMtu43WMLbcsf30HYdAJ8Qp4NijoCby
         vzYhDq/BX4NmAM5To7eLNx6WztTpd/FzkPyEOiv308Ym3mqPlpK45j5MuRphVxIkIC
         Nxye89qKSYKsY817ugNm/v4b4buNvh/AjqjReSFBvVplgxelDohHSiCv4yxLFU2rV3
         KaecdzufOC2bQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH RFC] f2fs: compress: add compress_flag in struct
 f2fs_comp_option
Message-ID: <X9JZn2ELSZISEQpU@google.com>
References: <20201210092020.66245-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210092020.66245-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10, Chao Yu wrote:
> Add a extra field compress_flag to get/set more compress option from/to
> compressed inode.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> 
> Daeho, Jaegeuk,
> 
> Could you please check whether we could add this new field to struct
> f2fs_comp_option? so we can expand to allow user to query/config more
> options of compressed inode via new ioctl.
> 
> It needs to consider before original patches goes to merge window, let
> me know you have other concerns.

Chao, I think it'd hard to add this at time point, unless there's critical
info that we need to set very urgently.

> 
>  fs/f2fs/file.c            | 1 +
>  include/uapi/linux/f2fs.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 16ea10f2bcf5..fbf06311c88d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3965,6 +3965,7 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
>  
>  	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
>  	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
> +	option.compress_flag = F2FS_I(inode)->i_compress_flag;
>  
>  	inode_unlock_shared(inode);
>  
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 352a822d4370..2b9c4c99ceee 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -93,6 +93,7 @@ struct f2fs_sectrim_range {
>  struct f2fs_comp_option {
>  	__u8 algorithm;
>  	__u8 log_cluster_size;
> +	__u16 compress_flag;
>  };
>  
>  #endif /* _UAPI_LINUX_F2FS_H */
> -- 
> 2.29.2
