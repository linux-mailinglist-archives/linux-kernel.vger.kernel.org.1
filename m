Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB72D1855
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgLGSRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgLGSRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:17:35 -0500
Date:   Mon, 7 Dec 2020 10:16:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607365015;
        bh=le8vfxceC05Tky48BN1v0WaIn5E3rrFNOOcF0AF1HL4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRvuvDQVG1PXt8E3Pc3u2I3v3PG+NTgsIULlnokT5ZIij6isspvvrH9tQ9Pp57O8w
         MCZ2cx7Fcypat1dqvCbepSXIQOcD2uMmw4m1NpKiqaECFcbgeQPcc3dVy2+4bpsfKl
         BPK7YZkcDuvN1aIjYIVRPaWP4f3EsrSDjhsxn4cfsBR5NAuyNOlX3P1aAlGtWk7AgZ
         maZmLyldh4UpG8YVt+OH5Ifd5QxVz/QMGKUU7RZjdTMcXGeoIlI/w12ZELNlRjA1e8
         URI1KhV4Sb94eNQRbeZN486oF3xVrrdi5aE93A/3qBNsyqOn6fxU7Lp6tg1WlwlHem
         ahSPnDha6IQrw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: compress: deny setting
 unsupported compress algorithm
Message-ID: <X85xlc2Q0gnBywBE@gmail.com>
References: <20201207095609.73825-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207095609.73825-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 05:56:09PM +0800, Chao Yu wrote:
> If kernel doesn't support certain kinds of compress algorithm, deny to set
> them as compress algorithm of f2fs via 'compress_algorithm=%s' mount option.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> no changes, just rebase on dev branch.

This doesn't apply to the dev branch anymore.

>  fs/f2fs/super.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e0fe72f1d2c8..662e59f32645 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -936,9 +936,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			if (!name)
>  				return -ENOMEM;
>  			if (!strcmp(name, "lzo")) {
> +#ifdef CONFIG_F2FS_FS_LZO
>  				F2FS_OPTION(sbi).compress_algorithm =
>  								COMPRESS_LZO;
> +#else
> +				f2fs_info(sbi, "Image doesn't support lzo compression");
> +#endif

These info messages don't make sense.  It's not the filesystem image that
doesn't support the algorithm, but rather the kernel that doesn't.

Also, shouldn't these be warnings instead of "info"?

- Eric
