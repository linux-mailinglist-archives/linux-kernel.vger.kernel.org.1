Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993A12FA1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404386AbhARNhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:37:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390314AbhARN2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:28:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B94ED6E;
        Mon, 18 Jan 2021 05:27:46 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716473F719;
        Mon, 18 Jan 2021 05:27:44 -0800 (PST)
Subject: Re: [PATCH 1/2] of: device: Allow DMA range map to be set before
 of_dma_configure_id
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
 <ddf44e96-187b-91c0-822d-ade4f1e5be2b@arm.com> <YAMdZ9peWRMRACv2@collins>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com>
Date:   Mon, 18 Jan 2021 13:27:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAMdZ9peWRMRACv2@collins>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-16 17:07, Paul Kocialkowski wrote:
> Hi Robin,
> 
> Le Sat 16 Jan 21, 14:57, Robin Murphy a écrit :
>> On 2021-01-15 17:58, Paul Kocialkowski wrote:
>>> A mechanism was recently introduced for the sunxi architecture where
>>> the DMA offset for specific devices (under the MBUS) is set by a common
>>> driver (sunxi_mbus). This driver calls dma_direct_set_offset to set
>>> the device's dma_range_map manually.
>>>
>>> However this information was overwritten by of_dma_configure_id, which
>>> obtains the map from of_dma_get_range (or keeps it NULL when it fails
>>> and the force_dma argument is true, which is the case for platform
>>> devices).
>>>
>>> As a result, the dma_range_map was always overwritten and the mechanism
>>> could not correctly take effect.
>>>
>>> This adds a check to ensure that no previous DMA range map is
>>> overwritten and prints a warning when the map was already set while
>>> also being available from dt. In this case, the map that was already
>>> set is kept.
>>
>> Hang on, the hard-coded offset is only intended to be installed when there
>> *isn't* anything described in DT, in which case of_dma_get_range() should
>> always bail out early without touching it anyway. This sounds like
>> something's not quite right in the MBUS driver, so I don't think working
>> around it in core code is really the right thing to do.
> 
> That's right, there is no practical case where the two are in conflict.
> The problem that I'm solving here is that dev->dma_range_map is *always*
> assigned, even when of_dma_get_range bailed and map still is NULL.
> 
> This has the effect of always overwriting what the MBUS driver does
> (and leaking its memory too).

Oh, I should have looked closer at of_dma_configure_id() itself. I was 
assuming that b4bdc4fbf8d0 had been tested and at least *could* work, 
but apparently not :/

Indeed it seems there was a fundamental oversight in e0d072782c73 
("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset"), 
equivalent to the same one I previously made myself with bus_dma_mask 
and fixed in 6778be4e5209 ("of/device: Really only set bus DMA mask when 
appropriate"). I think same simpler fix is the right one for this case 
too, i.e. just move the assignment to dev->dma_range_map up under the 
"if (!ret)" condition. Assigning it this late - after the IOMMU and arch 
setup - looks wrong anyway, even if it isn't currently an issue in 
practice (in principle an IOMMU driver *could* start trying to figure 
out reserved regions around DMA windows for a device as early as its 
.of_xlate callback, even though that's not the intent of the API design).

Luckily dma_range_map hasn't been hooked up in the equivalent ACPI path 
yet, so you're off the hook for fixing that too :)

Cheers,
Robin.

>> Do you have a case where one of the relevant devices inherits a "dma-ranges"
>> via the regular hierarchy without indirecting via an "interconnects"
>> reference? Currently you're only checking for the latter, so that would be
>> one way things could go awry (although to be a problem, said "dma-ranges"
>> would also have to encode something *other* than the appropriate MBUS
>> offset, which implies an incorrect or at least inaccurately-structured DT as
>> well).
> 
> No, I think things are good in that regard. No messed up dt or anything like
> that :)
> 
> Cheers,
> 
> Paul
> 
>> Robin.
>>
>>> Fixes: b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a central place")
>>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>> ---
>>>    drivers/of/device.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index aedfaaafd3e7..db1b8634c2c7 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -181,7 +181,14 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>>    	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>>> -	dev->dma_range_map = map;
>>> +	if (!dev->dma_range_map) {
>>> +		dev->dma_range_map = map;
>>> +	} else if (map) {
>>> +		dev_warn(dev,
>>> +			 "DMA range map was already set, ignoring range map from dt\n");
>>> +		kfree(map);
>>> +	}
>>> +
>>>    	return 0;
>>>    }
>>>    EXPORT_SYMBOL_GPL(of_dma_configure_id);
>>>
> 
