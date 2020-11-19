Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01BF2B92C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgKSMtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:49:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38500 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKSMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:49:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJClvEt059528;
        Thu, 19 Nov 2020 06:47:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605790077;
        bh=LI2IoJ63ARbNnEA51i0+8fqNIJSk4cDS6Mj0qP1u1ys=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=UXQS+sJ5L/lenC6ngFBk+j6ypLa0ZcINtQjXNAnR8/CiKnib2kD/PoCT+wzzxJj3h
         uL+UpWRWFBklil2wzixHPIZO0i89IgKutI/iDEqa+YlYvQtoiJk8QtJzp9tPn76Axv
         QlyyMXHw7lVP3GR0XqAxUnRe2ggxH6sgLW1tIVjE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJClvC5073017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 06:47:57 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 06:47:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 06:47:56 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJClrcS021813;
        Thu, 19 Nov 2020 06:47:53 -0600
Subject: Re: [RFC PATCH] ASoC: ak4458: use reset control instead of reset gpio
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Lee Jones <lee.jones@linaro.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <cee287f3-29c1-771f-ca20-812de1ae8044@ti.com>
Date:   Thu, 19 Nov 2020 14:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/11/2020 0.20, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Using GPIO API seems not a way to go for the case
> when the same reset GPIO is used to control several codecs.
> For a such case we can use the "gpio-reset" driver
> and the "shared" reset API to manage the reset GPIO -
> to deassert the reset when the first codec is powered up
> and assert it when there is no codec in use.
> DTS is supposed to look as follows:
> 
> / {
>     ak4458_reset: gpio-reset {
>        compatible = "gpio-reset";
>        reset-gpios = <&pca6416 4 GPIO_ACTIVE_LOW>;
>        #reset-cells = <0>;
>        initially-in-reset;

I can not find anything resembling to this in next-20201119.

Where is the implementation and documentation for this gpio-reset?

>     };
> };
> 
> &i2c3 {
>     pca6416: gpio@20 {
>        compatible = "ti,tca6416";
>        reg = <0x20>;
>        gpio-controller;
>        #gpio-cells = <2>;
>     };
> 
>     ak4458_1: ak4458@10 {
>        compatible = "asahi-kasei,ak4458";
>        reg = <0x10>;
>        resets = <&ak4458_reset>;
>     };
> 
>     ak4458_2: ak4458@11 {
>        compatible = "asahi-kasei,ak4458";
>        reg = <0x11>;
>        resets = <&ak4458_reset>;
>     };
> 
>     ak4458_3: ak4458@12 {
>        compatible = "asahi-kasei,ak4458";
>        reg = <0x12>;
>        resets = <&ak4458_reset>;
>     };
> };
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  sound/soc/codecs/ak4458.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
> index 1010c9ee2e83..f27727cb1382 100644
> --- a/sound/soc/codecs/ak4458.c
> +++ b/sound/soc/codecs/ak4458.c
> @@ -13,6 +13,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <sound/initval.h>
>  #include <sound/pcm_params.h>
> @@ -45,7 +46,7 @@ struct ak4458_priv {
>  	const struct ak4458_drvdata *drvdata;
>  	struct device *dev;
>  	struct regmap *regmap;
> -	struct gpio_desc *reset_gpiod;
> +	struct reset_control *reset;
>  	struct gpio_desc *mute_gpiod;
>  	int digfil;	/* SSLOW, SD, SLOW bits */
>  	int fs;		/* sampling rate */
> @@ -597,17 +598,17 @@ static struct snd_soc_dai_driver ak4497_dai = {
>  
>  static void ak4458_power_off(struct ak4458_priv *ak4458)
>  {
> -	if (ak4458->reset_gpiod) {
> -		gpiod_set_value_cansleep(ak4458->reset_gpiod, 0);
> -		usleep_range(1000, 2000);
> +	if (ak4458->reset) {
> +		reset_control_assert(ak4458->reset);
> +		msleep(20);
>  	}
>  }
>  
>  static void ak4458_power_on(struct ak4458_priv *ak4458)
>  {
> -	if (ak4458->reset_gpiod) {
> -		gpiod_set_value_cansleep(ak4458->reset_gpiod, 1);
> -		usleep_range(1000, 2000);
> +	if (ak4458->reset) {
> +		reset_control_deassert(ak4458->reset);
> +		msleep(20);
>  	}
>  }
>  
> @@ -685,7 +686,6 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
>  	if (ak4458->mute_gpiod)
>  		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
>  
> -	ak4458_power_off(ak4458);
>  	ak4458_power_on(ak4458);
>  
>  	regcache_cache_only(ak4458->regmap, false);
> @@ -771,10 +771,9 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
>  
>  	ak4458->drvdata = of_device_get_match_data(&i2c->dev);
>  
> -	ak4458->reset_gpiod = devm_gpiod_get_optional(ak4458->dev, "reset",
> -						      GPIOD_OUT_LOW);
> -	if (IS_ERR(ak4458->reset_gpiod))
> -		return PTR_ERR(ak4458->reset_gpiod);
> +	ak4458->reset = devm_reset_control_get_optional_shared(ak4458->dev, NULL);
> +	if (IS_ERR(ak4458->reset))
> +		return PTR_ERR(ak4458->reset);

The binding documentation must be updated and you must support the gpio
way as well.

When I had this discussion around using the reset framework for shared
enable and/or reset pins it was suggested that _if_ such a driver makes
sense then it should internally handle (by using magic strings) the
fallback and work with pre-reset binding.

>  
>  	ak4458->mute_gpiod = devm_gpiod_get_optional(ak4458->dev, "mute",
>  						     GPIOD_OUT_LOW);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
