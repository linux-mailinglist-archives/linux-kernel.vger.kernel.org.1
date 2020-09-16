Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDEC26BE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIPHww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:52:52 -0400
Received: from smtp2.axis.com ([195.60.68.18]:24693 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgIPHwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=7655; q=dns/txt; s=axis-central1;
  t=1600242764; x=1631778764;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qnzjUMkLtB0F6GEDsOgQ5Eb/jJxGSDmoPsOmOe0g/TE=;
  b=PHrR+svWnx/PEG1qygjoTT8xqz2rsFRIMPZ5A6dZI1xD7bwg8jJQX//r
   1LwYg70x6m8jDVZ3EN4pL1o2OBbhnZdsOJj+s7jDm8Vbm6Y0L/bMEOVwG
   qHX5tVuSYQiBSWz6iPtTid8k8P1rSSQz9uhtYXCzcsGTsdYvhv6AEbH3e
   QNjY0IMci9VzOJO5DYQ3AesMoQrtoEuX+oLRJOWwmGAC0QRNnTwss4J3g
   7CNT/EVZJ1m1f+5HAHkbSXX7nT75/Zw0j1jynDXXuxSjtw8fEpBFu3OjV
   rz88hcv14MxGlxn+un0mD0OnSZiq2FJuIdw90Rwe1HLJTbCxKHDd+7pdB
   g==;
IronPort-SDR: hYhGIauaLyxFfyPDJFXuX/1rv8KOdoLpYITTSscQgGBCVyI5suR6gNGJiqi0gqWD6DOb8IXB7L
 sYnadlLJyUbm96zSwVWlii/Gqv00ClDixPwsSvtqBXbDE0evVB9SpuqsA94MB8k0MhLQV+sCkT
 3yQ16JiQlvOqib8HLSp6zfvf+JPbgrYR3SmiqYqDZbFV7JqyCKp+ia7E4out7xXK/jPWyimnH0
 egIRIWUxPDpK69wUXgKPsJzW8sniLFt4g0o0gQf9x7KGPObanHVKwEN2jQspZfi2LlFb9kKDBc
 nYM=
X-IronPort-AV: E=Sophos;i="5.76,432,1592863200"; 
   d="scan'208";a="12534492"
Subject: Re: [PATCH v2 3/3] ASoC: tlv320adcx140: Add proper support for master
 mode
To:     Dan Murphy <dmurphy@ti.com>, Camel Guo <Camel.Guo@axis.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
References: <20200911080753.30342-1-camel.guo@axis.com>
 <20200911080753.30342-3-camel.guo@axis.com>
 <c2fb617e-fa61-e9d1-449f-7d8806168b9a@ti.com>
From:   Camel Guo <camelg@axis.com>
Message-ID: <507f2f53-e236-f894-cb17-4fc84cf00326@axis.com>
Date:   Wed, 16 Sep 2020 09:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c2fb617e-fa61-e9d1-449f-7d8806168b9a@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX04.axis.com (10.0.5.18) To xbox06.axis.com
 (10.0.15.176)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please forget about this patch since Dan will upload a similar one.

@Dan, see my comment below.

On 9/15/20 8:50 PM, Dan Murphy wrote:
> Camel
> 
> On 9/11/20 3:07 AM, Camel Guo wrote:
>> From: Camel Guo <camelg@axis.com>
>>
>> Add setup of bclk-to-ws ratio and sample rate when in master mode,
>> as well as MCLK input pin setup.
>>
>> Signed-off-by: Camel Guo <camelg@axis.com>
>> ---
>>   v2:
>>    - Move GPIO setting into devicetree
>>    - Move master config register setting into a new function
>>
>>   sound/soc/codecs/tlv320adcx140.c | 139 ++++++++++++++++++++++++++++++-
>>   sound/soc/codecs/tlv320adcx140.h |  27 ++++++
>>   2 files changed, 162 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
>> index 97f16fbba441..685f5fd8b537 100644
>> --- a/sound/soc/codecs/tlv320adcx140.c
>> +++ b/sound/soc/codecs/tlv320adcx140.c
>> @@ -35,6 +35,7 @@ struct adcx140_priv {
>>        unsigned int dai_fmt;
>>        unsigned int tdm_delay;
>>        unsigned int slot_width;
>> +     bool master;
>>   };
>>   
>>   static const char * const gpo_config_names[] = {
>> @@ -651,11 +652,136 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
>>        return ret;
>>   }
>>   
>> +static int adcx140_fs_bclk_ratio(unsigned int bclk_ratio)
>> +{
>> +     switch (bclk_ratio) {
>> +     case 16:
>> +             return ADCX140_RATIO_16;
>> +     case 24:
>> +             return ADCX140_RATIO_24;
>> +     case 32:
>> +             return ADCX140_RATIO_32;
>> +     case 48:
>> +             return ADCX140_RATIO_48;
>> +     case 64:
>> +             return ADCX140_RATIO_64;
>> +     case 96:
>> +             return ADCX140_RATIO_96;
>> +     case 128:
>> +             return ADCX140_RATIO_128;
>> +     case 192:
>> +             return ADCX140_RATIO_192;
>> +     case 256:
>> +             return ADCX140_RATIO_256;
>> +     case 384:
>> +             return ADCX140_RATIO_384;
>> +     case 512:
>> +             return ADCX140_RATIO_512;
>> +     case 1024:
>> +             return ADCX140_RATIO_1024;
>> +     case 2048:
>> +             return ADCX140_RATIO_2048;
>> +     default:
>> +             break;
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static int adcx140_fs_rate(unsigned int rate)
>> +{
>> +     switch (rate) {
>> +     case 7350:
>> +     case 8000:
>> +             return ADCX140_8_OR_7_35KHZ;
>> +     case 14700:
>> +     case 16000:
>> +             return ADCX140_16_OR_14_7KHZ;
>> +     case 22050:
>> +     case 24000:
>> +             return ADCX140_24_OR_22_05KHZ;
>> +     case 29400:
>> +     case 32000:
>> +             return ADCX140_32_OR_29_4KHZ;
>> +     case 44100:
>> +     case 48000:
>> +             return ADCX140_48_OR_44_1KHZ;
>> +     case 88200:
>> +     case 96000:
>> +             return ADCX140_96_OR_88_2KHZ;
>> +     case 176400:
>> +     case 192000:
>> +             return ADCX140_192_OR_176_4KHZ;
>> +     case 352800:
>> +     case 384000:
>> +             return ADCX140_384_OR_352_8KHZ;
>> +     case 705600:
>> +     case 768000:
>> +             return ADCX140_768_OR_705_6KHZ;
>> +     default:
>> +             break;
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static int adcx140_setup_master_config(struct snd_soc_component *component,
>> +                                    struct snd_pcm_hw_params *params)
>> +{
>> +     int ret = 0;
>> +     struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
>> +
>> +     if (adcx140->master) {
> 
> Move this out to hw_params.  No reason to jump here just to jump back.
> 
> Check for master and if master then configure
> 
> This will eliminate the mixed code and variable declaration below which
> is what I wanted to avoid in v1.
> 
> This will also allow you to remove some of the variable initialization.
> 
>> +             u8 mst_cfg1 = 0;
>> +             u8 mst_cfg0 = 0;
> This can be init to mst_cfg0 = ADCX140_BCLK_FSYNC_MASTER no reason to
> set it here and then change it immediately.
>> +             unsigned int bclk_ratio;
>> +
>> +             mst_cfg0 = ADCX140_BCLK_FSYNC_MASTER;
>> +             if (params_rate(params) % 1000)
>> +                     mst_cfg0 |= ADCX140_FSYNCINV_BIT; /* 44.1 kHz et al */
>> +
>> +             ret = adcx140_fs_rate(params_rate(params));
>> +             if (ret < 0) {
>> +                     dev_err(adcx140->dev, "%s: Unsupported rate %d\n",
>> +                                     __func__, params_rate(params));
>> +                     return ret;
>> +             }
>> +             mst_cfg1 |= ret;
> Why the | here?  This is initialized to 0 so mst_cfg1 = ret. And why
> even use ret just return into mst_cfg1 and check that variable
>> +
>> +             /* In slave mode when using automatic clock configuration,
>> +              * the codec figures out the BCLK to FSYNC ratio itself. But
>> +              * here in master mode, we need to tell it.
>> +              */
>> +
>> +             bclk_ratio = snd_soc_params_to_frame_size(params);
>> +             ret = adcx140_fs_bclk_ratio(bclk_ratio);
>> +             if (ret < 0) {
>> +                     dev_err(adcx140->dev, "%s: Unsupported bclk_ratio %d\n",
>> +                                     __func__, bclk_ratio);
>> +                     return ret;
>> +             }
>> +             mst_cfg1 |= ret;
>> +
>> +             snd_soc_component_update_bits(component, ADCX140_MST_CFG1,
>> +                             ADCX140_FS_RATE_MSK |
>> +                             ADCX140_RATIO_MSK,
>> +                             mst_cfg1);
> 
> I don't understand the update_bits since you have calcualted both the
> Ratio and rate you can just write the register with the
> snd_soc_component_write.
> 
>> +
>> +             snd_soc_component_update_bits(component, ADCX140_MST_CFG0,
>> +                             ADCX140_FSYNCINV_BIT |
>> +                             ADCX140_BCLK_FSYNC_MASTER,
>> +                             mst_cfg0);
>> +
> 
> But this is ok.  I actually have other changes I am posting which move
> this to the set_dai_format.  So I am not sure if this will be needed
> after that patch is applied.

Maybe I can just wait for your patch. If it can make master mode work, 
there is no need for me to work on this one.

> 
> I will CC you on those patches.
> 
> Dan
