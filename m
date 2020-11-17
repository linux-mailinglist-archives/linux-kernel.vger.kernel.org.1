Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1626B2B58BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 05:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgKQEO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 23:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgKQEO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:14:56 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39ED824692;
        Tue, 17 Nov 2020 04:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605586496;
        bh=EUZuSaWR7L8DS5oY3+rH31vEa/9kDCzJ9/I0RDpwemM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+UDMrWZsAB8vfZVXXHBEyaOsdr9Z7jW4tHsDEc5ybT409kb0Clb58Jpk6Cj825Nv
         HgTZsdLl+uYtHt6Ane5SiOLN25muFQx6kjLVlOjMCQzVj5S0FPSE3/TTe+iffbu5vn
         ALSgWq4U4NURD7exEGe0A1i6idTtgKXtrZ97O5eQ=
Date:   Mon, 16 Nov 2020 20:14:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add disable_auto_compr mount option
Message-ID: <X7NOPrbIMtHFvVwp@sol.localdomain>
References: <20201117040223.858979-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117040223.858979-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset doesn't have a cover letter, and it doesn't apply to f2fs/dev, so
I'm not sure what its purpose is.

On Tue, Nov 17, 2020 at 01:02:22PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We will add a new disable_auto_compr mount option to turn off the
> automaic compression on the compression enabled file, in order to
> give discretion of choosing the target file and the timing of
> compression to the user.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/filesystems/f2fs.rst |  4 ++++
>  fs/f2fs/data.c                     | 10 +++++-----
>  fs/f2fs/f2fs.h                     |  8 ++++++++
>  fs/f2fs/segment.c                  |  2 +-
>  fs/f2fs/super.c                    |  9 +++++++++
>  5 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index b8ee761c9922..c36ca1e0f7ab 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -260,6 +260,10 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
>  			 For other files, we can still enable compression via ioctl.
>  			 Note that, there is one reserved special extension '*', it
>  			 can be set to enable compression for all files.
> +disable_auto_compr       Even if compression feature is enabled, this option can
> +                         disable automaic compression on the compression enabled
> +                         file to give discretion of choosing the target file and
> +                         the timing of compression to the user.

I don't understand.  How is this different from just not specifying the
compress_extension mount option?  And how can a file have compression both
enabled and disabled at the same time?

- Eric
