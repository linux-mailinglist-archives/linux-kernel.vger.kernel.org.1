Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0672C4262
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgKYOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:48:29 -0500
Received: from mx-relay80-hz1.antispameurope.com ([94.100.133.250]:39268 "EHLO
        mx-relay80-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729817AbgKYOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:48:28 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2020 09:48:28 EST
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay80-hz1.antispameurope.com;
 Wed, 25 Nov 2020 15:43:05 +0100
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1b) by
 EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 25 Nov 2020 15:42:58 +0100
Date:   Wed, 25 Nov 2020 15:42:57 +0100
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] siox: Make remove callback return void
Message-ID: <20201125144257.ck5hndrqczvdb6se@ws067.eckelmann.group>
References: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
 <20201125093106.240643-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125093106.240643-3-u.kleine-koenig@pengutronix.de>
X-Originating-IP: [2a00:1f08:4007:e035:172:18:35:1b]
X-ClientProxiedBy: EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61)
 To EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61)
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay80-hz1.antispameurope.com with 50D4C10E58DE
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security: scantime:.5533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=hse1; bh=
        jSCBTisSbgyVlN2ckNYq07hYs8qkcA3hyWElz2yILrA=; b=cZzbKtmFbzyfnbk6
        xrw5STuV0V7buSOmsgn9e5tg8almC6SVM7lBUQh0ewPrH5n1/ZcPo2x0G/LDuwXv
        zVrIPnYxH/Z7teJdEnw8QkLCu/HB8suWQXZOYIJX+67a+SRaUYfHv80ieW8Q7vzC
        07/+XplFej7TVsTzx/ELxtc7NDSKkIsROjfm43AHJlstq4/b9b2YlSLiY7Lhuwle
        TNUGv2jIFXznkx++XHo5tI2B15FurxVkqRkT97YnTfIgfivHZVPm+AjpyKw/YOeI
        y38Z2rPSxyMXy0WXjC/YhLDI4DLcXe6yT1XAtdhiaC+K0nVC6jfNiLrrLpY45Q7k
        FaVmJQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 25, 2020 at 10:31:06AM +0100, Uwe Kleine-König wrote:
> The driver core ignores the return value of the remove callback, so
> don't give siox drivers the chance to provide a value.
> 
> All siox drivers only allocate devm-managed resources in
> .probe, so there is no .remove callback to fix.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

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
>  static void siox_shutdown(struct device *dev)
> diff --git a/include/linux/siox.h b/include/linux/siox.h
> index da7225bf1877..6bfbda3f634c 100644
> --- a/include/linux/siox.h
> +++ b/include/linux/siox.h
> @@ -36,7 +36,7 @@ bool siox_device_connected(struct siox_device *sdevice);
>  
>  struct siox_driver {
>  	int (*probe)(struct siox_device *sdevice);
> -	int (*remove)(struct siox_device *sdevice);
> +	void (*remove)(struct siox_device *sdevice);
>  	void (*shutdown)(struct siox_device *sdevice);
>  
>  	/*
> -- 
> 2.29.2
> 

Kind regards
Thorsten

--
Thorsten Scherer | Eckelmann AG | www.eckelmann.de |
