Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1BC2E2548
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 08:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgLXHuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 02:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgLXHuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 02:50:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 993BF22571;
        Thu, 24 Dec 2020 07:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608796161;
        bh=bmL0tWs45xYqEhuiyx9z9sxX9bCxhXR7RT6XHGtYCk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6TVvqxXzPl2ow9EcTVNvPghEGp/SvoUNXMFdPddFNPpVMlDikKg7J0QzImGfs/VU
         zJ05HL9cZNf0ULZtWjLx9/FwRd3ajAneY4M//uvN84LdbIyO3RqHzr8jxgd4WWArvS
         CUlY209sX5o7Rh3/h32TGhOcP6mdF7jIaTxsfhGM=
Date:   Thu, 24 Dec 2020 08:49:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayoub Soussi <ayoubfme@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Fixed blank line coding style issue
Message-ID: <X+RH/VlugeGaAY8b@kroah.com>
References: <20201223202230.31325-1-ayoubfme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223202230.31325-1-ayoubfme@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 09:22:30PM +0100, Ayoub Soussi wrote:
> Fixed coding style issue.
> 
> Signed-off-by: Ayoub Soussi <ayoubfme@gmail.com>
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

With your knowledge of C, does this change look correct?

thanks,

greg k-h
