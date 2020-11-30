Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BD2C909D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgK3WHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:07:20 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:57316 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730359AbgK3WHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:07:19 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 602EA215CF4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:06:37 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id jrJckFjPAi1lMjrJdkDuzk; Mon, 30 Nov 2020 15:06:37 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=VoRTO6+n c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10
 a=evQFzbml-YQA:10 a=ZTmiYS-oAAAA:8 a=_jlGtV7tAAAA:8 a=3-eR0ndxMxsxrohF3LYA:9
 a=CjuIK1q_8ugA:10 a=Bgfdu2smNuKfk3vLOmSO:22 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fXgYo2KBbqtF7aq6Tt/ZP/pEbhkUhWEn4EmEkIRylPQ=; b=YHXDlkcqfV8QDuAbh9+YWyjhIG
        CpbyJcX7DX9/hf88wya014GPcyjg9ZzMHXa4xw2pN+0deJ5l7RneQ3GGnkHwFFWrR8FAEQYXRwyAb
        w+iWB31GU/sM60eoGibNSVSfZmLYudP4yxbFj8WdIwrp5wKTyzuGA0y7mWKpw1p2e8L6DchOZ5NoN
        onEXn3OrBcPbjOu3Fxyj4elqD1NPdMQgdYsQj+3Yk7AZH0o/y72mPalQ1+1m72AOFmuMk4eLJYxSX
        F8Gp653LAKrW4Bah+d/dZiSNdB/1oQBEuoZzJgTVDe4LrSOeazQaLuX8gUflBdPcNxfjEsIWrkynE
        PuV7RVlg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56764 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kjrJc-001eJb-I0; Mon, 30 Nov 2020 22:06:36 +0000
Date:   Mon, 30 Nov 2020 14:06:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: iTCO_wdt: use module_platform_device()
 macro
Message-ID: <20201130220635.GA42747@roeck-us.net>
References: <20201117152214.32244-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117152214.32244-1-info@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kjrJc-001eJb-I0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:56764
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:22:12PM +0100, Enrico Weigelt, metux IT consult wrote:
> Reducing init boilerplate by using the module_platform_device macro.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/iTCO_wdt.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index a370a185a41c..f2ddc8fc71cd 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -651,21 +651,7 @@ static struct platform_driver iTCO_wdt_driver = {
>  	},
>  };
>  
> -static int __init iTCO_wdt_init_module(void)
> -{
> -	pr_info("Intel TCO WatchDog Timer Driver v%s\n", DRV_VERSION);
> -
> -	return platform_driver_register(&iTCO_wdt_driver);
> -}
> -
> -static void __exit iTCO_wdt_cleanup_module(void)
> -{
> -	platform_driver_unregister(&iTCO_wdt_driver);
> -	pr_info("Watchdog Module Unloaded\n");
> -}
> -
> -module_init(iTCO_wdt_init_module);
> -module_exit(iTCO_wdt_cleanup_module);
> +module_platform_driver(iTCO_wdt_driver);
>  
>  MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
>  MODULE_DESCRIPTION("Intel TCO WatchDog Timer Driver");
