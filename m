Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10032D2197
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgLHDwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgLHDwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:52:10 -0500
Date:   Mon, 7 Dec 2020 19:51:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607399488;
        bh=uwHFkmRMJNQWu5o/EktiSUuQpKFAf8s/mDCjQuqN0WU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hj2AQrK111a4NAJdVMKLrtiByZkLgjt3j1np2yhikhW+uCESRy7eYd7DxHAtQvjBe
         2yDJghoslgQxsec98NCG9pdjn8o81bXne83X09b5B3h8xhLDbnAIT67F0NFH358EFc
         2h6ybdNfjOizuC8ETt+xjz/f41rLNhYAbFalqIEd5Ac5JLhJOWQFQiRv7s5z0Jx6R1
         k5Y8XR3CkWT5mnyJtm/QnmZf93RgC7RJW2ZCVRGQvp6kHsnBnTI64wfSBesMwdPEUV
         aFfHhiadgico2WlHLVtYPC4sYe8uyt9pTB1W8BG/uF1U1UDu8AZMRBo80FhT8yAE/H
         43O3L4Xa5pzAw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add compress_mode mount option
Message-ID: <X874P2evu7SUgjBA@gmail.com>
References: <20201201040803.3590442-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201040803.3590442-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:08:02PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We will add a new "compress_mode" mount option to control file
> compression mode. This supports "fs" and "user". In "fs" mode (default),
> f2fs does automatic compression on the compression enabled files.
> In "user" mode, f2fs disables the automaic compression and gives the
> user discretion of choosing the target file and the timing. It means
> the user can do manual compression/decompression on the compression
> enabled files using ioctls.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: changed mount option name and added more explanation of mount option
> ---
>  Documentation/filesystems/f2fs.rst | 35 ++++++++++++++++++++++++++++++
>  fs/f2fs/compress.c                 |  2 +-
>  fs/f2fs/data.c                     |  2 +-
>  fs/f2fs/f2fs.h                     | 30 +++++++++++++++++++++++++
>  fs/f2fs/segment.c                  |  2 +-
>  fs/f2fs/super.c                    | 23 ++++++++++++++++++++
>  6 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index b8ee761c9922..5eb8d63439ec 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -260,6 +260,13 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
>  			 For other files, we can still enable compression via ioctl.
>  			 Note that, there is one reserved special extension '*', it
>  			 can be set to enable compression for all files.
> +compress_mode=%s	 Control file compression mode. This supports "fs" and "user"
> +			 modes. In "fs" mode (default), f2fs does automatic compression
> +			 on the compression enabled files. In "user" mode, f2fs disables
> +			 the automaic compression and gives the user discretion of
> +			 choosing the target file and the timing. The user can do manual
> +			 compression/decompression on the compression enabled files using
> +			 ioctls.
>  inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
>  			 files using the blk-crypto framework rather than
>  			 filesystem-layer encryption. This allows the use of
> @@ -810,6 +817,34 @@ Compress metadata layout::
>  	| data length | data chksum | reserved |      compressed data       |
>  	+-------------+-------------+----------+----------------------------+
>  
> +Compression mode
> +--------------------------
> +
> +f2fs supports "fs" and "user" compression modes with "compression_mode" mount option.
> +With this option, f2fs provides a choice to select the way how to compress the
> +compression enabled files (refer to "Compression implementation" section for how to
> +enable compression on a regular inode).
> +
> +1) compress_mode=fs
> +This is the default option. f2fs does automatic compression in the writeback of the
> +compression enabled files.
> +
> +2) compress_mode=user
> +This disables the automaic compression and gives the user discretion of choosing the
> +target file and the timing. The user can do manual compression/decompression on the
> +compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
> +ioctls like the below.
> +
> +To decompress a file,
> +
> +fd = open(filename, O_WRONLY, 0);
> +ret = ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
> +
> +To compress a file,
> +
> +fd = open(filename, O_WRONLY, 0);
> +ret = ioctl(fd, F2FS_IOC_COMPRESS_FILE);
> +

Why doesn't compress_mode=user just cause regular files to not inherit the
compression flag?  Then users could set or clear the compression flag using
FS_IOC_SETFLAGS, without any need for these new ioctls.

- Eric
