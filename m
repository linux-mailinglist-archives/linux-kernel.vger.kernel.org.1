Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92692FE8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbhAULhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbhAULgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:36:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093EDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:35:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g10so1399472wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rc71x9TS71KaH+vBTC5IHCDnRNTPkNtiIqNh/exWqsc=;
        b=R1qMmimUh7xC7DTZFuC+wrgnkfUadRgEtVRdWS97cBihtkTL0p6Pz91WiHk8LHLB6S
         PE+OugPoFtk8BRQkOCZkT4YxuBkO9+dsr1dGur+xUbhJqPJVePDdffv9DbNgMxGw9yJc
         YPde5ZpM3qpRDCdF4nc1g3o1g1PorW4zee8HYOKbLqJuMPa63kX74aqqCthpHGlfNYmD
         sCqP9iLniEJKGxZ3Qkv4BTxeyTe2geLvKJ24vsg6gFaloOOjqHrdA58XFqFzSBBh2oaQ
         lV1jAslAEv66rP6oSvJN5ataFUbsPXU/4jZjAlXL4MsJQg0dsUsk7abHF0U/16H/sIID
         P4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rc71x9TS71KaH+vBTC5IHCDnRNTPkNtiIqNh/exWqsc=;
        b=ecVsRKFVSgFmiDNoXcenebXElFrTuyi9thGYFLQzC2bh6R6v/x2KrEQwFqgp+mh5Vt
         rN5E6pZvxHJ0WQEQI/5XKExa8SIkJjvbC08NyIk1LoNZjijOTFot+T3E89Y8mqz5YFES
         vVPU7Wb2hMUTrYdkfV/iKAbYEMik0kVyzqNVv4Zi1fyucNH6RQkGw8xu8O2y5Kz+jhN4
         9XGjNj8ThERAp4NKNU170dB9sgze9wQlPzm0hkUcBRKbq9L52ElsdUiRj9EDbW8E51Dj
         ewPRgaUTnX6oRMxIrhnz5FCqFXBftoNqxebobwun/lzw9hNeaEu9dP7DsSJZYtnnfJXO
         xfNA==
X-Gm-Message-State: AOAM533Cm1Htv1cYT4gjyWpfrmW0PNBcbfUr2CCI/PhuGRWi3E9ALuBP
        Fv0cgfp74Nay+034CmCYS7wk3ViqWNTIvQ==
X-Google-Smtp-Source: ABdhPJwMfLdUylIRf3XEW6U838QeBvWhs6H60c51uU1QwoGmMEvGxunqPML5U9E1+K4/lo+dTDTuoA==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr1362292wrq.196.1611228922477;
        Thu, 21 Jan 2021 03:35:22 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id s25sm9392026wrs.49.2021.01.21.03.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:35:21 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, gregkh@linuxfoundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
 <20210120180110.8357-2-srinivas.kandagatla@linaro.org>
 <fcc1b199-644d-8c7f-5e8b-d12b0d9c9a04@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0a2bbbe5-821a-34dd-e893-fef42baaad2b@linaro.org>
Date:   Thu, 21 Jan 2021 11:35:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fcc1b199-644d-8c7f-5e8b-d12b0d9c9a04@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for your inputs,

On 20/01/2021 22:15, Pierre-Louis Bossart wrote:
> 
> 
> On 1/20/21 12:01 PM, Srinivas Kandagatla wrote:
>> Some of the soundwire controllers can have static functions assigned
>> to each port, like some ports can only do PCM or PDM. This is the 
>> situation
>> with some of the Qualcomm Controllers.
>>
>> In such cases its not correct to assign/map any free port on master
>> during streaming.
>>
>> So, this patch provides a way to pass mapped port number along
>> with the port config, so that master can assign correct ports based
>> on the provided static mapping.
> 
> I am not sure I understand the problem or what's different between Intel 
> and Qualcomm.
> 
> On the Intel side we also have fixed-function ports, some for PDM and 
> some for PCM. They are not interchangeable, and they are also dedicated 
> for each link.
> 
That is good to know!

> We don't dynamically allocate ports on the master side, the mapping is 
> defined by the dai->id and is static. There is a 1:1 relationship 
> between dai->id and port_number. See intel_register_dai() and 
> intel_hw_params() in drivers/soundwire/intel.c
> 
> In the machine driver we make use of specific master DAIs in the dailink 
> definitions, just like regular ASoC solutions, so which DAIs you use in 
> the machine driver defines what ports end-up being used. There is 
> nothing fancy or dynamic here, the dai/port allocation is defined by the 
> dailinks. This is a static/worst-case allocation, we don't reassign 
> ports depending on use-cases, etc.
> 
> The only thing that is dynamic is that the programming of each port is 
> handled based on the bandwidth needs of that port, i.e if you play 16 or 
> 24 bits you'd get fewer or more bitSlots allocated to that dai/port, and 
> the DPn registers are updated if you have concurrent streaming on other 
> ports. If you only have a fixed set of payloads, as in the existing 
> amplifier cases, you can hard-code this allocation as well.
Yes, it will work for the existing WSA881x amplifier case.

Am preparing patches for a new QCOM codec driver WCD938x (TX and RX) 
connected via Soundwire,

Port allocations are something like this:

RX: (Simple)
Port 1 -> HPH L/R
Port 2 -> CLASS H Amp
Port 3 -> COMP
Port 4 -> DSD.

TX: (This get bit more complicated)
Port 1: PCM
Port 2: ADC 1 & 2
Port 3: ADC 3 & 4
Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7

We handle the port allocation dynamically based on mixer and dapm 
widgets in my code! Also channel allocations are different for each 
function!

> 
> Does this help and can you align on what Intel started with?

Firstly, This is where the issue comes, if we go with the 
suggested(dai->id) solution, we would end up with a long list of 
dai-links with different combinations of both inputs/output connections 
and usecases. Again we have to deal with limited DSP resources too!

Secondly, The check [1] in stream.c will not allow more than one master 
port config to be added to master runtime. Ex: RX Port 1, 2, 3 is used 
for Headset Playback.

But if we have a static mapping table of the ports then this will 
provide more flexibility to codec driver! And we can dynamically select 
ports based on the usecase or active dapm path!

--srini

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soundwire/stream.c?h=v5.11-rc4#n1294
> 
