Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F622C90AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgK3WJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:09:30 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:39185 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730465AbgK3WJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:09:29 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id E90721AB0C4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:08:48 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id jrLkkhgt3dCH5jrLkkm6PT; Mon, 30 Nov 2020 15:08:48 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=cYj8UELM c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=ZTmiYS-oAAAA:8
 a=_jlGtV7tAAAA:8 a=vMNCTu6vAAAA:8 a=U0xo_0js9GdCvtQum8kA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=Bgfdu2smNuKfk3vLOmSO:22
 a=nlm17XC03S6CtCLSeiRr:22 a=43t_X0ebxCaElrQIzA55:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f2s/1JVHZExFP08pFlV3R/BaHZ8rkqrvALcAOh9RWP8=; b=lo0JxoWvtdi5kt8qNP67GAKEH4
        xjnPwSYCCx53LFuRGXBlQMiIQth8ePOCfd8xLXppsXoaMluERumZbscKr2tePl3UKtunYQqY7vTnS
        QUhQIUMOCMEMh2gn60rTZOzPR7qP7SxjNyOmedjOoChvU4CJnUETlpR1hZmTdOFjXHVcfpCjIN9LL
        hj2HYEa366+4j5zmU56IiMtK5yS9faWOV60/QuTuh3QITeDJeI/VYdXeeSAU0smVYvJwBR6d//WbN
        SkYYOFDavgHS8MYUjcwvmkcjPnEjVjSL0hFowZq99M2dPwG+acQdtfyQVA+TazzW0oCnHph9BhFO6
        Yw12Tlrg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56788 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kjrLk-001ey8-2a; Mon, 30 Nov 2020 22:08:48 +0000
Date:   Mon, 30 Nov 2020 14:08:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: iTCO_wdt: use dev_*() instead of pr_*()
 for logging
Message-ID: <20201130220847.GA42939@roeck-us.net>
References: <20201117152214.32244-1-info@metux.net>
 <20201117152214.32244-2-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117152214.32244-2-info@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kjrLk-001ey8-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:56788
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 16
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:22:13PM +0100, Enrico Weigelt, metux IT consult wrote:
> For device log outputs, it's better to have device name / ID
> prefixed in all messages, so use the proper dev_*() functions here.
> 
> Explicit message on module load/unload don't seem to be really helpful
> (we have other means to check which modules have been loaded), instead
> just add noise to the kernel log. So, removing them.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/iTCO_wdt.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index f2ddc8fc71cd..edc588a06ae6 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -40,8 +40,6 @@
>   *	Includes, defines, variables, module parameters, ...
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  /* Module and version information */
>  #define DRV_NAME	"iTCO_wdt"
>  #define DRV_VERSION	"1.11"
> @@ -279,7 +277,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  	/* disable chipset's NO_REBOOT bit */
>  	if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
>  		spin_unlock(&p->io_lock);
> -		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
> +		dev_err(wd_dev->dev, "failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
>  		return -EIO;
>  	}
>  
> @@ -510,7 +508,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	/* Check chipset's NO_REBOOT bit */
>  	if (p->update_no_reboot_bit(p->no_reboot_priv, false) &&
>  	    iTCO_vendor_check_noreboot_on()) {
> -		pr_info("unable to reset NO_REBOOT flag, device disabled by hardware/BIOS\n");
> +		dev_info(dev, "unable to reset NO_REBOOT flag, device disabled by hardware/BIOS\n");
>  		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
>  	}
>  
> @@ -530,12 +528,12 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	if (!devm_request_region(dev, p->tco_res->start,
>  				 resource_size(p->tco_res),
>  				 pdev->name)) {
> -		pr_err("I/O address 0x%04llx already in use, device disabled\n",
> +		dev_err(dev, "I/O address 0x%04llx already in use, device disabled\n",
>  		       (u64)TCOBASE(p));
>  		return -EBUSY;
>  	}
>  
> -	pr_info("Found a %s TCO device (Version=%d, TCOBASE=0x%04llx)\n",
> +	dev_info(dev, "Found a %s TCO device (Version=%d, TCOBASE=0x%04llx)\n",
>  		pdata->name, pdata->version, (u64)TCOBASE(p));
>  
>  	/* Clear out the (probably old) status */
> @@ -558,7 +556,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> -	p->wddev.info =	&ident,
> +	p->wddev.info = &ident,
>  	p->wddev.ops = &iTCO_wdt_ops,
>  	p->wddev.bootstatus = 0;
>  	p->wddev.timeout = WATCHDOG_TIMEOUT;
> @@ -575,7 +573,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	   if not reset to the default */
>  	if (iTCO_wdt_set_timeout(&p->wddev, heartbeat)) {
>  		iTCO_wdt_set_timeout(&p->wddev, WATCHDOG_TIMEOUT);
> -		pr_info("timeout value out of range, using %d\n",
> +		dev_info(dev, "timeout value out of range, using %d\n",
>  			WATCHDOG_TIMEOUT);
>  	}
>  
> @@ -583,11 +581,11 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	watchdog_stop_on_unregister(&p->wddev);
>  	ret = devm_watchdog_register_device(dev, &p->wddev);
>  	if (ret != 0) {
> -		pr_err("cannot register watchdog device (err=%d)\n", ret);
> +		dev_err(dev, "cannot register watchdog device (err=%d)\n", ret);
>  		return ret;
>  	}
>  
> -	pr_info("initialized. heartbeat=%d sec (nowayout=%d)\n",
> +	dev_info(dev, "initialized. heartbeat=%d sec (nowayout=%d)\n",
>  		heartbeat, nowayout);
>  
>  	return 0;
