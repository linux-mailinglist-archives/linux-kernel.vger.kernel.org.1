Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE25295741
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgJVE0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgJVE0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:26:10 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C93223C7;
        Thu, 22 Oct 2020 04:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603340770;
        bh=tO1bg+mezuCia7YL2G0Qpt4JP1mhgBL20CGZrVb1xQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zlbSAvsHJd1XSuS7yLA1SMc54fNVzI9yhNG7FWvAnGm45Wx0YHj6hGBb0rnfcXsV8
         +xEadr7eMjPcp5Pg4c/GFZPFowk4+OAo59JK0tb7gMz59ahkkNk2Freq04wSqvmvMP
         cP2PnWYKriq0/Y/gdOJbQkkQ6mVpEk8zi4/R1IVU=
Date:   Wed, 21 Oct 2020 21:26:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION
 ioctl
Message-ID: <20201022042608.GB857@sol.localdomain>
References: <20201022035848.976286-1-daeho43@gmail.com>
 <20201022035848.976286-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022035848.976286-2-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:58:48PM +0900, Daeho Jeong wrote:
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7895186cc765..3b58a41223f8 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
>  	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
>  }
>  
> +bool f2fs_is_compress_algorithm_ready(unsigned char algorithm)
> +{
> +	return algorithm >= COMPRESS_MAX ? false : f2fs_cops[algorithm];
> +}

The use of ?: here is a bit strange.  How about:

	return algorithm < COMPRESS_MAX && f2fs_cops[algorithm] != NULL;

> +	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> +			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
> +			!f2fs_is_compress_algorithm_ready(option.algorithm))
> +		return -EINVAL;

Likewise, EINVAL tends to be over-used, which makes it ambiguous.  Maybe use
ENOPKG for the case where algorithm < COMPRESS_MAX but the algorithm wasn't
compiled into the kernel?  That would be similar to how opening an encrypted
file fails with ENOPKG when the encryption algorithm isn't available.

> +	if (f2fs_is_mmap_file(inode) ||
> +			get_dirty_pages(inode) || inode->i_size) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

How about EBUSY for f2fs_is_mmap_file(inode) || get_dirty_pages(inode),
and EFBIG for inode->i_size != 0?

- Eric
