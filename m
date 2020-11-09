Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0832AC1A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgKIRAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:00:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgKIRAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:00:37 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B2E20809;
        Mon,  9 Nov 2020 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604941237;
        bh=bjONPyQjSWqtb8RSe2JNSEdnNR0aM/RcazfxhnrBinQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0z0S+1luyaFGtlhYEbEKUj2Bc+EyUgvnD4ecLtS5bxK1+MuXnD5zHW1+fjMwzfDV
         nFwT+nWYmkN34j7h564nR7JJrCABZH03vpLOazzrDiGHx7ZSbwK7EvRPiqWB0WpquL
         czPXQyBfs8NSkQR5cN99AR7K1lPS+yNt0ClbEFTQ=
Date:   Mon, 9 Nov 2020 09:00:35 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid unneeded data copy in f2fs_ioc_move_range()
Message-ID: <20201109170035.GA2129970@google.com>
References: <20201109165914.2118360-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109165914.2118360-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this.

On 11/09, Jaegeuk Kim wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Fields in struct f2fs_move_range won't change in f2fs_ioc_move_range(),
> let's avoid copying this structure's data to userspace.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 52417a2e3f4f..22ae8ae0072f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2898,12 +2898,6 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
>  					range.pos_out, range.len);
>  
>  	mnt_drop_write_file(filp);
> -	if (err)
> -		goto err_out;
> -
> -	if (copy_to_user((struct f2fs_move_range __user *)arg,
> -						&range, sizeof(range)))
> -		err = -EFAULT;
>  err_out:
>  	fdput(dst);
>  	return err;
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
