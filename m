Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C162FEF39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbhAUPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733104AbhAUPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:42:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:41:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c124so1839674wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yYkGSQxEuVHgVYqPR33Yj58TultHi9vTZtbAI8y9az4=;
        b=onBsKdxvVavssmI8rA12b808rcLn2XtCSJgb41Bvl3//4pD0tRiSupygejhTlK+hlh
         j8L4A6ZdO1pmgDaoCAm12y2CEHVGnUUbZyo/OK8LYp35ILcxLpTwrl69zTc12m6T7BaW
         Zxf7phQdRPfMN/MmQBby9qMcW4ljpqsE2kTU1/ThZz9ZgrR4Rw/qM0PEMSQbpp4DCK1C
         7h3lvVRqTV4qJPygVo4iuwD3ZobeCdmTtlC0C1vezn8rOy6xOBAhoPEMw1ctenF8wDZ/
         /mocORrCmSeDuiQgPYSQr/ZtbXbjFdeHoV7Hl9bjHLYWdf5F9J+A+j4DzWMt5X5WDJLS
         WN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yYkGSQxEuVHgVYqPR33Yj58TultHi9vTZtbAI8y9az4=;
        b=FReMHoH09Z7PbqcCvQnpdjMifG1igtyG4CZKzzqlOhPJ7H9IwdLjzEbJ3oWTorC3NT
         T9FRHXPnADmJ2gCjS/4AqLfOHS5m+KZ25mcRMvQDe4kcmQunk68FbYxQuRzEDmzptY6t
         CFI+sIfQadIzrxhSix9WHO7vMNiXVcPj9tiDLNXEJ5sLYMcj8mdP3b6orFPxNYMTp/vX
         t9GLBA6ZGccldnRKAzXC2kfUwQXryYnSMd+52DiW1IQDrgg0y/F37lfCmCOC/H5wtBlT
         /jczGQIs5W64mQSoCgJNxwxNGMqlyVge+wnzfVyYxTxnsdi/332/wiGEeL+PV0WgFNiu
         c3gw==
X-Gm-Message-State: AOAM533RDz40fLjtp180z2FJKxcITEwrqq8A3zl2sDrycUi9UDbfeiqD
        fgJwcXkzzbIINcDTanPDJByJvONqY90/zw==
X-Google-Smtp-Source: ABdhPJzFImVwxFfXZaO5auJux/Yh75i+5b++ELZ9n6+/zSvtapYTTlq6W1J+hTLH4w0FVli7+5ex/w==
X-Received: by 2002:a1c:e055:: with SMTP id x82mr8433273wmg.185.1611243685461;
        Thu, 21 Jan 2021 07:41:25 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id t67sm8814444wmt.28.2021.01.21.07.41.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 07:41:24 -0800 (PST)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
Date:   Thu, 21 Jan 2021 15:41:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2021 14:56, Pierre-Louis Bossart wrote:
> 
> 
>> Port allocations are something like this:
>>
>> RX: (Simple)
>> Port 1 -> HPH L/R
>> Port 2 -> CLASS H Amp
>> Port 3 -> COMP
>> Port 4 -> DSD.
>>
>> TX: (This get bit more complicated)
>> Port 1: PCM
>> Port 2: ADC 1 & 2
>> Port 3: ADC 3 & 4
>> Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
>> Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7
>>
>> We handle the port allocation dynamically based on mixer and dapm 
>> widgets in my code! Also channel allocations are different for each 
>> function!
> 
> Sorry, I am not following here. What is dynamic here and use-case 
> dependent? And is this a mapping on the master or the codec sides that 
> you want to modify?

[SLAVE]-------[MASTER]
NA-------------Port 1: PCM
Port 1---------Port 2: ADC 1 & 2
Port 2---------Port 3: ADC 3 & 4
Port 3---------Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
Port 4---------Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7


Mapping is still static however Number of ports selection and channel 
mask will be dynamic here.


Example: for Headset MIC usecase we will be using Slv Port1, Slv Port3 
along with Mstr Port2 and Master Port4

Similarly for usecases like Digital MIC or other Analog MICs.


> 
>>> Does this help and can you align on what Intel started with?
>>
>> Firstly, This is where the issue comes, if we go with the 
>> suggested(dai->id) solution, we would end up with a long list of 
>> dai-links with different combinations of both inputs/output 
>> connections and usecases. Again we have to deal with limited DSP 
>> resources too!
>>
>> Secondly, The check [1] in stream.c will not allow more than one 
>> master port config to be added to master runtime. Ex: RX Port 1, 2, 3 
>> is used for Headset Playback.
> 
> I am confused here, we do have examples in existing codec drivers where 
> we use multiple ports for a single stream, e.g. for IV feedback we use 2 
> ports.

Is this on multi_link? which is why it might be working for you.

> 

Currently we have below check in sdw_stream_add_master().

if (!bus->multi_link && stream->m_rt_count > 0) {
	dev_err(bus->dev, "Multilink not supported, link %d\n", bus->link_id);
	ret = -EINVAL;
	goto unlock;
}

If we have single master(like my case) and dai-links which have more 
then one port  will be calling  sdw_stream_add_master() for each port, 
so m_rt_count above check will fail for the second call!



> In your "RX Port 1, 2, 3" example, are you referring to the codec or the 
> master side? If it's for the codec, it's already supported, see e.g. 

Master side.

> https://github.com/thesofproject/linux/pull/2514, we use DP2 and DP4 for 

This fine on slave side! Issue is on the master side!

> the same stream. This is done with the port_config capability.
> 
> 
