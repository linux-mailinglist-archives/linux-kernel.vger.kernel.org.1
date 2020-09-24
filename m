Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9109C277A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIXUjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:39:40 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55736 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:39:38 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0D24220079;
        Thu, 24 Sep 2020 22:39:34 +0200 (CEST)
Date:   Thu, 24 Sep 2020 22:39:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: otm8009a: remove hack to force commands in
 HS
Message-ID: <20200924203933.GM1223313@ravnborg.org>
References: <20200922074242.28719-1-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922074242.28719-1-yannick.fertre@st.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8b9GpE9nAAAA:8 a=e5mUnYsNAAAA:8
        a=3IXDLeCq4fybylwK7oQA:9 a=CjuIK1q_8ugA:10 a=T3LWEMljR5ZiDmsYVIUa:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:42:42AM +0200, Yannick Fertre wrote:
> From: Antonio Borneo <antonio.borneo@st.com>
> 
> The panel is able to receive commands in LP. The current hack to
> force backlight commands in HS was due to workaround an incorrect
> settings on DSI controller that prevents sending LP commands while
> video out was active.
> 
> Remove the hack that forces HS commands.
> 
> Changes in v2:
>   - Added my signed-off
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Thanks, applied to drm-misc-next.

	Sam


> ---
>  .../gpu/drm/panel/panel-orisetech-otm8009a.c   | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> index 6ac1accade80..f80b44a8a700 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> @@ -99,20 +99,6 @@ static void otm8009a_dcs_write_buf(struct otm8009a *ctx, const void *data,
>  		dev_warn(ctx->dev, "mipi dsi dcs write buffer failed\n");
>  }
>  
> -static void otm8009a_dcs_write_buf_hs(struct otm8009a *ctx, const void *data,
> -				      size_t len)
> -{
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -
> -	/* data will be sent in dsi hs mode (ie. no lpm) */
> -	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> -
> -	otm8009a_dcs_write_buf(ctx, data, len);
> -
> -	/* restore back the dsi lpm mode */
> -	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> -}
> -
>  #define dcs_write_seq(ctx, seq...)			\
>  ({							\
>  	static const u8 d[] = { seq };			\
> @@ -400,7 +386,7 @@ static int otm8009a_backlight_update_status(struct backlight_device *bd)
>  		 */
>  		data[0] = MIPI_DCS_SET_DISPLAY_BRIGHTNESS;
>  		data[1] = bd->props.brightness;
> -		otm8009a_dcs_write_buf_hs(ctx, data, ARRAY_SIZE(data));
> +		otm8009a_dcs_write_buf(ctx, data, ARRAY_SIZE(data));
>  
>  		/* set Brightness Control & Backlight on */
>  		data[1] = 0x24;
> @@ -412,7 +398,7 @@ static int otm8009a_backlight_update_status(struct backlight_device *bd)
>  
>  	/* Update Brightness Control & Backlight */
>  	data[0] = MIPI_DCS_WRITE_CONTROL_DISPLAY;
> -	otm8009a_dcs_write_buf_hs(ctx, data, ARRAY_SIZE(data));
> +	otm8009a_dcs_write_buf(ctx, data, ARRAY_SIZE(data));
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
