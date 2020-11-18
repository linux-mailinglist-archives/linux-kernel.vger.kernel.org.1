Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6F2B7837
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgKRIKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:10:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:38376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgKRIKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:10:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1053ABDE;
        Wed, 18 Nov 2020 08:10:13 +0000 (UTC)
Subject: Re: [PATCH] drm: imx: Move fbdev setup to before output polling
To:     Mark Jonas <mark.jonas@de.bosch.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Leo Ruan <tingquan.ruan@cn.bosch.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20201117155229.9837-1-mark.jonas@de.bosch.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <e089d4d5-3bd8-c2cd-3011-ed87ae4284e8@suse.de>
Date:   Wed, 18 Nov 2020 09:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117155229.9837-1-mark.jonas@de.bosch.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 17.11.20 um 16:52 schrieb Mark Jonas:
> From: Leo Ruan <tingquan.ruan@cn.bosch.com>
> 
> The generic fbdev has to be setup before enabling output polling.
> Otherwise the fbdev client is not ready to handle delayed events.
> 
> Since f53705fd, the generic fbdev is setup after the output polling
> init. During fbdev setup, when fbdev probes attached outputs and a
> status changes from unknown to connected, the delayed event is
> marked and the output_poll_work thread is scheduled without delay.
> If output_poll_execute() is runs immediately, the delayed event
> is handled without actually polling the output because the fbdev is not
> registered yet. So the delayed event is lost. This leads to a dark
> screen until a KMS application (or fbcon) sets the screen mode.
> 
> This patch fixes the issue by moving the setup of generic fbdev before
> initializing and enabling output polling.
> 
> Signed-off-by: Leo Ruan <tingquan.ruan@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>  drivers/gpu/drm/imx/imx-drm-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index 9bf5ad6d18a2..2665040e11c7 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -240,14 +240,18 @@ static int imx_drm_bind(struct device *dev)
>  		legacyfb_depth = 16;
>  	}
>  
> +	/*
> +	 * The generic fbdev has to be setup before enabling output polling.
> +	 * Otherwise the fbdev client is not ready to handle delayed events.
> +	 */
> +	drm_fbdev_generic_setup(drm, legacyfb_depth);
> +
>  	drm_kms_helper_poll_init(drm);
>  
>  	ret = drm_dev_register(drm, 0);
>  	if (ret)
>  		goto err_poll_fini;
>  
> -	drm_fbdev_generic_setup(drm, legacyfb_depth);
> -

This does not work well. fbdev is supposed to be another regular DRM
client. It has to be enabled after registering the DRM device.

I'd rather improve fbdev or the driver to handle this gracefully.

Best regards
Thomas

>  	return 0;
>  
>  err_poll_fini:
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
