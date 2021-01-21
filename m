Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B404F2FF2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbhAUSCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:02:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:37976 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733311AbhAUSCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:02:35 -0500
IronPort-SDR: x/H7FBF3km1ithgUA9MAl/GcQ/PYQOV9RJAoa0do6D7gljfUiKVzkhfTO9cqd8f2SD64VcC9FI
 rdImyIMftJ1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="176740063"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="176740063"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:00:46 -0800
IronPort-SDR: WbrhJ1s/WXBl7c594rfxC/HuUP/PkmBXeJ4I2wCTdEr3SjQf3h2E8bpa6/NABbH42Aa3FuL1Rf
 /KnXMnaUzQeg==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="354853875"
Received: from swehrlex-mobl.amr.corp.intel.com (HELO [10.212.61.64]) ([10.212.61.64])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:00:44 -0800
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
Date:   Thu, 21 Jan 2021 12:00:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 9:41 AM, Srinivas Kandagatla wrote:
> 
> 
> On 21/01/2021 14:56, Pierre-Louis Bossart wrote:
>>
>>
>>> Port allocations are something like this:
>>>
>>> RX: (Simple)
>>> Port 1 -> HPH L/R
>>> Port 2 -> CLASS H Amp
>>> Port 3 -> COMP
>>> Port 4 -> DSD.
>>>
>>> TX: (This get bit more complicated)
>>> Port 1: PCM
>>> Port 2: ADC 1 & 2
>>> Port 3: ADC 3 & 4
>>> Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
>>> Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7
>>>
>>> We handle the port allocation dynamically based on mixer and dapm 
>>> widgets in my code! Also channel allocations are different for each 
>>> function!
>>
>> Sorry, I am not following here. What is dynamic here and use-case 
>> dependent? And is this a mapping on the master or the codec sides that 
>> you want to modify?
> 
> [SLAVE]-------[MASTER]
> NA-------------Port 1: PCM
> Port 1---------Port 2: ADC 1 & 2
> Port 2---------Port 3: ADC 3 & 4
> Port 3---------Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
> Port 4---------Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7
> 
> 
> Mapping is still static however Number of ports selection and channel 
> mask will be dynamic here.
> 
> 
> Example: for Headset MIC usecase we will be using Slv Port1, Slv Port3 
> along with Mstr Port2 and Master Port4
> 
> Similarly for usecases like Digital MIC or other Analog MICs.

Sorry, I must be thick here, but in my experience the choice of Digital 
or analog mics is a hardware design level not a use-case one. Using ADC 
1 & 2 at the same time as DMICs is very surprising to me. You'd have 
different sensitivities/performance, not sure how you would combine the 
results.

I also don't see how a headset mic can both use Analog and digital, 
unless we have a different definition of what a 'headset' is.

>>>> Does this help and can you align on what Intel started with?
>>>
>>> Firstly, This is where the issue comes, if we go with the 
>>> suggested(dai->id) solution, we would end up with a long list of 
>>> dai-links with different combinations of both inputs/output 
>>> connections and usecases. Again we have to deal with limited DSP 
>>> resources too!
>>>
>>> Secondly, The check [1] in stream.c will not allow more than one 
>>> master port config to be added to master runtime. Ex: RX Port 1, 2, 3 
>>> is used for Headset Playback.
>>
>> I am confused here, we do have examples in existing codec drivers 
>> where we use multiple ports for a single stream, e.g. for IV feedback 
>> we use 2 ports.
> 
> Is this on multi_link? which is why it might be working for you.

no, this is done at the codec driver level, which has no notion of 
multi-link. we pass a port_config as a array of 2.

> Currently we have below check in sdw_stream_add_master().
> 
> if (!bus->multi_link && stream->m_rt_count > 0) {
>      dev_err(bus->dev, "Multilink not supported, link %d\n", bus->link_id);
>      ret = -EINVAL;
>      goto unlock;
> }
> 
> If we have single master(like my case) and dai-links which have more 
> then one port  will be calling  sdw_stream_add_master() for each port, 
> so m_rt_count above check will fail for the second call!

if you use multiple ports in a given master for the same stream, you 
should have the m_rt_count == 1. That's a feature, not a bug.

A port is not a stream... You cannot call sdw_stream_add_master() for 
each port, that's not what the concept was. You allocate ONE master_rt 
per master, and that master_rt deals with one or more ports - your choice.

A 'stream' is an abstract data transport which can be split across 
multiple masters/sales and for each master/slave use multiple ports.
When calling sdw_stream_add_master/slave, you need to provide a 
port_config/num_ports to state which ports will be used on that 
master/slave when using the stream. That's how we e.g. deal with 4ch 
streams that are handled by two ports on each side.

To up-level a bit, the notion of 'stream' is actually very very similar 
to the notion of dailink. And in fact, the 'stream' is actually created 
for Intel in the dailink .startup callback, so I am quite in the dark on 
what you are trying to accomplish.
