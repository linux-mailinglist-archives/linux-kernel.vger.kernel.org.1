Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174AA2D1844
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLGSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgLGSNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:13:48 -0500
Date:   Mon, 7 Dec 2020 10:13:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607364787;
        bh=WA4Z5WMSDn1c5FX1KInte6wma4gAm1WZIUR0t0bLAeA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDj6p9550nh/kmo2eBV+sSK1bKA6XsgWLdqpQDky9RqdxoFAv8T07+xDVmGRAgFRi
         sAE23IFyV5G70emWahdMg6pl7bTorbHxpSFQ4SdLFqb7ll5p7fm5ZD8TqqOsGZ8Fqs
         GmjC9SmJHqh6E9KmujPd4tY+RCjeW+mRr4R27jqzV5d6Ql5gekLjwqjgAmtGlubt26
         mc2ysCjWRr9BG37SWFZAuog1V8aFIqjnxlztPkxRK3KvMmM/j5VoTlb7YsEwPOoL+N
         CH18aO/t3ffpDw39PptLXRYbl7qzaDMx8bIfUVLxIx3H5A1xFNuIj/dST+Mcv2iMaD
         jPH2t3GO84VrQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v5 RESEND] f2fs: compress: add compress_inode
 to cache compressed blocks
Message-ID: <X85wshahXe4nR+N6@gmail.com>
References: <20201207095220.73093-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207095220.73093-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 05:52:20PM +0800, Chao Yu wrote:
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index dae15c96e659..fd413d319e93 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -268,6 +268,9 @@ compress_mode=%s	 Control file compression mode. This supports "fs" and "user"
>  			 choosing the target file and the timing. The user can do manual
>  			 compression/decompression on the compression enabled files using
>  			 ioctls.
> +compress_cache		 Support to use address space of inner inode to cache
> +			 compressed block, in order to improve cache hit ratio of
> +			 random read.

What is an "inner inode"?  Mount options should be understandable without
understanding filesystem implementation details.

> +const struct address_space_operations f2fs_compress_aops = {
> +	.releasepage = f2fs_release_page,
> +	.invalidatepage = f2fs_invalidate_page,
> +};
> +
> +struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
> +{
> +	return sbi->compress_inode->i_mapping;
> +}
> +
> +void invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr)
> +{
> +	if (!sbi->compress_inode)
> +		return;
> +	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr);
> +}

Global functions should have the "f2fs_" prefix.

- Eric
