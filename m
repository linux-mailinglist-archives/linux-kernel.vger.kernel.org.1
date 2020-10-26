Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8184299077
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783072AbgJZPFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:05:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60867 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1783063AbgJZPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:05:39 -0400
Received: (qmail 1193324 invoked by uid 1000); 26 Oct 2020 11:05:38 -0400
Date:   Mon, 26 Oct 2020 11:05:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-tegra: Fix error handling in
 tegra_ehci_probe()
Message-ID: <20201026150538.GA1192191@rowland.harvard.edu>
References: <20201026090657.49988-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026090657.49988-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:06:57PM +0800, Tang Bin wrote:
> If the function platform_get_irq() failed, the negative value
> returned will not be detected here. So fix error handling in
> tegra_ehci_probe().
> 
> Fixes: 79ad3b5add4a ("usb: host: Add EHCI driver for NVIDIA Tegra SoCs")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/host/ehci-tegra.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index 75a075daf..7b0efaf15 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -479,9 +479,9 @@ static int tegra_ehci_probe(struct platform_device *pdev)
>  	u_phy->otg->host = hcd_to_bus(hcd);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (!irq) {
> -		err = -ENODEV;
> -		goto cleanup_phy;
> +	if (irq < 0) {
> +		err = irq;
> +		goto cleanup_phy;
>  	}
>  
>  	otg_set_host(u_phy->otg, &hcd->self);

Acked-by: Alan Stern <stern@rowland.harvard.edu>

The "if (!irq)" statement occurs at least one other driver in this 
directory.  Would you like to submit a patch for ehci-xilinx-of.c as 
well?

Alan Stern
