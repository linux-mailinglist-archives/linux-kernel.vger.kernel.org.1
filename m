Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD2300934
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbhAVRDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:03:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:4339 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbhAVQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:44:25 -0500
IronPort-SDR: sDb20MSCPlIvr9AZA61O4GfDsW/Bc4yLQh45Asn6r0a/zRnn3IojydYVA5eWzC1JYk3qNQcvLh
 jkiyhTYLecIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="241010622"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="241010622"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:42:38 -0800
IronPort-SDR: eyKTjn9B1POkjG9aA8K5ifo9qU5aNWzoFmJyMj5AAdRvlSYZ0Cl5tGgaow9HKO+peCX4rVHvHT
 32gigo3asZMA==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="428027764"
Received: from cdgarci1-mobl1.amr.corp.intel.com (HELO [10.212.60.15]) ([10.212.60.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:42:37 -0800
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
 <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
 <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <adb91730-35db-db7a-75b3-4771723de945@linux.intel.com>
Date:   Fri, 22 Jan 2021 10:42:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> No, what I was saying is that you need to define multiple streams e.g.
>> - headset capture (configured with or without click suppression)
>> - mic capture (configured with AMICs or DMICs)
>> - playback (or possibly different endpoint specific streams depending 
>> on whether concurrency between endpoint is possible)
>>
>> if you change the configuration, you have to tear down the stream and 
>> reconfigure it - and for this we already have the required API and you 
>> can guarantee that the configuration for that stream is consistent 
>> between master and slave(s).
> 
> Yes, we make sure that new configuration is only applied before the 
> stream is started, and not in middle of already started stream.

ok, we are almost in agreement but...

>>> All am saying is that codec can decide which ports it has to select 
>>> based on mixer setting before the stream is setup/started. This 
>>> updated mapping between slv port and master ports is passed as part 
>>> of the port_config in sdw_stream_add_slave().
>>
>> if you completely remove the stream and re-add it with updated 
>> configuration things should work.
> 
> That's exactly what we do currently!
> 
> The updated ports due to new configuration ex: for "mic capture" dailink 
> needs to be communicated from slave(codec) to master so that it can 
> allocate correct ports. That is what this patch is trying to do (share 
> current port map information).

.. we have a disconnect on how to do this configuration update.

The 'stream' support was designed so that a stream can be split across 
multiple devices (both masters and slaves). With this design we need to 
have a central configuration and distribute the information to all 
devices taking part of the stream.

It seems you are in a different solution-space, where the codec driver 
needs to notify the master of which ports it needs to use?

I also don't see where the mapping is actually set. Patch 2 uses a 
mapping but there's no codec driver change that defines the mapping?

Do you actually call sdw_stream_add_slave() with a new mapping?

It feels we are missing the codec part to really see what you are trying 
to do?

