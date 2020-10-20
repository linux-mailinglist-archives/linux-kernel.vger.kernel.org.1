Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73A2932AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbgJTBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390009AbgJTBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:24:43 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D07C0613CE;
        Mon, 19 Oct 2020 18:24:42 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id w7so16525oow.7;
        Mon, 19 Oct 2020 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D564rZOfF3k0oVe3HCHAGp0/NJldYMB7oVirijE+i+I=;
        b=Qn5BGl0fJYBFVJhISBYmMOaefLst5heIFuvb0zICODjXjQ/wrDFZvlhV8cCmcqPu+t
         jYGFAKkFGU33f4FH9kppekKzxJ/tvVrJCuve/hG36gN8rJndS/w0fy4eLwHR7YEBllYq
         LyZMshTvx9mYIyF4+2Tsiv661ZgtqLU2UrHtgR8/dhLXUcSSjhlQo1xAgWMPQ2eYxrBq
         pLDN4KYunO0uI7GoeUOb6/RqQo0jX6TEVS6n/EEXoYiVsyvcWAEjxgqNKdPk299VRK4S
         AXg9JD+0GQl80ICOfuZPPCVeOnBAzV6fPP7Avr7ryfRVwNqC+1Zz+RudDch9IB1h7rd1
         EEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D564rZOfF3k0oVe3HCHAGp0/NJldYMB7oVirijE+i+I=;
        b=VY3eHal6QK9VsqcW7xtwjB4N9gw5yUNZzdRxp+PhvQbmfxsBaCLY4aYRuHBtHwLHEv
         tHN90ZLfQ3Xj8G0Ed2lywlwub2ENVLakA11QTjMH8zdxH6k7yC5rWPKpLT2WDVxdkgP0
         nWhL/NzEviDnzA2BFDQXjFZVmDnh+5PdH90SHIpK5VaoUhXJStkO69/ac2poIdwKpGSj
         kg+S9+530ZvAU2TEuOF3n5YJzc9OxiMsLxlmvutOOZLHUDs0XgEVNWhtlW0jhh6ymA3v
         R4D/uJXDEAmJ2XAjw6RZkssPwukMTHPYeohw3/k+CUVsOUkVH7pQu6KKsccsAnzyBIMz
         dctg==
X-Gm-Message-State: AOAM533UH8LP9EU0DvtnkJdfoR9NBIoUwQgbAAw5k4Of08nV/4kB9A+Q
        N6lVNK+caPdAKKas3raYPnxzJ5NHYewjPQ==
X-Google-Smtp-Source: ABdhPJxMGxNhib1lTLCTo6dKakOyPTgK9aoKBakEA28oMI2Fb2EpiVVRQTTFzl4e8Jjjc8EQ+7CDeA==
X-Received: by 2002:a4a:a844:: with SMTP id p4mr144097oom.59.1603157081962;
        Mon, 19 Oct 2020 18:24:41 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 15sm32385ooy.36.2020.10.19.18.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 18:24:41 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] drm/bridge: sii902x: Enable I/O and core VCC
 supplies if present
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <20200928173056.1674274-1-mr.nuke.me@gmail.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <d74c7626-8f16-db85-c23f-79bf0cc400d0@gmail.com>
Date:   Mon, 19 Oct 2020 20:24:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/20 12:30 PM, Alexandru Gagniuc wrote:
> On the SII9022, the IOVCC and CVCC12 supplies must reach the correct
> voltage before the reset sequence is initiated. On most boards, this
> assumption is true at boot-up, so initialization succeeds.
> 
> However, when we try to initialize the chip with incorrect supply
> voltages, it will not respond to I2C requests. sii902x_probe() fails
> with -ENXIO.
> 
> To resolve this, look for the "iovcc" and "cvcc12" regulators, and
> make sure they are enabled before starting the reset sequence. If
> these supplies are not available in devicetree, then they will default
> to dummy-regulator. In that case everything will work like before.
> 
> This was observed on a STM32MP157C-DK2 booting in u-boot falcon mode.
> On this board, the supplies would be set by the second stage
> bootloader, which does not run in falcon mode.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> Changes since v1:
>    * Fix return code after regulator_enable(sii902x->iovcc) fails (Fabio Estevam)
>    * Use dev_err_probe() instead of dev_err() where appropriate (Sam Ravnborg)
> 
>   drivers/gpu/drm/bridge/sii902x.c | 54 ++++++++++++++++++++++++++++----
>   1 file changed, 48 insertions(+), 6 deletions(-)

This patch seems to have entered fall dormancy. Did I miss somebody in 
the CC field?

Alex


> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 33fd33f953ec..d15e9f2c0d8a 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -17,6 +17,7 @@
>   #include <linux/i2c.h>
>   #include <linux/module.h>
>   #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/clk.h>
>   
>   #include <drm/drm_atomic_helper.h>
> @@ -168,6 +169,8 @@ struct sii902x {
>   	struct drm_connector connector;
>   	struct gpio_desc *reset_gpio;
>   	struct i2c_mux_core *i2cmux;
> +	struct regulator *iovcc;
> +	struct regulator *cvcc12;
>   	/*
>   	 * Mutex protects audio and video functions from interfering
>   	 * each other, by keeping their i2c command sequences atomic.
> @@ -954,13 +957,13 @@ static const struct drm_bridge_timings default_sii902x_timings = {
>   		 | DRM_BUS_FLAG_DE_HIGH,
>   };
>   
> +static int sii902x_init(struct sii902x *sii902x);
> +
>   static int sii902x_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
>   	struct device *dev = &client->dev;
> -	unsigned int status = 0;
>   	struct sii902x *sii902x;
> -	u8 chipid[4];
>   	int ret;
>   
>   	ret = i2c_check_functionality(client->adapter,
> @@ -989,6 +992,43 @@ static int sii902x_probe(struct i2c_client *client,
>   
>   	mutex_init(&sii902x->mutex);
>   
> +	sii902x->iovcc = devm_regulator_get(dev, "iovcc");
> +	if (IS_ERR(sii902x->iovcc))
> +		return PTR_ERR(sii902x->iovcc);
> +
> +	sii902x->cvcc12 = devm_regulator_get(dev, "cvcc12");
> +	if (IS_ERR(sii902x->cvcc12))
> +		return PTR_ERR(sii902x->cvcc12);
> +
> +	ret = regulator_enable(sii902x->iovcc);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Failed to enable iovcc supply");
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(sii902x->cvcc12);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Failed to enable cvcc12 supply");
> +		regulator_disable(sii902x->iovcc);
> +		return ret;
> +	}
> +
> +	ret = sii902x_init(sii902x);
> +	if (ret < 0) {
> +		regulator_disable(sii902x->cvcc12);
> +		regulator_disable(sii902x->iovcc);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sii902x_init(struct sii902x *sii902x)
> +{
> +	struct device *dev = &sii902x->i2c->dev;
> +	unsigned int status = 0;
> +	u8 chipid[4];
> +	int ret;
> +
>   	sii902x_reset(sii902x);
>   
>   	ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
> @@ -1012,11 +1052,11 @@ static int sii902x_probe(struct i2c_client *client,
>   	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>   	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>   
> -	if (client->irq > 0) {
> +	if (sii902x->i2c->irq > 0) {
>   		regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
>   			     SII902X_HOTPLUG_EVENT);
>   
> -		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +		ret = devm_request_threaded_irq(dev, sii902x->i2c->irq, NULL,
>   						sii902x_interrupt,
>   						IRQF_ONESHOT, dev_name(dev),
>   						sii902x);
> @@ -1031,9 +1071,9 @@ static int sii902x_probe(struct i2c_client *client,
>   
>   	sii902x_audio_codec_init(sii902x, dev);
>   
> -	i2c_set_clientdata(client, sii902x);
> +	i2c_set_clientdata(sii902x->i2c, sii902x);
>   
> -	sii902x->i2cmux = i2c_mux_alloc(client->adapter, dev,
> +	sii902x->i2cmux = i2c_mux_alloc(sii902x->i2c->adapter, dev,
>   					1, 0, I2C_MUX_GATE,
>   					sii902x_i2c_bypass_select,
>   					sii902x_i2c_bypass_deselect);
> @@ -1051,6 +1091,8 @@ static int sii902x_remove(struct i2c_client *client)
>   
>   	i2c_mux_del_adapters(sii902x->i2cmux);
>   	drm_bridge_remove(&sii902x->bridge);
> +	regulator_disable(sii902x->cvcc12);
> +	regulator_disable(sii902x->iovcc);
>   
>   	return 0;
>   }
> 
