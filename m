Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3C281187
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgJBLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:49:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54894 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:49:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092Bn8Hq080454;
        Fri, 2 Oct 2020 06:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601639348;
        bh=s3DN3MeqQyiIvhI3oNKOPX1pPbCC/r3S5ZGQ31V60RA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z5DrgLMv56Poc2oWfXOawXuLHQ2/fFzYZ6+70o9HE4e29SH6nBoficclVL18S9A9q
         kx/JmBSOo7SvJUAuw7o1Z5lvnOnmOQrm5vEUhN7y84e9M6K0/bHMH5+2Th53P2PvFW
         j22qdYl3Vuxb4yZoPUo/8d1EjsFZc3s/cFriAzlU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092Bn8UN009228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 06:49:08 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 06:49:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 06:49:08 -0500
Received: from [10.250.71.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092Bn7Vu054127;
        Fri, 2 Oct 2020 06:49:07 -0500
Subject: Re: [PATCH 2/2] ASoC: tas2764: Add the driver for the TAS2764
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20200930163809.6978-1-dmurphy@ti.com>
 <20200930163809.6978-2-dmurphy@ti.com> <20201001162505.GO6715@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e579ca44-dbc8-f7ff-a4b5-3d19ce9b5d7a@ti.com>
Date:   Fri, 2 Oct 2020 06:49:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001162505.GO6715@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

Thanks for the review

On 10/1/20 11:25 AM, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 11:38:09AM -0500, Dan Murphy wrote:
>
> This all looks good - a few very minor things below but nothing
> substantial:
>
>> +	default:
>> +		dev_err(tas2764->dev, "Not supported evevt\n");
>> +		return -EINVAL;
> evevt -> event
OK
>
>> +static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
>> +{
>> +	struct snd_soc_component *component = dai->component;
>> +	int ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
>> +						TAS2764_PWR_CTRL_MASK,
>> +						mute ? TAS2764_PWR_CTRL_MUTE : 0);
>> +
>> +	if (ret < 0)
>> +		return ret;
> This looks weird with the ternery operator and extreme indentation -
> could you please at least split the declaration of ret from the call to
> make the line length a bit extreme?

I will fix it up


>> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +	case SND_SOC_DAIFMT_I2S:
>> +	case SND_SOC_DAIFMT_DSP_A:
>> +		tdm_rx_start_slot = 1;
>> +		break;
>> +	case SND_SOC_DAIFMT_DSP_B:
>> +	case SND_SOC_DAIFMT_LEFT_J:
>> +		tdm_rx_start_slot = 0;
>> +		break;
> I'm not seeing any other handling that distinguishes between the I2S and
> DSP modes anywhere - I'm guessing this is because the device is really
> only implementing the DSP modes but because it's mono this is compatible
> with the I2S modes?  It'd be worth having a comment saying this since
> while that would be OK not distinguishing between modes properly is a
> common error in drivers so it'd help avoid cut'n'paste issues if someone
> uses this code as a reference.

Ah it does do LEFT J and Right J so I will fix this


>> +static int tas2764_register_codec(struct tas2764_priv *tas2764)
>> +{
>> +	return devm_snd_soc_register_component(tas2764->dev,
>> +					       &soc_component_driver_tas2764,
>> +					       tas2764_dai_driver,
>> +					       ARRAY_SIZE(tas2764_dai_driver));
>> +}
> This is a bit odd - can we not just inline the component registration
> rather than having this function?

I will eliminate this completely and move to i2c_probe

Dan

