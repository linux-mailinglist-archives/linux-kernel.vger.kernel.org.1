Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ECA2D0E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgLGKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:40:41 -0500
Received: from foss.arm.com ([217.140.110.172]:46698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgLGKkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:40:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D43B1042;
        Mon,  7 Dec 2020 02:39:55 -0800 (PST)
Received: from [10.163.86.92] (unknown [10.163.86.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BC2A3F66B;
        Mon,  7 Dec 2020 02:39:50 -0800 (PST)
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the memory
 reserved for the page map
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei213@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, butao@hisilicon.com,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        fengbaopeng2@hisilicon.com
References: <20201204014443.43329-1-liwei213@huawei.com>
 <20201204111347.GA844@willie-the-truck>
 <CAMj1kXGQ-CeYcbS-hc+Yy8DKHm2t-RYsLu4+7wOG1bWuJqkjGQ@mail.gmail.com>
 <390f5f441d99a832f4b2425b46f6d971@kernel.org>
 <20201207094215.GC1112728@linux.ibm.com>
 <CAMj1kXFdtom+OBJ84he9C5eNw-KJ8zwW04WB0ab6Gp_DCiYkRg@mail.gmail.com>
 <20201207100426.GE1112728@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <39d72e1c-b3b3-89d3-1a1a-3ee222d40761@arm.com>
Date:   Mon, 7 Dec 2020 16:09:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207100426.GE1112728@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/20 3:34 PM, Mike Rapoport wrote:
> On Mon, Dec 07, 2020 at 10:49:26AM +0100, Ard Biesheuvel wrote:
>> On Mon, 7 Dec 2020 at 10:42, Mike Rapoport <rppt@linux.ibm.com> wrote:
>>>
>>> On Mon, Dec 07, 2020 at 09:35:06AM +0000, Marc Zyngier wrote:
>>>> On 2020-12-07 09:09, Ard Biesheuvel wrote:
>>>>> (+ Marc)
>>>>>
>>>>> On Fri, 4 Dec 2020 at 12:14, Will Deacon <will@kernel.org> wrote:
>>>>>>
>>>>>> On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
>>>>>>> For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
>>>>>>> do not free the reserved memory for the page map, decrease the section
>>>>>>> size can reduce the waste of reserved memory.
>>>>>>>
>>>>>>> Signed-off-by: Wei Li <liwei213@huawei.com>
>>>>>>> Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
>>>>>>> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
>>>>>>> ---
>>>>>>>  arch/arm64/include/asm/sparsemem.h | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
>>>>>>> index 1f43fcc79738..8963bd3def28 100644
>>>>>>> --- a/arch/arm64/include/asm/sparsemem.h
>>>>>>> +++ b/arch/arm64/include/asm/sparsemem.h
>>>>>>> @@ -7,7 +7,7 @@
>>>>>>>
>>>>>>>  #ifdef CONFIG_SPARSEMEM
>>>>>>>  #define MAX_PHYSMEM_BITS     CONFIG_ARM64_PA_BITS
>>>>>>> -#define SECTION_SIZE_BITS    30
>>>>>>> +#define SECTION_SIZE_BITS    27
>>>>>>
>>>>>> We chose '30' to avoid running out of bits in the page flags. What
>>>>>> changed?
>>>>>>
>>>>>> With this patch, I can trigger:
>>>>>>
>>>>>> ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds
>>>>>> SECTION_SIZE
>>>>>> #error Allocator MAX_ORDER exceeds SECTION_SIZE
>>>>>>
>>>>>> if I bump up NR_CPUS and NODES_SHIFT.
>>>>>>
>>>>>
>>>>> Does this mean we will run into problems with the GICv3 ITS LPI tables
>>>>> again if we are forced to reduce MAX_ORDER to fit inside
>>>>> SECTION_SIZE_BITS?
>>>>
>>>> Most probably. We are already massively constraint on platforms
>>>> such as TX1, and dividing the max allocatable range by 8 isn't
>>>> going to make it work any better...
>>>
>>> I don't think MAX_ORDER should shrink. Even if SECTION_SIZE_BITS is
>>> reduced it should accomodate the existing MAX_ORDER.
>>>
>>> My two pennies.
>>>
>>
>> But include/linux/mmzone.h:1170 has this:
>>
>> #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
>> #error Allocator MAX_ORDER exceeds SECTION_SIZE
>> #endif
>>
>> and Will managed to trigger it after applying this patch.
> 
> Right, because with 64K pages section size of 27 bits is not enough to
> accomodate MAX_ORDER (2^13 pages of 64K).
> 
> Which means that definition of SECTION_SIZE_BITS should take MAX_ORDER
> into account either statically with 
> 
> #ifdef ARM64_4K_PAGES
> #define SECTION_SIZE_BITS <a number>
> #elif ARM64_16K_PAGES
> #define SECTION_SIZE_BITS <a larger number>
> #elif ARM64_64K_PAGES
> #define SECTION_SIZE_BITS <even larger number>
> #else
> #error "and what is the page size?"
> #endif
> 
> or dynamically, like e.g. ia64 does:
> 
> #ifdef CONFIG_FORCE_MAX_ZONEORDER
> #if ((CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
> #undef SECTION_SIZE_BITS
> #define SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
> #endif

I had proposed the same on the other thread here. But with this the
SECTION_SIZE_BITS becomes 22 in case of 4K page size reducing to an
extent where PMD based vmemmap mapping could not be created. Though
have not looked into much details yet.

Using CONFIG_FORCE_MAX_ZONEORDER seems to the right thing to do. But
if that does not reasonably work for 4K pages, we might have to hard
code it as 27 to have huge page vmemmap mappings.
