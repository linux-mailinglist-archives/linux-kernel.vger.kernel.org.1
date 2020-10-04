Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E41282B94
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJDPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 11:45:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10406C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 08:45:33 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a2so6221559otr.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xGAaZlULxRnETqUVWzjLk8Mz1WjD46DK8i9GWsNTs18=;
        b=dV1gX4zqZmbJQOPTdUVdivyx029QwLokW0xCfS7wBE3/G7FyPDPNKL1vqvIVEUcX8t
         lCk/u+BiBujGCpb9gEQ/3fTh1RYfcqi4Gnaswrg7qLAXlDJuoJKiyZERhtIx6I6xKUgA
         FGlFvjGRDrgupoBKJwMuyKg6cia7A5Bln0NA9MlJmWap80a517wDdFSpJjOtMHSsSMUX
         pwXo9+vrjQxypZ4U/T6RtpuQDLeyQ76u6Ume/i9a/PRI2qQx+QT3g8V3TervWV2jkIsO
         F0V2HZ3l1U3su3ZuNhC40yaNqXw4GmW25NqJmSCl1az+/mUukNEEVoewaz9NMFV/YITT
         +Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xGAaZlULxRnETqUVWzjLk8Mz1WjD46DK8i9GWsNTs18=;
        b=ezp09An2edrTT8cZnitpAa7T+PNwtH+ibTWe8IbcqkkgQjsYsAHaVB00o13ZTISgml
         yb40V68DtMmeQdDiZZb8JJTpp5mRadvqne0TXDCvsKRFLezojFl6yyECW9TKxBMdr/e/
         YKbKLokUY4wiwuTWsxEt/Gc1LgT/5sNDBJnKWsLtTWgkX6XiMD4U5QrnpSBPLPoM7Hsv
         KIuT0Buzb+9r7XCEldBSgWKbxVt1xEf35/LpWo5nb8PBYFkSKjiwTvbt7wDO96pCLcg1
         Bhkt6hhMaypE7PCMKWP3/vZqzmfJMOQCdPcAAuEyCHUSmlw2qButm+unhqZBprYyHEI8
         J78Q==
X-Gm-Message-State: AOAM530aZoICX7ZOGQh3PEZte8GWgtdEc5rb7rFbT7NlIEvRyRt/rVcC
        sOhNIoAVSREE72EmJFw6q7YpegojPKM3MpF6
X-Google-Smtp-Source: ABdhPJzAkK7Ed/NxS+dDPERTzbQ+ASLKgaHlFbiIZmKavzA4g8BCHoJiOSZ5JsmCvp/tNE3z7OPMuw==
X-Received: by 2002:a9d:5e8a:: with SMTP id f10mr8217883otl.242.1601826332190;
        Sun, 04 Oct 2020 08:45:32 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id k73sm2209402otk.63.2020.10.04.08.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 08:45:31 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Add retries for link training
To:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201002135920.1.I2adbc90b2db127763e2444bd5a4e5bf30e1db8e5@changeid>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <29cace9d-39e2-a5f5-dd2b-ab3eb7ad1622@kali.org>
Date:   Sun, 4 Oct 2020 10:45:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002135920.1.I2adbc90b2db127763e2444bd5a4e5bf30e1db8e5@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/20 4:03 PM, Douglas Anderson wrote:
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


Apologies for the previous HTML email, I was trying a new mail client
and... will not be switching to it.

Anyway.. again, this time in text..


Tested on the Lenovo C630, and haven’t seen the message, although I
hadn’t seen the described issue before either.

Tested-By: Steev Klimaszewski <steev@kali.org>


