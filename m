Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD22BAB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKTNk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:40:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58490 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKTNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:40:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AKDdZqW076615;
        Fri, 20 Nov 2020 07:39:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605879575;
        bh=wZhG8MmEO6RWkp9NIebIOaU7ygmPrS92fsTYsm1LD+0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=jhDNejlS8XfYODAl093xJ/wsewtgoQoMkvL+8QYCvq7CfqyY/oGY6IENM/4AQ79Tm
         /TR1MFx1ibliPTI+02iSb8JEqfut1FBIFYmE/VkVgOcaQD9nLjszFM34jdGZUXxzTC
         DgyhPwsE7P1rII1kzpeJlHO5evzN2i0Fal+pJyWs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AKDdZ8v113455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 07:39:35 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 20
 Nov 2020 07:39:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 20 Nov 2020 07:39:35 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AKDdWCQ085567;
        Fri, 20 Nov 2020 07:39:32 -0600
Subject: Re: [RFC PATCH] ASoC: ak4458: use reset control instead of reset gpio
To:     Viorel Suman <viorel.suman@nxp.com>,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
 <cee287f3-29c1-771f-ca20-812de1ae8044@ti.com>
 <VI1PR0401MB22729D51912D66FDB2973A7792E00@VI1PR0401MB2272.eurprd04.prod.outlook.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c6e7ff22-f421-d05e-621f-738740b30482@ti.com>
Date:   Fri, 20 Nov 2020 15:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB22729D51912D66FDB2973A7792E00@VI1PR0401MB2272.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Viorel,

On 19/11/2020 18.24, Viorel Suman wrote:
> Hi Peter,
> 
>> DTS is supposed to look as follows:
>>>
>>> / {
>>>     ak4458_reset: gpio-reset {
>>>        compatible = "gpio-reset";
>>>        reset-gpios = <&pca6416 4 GPIO_ACTIVE_LOW>;
>>>        #reset-cells = <0>;
>>>        initially-in-reset;
>>
>> I can not find anything resembling to this in next-20201119.
>> Where is the implementation and documentation for this gpio-reset?
> 
> The board schematics is not publicly available; some info may be seen in DTS files below:
> https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8mm-evk.dts?h=imx_5.4.24_2.1.0
> https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8mm-ab2.dts?h=imx_5.4.24_2.1.0
> https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8mp-ab2.dts?h=imx_5.4.24_2.1.0
> 
> In examples above the GPIO is handled by machine driver - wrong approach given that
> it requires machine driver being probed before codec driver.

Right, so this gpio-reset driver is not in mainline. You are adding
support for something which does not exists ;)

> 
>>> -	ak4458->reset_gpiod = devm_gpiod_get_optional(ak4458->dev,
>> "reset",
>>> -						      GPIOD_OUT_LOW);
>>> -	if (IS_ERR(ak4458->reset_gpiod))
>>> -		return PTR_ERR(ak4458->reset_gpiod);
>>> +	ak4458->reset = devm_reset_control_get_optional_shared(ak4458-
>>> dev, NULL);
>>> +	if (IS_ERR(ak4458->reset))
>>> +		return PTR_ERR(ak4458->reset);
>>
>> The binding documentation must be updated and you must support the gpio
>> way as well.
> 
> Sure, make sense.
> 
>> When I had this discussion around using the reset framework for shared
>> enable and/or reset pins it was suggested that _if_ such a driver makes
>> sense then it should internally handle (by using magic strings) the fallback
>> and work with pre-reset binding.
> 
> Thanks, would appreciate if you point me to the discussion you had.

There were few iterations of it when I finally given up, I can quickly
find rfc v2:
https://lkml.org/lkml/2019/10/30/311

Probably in earlier or later series the reset framework was also discussed.

I ended up using GPIOD_FLAGS_BIT_NONEXCLUSIVE in the pcm3168a driver.
https://lkml.org/lkml/2019/11/13/411
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
