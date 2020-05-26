Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3F1CF929
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgELPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 11:30:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:27052 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgELPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:30:23 -0400
IronPort-SDR: 3b5vhqxJ0WuCgOoGVJD8tXx/IJNWxyYF/vL4KUDI/tyEar6YN7gCHM9wMW6hMBDD4TB7gIacLL
 bDSdSPSOxxRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 08:30:23 -0700
IronPort-SDR: ZK3Se/fAkNFyJF7QxFxocRhwMaC21XL7PjjHBRWOuKhXYlwUSsgU9zriRl+JD5WOMbFHC3V6Jr
 FnvElm6Y+HgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="409336630"
Received: from bmtannen-mobl.amr.corp.intel.com (HELO [10.255.228.231]) ([10.255.228.231])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2020 08:30:21 -0700
Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
 <20200511063227.GS1375924@vkoul-mobl>
 <e214d308-1b92-a7a5-3c76-da05dca99cc5@linux.intel.com>
 <20200512033035.GV1375924@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <84f09843-3245-5fa4-530f-c915b28e9bc5@linux.intel.com>
Date:   Tue, 12 May 2020 09:36:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512033035.GV1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/20 10:30 PM, Vinod Koul wrote:
> On 11-05-20, 14:00, Pierre-Louis Bossart wrote:
>>>> +	md = &bus->md;
>>>> +	md->dev.bus = &sdw_bus_type;
>>>> +	md->dev.type = &sdw_master_type;
>>>> +	md->dev.parent = parent;
>>>> +	md->dev.of_node = parent->of_node;
>>>> +	md->dev.fwnode = fwnode;
>>>> +	md->dev.dma_mask = parent->dma_mask;
>>>> +
>>>> +	dev_set_name(&md->dev, "sdw-master-%d", bus->link_id);
>>>
>>> This give nice sdw-master-0. In DT this comes from reg property. I dont
>>> seem to recall if the ACPI/Disco spec treats link_id as unique across
>>> the system, can you check that please, if not we would need to update
>>> this.
>> Table 3 in the Disco for Soundwire 1.0 spec: "all LinkID values are relative
>> to the immediate parent Device."
>>
>> There isn't any known implementation with more than one controller.
> 
> But then it can come in "future" right. So lets try to make it future
> proof by not using the link_id (we can expose that as a sysfs if people
> want to know). So a global unique id needs to allocated (hint: idr or
> equivalent) and used as master_id

Can you clarify if you are asking for a global ID for Intel/ACPI 
platforms, or for DT as well? I can't figure out from the 
soundwire-controller.yaml definitions if there is already a notion of 
unique ID.

properties:
   $nodename:
     pattern: "^soundwire(@.*)?$"

    soundwire@c2d0000 {
         #address-cells = <2>;
         #size-cells = <0>;
         reg = <0x0c2d0000 0x2000>;
