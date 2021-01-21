Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5A2FF3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAUS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbhAUSmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:42:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A1C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:41:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m1so2061991wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1LZdJjGc48/gwLzyAgp0Q9hkzPKTZ92XadLVHIdNeus=;
        b=UD6zT62AGvo2fkoK8hEZH4D0yvQgJfrJUmPrHfaow3f8ai0CV5F14TRdrLUrfrHfS7
         tPT8wNAqsCD3dlFHt+lylV23YroI4y+uWBeBXFoYbmLfQKRevZWiiMSH+CQNHC7+DLG6
         CE3WJtsuxOSURAXoqqTtb3rewX+RZc/LBapifzI5lT60egICl9V23Px7ajkNaxOoiLYx
         PXh+4RRQrMYgDm/Y6uQyMngL143bihRL75rMmJdqX/868pLucWFY44PqNBiEaYuZ3RSy
         VsUuFz+6IqAIpYO5AJLAnKnDKlDY0E6aeKB14S6wICxCQXWNiugvnxtN6DLUtmTRC45c
         J6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LZdJjGc48/gwLzyAgp0Q9hkzPKTZ92XadLVHIdNeus=;
        b=Cppl9hn0gxgGKEcQcAJF4lpmtuoGf3T9j1nmeGowpVba0RW4JZ/0Ypmy/+3x9qE1Vl
         lac9NBZaUareA/9AiE60I/eu4ZwM4Z6r0Ez3HuvG47/FLCjNEh35VBRgqwdnSv7jAAUq
         Z5B3kNQxll6pqsQG9MnCagEwUQb+g0M13pii7FCcJ61UlLkD6v6ht+3ZRTaMgKONs7yz
         98coasYU+y1L3r4aBOAkyu2F9sQrBpXWTHKNCFhN7YBvNwkRropN/pKJbH5CfbEkeJrz
         o6cJXx9F+ApV/rTdW7v6hrZsqK+ZjM/FEVlhihY2eV5OX9f9fLTAHJiEGXY37tx1GZyI
         nT8g==
X-Gm-Message-State: AOAM530MNm1H4uI5va9KkvIyIC5XkP5w1IxviBswWFPPe/SHIYsDge/1
        BiKFEiEA1n6MA0NxnmWOqnAxVdVKTmObJA==
X-Google-Smtp-Source: ABdhPJx8D0CkZqme6uOFhWSz66F7vNTs1DfA97Uneyp1dieL6ivNfdJxzmiwg5skCfOhlEJAyKj4Ew==
X-Received: by 2002:a5d:4241:: with SMTP id s1mr788988wrr.269.1611254491953;
        Thu, 21 Jan 2021 10:41:31 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g192sm9878730wmg.18.2021.01.21.10.41.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 10:41:31 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     gregkh@linuxfoundation.org, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
 <20210120180110.8357-2-srinivas.kandagatla@linaro.org>
 <fcc1b199-644d-8c7f-5e8b-d12b0d9c9a04@linux.intel.com>
 <0a2bbbe5-821a-34dd-e893-fef42baaad2b@linaro.org>
 <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
 <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
 <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
Date:   Thu, 21 Jan 2021 18:41:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2021 18:00, Pierre-Louis Bossart wrote:
> 
> 
> On 1/21/21 9:41 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 21/01/2021 14:56, Pierre-Louis Bossart wrote:
>>>
>>>
>>>> Port allocations are something like this:
>>>>
>>>> RX: (Simple)
>>>> Port 1 -> HPH L/R
>>>> Port 2 -> CLASS H Amp
>>>> Port 3 -> COMP
>>>> Port 4 -> DSD.
>>>>
>>>> TX: (This get bit more complicated)
>>>> Port 1: PCM
>>>> Port 2: ADC 1 & 2
>>>> Port 3: ADC 3 & 4
>>>> Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
>>>> Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7
>>>>
>>>> We handle the port allocation dynamically based on mixer and dapm 
>>>> widgets in my code! Also channel allocations are different for each 
>>>> function!
>>>
>>> Sorry, I am not following here. What is dynamic here and use-case 
>>> dependent? And is this a mapping on the master or the codec sides 
>>> that you want to modify?
>>
>> [SLAVE]-------[MASTER]
>> NA-------------Port 1: PCM
>> Port 1---------Port 2: ADC 1 & 2
>> Port 2---------Port 3: ADC 3 & 4
>> Port 3---------Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
>> Port 4---------Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7
>>
>>
>> Mapping is still static however Number of ports selection and channel 
>> mask will be dynamic here.
>>
>>
>> Example: for Headset MIC usecase we will be using Slv Port1, Slv Port3 
>> along with Mstr Port2 and Master Port4
>>
>> Similarly for usecases like Digital MIC or other Analog MICs.
> 
> Sorry, I must be thick here, but in my experience the choice of Digital 
> or analog mics is a hardware design level not a use-case one. Using ADC 
> 1 & 2 at the same time as DMICs is very surprising to me. You'd have 
> different sensitivities/performance, not sure how you would combine the 
> results.

In this particular case, ADC2 on Port2 is used along with the MBHC(Multi 
Button and Headset Detection) channel on Master Port4. This is intended 
for Headset Button Click Suppression!. This again can be  dynamically 
selected based on if headset button Click Suppression is enabled or not.

So this is not really mixing ADC with DMICs here!


> 

> I also don't see how a headset mic can both use Analog and digital, 
> unless we have a different definition of what a 'headset' is.
> 
>>>>> Does this help and can you align on what Intel started with?
>>>>
>>>> Firstly, This is where the issue comes, if we go with the 
>>>> suggested(dai->id) solution, we would end up with a long list of 
>>>> dai-links with different combinations of both inputs/output 
>>>> connections and usecases. Again we have to deal with limited DSP 
>>>> resources too!
>>>>
>>>> Secondly, The check [1] in stream.c will not allow more than one 
>>>> master port config to be added to master runtime. Ex: RX Port 1, 2, 
>>>> 3 is used for Headset Playback.
>>>
>>> I am confused here, we do have examples in existing codec drivers 
>>> where we use multiple ports for a single stream, e.g. for IV feedback 
>>> we use 2 ports.
>>
>> Is this on multi_link? which is why it might be working for you.
> 
> no, this is done at the codec driver level, which has no notion of 
> multi-link. we pass a port_config as a array of 2.
> 

Am referring to sdw_stream_add_master() not sdw_stream_add_slave().

>> Currently we have below check in sdw_stream_add_master().
>>
>> if (!bus->multi_link && stream->m_rt_count > 0) {
>>      dev_err(bus->dev, "Multilink not supported, link %d\n", 
>> bus->link_id);
>>      ret = -EINVAL;
>>      goto unlock;
>> }
>>
>> If we have single master(like my case) and dai-links which have more 
>> then one port  will be calling  sdw_stream_add_master() for each port, 
>> so m_rt_count above check will fail for the second call!
> 
> if you use multiple ports in a given master for the same stream, you 
> should have the m_rt_count == 1. That's a feature, not a bug.
> 
> A port is not a stream... You cannot call sdw_stream_add_master() for 
> each port, that's not what the concept was. You allocate ONE master_rt

Am looking at intel_hw_params(). Isn't sdw_stream_add_master() called 
for every dai in the dai link.

> per master, and that master_rt deals with one or more ports - your choice. >
> A 'stream' is an abstract data transport which can be split across 
> multiple masters/sales and for each master/slave use multiple ports.
> When calling sdw_stream_add_master/slave, you need to provide a 
> port_config/num_ports to state which ports will be used on that 
> master/slave when using the stream. That's how we e.g. deal with 4ch 
> streams that are handled by two ports on each side.
> 
> To up-level a bit, the notion of 'stream' is actually very very similar 
> to the notion of dailink. And in fact, the 'stream' is actually created 
> for Intel in the dailink .startup callback, so I am quite in the dark on 
> what you are trying to accomplish.
In qcom case stream is also allocated for in dai startup().

I think we are talking about two different issues,

1>one is the failure I see in sdw_stream_add_master() when I try to use 
dai-link dai-id style approach suggested. I will dig this bit more and 
collect more details!

2>(Main issue) Ability for slave to select different combination of 
ports at runtime based on the mixer setting or active dapm.

All this patch is trying do is the pass this *CURRENT/ACTIVE* static 
port mapping between slave and master while setting up the stream.
With the dailink approach number of ports are pretty much static and may 
not be required for particular use case. As above example if we have a 
headset with button click suppression we would need 2 Ports and 
similarly without we only need one port.

This is not possible with dai-link approach, unless we create two 
different dai links for the above example usecase!

Hopefully this adds some light to the issue :-)

--srini
