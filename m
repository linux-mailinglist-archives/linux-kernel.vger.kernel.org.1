Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565BC29100F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437016AbgJQGTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:19:55 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59276 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411646AbgJQGTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:19:55 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BBA9780573;
        Sat, 17 Oct 2020 08:19:53 +0200 (CEST)
Date:   Sat, 17 Oct 2020 08:19:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/panel: simplify the return expression of
 rb070d30_panel_enable()
Message-ID: <20201017061952.GE2242298@ravnborg.org>
References: <20200915032623.1772361-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915032623.1772361-1-liushixin2@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=Sa3K4Do9iwlq6gi14jcA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu

On Tue, Sep 15, 2020 at 11:26:23AM +0800, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thanks, applied to drm-misc-next.
The patch will appear in drm-misc-next in a few weeks.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> index 535c8d1cca21..a3782830ae3c 100644
> --- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> +++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> @@ -75,13 +75,8 @@ static int rb070d30_panel_unprepare(struct drm_panel *panel)
>  static int rb070d30_panel_enable(struct drm_panel *panel)
>  {
>  	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
> -	int ret;
>  
> -	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
>  }
>  
>  static int rb070d30_panel_disable(struct drm_panel *panel)
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
