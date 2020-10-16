Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C47290CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406909AbgJPUvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:51:47 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:60816 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbgJPUvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:51:47 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7E2F520030;
        Fri, 16 Oct 2020 22:51:44 +0200 (CEST)
Date:   Fri, 16 Oct 2020 22:51:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: rm68200: fix mode to 50fps
Message-ID: <20201016205142.GA1496366@ravnborg.org>
References: <20200925141618.12097-1-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925141618.12097-1-yannick.fertre@st.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=S433PrkP c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8b9GpE9nAAAA:8 a=e5mUnYsNAAAA:8
        a=IhV6Tf_-iKTokH-9AMUA:9 a=CjuIK1q_8ugA:10 a=T3LWEMljR5ZiDmsYVIUa:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On Fri, Sep 25, 2020 at 04:16:18PM +0200, Yannick Fertre wrote:
> Compute new timings to get a framerate of 50fps with a pixel clock
> @54Mhz.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Thanks, applied to drm-misc-next.
Sorry for taking so long time.

	Sam
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm68200.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> index 2b9e48b0a491..412c0dbcb2b6 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> @@ -82,15 +82,15 @@ struct rm68200 {
>  };
>  
>  static const struct drm_display_mode default_mode = {
> -	.clock = 52582,
> +	.clock = 54000,
>  	.hdisplay = 720,
> -	.hsync_start = 720 + 38,
> -	.hsync_end = 720 + 38 + 8,
> -	.htotal = 720 + 38 + 8 + 38,
> +	.hsync_start = 720 + 48,
> +	.hsync_end = 720 + 48 + 9,
> +	.htotal = 720 + 48 + 9 + 48,
>  	.vdisplay = 1280,
>  	.vsync_start = 1280 + 12,
> -	.vsync_end = 1280 + 12 + 4,
> -	.vtotal = 1280 + 12 + 4 + 12,
> +	.vsync_end = 1280 + 12 + 5,
> +	.vtotal = 1280 + 12 + 5 + 12,
>  	.flags = 0,
>  	.width_mm = 68,
>  	.height_mm = 122,
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
