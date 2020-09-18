Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2532626F226
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgIRC4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbgIRC43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:56:29 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB8E206B6;
        Fri, 18 Sep 2020 02:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600397789;
        bh=btqXYTF0PNPv/mb8paQ68oaE4+SHI3dRRxApfP+mkmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcFsvhzc6CeEQ2WObijhFV05KNALsNgNCaTmUQZomWYV8hLpjWsCgGVMHDragVd5F
         zhsUNf/clR7+8Drg1VGRAXaXEFpPCkw3Bi/BTmxg/IUtooLBLifg9tgtO6u00Jy/1n
         rD0qAz3zWclop2Fw4CQbTItr5M0orjqojFzNcmYE=
Date:   Thu, 17 Sep 2020 19:56:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Nick Terrell <terrelln@fb.com>, Johannes Weiner <jweiner@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Yann Collet <cyan@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Petr Malat <oss@malat.biz>, Chris Mason <clm@fb.com>,
        Kernel Team <Kernel-team@fb.com>, Niket Agarwal <niketa@fb.com>
Subject: Re: [PATCH 6/9] f2fs: zstd: Switch to the zstd-1.4.6 API
Message-ID: <20200918025627.GA3518637@gmail.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-9-nickrterrell@gmail.com>
 <28bf92f1-1246-a840-6195-0e230e517e6d@huawei.com>
 <C8517011-9B6F-499F-BEC6-25BF1F0794AC@fb.com>
 <f7b19bc6-e57f-b4d8-b1f7-89c428b79cdf@huawei.com>
 <C327820B-5BD8-4739-AE4E-04EF27BE8150@fb.com>
 <9589E483-A94B-4AF6-8C03-B0763715B40A@fb.com>
 <a8b6e21d-fb51-1a50-8f2a-045f3a496c12@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b6e21d-fb51-1a50-8f2a-045f3a496c12@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 09:47:32AM +0800, Chao Yu wrote:
> Ah, I got it.
> 
> Step of enabling compressed inode is not correct, we should touch an empty
> file, and then use 'chattr +c' on that file to enable compression, otherwise
> the race condition could be complicated to handle. So we need below diff to
> disallow setting compression flag on an non-empty file:
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 8a422400e824..b462db7898fd 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1836,6 +1836,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  		if (iflags & F2FS_COMPR_FL) {
>  			if (!f2fs_may_compress(inode))
>  				return -EINVAL;
> +			if (get_dirty_pages(inode) || fi->i_compr_blocks)
> +				return  -EINVAL;
> 
>  			set_compress_context(inode);
>  		}

Why not:

	if (inode->i_size)
		return -EINVAL;
