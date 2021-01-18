Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35062FA73F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407067AbhARRQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:16:04 -0500
Received: from foss.arm.com ([217.140.110.172]:39764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405593AbhARRPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:15:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4E731B;
        Mon, 18 Jan 2021 09:14:24 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 403C83F719;
        Mon, 18 Jan 2021 09:14:22 -0800 (PST)
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
To:     Will Deacon <will@kernel.org>
Cc:     youlin.pei@mediatek.com, anan.sun@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com>
 <e1e17782-a9f3-6b64-1630-bf29af5241cf@arm.com>
 <20210118165833.GA17722@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5043519d-fa2b-b066-8d6d-aa7a55a14b69@arm.com>
Date:   Mon, 18 Jan 2021 17:14:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118165833.GA17722@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-18 16:58, Will Deacon wrote:
> On Mon, Jan 18, 2021 at 04:35:22PM +0000, Robin Murphy wrote:
>> On 2020-12-16 10:36, Yong Wu wrote:
>>> In current iommu_unmap, this code is:
>>>
>>> 	iommu_iotlb_gather_init(&iotlb_gather);
>>> 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
>>> 	iommu_iotlb_sync(domain, &iotlb_gather);
>>>
>>> We could gather the whole iova range in __iommu_unmap, and then do tlb
>>> synchronization in the iommu_iotlb_sync.
>>>
>>> This patch implement this, Gather the range in mtk_iommu_unmap.
>>> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
>>> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
>>> could be regardless of granule size.
>>>
>>> In this way, gather->start is impossible ULONG_MAX, remove the checking.
>>>
>>> This patch aims to do tlb synchronization *once* in the iommu_unmap.
>>
>> Assuming the update to patch #4 simply results in "unsigned long end = iova
>> + size - 1;" here,
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> There's a v4 here:
> 
> https://lore.kernel.org/r/20210107122909.16317-1-yong.wu@mediatek.com

Ha, so there is! Apparently I missed that in my post-holiday sweep last 
week and leant too heavily on the inbox-in-date-order assumption. Lemme 
just go catch up...

Thanks,
Robin.
