Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0566E2F1F49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbhAKT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:28:38 -0500
Received: from foss.arm.com ([217.140.110.172]:35082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbhAKT2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:28:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081BF101E;
        Mon, 11 Jan 2021 11:27:51 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77C23F719;
        Mon, 11 Jan 2021 11:27:49 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from
 other masters
To:     Will Deacon <will@kernel.org>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
 <20210107093340.15279-1-ajaykumar.rs@samsung.com>
 <20210107130319.GA2986@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5e047da1-6619-c716-927c-ae07a90f1597@arm.com>
Date:   Mon, 11 Jan 2021 19:27:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107130319.GA2986@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-07 13:03, Will Deacon wrote:
> On Thu, Jan 07, 2021 at 03:03:40PM +0530, Ajay Kumar wrote:
>> When PCI function drivers(ex:pci-endpoint-test) are probed for already
>> initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
>> then we encounter a situation where the function driver tries to attach
>> itself to the smmu with the same stream-id as PCIe-RC and re-initialize
>> an already initialized STE. This causes ste_live BUG_ON() in the driver.

Note that this is actually expected behaviour, since Stream ID aliasing 
has remained officially not supported until a sufficiently compelling 
reason to do so appears. I always thought the most likely scenario would 
be a legacy PCI bridge with multiple devices behind it, but even that 
seems increasingly improbable for a modern SMMUv3-based system to ever see.

> I don't understand why the endpoint is using the same stream ID as the root
> complex in this case. Why is that? Is the grouping logic not working
> properly?

It's not so much that it isn't working properly, it's more that it needs 
to be implemented at all ;)

>> There is an already existing check in the driver to manage duplicated ids
>> if duplicated ids are added in same master device, but there can be
>> scenarios like above where we need to extend the check for other masters
>> using the same stream-id.
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
> 
> It doesn't feel like the driver is the right place to fix this, as the same
> issue could surely occur for other IOMMUs too, right? In which case, I think
> we should avoid getting into the situation where different groups have
> overlapping stream IDs.

Yes, this patch does not represent the correct thing to do either way. 
The main reason that Stream ID aliasing hasn't been supported so far is 
that the required Stream ID to group lookup is rather awkward, and 
adding all of that complexity just for the sake of a rather unlikely 
possibility seemed dubious. However, PRI support has always had a more 
pressing need to implement almost the same thing (Stream ID to device), 
so once that lands we can finally get round to adding the rest of proper 
group support relatively easily.

Robin.
