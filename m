Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0028C2910AF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437615AbgJQIHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 04:07:52 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48006 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406626AbgJQIHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 04:07:50 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 473A980613;
        Sat, 17 Oct 2020 10:07:47 +0200 (CEST)
Date:   Sat, 17 Oct 2020 10:07:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add support for Innolux LS075AT011
Message-ID: <20201017080745.GC2568873@ravnborg.org>
References: <20200819101206.633253-1-lkundrak@v3.sk>
 <20200819101206.633253-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101206.633253-3-lkundrak@v3.sk>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=xLo76rB1dlWsSdU1wyoA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir.

Sorry for the late feedback!

On Wed, Aug 19, 2020 at 12:12:06PM +0200, Lubomir Rintel wrote:
> This adds support for the Innolux LS075AT011 7.5" 1200x900 panel. There's
> no public data sheet for the panel -- the values have been taken from Open
> Firmware and the documentation for the display controller that drives
> the panel and tested on the OLPC laptop.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index cb6550d37e858..dfc69457ed2d4 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2121,6 +2121,30 @@ static const struct panel_desc innolux_g121x1_l03 = {
>  	},
>  };
>  
> +static const struct display_timing innolux_ls075at011_timing = {
> +	.pixelclock = { 56000000, 57000000, 58000000 },
> +	.hactive = { 1200, 1200, 1200 },
> +	.hfront_porch = { 26, 26, 26 },
> +	.hback_porch = { 24, 24, 24 },
> +	.hsync_len = { 6, 6, 6 },
> +	.vactive = { 900, 900, 900 },
> +	.vfront_porch = { 4, 4, 4 },
> +	.vback_porch = { 5, 5, 5 },
> +	.vsync_len = { 3, 3, 3 },
> +	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
> +};
> +
> +static const struct panel_desc innolux_ls075at011 = {
> +	.timings = &innolux_ls075at011_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 152,
> +		.height = 115,
> +	},
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
For LVDS panels following info is mandatory:
.bus_flags
.bus_format

You have .bpc - so this part is OK.

See the checks in panel_simple_probe() - thay are not allowed to trigger
for any new panels.

	Sam
