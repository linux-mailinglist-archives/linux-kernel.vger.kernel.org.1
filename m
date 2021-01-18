Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB792FA534
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406015AbhARPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:52:20 -0500
Received: from foss.arm.com ([217.140.110.172]:38298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390778AbhARPt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:49:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7641FB;
        Mon, 18 Jan 2021 07:49:09 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559E53F68F;
        Mon, 18 Jan 2021 07:49:06 -0800 (PST)
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
 <20210114192732.GA3401278@robh.at.kernel.org>
 <1610688626.4578.1.camel@mhfsdcap03>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
Date:   Mon, 18 Jan 2021 15:49:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1610688626.4578.1.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-15 05:30, Yong Wu wrote:
> On Thu, 2021-01-14 at 13:27 -0600, Rob Herring wrote:
>> On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
>>> "dev->dma_range_map" contains the devices' dma_ranges information,
>>> This patch moves dma_range_map before of_iommu_configure. The iommu
>>> driver may need to know the dma_address requirements of its iommu
>>> consumer devices.
>>>
>>> CC: Rob Herring <robh+dt@kernel.org>
>>> CC: Frank Rowand <frowand.list@gmail.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>   drivers/of/device.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index aedfaaafd3e7..1d84636149df 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>>   	dev_dbg(dev, "device is%sdma coherent\n",
>>>   		coherent ? " " : " not ");
>>>   
>>> +	dev->dma_range_map = map;
>>>   	iommu = of_iommu_configure(dev, np, id);
>>>   	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>>>   		kfree(map);
>>> +		dev->dma_range_map = NULL;
>>
>> Not really going to matter, but you should probably clear dma_range_map
>> before what it points to is freed.
>>
>> With that,
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thanks for the review. I will move it before "kfree(map)" in next
> version.

Paul noticed that we already have a bug in assigning to this 
unconditionally[1] - I'd totally forgotten about this series when I 
theorised about IOMMU drivers wanting the information earlier, but 
sweeping my inbox now only goes to show I was right to think of it :)

We should really get something in as a fix independent of this series, 
taking both angles into account.

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com/

>>
>>>   		return -EPROBE_DEFER;
>>>   	}
>>>   
>>> @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>>   
>>>   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>>>   
>>> -	dev->dma_range_map = map;
>>>   	return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(of_dma_configure_id);
>>> -- 
>>> 2.18.0
>>>
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
