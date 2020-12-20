Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F92DF669
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgLTSIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgLTSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:08:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F49C061285
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:07:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6812831A;
        Sun, 20 Dec 2020 19:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608487633;
        bh=ESmu1mf1+w7dS5R6u7cgTeN7XbB4mMnlHWe0WVNNlQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQL+4bEiu1pivhSbVx9T6uOsJAde4JaEOFJNiTFNa3ME5Ig8CUsPxL0MbewOp5stS
         mVyUv6ncdHaj35qqJsNgt3Mmzw4Xsri1AlR05KZXFbN0tFbb91DImaV8GoHbbeBFLj
         R1BFXs1Povt/kmFwwpkcAomZZSp9T1tNFmodGYTI=
Date:   Sun, 20 Dec 2020 20:07:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, bogdan.togorean@analog.com,
        laurentiu.palcu@nxp.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: adv7511: Remove redundant null check before
 clk_disable_unprepare
Message-ID: <X9+SyT5fHfAlzKG9@pendragon.ideasonboard.com>
References: <20201127091829.50695-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127091829.50695-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xu Wang,

Thank you for the patch.

On Fri, Nov 27, 2020 at 09:18:29AM +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index a0d392c338da..76555ae64e9c 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1292,8 +1292,7 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  
>  err_unregister_cec:
>  	i2c_unregister_device(adv7511->i2c_cec);
> -	if (adv7511->cec_clk)
> -		clk_disable_unprepare(adv7511->cec_clk);
> +	clk_disable_unprepare(adv7511->cec_clk);
>  err_i2c_unregister_packet:
>  	i2c_unregister_device(adv7511->i2c_packet);
>  err_i2c_unregister_edid:
> @@ -1311,8 +1310,7 @@ static int adv7511_remove(struct i2c_client *i2c)
>  	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		adv7533_detach_dsi(adv7511);
>  	i2c_unregister_device(adv7511->i2c_cec);
> -	if (adv7511->cec_clk)
> -		clk_disable_unprepare(adv7511->cec_clk);
> +	clk_disable_unprepare(adv7511->cec_clk);
>  
>  	adv7511_uninit_regulators(adv7511);
>  

-- 
Regards,

Laurent Pinchart
