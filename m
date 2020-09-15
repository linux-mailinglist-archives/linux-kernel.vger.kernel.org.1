Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0787F26AC53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgIOSmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:42:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45816 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgIOSla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:41:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FIf1S2125142;
        Tue, 15 Sep 2020 13:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600195261;
        bh=/tdoN0OYwR8m4NawnYuovScUnXtRzZKV8TbiOry6es4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IJx8XQmM6o7a7eLjI0Fc9mEIJJCh+o0GU0kW922XsnCUFnr0WVOfqe+qH4GKu9Mg6
         ycf1wbiBdaeHRHRHNRntzTZPkA4OLzrYvE2XCxANyi/J+NwTT8Sj/6V46WS5JuveMl
         z1PPPEth1FYjVOz5bemdqqobb0/54GeihqLcjdGY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FIf16D002249;
        Tue, 15 Sep 2020 13:41:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 13:41:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 13:41:00 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FIf0mM041635;
        Tue, 15 Sep 2020 13:41:00 -0500
Subject: Re: [PATCH v2 2/3] ASoC: tlv320adcx140: Add support for configuring
 GPIO pin
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
References: <20200911080753.30342-1-camel.guo@axis.com>
 <20200911080753.30342-2-camel.guo@axis.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <da35edb3-bc41-967c-d530-4df4363ddddf@ti.com>
Date:   Tue, 15 Sep 2020 13:41:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911080753.30342-2-camel.guo@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel

On 9/11/20 3:07 AM, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>
> Add support to configure the GPIO pin to the specific configuration.
> The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
> GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
> drive can be configured with various configuration.
>
> Signed-off-by: Camel Guo <camelg@axis.com>
> ---
>   sound/soc/codecs/tlv320adcx140.c | 44 ++++++++++++++++++++++++++++++++
>   sound/soc/codecs/tlv320adcx140.h |  4 +++
>   2 files changed, 48 insertions(+)
>
> diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
> index f33ee604ee78..97f16fbba441 100644
> --- a/sound/soc/codecs/tlv320adcx140.c
> +++ b/sound/soc/codecs/tlv320adcx140.c
> @@ -837,6 +837,46 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
>   
>   }
>   
> +static int adcx140_configure_gpio(struct adcx140_priv *adcx140)
> +{
> +	int gpio_count = 0;
> +	u32 gpio_outputs[2];

This is #defined in configure_gpo and configure_gpi would like to see 
the consistency here.

> +	u32 gpio_output_val = 0;
> +	int ret;
> +
> +	gpio_count = device_property_count_u32(adcx140->dev,
> +			"ti,gpio-config");
> +	if (gpio_count == 0)
> +		return 0;
> +
> +	if (gpio_count != 2)
Same comment as above.
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32_array(adcx140->dev, "ti,gpio-config",
> +			gpio_outputs, gpio_count);
> +	if (ret)
> +		return ret;
> +
> +	if (gpio_outputs[0] > ADCX140_GPIO_CFG_MAX) {
> +		dev_err(adcx140->dev, "GPIO config out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (gpio_outputs[1] > ADCX140_GPIO_DRV_MAX) {
> +		dev_err(adcx140->dev, "GPIO drive out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio_output_val = gpio_outputs[0] << ADCX140_GPIO_SHIFT
> +		| gpio_outputs[1];
> +
> +	ret = regmap_write(adcx140->regmap, ADCX140_GPIO_CFG0, gpio_output_val);
> +	if (ret)
> +		return ret;

Just do return regmap_write no reason to check it. It is checked by the 
caller.


Dan

