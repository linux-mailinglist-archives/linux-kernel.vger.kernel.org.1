Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078892C324B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgKXVEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:04:11 -0500
Received: from mx-relay17-hz1.antispameurope.com ([94.100.132.217]:43615 "EHLO
        mx-relay17-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbgKXVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:04:09 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 16:04:08 EST
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay17-hz1.antispameurope.com;
 Tue, 24 Nov 2020 21:58:50 +0100
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1b) by
 EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 24 Nov 2020 21:58:47 +0100
Date:   Tue, 24 Nov 2020 21:58:45 +0100
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] siox: Make remove callback return void
Message-ID: <20201124205845.jma7lay5tux6wiav@ws067.eckelmann.group>
References: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
 <20201124141834.3096325-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124141834.3096325-3-u.kleine-koenig@pengutronix.de>
X-Originating-IP: [2a00:1f08:4007:e035:172:18:35:1b]
X-ClientProxiedBy: EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60)
 To EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61)
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay17-hz1.antispameurope.com with 75DAD1844F23
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security: scantime:.3002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=hse1; bh=
        M8GLMVkJvqxCzi92fFaRaFOYmB4+0wuwzPA71db+qjA=; b=sCGJ3wXT8Eyc9wZH
        AZOoCz4vlnaElGomiiN+9eko54C/UZxCDv6dpAgYdVTTiZSU/IstBI5Gbb/V+d4I
        xnPI/EyiIageFE5+WRDjNwQtx5AjApIyiunJcBdEouLS96nLzykPrpadV/dbJQ3r
        vPGCiu+maJYnnyA5wqGD0rVAO7x0zNW0qfucsufOtFIC8l5AQ98aYuIQj9p6gDud
        qqUmoSIN9Jm5V6M3devpZOOsRYYJfRva1Uvt0r/N9yMvkswvtkNSh5y/5LKkUaHx
        DwiYTUD8HvxExKHEUXETaIl1F7r+0mnKE0QzYxweV5GwnOP0u1xfmawBrMO98vJz
        Soikwg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 03:18:34PM +0100, Uwe Kleine-König wrote:
> The driver core ignores the return value of the remove callback, so
> don't give siox drivers the chance to provide a value.
> 
> All siox drivers only allocate devm-managed resources in
> .probe, so there is no .remove callback to fix.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/siox/siox-core.c | 5 ++---
>  include/linux/siox.h     | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> index b56cdcb52967..1794ff0106bc 100644
> --- a/drivers/siox/siox-core.c
> +++ b/drivers/siox/siox-core.c
> @@ -525,12 +525,11 @@ static int siox_remove(struct device *dev)

Shouldn't this return void?

>  	struct siox_driver *sdriver =
>  		container_of(dev->driver, struct siox_driver, driver);
>  	struct siox_device *sdevice = to_siox_device(dev);
> -	int ret = 0;
>  
>  	if (sdriver->remove)
> -		ret = sdriver->remove(sdevice);
> +		sdriver->remove(sdevice);
>  
> -	return ret;
> +	return 0;
>  }
>  

[...]

> -- 
> 2.29.2
> 

Kind regards
Thorsten

--
Thorsten Scherer | Eckelmann AG | www.eckelmann.de |
