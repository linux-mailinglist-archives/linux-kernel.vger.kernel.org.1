Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E794B262CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 12:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIKIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 06:08:30 -0400
Received: from smtp1.axis.com ([195.60.68.17]:3172 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIIKI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2483; q=dns/txt; s=axis-central1;
  t=1599646106; x=1631182106;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=g2QYr+BMBmVaXPE2srsqIOZIyAARlYjQfVHq31MwHR4=;
  b=EDRi3iFh0OZA8beq6rz8fEis7gb2Aa7o3cW+NfCSFpyF4P8CGVaKNCI4
   R/jo6gKeQ9oyPxw7TkbKVzeD5AJxXdsXrYVy+zsiVF5SMOE5zqUrIVYsL
   O6BbVm/+z+M2TqoQkeC31oyM1IKnt2IWaYLzwaxWjmOQw1yyAhbgelHdw
   TTb7ET5xFniZSF8Lm6odVx5nNsqilhaBem5qItSXnuSXxisU7w1o28TE8
   6zR40DbMUNiJXfY+U2paeVSGHCq/IUV87sQCyjoB9baHOyx55cJ1I7Aa5
   TM/8JqgDC0kPF/5dLngQbcn12IK5JAb1TJVhFAuceI7snZyfRruPIXr7b
   A==;
IronPort-SDR: 475Vczdz9GQmpwzIY5NB8KFVohnG7JSYz5NeXuueYvQpeaA5tEuv7l74yZU7TvrRrmBIlVXs0I
 RtQ0hp3nlQkN8GwtYYOTQLMhO6gEtS61VtE4luhg/rkkemwmXRRPJZ5jirazutySmf7hLoIVF0
 rdqvjCyd+0vTL1hz7U8uuAT4Q3kRIbV5KnvFzPR0vEwqQ2Hs0pwrWfrnm3PfJ6HCOU/Riy+1ds
 uLl5HI2gh+lklLyShvInYA2IojYQW4LVFhNQizLywQBcuakh7tX2Yc7bpfGm5I5fomx5fhCFL/
 NII=
X-IronPort-AV: E=Sophos;i="5.76,409,1592863200"; 
   d="scan'208";a="12709850"
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid
 gpio_reset
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Camel Guo <Camel.Guo@axis.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "dmurphy@ti.com" <dmurphy@ti.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200908083521.14105-1-camel.guo@axis.com>
 <7bb93489-dbd5-d1a5-5df6-e62470bd2252@ti.com>
 <e791162b-1292-e1c4-3fca-b8936beeeb45@ti.com>
From:   Camel Guo <camelg@axis.com>
Message-ID: <629c8afb-3feb-54c6-162e-4addb3c85908@axis.com>
Date:   Wed, 9 Sep 2020 12:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e791162b-1292-e1c4-3fca-b8936beeeb45@ti.com>
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

Hi Peter,

Thanks for your comment. I will make a new one like what you said.

On 9/8/20 2:03 PM, Peter Ujfalusi wrote:
> Hi,
> 
> On 08/09/2020 14.59, Peter Ujfalusi wrote:
>> 
>> 
>> On 08/09/2020 11.35, Camel Guo wrote:
>>> From: Camel Guo <camelg@axis.com>
>>>
>>> When gpio_reset is not well defined in devicetree, the
>>> adcx140->gpio_reset is an error code instead of NULL. In this case,
>>> adcx140->gpio_reset should not be used by adcx140_reset. This commit
>>> sets it NULL to avoid accessing an invalid variable.
>>>
>>> Signed-off-by: Camel Guo <camelg@axis.com>
>>> ---
>>>  sound/soc/codecs/tlv320adcx140.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
>>> index 7ae6ec374be3..597dd1062943 100644
>>> --- a/sound/soc/codecs/tlv320adcx140.c
>>> +++ b/sound/soc/codecs/tlv320adcx140.c
>>> @@ -984,8 +984,10 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
>>>  
>>>       adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
>>>                                                     "reset", GPIOD_OUT_LOW);
>>> -    if (IS_ERR(adcx140->gpio_reset))
>>> +    if (IS_ERR(adcx140->gpio_reset) || adcx140->gpio_reset == NULL) {
>>>               dev_info(&i2c->dev, "Reset GPIO not defined\n");
>>> +            adcx140->gpio_reset = NULL;
>> 
>> the correct fix is to:
>>        dev_err(&i2c->dev, "Reset GPIO not defined\n");
> 
> no need to print, I think gpio core will do that.
> 
>>        return PTR_ERR(adcx140->gpio_reset);
>> 
>> If the reset GPIO is specified and you get error when requesting it as
>> optional, there is a reason for that.
>> For example deferred probing.

I agree! Please ignore this patch and I will make a new one like this.

>> 
>>> +    }
>>>  
>>>       adcx140->supply_areg = devm_regulator_get_optional(adcx140->dev,
>>>                                                          "areg");
>>>
>> 
>> - Péter
>> 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>> 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
