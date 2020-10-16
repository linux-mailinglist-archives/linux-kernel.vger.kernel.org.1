Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44950290B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392300AbgJPSgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:36:13 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:39520 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391870AbgJPSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:36:13 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0615820030;
        Fri, 16 Oct 2020 20:36:08 +0200 (CEST)
Date:   Fri, 16 Oct 2020 20:36:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Add retries for link training
Message-ID: <20201016183607.GA1345100@ravnborg.org>
References: <20201002135920.1.I2adbc90b2db127763e2444bd5a4e5bf30e1db8e5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002135920.1.I2adbc90b2db127763e2444bd5a4e5bf30e1db8e5@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=S433PrkP c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=e5mUnYsNAAAA:8
        a=TbjnnDg1GpMu5epwdsMA:9 a=g2MK2S0s9NEDQWlg:21 a=iS_yR1XhKHkLfVqC:21
        a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas.

On Fri, Oct 02, 2020 at 02:03:51PM -0700, Douglas Anderson wrote:
> On some panels hooked up to the ti-sn65dsi86 bridge chip we found that
> link training was failing.  Specifically, we'd see:
> 
>   ti_sn65dsi86 2-002d: [drm:ti_sn_bridge_enable] *ERROR* Link training failed, link is off (-5)
> 
> The panel was hooked up to a logic analyzer and it was found that, as
> part of link training, the bridge chip was writing a 0x1 to DPCD
> address 00600h and the panel responded NACK.  As can be seen in header
> files, the write of 0x1 to DPCD address 0x600h means we were trying to
> write the value DP_SET_POWER_D0 to the register DP_SET_POWER.  The
> panel vendor says that a NACK in this case is not unexpected and means
> "not ready, try again".
> 
> In testing, we found that this panel would respond with a NACK in
> about 1/25 times.  Adding the retry logic worked fine and the most
> number of tries needed was 3.  Just to be safe, we'll add 10 tries
> here and we'll add a little blurb to the logs if we ever need more
> than 5.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I have picked this patch up and applied to drm-misc-next now.

	Sam

> ---
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 40 +++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index ecdf9b01340f..6e12cda69b54 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -106,6 +106,8 @@
>  #define SN_NUM_GPIOS			4
>  #define SN_GPIO_PHYSICAL_OFFSET		1
>  
> +#define SN_LINK_TRAINING_TRIES		10
> +
>  /**
>   * struct ti_sn_bridge - Platform data for ti-sn65dsi86 driver.
>   * @dev:          Pointer to our device.
> @@ -673,6 +675,7 @@ static int ti_sn_link_training(struct ti_sn_bridge *pdata, int dp_rate_idx,
>  {
>  	unsigned int val;
>  	int ret;
> +	int i;
>  
>  	/* set dp clk frequency value */
>  	regmap_update_bits(pdata->regmap, SN_DATARATE_CONFIG_REG,
> @@ -689,19 +692,34 @@ static int ti_sn_link_training(struct ti_sn_bridge *pdata, int dp_rate_idx,
>  		goto exit;
>  	}
>  
> -	/* Semi auto link training mode */
> -	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0x0A);
> -	ret = regmap_read_poll_timeout(pdata->regmap, SN_ML_TX_MODE_REG, val,
> -				       val == ML_TX_MAIN_LINK_OFF ||
> -				       val == ML_TX_NORMAL_MODE, 1000,
> -				       500 * 1000);
> -	if (ret) {
> -		*last_err_str = "Training complete polling failed";
> -	} else if (val == ML_TX_MAIN_LINK_OFF) {
> -		*last_err_str = "Link training failed, link is off";
> -		ret = -EIO;
> +	/*
> +	 * We'll try to link train several times.  As part of link training
> +	 * the bridge chip will write DP_SET_POWER_D0 to DP_SET_POWER.  If
> +	 * the panel isn't ready quite it might respond NAK here which means
> +	 * we need to try again.
> +	 */
> +	for (i = 0; i < SN_LINK_TRAINING_TRIES; i++) {
> +		/* Semi auto link training mode */
> +		regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0x0A);
> +		ret = regmap_read_poll_timeout(pdata->regmap, SN_ML_TX_MODE_REG, val,
> +					val == ML_TX_MAIN_LINK_OFF ||
> +					val == ML_TX_NORMAL_MODE, 1000,
> +					500 * 1000);
> +		if (ret) {
> +			*last_err_str = "Training complete polling failed";
> +		} else if (val == ML_TX_MAIN_LINK_OFF) {
> +			*last_err_str = "Link training failed, link is off";
> +			ret = -EIO;
> +			continue;
> +		}
> +
> +		break;
>  	}
>  
> +	/* If we saw quite a few retries, add a note about it */
> +	if (!ret && i > SN_LINK_TRAINING_TRIES / 2)
> +		DRM_DEV_INFO(pdata->dev, "Link training needed %d retries\n", i);
> +
>  exit:
>  	/* Disable the PLL if we failed */
>  	if (ret)
> -- 
> 2.28.0.806.g8561365e88-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
