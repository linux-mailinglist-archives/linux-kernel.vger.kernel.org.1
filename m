Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51862D571A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgLJJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgLJJ1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:27:39 -0500
Date:   Thu, 10 Dec 2020 10:28:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607592418;
        bh=+bm4nSxz3uw7A+wBxE5e9SXlmjGSJ/oe2vmGKGeAAEI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4DGBQuO/JPxvu0h5+FGlDWGI7zQnKw0nj47sUHM03bEup9UYODQF72kCKZ7bD3X3
         Dh1sxixAu71uuEaYgLVgBwXcYRKSayp3be6lGFQCav1Xgl8i0bndcV2Znbq7ToJ2sS
         lE856qsBfwCJpZCO2Bc5Z6Gnh9E98fPew6R64ARQ=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chris Bloomfield <ginge264@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: ralink-gdma: ralink-gdma: Fix a blank line
 coding style issue
Message-ID: <X9HqLFwjHSPXqRgZ@kroah.com>
References: <20201210100657.22562-1-ginge264@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210100657.22562-1-ginge264@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 10:06:57AM +0000, Chris Bloomfield wrote:
> Fix a coding style issue as identified by checkpatch.pl
> 
> Signed-off-by: Chris Bloomfield <ginge264@gmail.com>
> ---
>  drivers/staging/ralink-gdma/ralink-gdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
> index 655df317d0ee..a6181a167814 100644
> --- a/drivers/staging/ralink-gdma/ralink-gdma.c
> +++ b/drivers/staging/ralink-gdma/ralink-gdma.c
> @@ -122,6 +122,7 @@ struct gdma_dma_dev {
>  	struct gdma_data *data;
>  	void __iomem *base;
>  	struct tasklet_struct task;
> +
>  	volatile unsigned long chan_issued;
>  	atomic_t cnt;
>  

With your knowledge of C, do you think the above change looks correct?

thanks,

greg k-h
