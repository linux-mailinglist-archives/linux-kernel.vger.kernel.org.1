Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C219E2FF76F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbhAUVjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:39:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:30562 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbhAUVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:32:16 -0500
IronPort-SDR: ZKpuEba31gwLocUgw/44gJLmLCSduBe+mv6BDef13x5qLkQ60AbRKwCYlAbak4CoIz70Ptamc2
 7CCQi62g7HLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="158530151"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="158530151"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:30:20 -0800
IronPort-SDR: puBLcVzT9eJ+vIEIfZMikqkWfC79PhC7Iyym3fIAXbYVaD2V9Erx+5ZkIgUhHKhrHHNVAQX/nu
 6nBx1C69sZdQ==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="367062423"
Received: from mengyent-mobl1.amr.corp.intel.com (HELO [10.209.48.213]) ([10.209.48.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:30:19 -0800
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eaf13d70-86fe-3e18-7a5a-4043f2d8a22d@linux.intel.com>
Date:   Thu, 21 Jan 2021 15:30:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> [SLAVE]-------[MASTER]
>>> NA-------------Port 1: PCM
>>> Port 1---------Port 2: ADC 1 & 2
>>> Port 2---------Port 3: ADC 3 & 4
>>> Port 3---------Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
>>> Port 4---------Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7
>>>
>>>
>>> Mapping is still static however Number of ports selection and channel 
>>> mask will be dynamic here.
>>>
>>>
>>> Example: for Headset MIC usecase we will be using Slv Port1, Slv 
>>> Port3 along with Mstr Port2 and Master Port4
>>>
>>> Similarly for usecases like Digital MIC or other Analog MICs.
>>
>> Sorry, I must be thick here, but in my experience the choice of 
>> Digital or analog mics is a hardware design level not a use-case one. 
>> Using ADC 1 & 2 at the same time as DMICs is very surprising to me. 
>> You'd have different sensitivities/performance, not sure how you would 
>> combine the results.
> 
> In this particular case, ADC2 on Port2 is used along with the MBHC(Multi 
> Button and Headset Detection) channel on Master Port4. This is intended 
> for Headset Button Click Suppression!. This again can be  dynamically 
> selected based on if headset button Click Suppression is enabled or not.

The question is whether the ADC2 and MBHC ports convey data for the same 
'stream'. If they need to be synchronous, they have to be part of the 
same stream and triggered at the same time.

we don't have the ability to change the stream definition at run-time 
when an ALSA control value changes. The only thing you could do is 
enabled it always, and drop the data on the floor inside of the master 
if/when the control value changes.


>>>>> Firstly, This is where the issue comes, if we go with the 
>>>>> suggested(dai->id) solution, we would end up with a long list of 
>>>>> dai-links with different combinations of both inputs/output 
>>>>> connections and usecases. Again we have to deal with limited DSP 
>>>>> resources too!

Like I said above, your ability to reconfigure is limited, and you may 
have to stop/start streaming if you want to optimize allocation.

>>>>> Secondly, The check [1] in stream.c will not allow more than one 
>>>>> master port config to be added to master runtime. Ex: RX Port 1, 2, 
>>>>> 3 is used for Headset Playback.
>>>>
>>>> I am confused here, we do have examples in existing codec drivers 
>>>> where we use multiple ports for a single stream, e.g. for IV 
>>>> feedback we use 2 ports.
>>>
>>> Is this on multi_link? which is why it might be working for you.
>>
>> no, this is done at the codec driver level, which has no notion of 
>> multi-link. we pass a port_config as a array of 2.
>>
> 
> Am referring to sdw_stream_add_master() not sdw_stream_add_slave().

It doesn't matter, it's the same concept that for a given stream, you 
tell the device which ports will be used.

The API is quasi-identical, in the master case the bus/master/link are 
the same concept.

int sdw_stream_add_master(struct sdw_bus *bus,
			  struct sdw_stream_config *stream_config,
			  struct sdw_port_config *port_config,
			  unsigned int num_ports,
			  struct sdw_stream_runtime *stream)


int sdw_stream_add_slave(struct sdw_slave *slave,
			 struct sdw_stream_config *stream_config,
			 struct sdw_port_config *port_config,
			 unsigned int num_ports,
			 struct sdw_stream_runtime *stream)


>>> Currently we have below check in sdw_stream_add_master().
>>>
>>> if (!bus->multi_link && stream->m_rt_count > 0) {
>>>      dev_err(bus->dev, "Multilink not supported, link %d\n", 
>>> bus->link_id);
>>>      ret = -EINVAL;
>>>      goto unlock;
>>> }
>>>
>>> If we have single master(like my case) and dai-links which have more 
>>> then one port  will be calling  sdw_stream_add_master() for each 
>>> port, so m_rt_count above check will fail for the second call!
>>
>> if you use multiple ports in a given master for the same stream, you 
>> should have the m_rt_count == 1. That's a feature, not a bug.
>>
>> A port is not a stream... You cannot call sdw_stream_add_master() for 
>> each port, that's not what the concept was. You allocate ONE master_rt
> 
> Am looking at intel_hw_params(). Isn't sdw_stream_add_master() called 
> for every dai in the dai link.

Yes, that's correct, but again a dai may use one or more ports.

if you defined each port as a dai, and want to call 
sdw_stream_add_master() for each port you are doing something the API 
was not designed for. There is a 'num_ports' argument for a reason :-)

>> per master, and that master_rt deals with one or more ports - your 
>> choice. >
>> A 'stream' is an abstract data transport which can be split across 
>> multiple masters/sales and for each master/slave use multiple ports.
>> When calling sdw_stream_add_master/slave, you need to provide a 
>> port_config/num_ports to state which ports will be used on that 
>> master/slave when using the stream. That's how we e.g. deal with 4ch 
>> streams that are handled by two ports on each side.
>>
>> To up-level a bit, the notion of 'stream' is actually very very 
>> similar to the notion of dailink. And in fact, the 'stream' is 
>> actually created for Intel in the dailink .startup callback, so I am 
>> quite in the dark on what you are trying to accomplish.
> In qcom case stream is also allocated for in dai startup().
> 
> I think we are talking about two different issues,
> 
> 1>one is the failure I see in sdw_stream_add_master() when I try to use 
> dai-link dai-id style approach suggested. I will dig this bit more and 
> collect more details!
> 
> 2>(Main issue) Ability for slave to select different combination of 
> ports at runtime based on the mixer setting or active dapm.
> 
> All this patch is trying do is the pass this *CURRENT/ACTIVE* static 
> port mapping between slave and master while setting up the stream.
> With the dailink approach number of ports are pretty much static and may 
> not be required for particular use case. As above example if we have a 
> headset with button click suppression we would need 2 Ports and 
> similarly without we only need one port.

As I said above you cannot enable the button click suppression 
dynamically *after* the headset capture hw_params/prepare.

> This is not possible with dai-link approach, unless we create two 
> different dai links for the above example usecase!

The current approach is a worst-case one, where you would create a 
single 'headset capture' dailink.

We never envisioned a case where you modify what the definition of 
'headset capture' is based on control events, and I really challenge the 
fact that it is feasible/realistic. This is really about streaming data 
across a bus, and we are limited on what we can do. It's the same 
problem that we never modify the number of channels dynamically on a PCM 
device.




