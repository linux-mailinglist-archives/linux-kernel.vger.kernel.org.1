Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4261CB0F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEHNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 09:51:24 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55333 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726904AbgEHNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:51:23 -0400
Received: (qmail 20603 invoked by uid 500); 8 May 2020 09:51:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2020 09:51:22 -0400
Date:   Fri, 8 May 2020 09:51:22 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Tang Bin <tangbin@cmss.chinamobile.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] USB: host: ehci: Add error handling in ehci_mxc_drv_probe()
In-Reply-To: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
Message-ID: <Pine.LNX.4.44L0.2005080950180.19653-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020, Tang Bin wrote:

> The function ehci_mxc_drv_probe() does not perform sufficient error
> checking after executing platform_get_irq(), thus fix it.

Aside from the "irq <= 0" issue, the Subject: line should say 
"ehci-mxc", not "ehci".

Alan Stern

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
>  
>  	hcd = usb_create_hcd(&ehci_mxc_hc_driver, dev, dev_name(dev));
>  	if (!hcd)
> 

