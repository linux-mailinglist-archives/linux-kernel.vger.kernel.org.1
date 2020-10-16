Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFE290C14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409971AbgJPTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:04:54 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42286 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409944AbgJPTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:04:53 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 13BBD80623;
        Fri, 16 Oct 2020 21:04:49 +0200 (CEST)
Date:   Fri, 16 Oct 2020 21:04:47 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, daniel@ffwll.ch, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: remove redundant null check
Message-ID: <20201016190447.GB1345100@ravnborg.org>
References: <20200930081859.52431-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930081859.52431-1-vulab@iscas.ac.cn>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=hVaCtnEc0TjjHIDlNK8A:9
        a=1Kb86hCPPUzEXHOj:21 a=4AxGUG8XqSeI4mlC:21 a=CjuIK1q_8ugA:10
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu Wang

On Wed, Sep 30, 2020 at 08:18:59AM +0000, Xu Wang wrote:
> Because clk_disable_unprepare already checked NULL clock parameter,
> so the additional checks are unnecessary, just remove it
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Thanks, applied to drm-misc-next. I will appear in linux-next in a few
weeks.

	Sam

> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 5b6e19ecbc84..1b01836f1eb1 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -819,8 +819,7 @@ static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
>  {
>  	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
>  
> -	if (pdata->refclk)
> -		clk_disable_unprepare(pdata->refclk);
> +	clk_disable_unprepare(pdata->refclk);
>  
>  	pm_runtime_put_sync(pdata->dev);
>  }
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
