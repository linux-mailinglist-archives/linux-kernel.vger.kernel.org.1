Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB52F6888
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbhANR51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:57:27 -0500
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:60208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbhANR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:57:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4A746837F24D;
        Thu, 14 Jan 2021 17:56:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4321:5007:7652:7807:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12895:13069:13255:13311:13357:13439:13894:14659:14721:21080:21627:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: vein42_380c97427528
X-Filterd-Recvd-Size: 2342
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Jan 2021 17:56:43 +0000 (UTC)
Message-ID: <d9ebc10ac5c4ba5231ed50ef0d2a15f424547736.camel@perches.com>
Subject: Re: [PATCH v2 3/4] staging: hikey9xx: phy-hi3670-usb3.c:
 hi3670_is_abbclk_seleted() returns bool
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Jan 2021 09:56:41 -0800
In-Reply-To: <d1e0d94381e214157545d6808835fdfe99448f76.1610645385.git.mchehab+huawei@kernel.org>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
         <d1e0d94381e214157545d6808835fdfe99448f76.1610645385.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-14 at 18:35 +0100, Mauro Carvalho Chehab wrote:
> Instead of using 1/0 for true/false, change the type to boolean
> and change the returned value.
[]
> diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
[]
> @@ -326,24 +326,24 @@ static int hi3670_phy_set_params(struct hi3670_priv *priv)
>  	return ret;
>  }
> 
> -static int hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
> +static bool hi3670_is_abbclk_seleted(struct hi3670_priv *priv)

Presumably this should be "selected" not "seleted"

>  {
>  	u32 reg;
> 
>  	if (!priv->sctrl) {
>  		dev_err(priv->dev, "priv->sctrl is null!\n");
> -		return 1;
> +		return true;
>  	}
> 
>  	if (regmap_read(priv->sctrl, SCTRL_SCDEEPSLEEPED, &reg)) {
>  		dev_err(priv->dev, "SCTRL_SCDEEPSLEEPED read failed!\n");
> -		return 1;
> +		return true;
>  	}
> 
>  	if ((reg & USB_CLK_SELECTED) == 0)
> -		return 1;
> +		return true;
> 
> -	return 0;
> +	return false;
>  }

	if (foo)
		return true;
	return false;

should generally be consolidated into a single test.

So this is perhaps better as:

	return (!(reg & USB_CLK_SELECTED));

But the return value seems backwards.


