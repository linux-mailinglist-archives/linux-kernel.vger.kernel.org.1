Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6048B2A365D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKBWUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:20:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32204C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 14:20:07 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A4CA583;
        Mon,  2 Nov 2020 23:20:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1604355605;
        bh=fTY55DHx6zAJQyTjZInJxof34DI3DmbATb+EmXI8rgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iR4l77BBx5bYi9Lw/uWhIPymMZVyuy3F/MzDsTmPa9Xok1VN3PsFmEBcG0PsrOk1a
         67RFNH2p/Lq3ZaY+MzPqWrFMzPy5RbI+wRHS90N3RM5eI0ZKudhlMc7PP3fYKiIwgj
         ZDoIvlG5UVjyjGzZxoEPzWQWK6EROi0l90xUZms8=
Date:   Tue, 3 Nov 2020 00:19:17 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        tomi.valkeinen@ti.com, sebastian.reichel@collabora.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: tpd12s015: Fix irq registering in
 tpd12s015_probe
Message-ID: <20201102221917.GJ3971@pendragon.ideasonboard.com>
References: <20201031031648.42368-1-yuehaibing@huawei.com>
 <20201102143024.26216-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102143024.26216-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Thank you for the patch.

On Mon, Nov 02, 2020 at 10:30:24PM +0800, YueHaibing wrote:
> gpiod_to_irq() return negative value in case of error,
> the existing code doesn't handle negative error codes.
> If the HPD gpio supports IRQs (gpiod_to_irq returns a
> valid number), we use the IRQ. If it doesn't (gpiod_to_irq
> returns an error), it gets polled via detect(). 
> 
> Fixes: cff5e6f7e83f ("drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2: Add checking for >= 0 and update commit message
> ---
>  drivers/gpu/drm/bridge/ti-tpd12s015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
> index 514cbf0eac75..e0e015243a60 100644
> --- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
> +++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
> @@ -160,7 +160,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
>  
>  	/* Register the IRQ if the HPD GPIO is IRQ-capable. */
>  	tpd->hpd_irq = gpiod_to_irq(tpd->hpd_gpio);
> -	if (tpd->hpd_irq) {
> +	if (tpd->hpd_irq >= 0) {
>  		ret = devm_request_threaded_irq(&pdev->dev, tpd->hpd_irq, NULL,
>  						tpd12s015_hpd_isr,
>  						IRQF_TRIGGER_RISING |

-- 
Regards,

Laurent Pinchart
