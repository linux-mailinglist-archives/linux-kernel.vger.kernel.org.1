Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF18300776
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbhAVPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:36:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:38995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbhAVPeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:34:46 -0500
IronPort-SDR: xzewRl/+wd4V9WETPi3IhfozB+/Zy6YzRlRrPJjK1MBaGJLJRjaHesU0z8IZKUGy4FXPfMJWLb
 uwjakBojdVSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="175948174"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="175948174"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:33:01 -0800
IronPort-SDR: c6CMTh6GIjd71turua9AZMpzbR8aORsNaKtA5Vo1r0rUmxVuqR9CvJbGcMpVuBYg/+oOEufnoG
 ayjyzQ6GHdgg==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="428000291"
Received: from cdgarci1-mobl1.amr.corp.intel.com (HELO [10.212.60.15]) ([10.212.60.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:33:00 -0800
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
 <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
 <eaf13d70-86fe-3e18-7a5a-4043f2d8a22d@linux.intel.com>
 <aaf34f07-5eed-3045-e4c6-dc9416689b20@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
Date:   Fri, 22 Jan 2021 09:32:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aaf34f07-5eed-3045-e4c6-dc9416689b20@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/21 1:05 AM, Srinivas Kandagatla wrote:
> 
> 
> On 21/01/2021 21:30, Pierre-Louis Bossart wrote:
>>>
>>> Am looking at intel_hw_params(). Isn't sdw_stream_add_master() called 
>>> for every dai in the dai link.
>>
>> Yes, that's correct, but again a dai may use one or more ports.
>>
>> if you defined each port as a dai, and want to call 
>> sdw_stream_add_master() for each port you are doing something the API 
>> was not designed for. There is a 'num_ports' argument for a reason :-)
>>
>>>> per master, and that master_rt deals with one or more ports - your 
>>>> choice. >
>>>> A 'stream' is an abstract data transport which can be split across 
>>>> multiple masters/sales and for each master/slave use multiple ports.
>>>> When calling sdw_stream_add_master/slave, you need to provide a 
>>>> port_config/num_ports to state which ports will be used on that 
>>>> master/slave when using the stream. That's how we e.g. deal with 4ch 
>>>> streams that are handled by two ports on each side.
>>>>
>>>> To up-level a bit, the notion of 'stream' is actually very very 
>>>> similar to the notion of dailink. And in fact, the 'stream' is 
>>>> actually created for Intel in the dailink .startup callback, so I am 
>>>> quite in the dark on what you are trying to accomplish.
>>> In qcom case stream is also allocated for in dai startup().
>>>
>>> I think we are talking about two different issues,
>>>
>>> 1>one is the failure I see in sdw_stream_add_master() when I try to 
>>> use dai-link dai-id style approach suggested. I will dig this bit 
>>> more and collect more details!
>>>
>>> 2>(Main issue) Ability for slave to select different combination of 
>>> ports at runtime based on the mixer setting or active dapm.
>>>
>>> All this patch is trying do is the pass this *CURRENT/ACTIVE* static 
>>> port mapping between slave and master while setting up the stream.
>>> With the dailink approach number of ports are pretty much static and 
>>> may not be required for particular use case. As above example if we 
>>> have a headset with button click suppression we would need 2 Ports 
>>> and similarly without we only need one port.
>>
>> As I said above you cannot enable the button click suppression 
>> dynamically *after* the headset capture hw_params/prepare.
> 
> That is not true, the ports in this case are selected based on mixer 
> setting or register state even before stream is setup/started in 
> hw_params/prepare.
> WSA881x codec has pretty much similar setup.

we are saying the same thing, the configuration provided is only taken 
into account when setting-up the stream in hw_params. mixer or 
configuration changes after that step are ignored.

If you follow what we've done at Intel with the sdw_stream_add_master() 
called in the .hw_params phase, and conversely call 
sdw_stream_remove_master() in .hw_free, you should be good to go.

You will note that we have a notification to the DSP, so you can manage 
resources in your firmware, there is no need to oversubscribe but only 
allocate what is required for a given use case.

>>> This is not possible with dai-link approach, unless we create two 
>>> different dai links for the above example usecase!
>>
>> The current approach is a worst-case one, where you would create a 
>> single 'headset capture' dailink.
>>
> 
> Are you suggesting that we have dailink for each usecase like:
> 
> "headset capture"
> "Analog MIC1 capture"
> "Analog MIC2 Capture"
> 
> ...
> 
> "Analog MIC4 Capture"
> 
> ...
> 
> "DMIC0 capture"
> "DMIC1 Capture"
> "DMIC2 Capture"
> 
> ...
> 
> "DMIC7 Capture"
> ..
> "Headset Playback"
> "Ear Playback"
> ..
> "Aux Playback"
> ...
> 
> this is not really doable!

No, what I was saying is that you need to define multiple streams e.g.
- headset capture (configured with or without click suppression)
- mic capture (configured with AMICs or DMICs)
- playback (or possibly different endpoint specific streams depending on 
whether concurrency between endpoint is possible)

if you change the configuration, you have to tear down the stream and 
reconfigure it - and for this we already have the required API and you 
can guarantee that the configuration for that stream is consistent 
between master and slave(s).

> All am saying is that codec can decide which ports it has to select 
> based on mixer setting before the stream is setup/started. This updated 
> mapping between slv port and master ports is passed as part of the 
> port_config in sdw_stream_add_slave().

if you completely remove the stream and re-add it with updated 
configuration things should work.



