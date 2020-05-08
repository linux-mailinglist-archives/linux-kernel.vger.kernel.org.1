Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6541CA9F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEHLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 07:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgEHLtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:49:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF2D206D5;
        Fri,  8 May 2020 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588938541;
        bh=3XIhhm1Au/xGkfcAr3Z9Yi2x3ynKKFKgs0eZV/NQRgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvsvQSGYKzYmyT1GogXbnmyne0OVwyEJLMmFQZoxw8cqsVmaiMwZ18Fv/ZovqttVX
         j0NvV2MUYhdZ+6GNLpdvDNoKHYFINt4Va8mIkvXzdL8ayp5zLkcKcIuMWyXMDDgKCS
         EnLtw9BgnueLU3C+JSD/ZF9KHLqAdNlAOOMgvLuo=
Date:   Fri, 8 May 2020 13:48:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] USB: host: ehci: Add error handling in
 ehci_mxc_drv_probe()
Message-ID: <20200508114858.GA4085349@kroah.com>
References: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:44:53PM +0800, Tang Bin wrote:
> The function ehci_mxc_drv_probe() does not perform sufficient error
> checking after executing platform_get_irq(), thus fix it.
> 
> Fixes: 7e8d5cd93fa ("USB: Add EHCI support for MX27 and MX31 based boards")
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/host/ehci-mxc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index a1eb5ee77..a0b42ba59 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -50,6 +50,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;

<= ?
