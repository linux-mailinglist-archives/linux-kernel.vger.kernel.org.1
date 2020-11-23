Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7516A2C13D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbgKWSqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732338AbgKWSqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:46:49 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38FC20724;
        Mon, 23 Nov 2020 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606157209;
        bh=UtIMi0SFKxzigdnldRadgfBJUTnGFAzotVHREA3Z6uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGcuQcTXADPhCET2VVTwHQyHkkr8W7LYUFuKrcwcc/TIrRydZoBZWQ3IMxMUMf/qw
         fsQhVP6M9bBnOj4a7w7rkzz9NSK0cSB12Ep/iBNfd8cXGrQw2xyP5GahT8j/NnMP/4
         uHqqCVKRFUWaPKfI/J3eZtFpjCajeQWVAo1SBo+g=
Date:   Mon, 23 Nov 2020 10:46:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add compress_mode mount option
Message-ID: <20201123184647.GA3694916@gmail.com>
References: <20201123031751.36811-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123031751.36811-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:17:50PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We will add a new "compress_mode" mount option to control file
> compression mode. This supports "fs-based" and "user-based".
> In "fs-based" mode (default), f2fs does automatic compression on
> the compression enabled files. In "user-based" mode, f2fs disables
> the automaic compression and gives the user discretion of choosing
> the target file and the timing. It means the user can do manual
> compression/decompression on the compression enabled files using ioctls.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/filesystems/f2fs.rst |  7 +++++++
>  fs/f2fs/data.c                     | 10 +++++-----
>  fs/f2fs/f2fs.h                     | 30 ++++++++++++++++++++++++++++++
>  fs/f2fs/segment.c                  |  2 +-
>  fs/f2fs/super.c                    | 23 +++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index b8ee761c9922..0679c53d5012 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -260,6 +260,13 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
>  			 For other files, we can still enable compression via ioctl.
>  			 Note that, there is one reserved special extension '*', it
>  			 can be set to enable compression for all files.
> +compress_mode=%s	 Control file compression mode. This supports "fs-based" and
> +			 "user-based". In "fs-based" mode (default), f2fs does
> +			 automatic compression on the compression enabled files.
> +			 In "user-based" mode, f2fs disables the automaic compression
> +			 and gives the user discretion of choosing the target file and
> +			 the timing. The user can do manual compression/decompression
> +			 on the compression enabled files using ioctls.

Please clarify in the documentation what it means for compression-enabled files
to not be compressed.  It is not obvious.

- Eric
