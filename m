Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129A26CA73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIPUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:00:17 -0400
Received: from foss.arm.com ([217.140.110.172]:34566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgIPRfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C3991396;
        Wed, 16 Sep 2020 03:46:45 -0700 (PDT)
Received: from [10.57.47.84] (unknown [10.57.47.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CA383F68F;
        Wed, 16 Sep 2020 03:46:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64/mm: Enable color zero pages
To:     Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>
Cc:     mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20200916032523.13011-1-gshan@redhat.com>
 <20200916032523.13011-3-gshan@redhat.com>
 <20200916082819.GB27496@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <77dcab5a-b5f2-a67c-6157-71a5a53db5de@arm.com>
Date:   Wed, 16 Sep 2020 11:46:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916082819.GB27496@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-16 09:28, Will Deacon wrote:
> On Wed, Sep 16, 2020 at 01:25:23PM +1000, Gavin Shan wrote:
>> This enables color zero pages by allocating contigous page frames
>> for it. The number of pages for this is determined by L1 dCache
>> (or iCache) size, which is probbed from the hardware.
>>
>>     * Add cache_total_size() to return L1 dCache (or iCache) size
>>
>>     * Implement setup_zero_pages(), which is called after the page
>>       allocator begins to work, to allocate the contigous pages
>>       needed by color zero page.
>>
>>     * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/cache.h   | 22 ++++++++++++++++++++
>>   arch/arm64/include/asm/pgtable.h |  9 ++++++--
>>   arch/arm64/kernel/cacheinfo.c    | 34 +++++++++++++++++++++++++++++++
>>   arch/arm64/mm/init.c             | 35 ++++++++++++++++++++++++++++++++
>>   arch/arm64/mm/mmu.c              |  7 -------
>>   5 files changed, 98 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>> index a4d1b5f771f6..420e9dde2c51 100644
>> --- a/arch/arm64/include/asm/cache.h
>> +++ b/arch/arm64/include/asm/cache.h
>> @@ -39,6 +39,27 @@
>>   #define CLIDR_LOC(clidr)	(((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
>>   #define CLIDR_LOUIS(clidr)	(((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
>>   
>> +#define CSSELR_TND_SHIFT	4
>> +#define CSSELR_TND_MASK		(UL(1) << CSSELR_TND_SHIFT)
>> +#define CSSELR_LEVEL_SHIFT	1
>> +#define CSSELR_LEVEL_MASK	(UL(7) << CSSELR_LEVEL_SHIFT)
>> +#define CSSELR_IND_SHIFT	0
>> +#define CSSERL_IND_MASK		(UL(1) << CSSELR_IND_SHIFT)
>> +
>> +#define CCSIDR_64_LS_SHIFT	0
>> +#define CCSIDR_64_LS_MASK	(UL(7) << CCSIDR_64_LS_SHIFT)
>> +#define CCSIDR_64_ASSOC_SHIFT	3
>> +#define CCSIDR_64_ASSOC_MASK	(UL(0x1FFFFF) << CCSIDR_64_ASSOC_SHIFT)
>> +#define CCSIDR_64_SET_SHIFT	32
>> +#define CCSIDR_64_SET_MASK	(UL(0xFFFFFF) << CCSIDR_64_SET_SHIFT)
>> +
>> +#define CCSIDR_32_LS_SHIFT	0
>> +#define CCSIDR_32_LS_MASK	(UL(7) << CCSIDR_32_LS_SHIFT)
>> +#define CCSIDR_32_ASSOC_SHIFT	3
>> +#define CCSIDR_32_ASSOC_MASK	(UL(0x3FF) << CCSIDR_32_ASSOC_SHIFT)
>> +#define CCSIDR_32_SET_SHIFT	13
>> +#define CCSIDR_32_SET_MASK	(UL(0x7FFF) << CCSIDR_32_SET_SHIFT)
> 
> I don't think we should be inferring cache structure from these register
> values. The Arm ARM helpfully says:
> 
>    | You cannot make any inference about the actual sizes of caches based
>    | on these parameters.
> 
> so we need to take the topology information from elsewhere.

Yes, these represent parameters for the low-level cache maintenance by 
set/way instructions, and nothing more. There are definitely cases where 
they do not reflect the underlying cache structure (commit 793acf870ea3 
is an obvious first call).

Robin.

> But before we get into that, can you justify why we need to do this at all,
> please? Do you have data to show the benefit of adding this complexity?
> 
> Cheers,
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
