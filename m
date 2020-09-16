Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1190B26C4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIPPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIPPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C64DC02C295
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:33:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so7323378wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rp1wZY8BVBrn0y92Gv56FCXxt2z7x+n79Dv0r+y6bVE=;
        b=NSwB7tHGxZJCPjtpDxpWqrHBlcSKJ0qycbhaKRGrWzh/3n12dDGP0GqRJoHwkOUUsB
         Flh/XBMhfA/8BxLkeBncfwROM8DtZsJcgUdP+dmydro5vCEQ8PHEmFU4hLoIsJ2oE5iz
         jnmmda5nmpvWA/TzZ/IcaDfBzd+LuhwEOPX6jKRO/UFqRIBOGvQSNxRNj2THfMdoHeLg
         bbmNb1gv1BKKWb0E3guPLkhjYNiulb1XMqKN550suBbwEwlh61HFZO3mt9NGWdvml+Va
         FUtM4J0H4YRlDKmpHhMKpvCohl1TszfGwGTMHZo+M0YLbktEig13a8t13e7JJ4J5Rlgx
         Z9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rp1wZY8BVBrn0y92Gv56FCXxt2z7x+n79Dv0r+y6bVE=;
        b=L+Jw2SVmUv4K1Acq2YMWltKVUXczM3zGybCXjNoskefqBshEhbo5LcxvFZybWEmmzR
         /i+aBMIZhN5W6moVSniZdNvsAX9RV8zxZb+8FdEWvipzkmTfpztabuWu6FruXmO/M+bv
         3rnQhm0pQ/cDCxudG4r9iS/Ca0yjYgu8DauYA9ZQMb+TE6VNtGUlcpnPLPBKhZilpnzo
         jwcowoJxj9yxmfTdp4qCjFdN8kPd/JiKTBZhbPVvIngVM+7NoUtEGkcB07gyPTpJbVbO
         2Me3/1yAsCRtFquBJZnjA/PkM9cRvLmXvPc9V8Rt23GO3Xfpxt35HLVH9G1ak+pYv5mZ
         BIvQ==
X-Gm-Message-State: AOAM533OvOe9bq14Cmx9A0QeuJP9A2oRmQm29h8/RRBvVHjyXkSq/EZ7
        7D2xEQ02fEIay/pmzIv6GsI+RNrZKKwemQ==
X-Google-Smtp-Source: ABdhPJyxBjbhOzSWAljX7lEw5mYidrPfuxQlMPxfcM+QiRhRCtXd4wsSvs4LaBDMxhzrXTIPOFafpw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr27297986wrp.298.1600270430632;
        Wed, 16 Sep 2020 08:33:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id i16sm33704929wrq.73.2020.09.16.08.33.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 08:33:49 -0700 (PDT)
Subject: Re: [PATCH] bitfield.h: annotate type_replace_bits functions with
 __must_check
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     davem@davemloft.net, vkoul@kernel.org, linux-kernel@vger.kernel.org
References: <20200916150333.11790-1-srinivas.kandagatla@linaro.org>
 <20200916152059.GA3018065@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <66657ed6-b8ef-7e8d-b77c-9fd65453f53e@linaro.org>
Date:   Wed, 16 Sep 2020 16:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200916152059.GA3018065@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/09/2020 16:20, Greg KH wrote:
> On Wed, Sep 16, 2020 at 04:03:33PM +0100, Srinivas Kandagatla wrote:
>> usage of apis like u32_replace_bits() without actually catching the return
>> value could hide problems without any warning!
>>
>> Found this with recent usage of this api in SoundWire!
>> Having __must_check annotation would really catch this issues in future!
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   include/linux/bitfield.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>> index 4e035aca6f7e..eb4f69253946 100644
>> --- a/include/linux/bitfield.h
>> +++ b/include/linux/bitfield.h
>> @@ -131,7 +131,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
>>   		__field_overflow();					\
>>   	return to((v & field_mask(field)) * field_multiplier(field));	\
>>   }									\
>> -static __always_inline __##type type##_replace_bits(__##type old,	\
>> +static __always_inline __must_check __##type type##_replace_bits(__##type old, \
>>   					base val, base field)		\
>>   {									\
>>   	return (old & ~to(field)) | type##_encode_bits(val, field);	\
>> -- 
>> 2.21.0
>>
> 
> Don't add __must_check to things that if merged will instantly cause
> build warnings to the system, that's just rude :(
Currently there are not many users for this api, found only one instance 
in drivers/net/ipa/ipa_table.c which is also fixed with 
https://lkml.org/lkml/2020/9/10/1062

> 
> Fix up everything first, and then try to make this type of change.
> 
> But why does this function have to be checked?
As this function would return updated value, this check is more to with 
using the return value!

It is easy for someone to ignore this return value assuming that the new 
value is already updated! So this check should help!

TBH, This is what happened when we(vkoul and me) tried use this api :-)

--srini

> 
> thanks,
> 
> greg k-h
> 
