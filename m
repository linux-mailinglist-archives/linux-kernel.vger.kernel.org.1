Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5C1C76BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgEFQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:42:20 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59634 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgEFQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:42:19 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7259A80500;
        Wed,  6 May 2020 18:42:16 +0200 (CEST)
Date:   Wed, 6 May 2020 18:42:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 3/6] drm/tegra: output: Don't leak OF node on error
Message-ID: <20200506164215.GC19296@ravnborg.org>
References: <20200418170703.1583-1-digetx@gmail.com>
 <20200418170703.1583-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418170703.1583-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8
        a=e5mUnYsNAAAA:8 a=K8HgHsMCaQdvhFoLfFEA:9 a=CjuIK1q_8ugA:10
        a=D0XLA9XvdZm18NrgonBM:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 08:07:00PM +0300, Dmitry Osipenko wrote:
> The OF node should be put before returning error in tegra_output_probe(),
> otherwise node's refcount will be leaked.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/tegra/output.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
> index e36e5e7c2f69..a6a711d54e88 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -102,10 +102,10 @@ int tegra_output_probe(struct tegra_output *output)
>  	panel = of_parse_phandle(output->of_node, "nvidia,panel", 0);
>  	if (panel) {
>  		output->panel = of_drm_find_panel(panel);
> +		of_node_put(panel);
> +
>  		if (IS_ERR(output->panel))
>  			return PTR_ERR(output->panel);
> -
> -		of_node_put(panel);
>  	}
>  
>  	output->edid = of_get_property(output->of_node, "nvidia,edid", &size);
> @@ -113,13 +113,12 @@ int tegra_output_probe(struct tegra_output *output)
>  	ddc = of_parse_phandle(output->of_node, "nvidia,ddc-i2c-bus", 0);
>  	if (ddc) {
>  		output->ddc = of_find_i2c_adapter_by_node(ddc);
> +		of_node_put(ddc);
> +
>  		if (!output->ddc) {
>  			err = -EPROBE_DEFER;
> -			of_node_put(ddc);
>  			return err;
>  		}
> -
> -		of_node_put(ddc);
>  	}
>  
>  	output->hpd_gpio = devm_gpiod_get_from_of_node(output->dev,
> -- 
> 2.26.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
