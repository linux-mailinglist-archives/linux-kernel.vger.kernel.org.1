Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C3298C27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773891AbgJZLgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:36:07 -0400
Received: from foss.arm.com ([217.140.110.172]:36262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773883AbgJZLgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:36:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A68D3101E;
        Mon, 26 Oct 2020 04:36:05 -0700 (PDT)
Received: from [10.57.50.191] (unknown [10.57.50.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3DC63F719;
        Mon, 26 Oct 2020 04:36:02 -0700 (PDT)
Subject: Re: [PATCH v3 11/24] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for
 MediaTek
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-12-yong.wu@mediatek.com>
 <a5713949-1d95-40f1-d35d-d99735b48294@arm.com>
 <1603698083.26323.87.camel@mhfsdcap03>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7a03faf4-b382-2923-b9fa-9a55861f49d6@arm.com>
Date:   Mon, 26 Oct 2020 11:35:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1603698083.26323.87.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 07:41, Yong Wu wrote:
> On Fri, 2020-10-23 at 15:10 +0100, Robin Murphy wrote:
>> On 2020-09-30 08:06, Yong Wu wrote:
>>> The standard input iova bits is 32. MediaTek quad the lvl1 pagetable
>>> (4 * lvl1). No change for lvl2 pagetable. Then the iova bits can reach
>>> 34bit.
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>    drivers/iommu/io-pgtable-arm-v7s.c | 13 ++++++++++---
>>>    drivers/iommu/mtk_iommu.c          |  2 +-
>>>    2 files changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
>>> index 8362fdf76657..306bae2755ed 100644
>>> --- a/drivers/iommu/io-pgtable-arm-v7s.c
>>> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
>>> @@ -50,10 +50,17 @@
>>>     */
>>>    #define ARM_V7S_ADDR_BITS		32
>>>    #define _ARM_V7S_LVL_BITS(lvl)		(16 - (lvl) * 4)
>>> +/* MediaTek: totally 34bits, 14bits at lvl1 and 8bits at lvl2. */
>>> +#define _ARM_V7S_LVL_BITS_MTK(lvl)	(20 - (lvl) * 6)
>>
>> This should defined in terms of both lvl and cfg->ias. The formula here
>> is nothing more than a disgusting trick I made up since a linear
>> interpolation happened to fit the required numbers. That said, all of
>> these bits pretending that short-descriptor is a well-defined recursive
>> format only served to allow the rest of the code to look more like the
>> LPAE code - IIRC they've already diverged a fair bit since then, so
>> frankly a lot of this could stand to be unpicked and made considerably
>> clearer by simply accepting that level 1 and level 2 are different from
>> each other.
> 
> If the formula is not good and make it clearer, How about this?
> 
> 
> /*
>   * We have 32 bits total; 12 bits resolved at level 1, 8 bits at level
> 2,
> -* and 12 bits in a page. With some carefully-chosen coefficients we can
> -* hide the ugly inconsistencies behind these macros and at least let
> the
> -* rest of the code pretend to be somewhat sane.
> +* and 12 bits in a page.
> +*
> +* MediaTek extend 2 bits to reach 34 bits, 14 bits at lvl1 and 8 bits
> at lvl2.
>   */
> 
> -#define _ARM_V7S_LVL_BITS(lvl)		(16 - (lvl) * 4)
> +#define _ARM_V7S_LVL1_BITS_NR(cfg)     (((cfg)->ias == 32) ? 12 : 14)
> +#define _ARM_V7S_LVL2_BITS_NR		8
> +
> +#define _ARM_V7S_LVL_BITS(lvl, cfg)    \
> +      (((lvl) == 1) ? _ARM_V7S_LVL1_BITS_NR(cfg):_ARM_V7S_LVL2_BITS_NR)

Well, I'd have gone for something really simple and clear like:

#define ARM_V7S_LVL_BITS(lvl, cfg) ((lvl) == 1 ? (cfg)->ias - 20 : 8)
#define ARM_V7S_LVL_SHIFT(lvl)     ((lvl) == 1 ? 20 : 12)

Then maybe see if enough of the users could resolve lvl significantly 
earlier to make it worth splitting things up further.

Robin.

>>>    #define ARM_V7S_LVL_SHIFT(lvl)		(ARM_V7S_ADDR_BITS - (4 + 8 * (lvl)))
>>>    #define ARM_V7S_TABLE_SHIFT		10
>>>    
>>> -#define ARM_V7S_PTES_PER_LVL(lvl, cfg)	(1 << _ARM_V7S_LVL_BITS(lvl))
>>> +#define ARM_V7S_PTES_PER_LVL(lvl, cfg)	({				\
>>> +	int _lvl = lvl;							\
>>> +	!arm_v7s_is_mtk_enabled(cfg) ?					\
>>> +	 (1 << _ARM_V7S_LVL_BITS(_lvl)) : (1 << _ARM_V7S_LVL_BITS_MTK(_lvl));\
>>> +})
>>> +
>>>    #define ARM_V7S_TABLE_SIZE(lvl, cfg)					\
>>>    	(ARM_V7S_PTES_PER_LVL(lvl, cfg) * sizeof(arm_v7s_iopte))
>>>    
>>> @@ -63,7 +70,7 @@
>>>    #define _ARM_V7S_IDX_MASK(lvl, cfg)	(ARM_V7S_PTES_PER_LVL(lvl, cfg) - 1)
>>>    #define ARM_V7S_LVL_IDX(addr, lvl, cfg)	({			\
>>>    	int _l = lvl;							\
>>> -	((u32)(addr) >> ARM_V7S_LVL_SHIFT(_l)) & _ARM_V7S_IDX_MASK(_l, cfg); \
>>> +	((addr) >> ARM_V7S_LVL_SHIFT(_l)) & _ARM_V7S_IDX_MASK(_l, cfg); \
>>>    })
>>>    
>>>    /*
>>> @@ -755,7 +762,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>>>    {
>>>    	struct arm_v7s_io_pgtable *data;
>>>    
>>> -	if (cfg->ias > ARM_V7S_ADDR_BITS)
>>> +	if (cfg->ias > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
>>>    		return NULL;
>>>    
>>>    	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 35 : ARM_V7S_ADDR_BITS))
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index f6a2e3eb59d2..6e85c9976a33 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -316,7 +316,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>>>    			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
>>>    			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
>>>    		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
>>> -		.ias = 32,
>>> +		.ias = 34,
>>>    		.oas = 35,
>>>    		.tlb = &mtk_iommu_flush_ops,
>>>    		.iommu_dev = data->dev,
>>>
> 
