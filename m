Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A301FED89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgFRIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 04:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgFRIW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:22:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3152166E;
        Thu, 18 Jun 2020 08:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592468548;
        bh=VpzKjvvcq9cKpAHfRmxLguugzRbLfQsNRX/iv+XnJ4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwtLE0nJ45+bYIrXs2BzXtjtwDd5cYm/VGXw0562eUuFmKhCD7B1bwTIgDxuX2YKB
         2Anc8hKMP0BnfJFwYtNDQpWNZF0X7FxZgQHkhudsAFb/+sMw0PXKLEf+sdMSac4aFt
         tR5nyyCNj3GR5gsLWAvuoW7D7Y3ujsawon8cdhgQ=
Date:   Thu, 18 Jun 2020 10:22:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: use well defined macros for power_down
Message-ID: <20200618082220.GA1050230@kroah.com>
References: <20200616162617.38365cc8@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616162617.38365cc8@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 04:26:17PM +0800, Jisheng Zhang wrote:
> Use the well defined macros such as DWC2_POWER_DOWN_PARAM_NONE,
> DWC2_POWER_DOWN_PARAM_PARTIAL and DWC2_POWER_DOWN_PARAM_HIBERNATION
> to make code more readable.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Acked-by: Minas Harutyunyan <hminas@synopsys.com>
> ---
>  drivers/usb/dwc2/hcd.c    |  4 ++--
>  drivers/usb/dwc2/params.c | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index b90f858af960..e9ac215b9663 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -3628,7 +3628,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
>  				"SetPortFeature - USB_PORT_FEAT_SUSPEND\n");
>  			if (windex != hsotg->otg_port)
>  				goto error;
> -			if (hsotg->params.power_down == 2)
> +			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_HIBERNATION)
>  				dwc2_enter_hibernation(hsotg, 1);
>  			else
>  				dwc2_port_suspend(hsotg, windex);
> @@ -3646,7 +3646,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
>  			break;
>  
>  		case USB_PORT_FEAT_RESET:
> -			if (hsotg->params.power_down == 2 &&
> +			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_HIBERNATION &&
>  			    hsotg->hibernated)
>  				dwc2_exit_hibernation(hsotg, 0, 1, 1);
>  			hprt0 = dwc2_read_hprt0(hsotg);
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index ce736d67c7c3..8f9d061c4d5f 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -68,14 +68,14 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
>  	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 <<
>  		GAHBCFG_HBSTLEN_SHIFT;
>  	p->change_speed_quirk = true;
> -	p->power_down = false;
> +	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
>  }
>  
>  static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
>  {
>  	struct dwc2_core_params *p = &hsotg->params;
>  
> -	p->power_down = 0;
> +	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
>  	p->phy_utmi_width = 8;
>  }
>  
> @@ -89,7 +89,7 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
>  	p->host_perio_tx_fifo_size = 256;
>  	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 <<
>  		GAHBCFG_HBSTLEN_SHIFT;
> -	p->power_down = 0;
> +	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
>  }
>  
>  static void dwc2_set_ltq_params(struct dwc2_hsotg *hsotg)
> @@ -319,11 +319,11 @@ static void dwc2_set_param_power_down(struct dwc2_hsotg *hsotg)
>  	int val;
>  
>  	if (hsotg->hw_params.hibernation)
> -		val = 2;
> +		val = DWC2_POWER_DOWN_PARAM_HIBERNATION;
>  	else if (hsotg->hw_params.power_optimized)
> -		val = 1;
> +		val = DWC2_POWER_DOWN_PARAM_PARTIAL;
>  	else
> -		val = 0;
> +		val = DWC2_POWER_DOWN_PARAM_NONE;
>  
>  	hsotg->params.power_down = val;
>  }
> -- 
> 2.27.0
> 

This does not apply to Linus's tree :(
