Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E661A0E89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgDGNlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 09:41:51 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37937 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgDGNlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:41:50 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C9B56200010;
        Tue,  7 Apr 2020 13:41:47 +0000 (UTC)
Date:   Tue, 7 Apr 2020 15:41:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     cristian.birsan@microchip.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ludovic.desroches@microchip.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 2/7] usb: gadget: udc: atmel: add compatible for
 SAM9X60's PMC
Message-ID: <20200407134147.GI3628@piout.net>
References: <20200407122852.19422-1-cristian.birsan@microchip.com>
 <20200407122852.19422-3-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407122852.19422-3-cristian.birsan@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/04/2020 15:28:47+0300, cristian.birsan@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add compatible for SAM9X60's PMC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [cristian.birsan@microchip.com Add sentinel at the end of the array]
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 32e5b44d9fbd..c50902b91a96 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2056,6 +2056,8 @@ static const struct of_device_id atmel_pmc_dt_ids[] = {
>  	{ .compatible = "atmel,at91sam9g45-pmc" },
>  	{ .compatible = "atmel,at91sam9rl-pmc" },
>  	{ .compatible = "atmel,at91sam9x5-pmc" },
> +	{ .compatible = "microchip,sam9x60-pmc" },
> +	{ /* sentinel */ }

This patch can be squashed in the previous one.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
