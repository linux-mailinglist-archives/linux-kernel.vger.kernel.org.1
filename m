Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7384A2779DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIXUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgIXUDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:03:06 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC48621707;
        Thu, 24 Sep 2020 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600977786;
        bh=4qmfMtKFtj1GJGkFkWVAtlMq33rZaTCs31/4IdPYFgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9VS01GBzz6O6mO0j9z64QuPZISKKrv+9/L5RHqR2fvjRa2GE52yanS/0NdJ5me/Q
         ZvAnEk+SO6dz4UyHxJUC4XQAkSOv348iREjEmnJluefIBb0SZrypQkR0t2u4tuCThC
         YUNOLt3BSKhff+6NGw16fzuu0oX8md72JUsAwhAY=
Date:   Thu, 24 Sep 2020 13:03:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: compress: fix to disallow enabling compress on
 non-empty file
Message-ID: <20200924200305.GA2568648@google.com>
References: <20200918030349.19667-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918030349.19667-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18, Chao Yu wrote:
> Compressed inode and normal inode has different layout, so we should
> disallow enabling compress on non-empty file to avoid race condition
> during inode .i_addr array parsing and updating.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 58e464cc15f0..139fdfc1dc55 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1821,6 +1821,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  		if (iflags & F2FS_COMPR_FL) {
>  			if (!f2fs_may_compress(inode))
>  				return -EINVAL;
> +			if (inode->i_size)

Changed like this.

+                       if (S_ISREG(inode->i_mode) && inode->i_size)


> +				return -EINVAL;
>  
>  			set_compress_context(inode);
>  		}
> -- 
> 2.26.2
