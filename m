Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9391B2D54F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbgLJH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 02:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgLJH6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:58:38 -0500
Date:   Thu, 10 Dec 2020 08:57:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607587077;
        bh=l7FddddRY9V0TSIoGNnex9GDRQXNMvihk6mFVOYILH0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=w/Xx7GIVONCXXu0YeKLApd8VQAwRJu7LugJsd87hwboCmD7DgUHnKEAtvA1n3N/3l
         Q/G+Y/FpvqkFabtesYWDP3R7XuVV+3ePg8+4P8XwNZiUsk2lHV8/NzVVzk3duZRnDc
         rEaEaT8OwDlk+EHj6ze/HDpCjYGV+aobxHwCP290=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Triplehx3 <ginge264@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: ralink-gdma: ralink-gdma: Fix a blank line
 coding style issue
Message-ID: <X9HVAUdq0cEC63BP@kroah.com>
References: <20201210013228.9371-1-ginge264@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210013228.9371-1-ginge264@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:32:28AM +0000, Triplehx3 wrote:
> Fix a coding style issue as identified by checkpatch.pl
> 
> Signed-off-by: Triplehx3 <ginge264@gmail.com>
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


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
