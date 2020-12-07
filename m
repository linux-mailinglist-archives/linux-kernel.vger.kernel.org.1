Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555A2D0B23
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgLGHbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:31:21 -0500
Received: from foss.arm.com ([217.140.110.172]:42858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgLGHbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:31:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CCA511D4;
        Sun,  6 Dec 2020 23:30:35 -0800 (PST)
Received: from [10.163.86.92] (unknown [10.163.86.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27B623F66B;
        Sun,  6 Dec 2020 23:30:31 -0800 (PST)
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the memory
 reserved for the page map
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Cc:     "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "liwei (CM)" <liwei213@huawei.com>, butao <butao@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        fengbaopeng <fengbaopeng2@hisilicon.com>
References: <20201204014443.43329-1-liwei213@huawei.com>
 <20201204111347.GA844@willie-the-truck>
 <20201204114400.GT123287@linux.ibm.com>
 <60cb36d5dfcb4f9c904a83b520ecfe84@hisilicon.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ae384eff-448f-a8d5-a45a-e8a9234d26bb@arm.com>
Date:   Mon, 7 Dec 2020 13:00:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <60cb36d5dfcb4f9c904a83b520ecfe84@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/20 7:10 AM, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Mike Rapoport [mailto:rppt@linux.ibm.com]
>> Sent: Saturday, December 5, 2020 12:44 AM
>> To: Will Deacon <will@kernel.org>
>> Cc: liwei (CM) <liwei213@huawei.com>; catalin.marinas@arm.com; fengbaopeng
>> <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de; steve.capper@arm.com;
>> Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; butao
>> <butao@hisilicon.com>
>> Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the memory
>> reserved for the page map
>>
>> On Fri, Dec 04, 2020 at 11:13:47AM +0000, Will Deacon wrote:
>>> On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
>>>> For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
>>>> do not free the reserved memory for the page map, decrease the section
>>>> size can reduce the waste of reserved memory.
>>>>
>>>> Signed-off-by: Wei Li <liwei213@huawei.com>
>>>> Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
>>>> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
>>>> ---
>>>>  arch/arm64/include/asm/sparsemem.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/sparsemem.h
>> b/arch/arm64/include/asm/sparsemem.h
>>>> index 1f43fcc79738..8963bd3def28 100644
>>>> --- a/arch/arm64/include/asm/sparsemem.h
>>>> +++ b/arch/arm64/include/asm/sparsemem.h
>>>> @@ -7,7 +7,7 @@
>>>>
>>>>  #ifdef CONFIG_SPARSEMEM
>>>>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
>>>> -#define SECTION_SIZE_BITS	30
>>>> +#define SECTION_SIZE_BITS	27
>>>
>>> We chose '30' to avoid running out of bits in the page flags. What changed?
>>
>> I think that for 64-bit there are still plenty of free bits. I didn't
>> check now, but when I played with SPARSEMEM on m68k there were 8 bits
>> for section out of 32.
>>
>>> With this patch, I can trigger:
>>>
>>> ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds
>> SECTION_SIZE
>>> #error Allocator MAX_ORDER exceeds SECTION_SIZE
>>>
>>> if I bump up NR_CPUS and NODES_SHIFT.
>>
>> I don't think it's related to NR_CPUS and NODES_SHIFT.
>> This seems rather 64K pages that cause this.
>>
>> Not that is shouldn't be addressed.
> 
> Right now, only 4K PAGES will define ARM64_SWAPPER_USES_SECTION_MAPS.
> Other cases will use vmemmap_populate_basepages().
> The original patch should be only addressing the issue in 4K pages:
> https://lore.kernel.org/lkml/20200812010655.96339-1-liwei213@huawei.com/
> 
> would we do something like the below?
> #ifdef CONFIG_ARM64_4K_PAGE
> #define SECTION_SIZE_BITS	27
> #else
> #define SECTION_SIZE_BITS	30
> #endif

This is bit arbitrary. Probably 27 can be further reduced for 4K page size.
Instead, we should make SECTION_SIZE_BITS explicitly depend upon MAX_ORDER.
IOW section size should be the same as the highest order page in the buddy.
CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64. A quick test shows
SECTION_SIZE_BITS would be 22 on 4K pages and 29 for 64K pages. As a fall
back SECTION_SIZE_BITS can still be 30 in case CONFIG_FORCE_MAX_ZONEORDER
is not defined.

--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS       CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS      30
+#define SECTION_SIZE_BITS      (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
 #endif
 
 #endif

A similar approach exists on ia64 platform as well.
