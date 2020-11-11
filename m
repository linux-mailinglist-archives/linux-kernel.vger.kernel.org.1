Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABAA2AEA58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgKKHwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:52:54 -0500
Received: from host.euro-space.net ([87.117.239.2]:37228 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgKKHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=v0gNracZYa662N+Zm2+Lcy15dekgWNZ8vDABSWf7En8=; b=F75v5VKdxB1P6el0SrELxapUNM
        wADUAs314mslrEdM9E3wndHdQxpsS+jGfTKiTAmQMrQ1vw/UWhNTHDpCPhGv8suHjxIiB9JO4VfQj
        o8j4cf5btItNpK6qBFvrzvApZD6Uae9LPm4LjviG/+iZCtqRqxl0pcNg+YCRiPDydgsoNbG2qkYKW
        ofP2MosTT7AGZp2Y7fdI/Ubb/vNn818ChATUAqSjSfbkVCujoZekfPTH0Irrx5CXV8dQsTpSBPLre
        6Bce3ifOYunGAKlQhK2zyjhFdv6BgrnTqmMOdtT/bN7hogGU1ZJZptGWjVKfsKgtwcI74EY6CK9Uf
        0hAOQjdQ==;
Received: from dynamic-078-055-099-142.78.55.pool.telefonica.de ([78.55.99.142]:56092 helo=[192.168.1.2])
        by host.euro-space.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kmarinushkin@birdec.com>)
        id 1kckvx-0005J2-8E; Wed, 11 Nov 2020 07:52:49 +0000
Subject: Re: [PATCH] ASoC: pcm512x: Add support for data formats RJ and LJ
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20201109212133.25869-1-kmarinushkin@birdec.com>
 <690508c7-7029-6781-a1a2-0609e37cb9e6@ti.com>
From:   Kirill Marinushkin <kmarinushkin@birdec.com>
Message-ID: <a3df4fb0-35cd-4757-2037-d4ff80e9f74c@birdec.com>
Date:   Wed, 11 Nov 2020 08:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <690508c7-7029-6781-a1a2-0609e37cb9e6@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.com
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.com
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

than you for your review!

> The bus format and
>
>>  	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>
>>  	case SND_SOC_DAIFMT_CBS_CFS:
>>  		ret = regmap_update_bits(pcm512x->regmap,
>
> the clock generation role should be set in pcm512x_set_fmt(), in that
> way you can deny specific setups earlier.

I think we could move both checks for`SND_SOC_DAIFMT_FORMAT_MASK` and
`SND_SOC_DAIFMT_MASTER_MASK` into `pcm512x_set_fmt()`. But it would be a
different scope, and I didn't intend to do that level of refactoring.
Looking at other codecs in kernel, I would say, that doing those checks in
`pcm512x_hw_params()`, as they are done currently, is an equally valid approach.

As technically keeping checs where they are now doesn't break anything, and is
aligned with ASoC codecs design, I suggest to keep the checks where they are.
Would you agree?

> I would also add DSP_A and DSP_B modes at the same time, DSP_A would
> need a write of 1 to register 41 (PCM512x_I2S_2, offset = 1), other
> formats should set the offset to 0.

That's a good idea, than you for technical details! I just didn't know how to
use DSP_A and DSP_B. I will add them, and submit as patch v2

Best regards,
Kirill

On 11/10/2020 07:59 AM, Peter Ujfalusi wrote:
> 
> 
> On 09/11/2020 23.21, Kirill Marinushkin wrote:
>> Currently, pcm512x driver supports only I2S data format.
>> This commit adds RJ and LJ as well.
>>
>> I don't expect regression WRT existing sound cards, because:
>>
>> * default value in corresponding register of pcm512x codec is 0 ==  I2S
>> * existing in-tree sound cards with pcm512x codec are configured for I2S
>> * i don't see how existing off-tree sound cards with pcm512x codec could be
>>   configured differently - it would not work
>> * tested explicitly, that there is no regression with Raspberry Pi +
>>   sound card `sound/soc/bcm/hifiberry_dacplus.c`
>>
>> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Matthias Reichl <hias@horus.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Cc: alsa-devel@alsa-project.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  sound/soc/codecs/pcm512x.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
>> index 8153d3d01654..c6e975fb4a43 100644
>> --- a/sound/soc/codecs/pcm512x.c
>> +++ b/sound/soc/codecs/pcm512x.c
>> @@ -1167,6 +1167,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
>>  	struct snd_soc_component *component = dai->component;
>>  	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
>>  	int alen;
>> +	int afmt;
>>  	int gpio;
>>  	int clock_output;
>>  	int master_mode;
>> @@ -1195,6 +1196,22 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
>>  		return -EINVAL;
>>  	}
>>  
>> +	switch (pcm512x->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +	case SND_SOC_DAIFMT_I2S:
>> +		afmt = PCM512x_AFMT_I2S;
>> +		break;
>> +	case SND_SOC_DAIFMT_RIGHT_J:
>> +		afmt = PCM512x_AFMT_RTJ;
>> +		break;
>> +	case SND_SOC_DAIFMT_LEFT_J:
>> +		afmt = PCM512x_AFMT_LTJ;
>> +		break;
>> +	default:
>> +		dev_err(component->dev, "unsupported DAI format: 0x%x\n",
>> +			pcm512x->fmt);
>> +		return -EINVAL;
>> +	}
>> +
> 
> The bus format and
> 
>>  	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> 
>>  	case SND_SOC_DAIFMT_CBS_CFS:
>>  		ret = regmap_update_bits(pcm512x->regmap,
> 
> the clock generation role should be set in pcm512x_set_fmt(), in that
> way you can deny specific setups earlier.
> 
> I would also add DSP_A and DSP_B modes at the same time, DSP_A would
> need a write of 1 to register 41 (PCM512x_I2S_2, offset = 1), other
> formats should set the offset to 0.
> 
>> @@ -1236,6 +1253,13 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
>>  		return ret;
>>  	}
>>  
>> +	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_1,
>> +				 PCM512x_AFMT, afmt);
>> +	if (ret != 0) {
>> +		dev_err(component->dev, "Failed to set data format: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>  	if (pcm512x->pll_out) {
>>  		ret = regmap_write(pcm512x->regmap, PCM512x_FLEX_A, 0x11);
>>  		if (ret != 0) {
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
