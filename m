Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE411CA573
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 03:52:25 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48958 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgEHHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:52:24 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7451980503;
        Fri,  8 May 2020 09:52:17 +0200 (CEST)
Date:   Fri, 8 May 2020 09:52:10 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bernard <bernard@vivo.com>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] drm/exynos: remove no need devm_kfree in probe [re-send,
 welcome any comments]
Message-ID: <20200508075210.GA8789@ravnborg.org>
References: <AMkACAAICCLCcgaekrYcyKoA.1.1588769343436.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AMkACAAICCLCcgaekrYcyKoA.1.1588769343436.Hmail.bernard@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=1WtWmnkvAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=BHcMzYUn60HY1PDIBp0A:9 a=CjuIK1q_8ugA:10 a=-_UHfarfsM-RsASml2Jt:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard.

On Wed, May 06, 2020 at 08:49:03PM +0800, Bernard wrote:
> Remove no need devm_kfree in probe.
> The change is to make the code a bit more readable
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Could you take a closer look and fix similar patterns
in the rest of the driver?
For example in exynos_dpi_probe()

Is would be nice to only have to review for this
type of changes once, so one patch-set is preferred
over single patches over time.

You can add:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

to this patch when you re-send a new series.

Thanks,
	Sam

> ---
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> index 43fa0f26c052..e06f7d7a6695 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> @@ -181,10 +181,8 @@ static int exynos_dpi_parse_dt(struct exynos_dpi *ctx)
>  			return -ENOMEM;
>  
>  		ret = of_get_videomode(dn, vm, 0);
> -		if (ret < 0) {
> -			devm_kfree(dev, vm);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
>  		ctx->vm = vm;
>  
> @@ -233,10 +231,8 @@ struct drm_encoder *exynos_dpi_probe(struct device *dev)
>  	ctx->dev = dev;
>  
>  	ret = exynos_dpi_parse_dt(ctx);
> -	if (ret < 0) {
> -		devm_kfree(dev, ctx);
> -		return NULL;
> -	}
> +	if (ret < 0)
> +		return ERR_PTR(ret);
>  
>  	if (ctx->panel_node) {
>  		ctx->panel = of_drm_find_panel(ctx->panel_node);
> -- 
> 2.26.2
> 
> 
> [re-send, welcome any comments]
> Regards,
> Bernard
> 
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
