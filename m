Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0127A143
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgI0Npl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 09:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgI0Npl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 09:45:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F5120738;
        Sun, 27 Sep 2020 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601214340;
        bh=8M2wj3Z+sb6259NZn6nsVK/1uThSkA+tXtCNRa5H2Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXuqaR31JLLKBIpieZdr4Ii40RB9S2lGaUcdtLK/cft2hyFyz/3FEmKogI4gTG38I
         67dUgoxJElochFC2fZPUX04Qa8R7bGqIRDN6aXbqD20BI8QdYo9cqZIPUT6pixdzNa
         2HIlOHkIPXh9vWffOb2mt63qpkkkeUlxQ5iJmMsI=
Date:   Sun, 27 Sep 2020 15:45:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
Message-ID: <20200927134550.GA302849@kroah.com>
References: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 09:42:18PM +0800, Tang Bin wrote:
> In this function, we don't need dev_err() message because
> when something goes wrong, devm_platform_ioremap_resource()
> can print an error message itself, so remove the redundant
> one.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index 02a3a7746..9454f179e 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -508,10 +508,8 @@ static int bdc_probe(struct platform_device *pdev)
>  	bdc->clk = clk;
>  
>  	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(bdc->regs)) {
> -		dev_err(dev, "ioremap error\n");
> +	if (IS_ERR(bdc->regs))
>  		return -ENOMEM;

Why not return the error given to us?

thanks,

greg k-h
