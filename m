Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A96277A31
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIXU3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:29:39 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:54932 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIXU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:29:39 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 388BE2007E;
        Thu, 24 Sep 2020 22:29:36 +0200 (CEST)
Date:   Thu, 24 Sep 2020 22:29:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/ingenic: Add support for reserved memory
Message-ID: <20200924202934.GK1223313@ravnborg.org>
References: <20200915123818.13272-1-paul@crapouillou.net>
 <20200915123818.13272-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915123818.13272-4-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=Uiir0mAzoKyVEoIzVM8A:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 02:38:18PM +0200, Paul Cercueil wrote:
> Add support for static memory reserved from Device Tree. Since we're
> using GEM buffers backed by CMA, it is interesting to have an option to
> specify the CMA area where the GEM buffers will be allocated.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index aa32660033d2..44b0d029095e 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> @@ -827,6 +828,11 @@ static void ingenic_drm_unbind_all(void *d)
>  	component_unbind_all(priv->dev, &priv->drm);
>  }
>  
> +static void __maybe_unused ingenic_drm_release_rmem(void *d)
> +{
> +	of_reserved_mem_device_release(d);
> +}
> +
>  static int ingenic_drm_bind(struct device *dev, bool has_components)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -848,6 +854,19 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
>  		return -EINVAL;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
> +		ret = of_reserved_mem_device_init(dev);
> +
> +		if (ret && ret != -ENODEV)
> +			return dev_err_probe(dev, ret, "Failed to get reserved memory\n");
> +
> +		if (ret != -ENODEV) {
> +			ret = devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	priv = devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
>  				  struct ingenic_drm, drm);
>  	if (IS_ERR(priv))
> -- 
> 2.28.0
