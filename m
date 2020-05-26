Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDEB19C099
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 13:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbgDBL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 07:58:57 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40667 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgDBL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:58:55 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AE629C0007;
        Thu,  2 Apr 2020 11:58:51 +0000 (UTC)
Date:   Thu, 2 Apr 2020 13:58:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA:atmel:Use platform_get_irq_optional()
Message-ID: <20200402115851.GG3683@piout.net>
References: <20200402112135.18604-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402112135.18604-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2020 19:21:35+0800, Tang Bin wrote:
> In order to simply code,because platform_get_irq() already has
> dev_err() message.
> 

But what I see is a dev_dbg message so your patch actually changes the
behaviour when debugging is not enabled.

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/atmel/ac97c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
> index a1dce9725..25cfd5710 100644
> --- a/sound/atmel/ac97c.c
> +++ b/sound/atmel/ac97c.c
> @@ -715,7 +715,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	irq = platform_get_irq(pdev, 0);
> +	irq = platform_get_irq_optional(pdev, 0);
>  	if (irq < 0) {
>  		dev_dbg(&pdev->dev, "could not get irq: %d\n", irq);
>  		return irq;
> -- 
> 2.20.1.windows.1
> 
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
