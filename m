Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299722B0073
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 08:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgKLHml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:42:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35676 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKLHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:42:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AC7fEOh093923;
        Thu, 12 Nov 2020 01:41:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605166874;
        bh=45YuHlFIl+nnPp8u/mhMJGmH384zohkuJQT6RBJvbNI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=apQjJ5mumOgTzvWaAzTnzy2fE9AB691cWG25I2OSaFk1U1VaHHVHNcP0REYcw0x9N
         zsb7+l6EDI772UFOsov6mFj5rLBEz1DOPCqazc5lgMx+peVX02PiHL0Yn1f9oooUPa
         hNCOoBq8ps7Zw7QsXdEx5ZX/N78JTIKTBnvDXlZk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AC7fEY7041868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 01:41:14 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 01:41:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 01:41:13 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AC7fBq8009001;
        Thu, 12 Nov 2020 01:41:12 -0600
Subject: Re: [PATCH] ASoC: pcm512x: Add support for data formats RJ and LJ
To:     Kirill Marinushkin <kmarinushkin@birdec.com>
CC:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20201109212133.25869-1-kmarinushkin@birdec.com>
 <690508c7-7029-6781-a1a2-0609e37cb9e6@ti.com>
 <a3df4fb0-35cd-4757-2037-d4ff80e9f74c@birdec.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d0f76607-c3a5-9b87-dc0e-eddbce585558@ti.com>
Date:   Thu, 12 Nov 2020 09:41:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <a3df4fb0-35cd-4757-2037-d4ff80e9f74c@birdec.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 11/11/2020 9.54, Kirill Marinushkin wrote:
> Hello Peter,
> 
> than you for your review!
> 
>> The bus format and
>>
>>>  	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>>
>>>  	case SND_SOC_DAIFMT_CBS_CFS:
>>>  		ret = regmap_update_bits(pcm512x->regmap,
>>
>> the clock generation role should be set in pcm512x_set_fmt(), in that
>> way you can deny specific setups earlier.
> 
> I think we could move both checks for`SND_SOC_DAIFMT_FORMAT_MASK` and
> `SND_SOC_DAIFMT_MASTER_MASK` into `pcm512x_set_fmt()`. But it would be a
> different scope, and I didn't intend to do that level of refactoring.

Right, I was just saying what would make sense.

> Looking at other codecs in kernel, I would say, that doing those checks in
> `pcm512x_hw_params()`, as they are done currently, is an equally valid approach.

The exception proves the rule

> As technically keeping checs where they are now doesn't break anything

They are just in a wrong place.

> and is
> aligned with ASoC codecs design, I suggest to keep the checks where they are.

The set_fmt callback is there to set the bus format, it has nothing to
do (in most cases) with the sample format (hw_params). Bus coding, clock
source has nothing to do with hw_params.

When you bind a link you will use set_fmt for the two sides to see if
they can agree, that both can support what has been asked.

The pcm512x driver just saves the fmt and say back to that card:
whatever, I'm fine with it. But runtime during hw_params it can fail due
to unsupported bus format, which it actually acked to be ok.

This is the difference.

Sure, some device have constraint based on the fmt towards the hw_params
and it is perfectly OK to do such a checks and rejections or build
rules/constraints based on fmt, but failing hw_params just because
set_fmt did not checked that the bus format is not even supported is not
a nice thing to do.

> Would you agree?

I don't have a device to test, I'm just trying to point out what is the
right thing to do.

I don't buy the argument that the sequencing is important here for the
register writes. The fmt is set only once and those registers will be
only written once.

>> I would also add DSP_A and DSP_B modes at the same time, DSP_A would
>> need a write of 1 to register 41 (PCM512x_I2S_2, offset = 1), other
>> formats should set the offset to 0.
> 
> That's a good idea, than you for technical details! I just didn't know how to
> use DSP_A and DSP_B. I will add them, and submit as patch v2

Great!
Thanks
- Péter

> Best regards,
> Kirill
> 
> On 11/10/2020 07:59 AM, Peter Ujfalusi wrote:
>>
>>
>> On 09/11/2020 23.21, Kirill Marinushkin wrote:
>>> Currently, pcm512x driver supports only I2S data format.
>>> This commit adds RJ and LJ as well.
>>>
>>> I don't expect regression WRT existing sound cards, because:
>>>
>>> * default value in corresponding register of pcm512x codec is 0 ==  I2S
>>> * existing in-tree sound cards with pcm512x codec are configured for I2S
>>> * i don't see how existing off-tree sound cards with pcm512x codec could be
>>>   configured differently - it would not work
>>> * tested explicitly, that there is no regression with Raspberry Pi +
>>>   sound card `sound/soc/bcm/hifiberry_dacplus.c`
>>>
>>> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.com>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Takashi Iwai <tiwai@suse.com>
>>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>>> Cc: Matthias Reichl <hias@horus.com>
>>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> Cc: alsa-devel@alsa-project.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>  sound/soc/codecs/pcm512x.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
>>> index 8153d3d01654..c6e975fb4a43 100644
>>> --- a/sound/soc/codecs/pcm512x.c
>>> +++ b/sound/soc/codecs/pcm512x.c
>>> @@ -1167,6 +1167,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
>>>  	struct snd_soc_component *component = dai->component;
>>>  	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
>>>  	int alen;
>>> +	int afmt;
>>>  	int gpio;
>>>  	int clock_output;
>>>  	int master_mode;
>>> @@ -1195,6 +1196,22 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> +	switch (pcm512x->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>>> +	case SND_SOC_DAIFMT_I2S:
>>> +		afmt = PCM512x_AFMT_I2S;
>>> +		break;
>>> +	case SND_SOC_DAIFMT_RIGHT_J:
>>> +		afmt = PCM512x_AFMT_RTJ;
>>> +		break;
>>> +	case SND_SOC_DAIFMT_LEFT_J:
>>> +		afmt = PCM512x_AFMT_LTJ;
>>> +		break;
>>> +	default:
>>> +		dev_err(component->dev, "unsupported DAI format: 0x%x\n",
>>> +			pcm512x->fmt);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>
>> The bus format and
>>
>>>  	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>>
>>>  	case SND_SOC_DAIFMT_CBS_CFS:
>>>  		ret = regmap_update_bits(pcm512x->regmap,
>>
>> the clock generation role should be set in pcm512x_set_fmt(), in that
>> way you can deny specific setups earlier.
>>
>> I would also add DSP_A and DSP_B modes at the same time, DSP_A would
>> need a write of 1 to register 41 (PCM512x_I2S_2, offset = 1), other
>> formats should set the offset to 0.
>>
>>> @@ -1236,6 +1253,13 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
>>>  		return ret;
>>>  	}
>>>  
>>> +	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_1,
>>> +				 PCM512x_AFMT, afmt);
>>> +	if (ret != 0) {
>>> +		dev_err(component->dev, "Failed to set data format: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>>  	if (pcm512x->pll_out) {
>>>  		ret = regmap_write(pcm512x->regmap, PCM512x_FLEX_A, 0x11);
>>>  		if (ret != 0) {
>>>
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
