Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FE3284430
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJFDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 23:11:43 -0400
Received: from foss.arm.com ([217.140.110.172]:36424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgJFDLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:11:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F50C113E;
        Mon,  5 Oct 2020 20:11:42 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B6773F71F;
        Mon,  5 Oct 2020 20:11:39 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 3/3] arm64/mm/hotplug: Ensure early memory sections are
 all online
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
 <1601387687-6077-4-git-send-email-anshuman.khandual@arm.com>
 <471fed64-0f61-9c16-3943-2bb8f77ee810@redhat.com>
Message-ID: <8489f045-e94c-a3cc-3fc3-a7d92d19bca6@arm.com>
Date:   Tue, 6 Oct 2020 08:41:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <471fed64-0f61-9c16-3943-2bb8f77ee810@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2020 06:23 AM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 9/29/20 11:54 PM, Anshuman Khandual wrote:
>> This adds a validation function that scans the entire boot memory and makes
>> sure that all early memory sections are online. This check is essential for
>> the memory notifier to work properly, as it cannot prevent any boot memory
>> from offlining, if all sections are not online to begin with. The notifier
>> registration is skipped, if this validation does not go through. Although
>> the boot section scanning is selectively enabled with DEBUG_VM.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Steve Capper <steve.capper@arm.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/mm/mmu.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
> 
> I don't understand why this is necessary. The core already ensure the
> corresponding section is online when trying to offline it. It's guranteed
> that section is online when the notifier is triggered. I'm not sure if
> there is anything I missed?

Current memory notifier blocks any boot memory hot removal attempt via
blocking its offlining step itself. So if some sections in boot memory
are not online (because of a bug or change in init sequence) by the
time memory block device can be removed, the notifier loses the ability
to prevent its removal. This validation here, ensures that entire boot
memory is in online state, otherwise call out sections that are not,
with an warning that those boot memory can be removed.  

>  
> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 90a30f5ebfc0..b67a657ea1ad 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1522,6 +1522,62 @@ static struct notifier_block prevent_bootmem_remove_nb = {
>>       .notifier_call = prevent_bootmem_remove_notifier,
>>   };
>>   +/*
>> + * This ensures that boot memory sections on the plaltform are online

Will fix.

>                                                     ^^^^^^^^^
>> + * during early boot. They could not be prevented from being offlined
>> + * if for some reason they are not brought online to begin with. This
>> + * help validate the basic assumption on which the above memory event
>> + * notifier works to prevent boot memory offlining and it's possible
>> + * removal.
>> + */
>> +static bool validate_bootmem_online(void)
>> +{
>> +    struct memblock_region *mblk;
>> +    struct mem_section *ms;
>> +    unsigned long pfn, end_pfn, start, end;
>> +    bool all_online = true;
>> +
>> +    /*
>> +     * Scanning across all memblock might be expensive
>> +     * on some big memory systems. Hence enable this
>> +     * validation only with DEBUG_VM.
>> +     */
>> +    if (!IS_ENABLED(CONFIG_DEBUG_VM))
>> +        return all_online;
>> +
>> +    for_each_memblock(memory, mblk) {
>> +        pfn = PHYS_PFN(mblk->base);
>> +        end_pfn = PHYS_PFN(mblk->base + mblk->size);
>> +
> 
> It's not a good idea to access @mblk->{base, size}. There are two
> accessors: memblock_region_memory_{base, end}_pfn().

Sure, will replace.

> 
>> +        for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +            ms = __pfn_to_section(pfn);
>> +
>> +            /*
>> +             * All memory ranges in the system at this point
>> +             * should have been marked early sections.
>> +             */
>> +            WARN_ON(!early_section(ms));
>> +
>> +            /*
>> +             * Memory notifier mechanism here to prevent boot
>> +             * memory offlining depends on the fact that each
>> +             * early section memory on the system is intially
>> +             * online. Otherwise a given memory section which
>> +             * is already offline will be overlooked and can
>> +             * be removed completely. Call out such sections.
>> +             */
> 
> s/intially/initially

Will change.

> 
>> +            if (!online_section(ms)) {
>> +                start = PFN_PHYS(pfn);
>> +                end = start + (1UL << PA_SECTION_SHIFT);
>> +                pr_err("Memory range [%lx %lx] is offline\n", start, end);
>> +                pr_err("Memory range [%lx %lx] can be removed\n", start, end);
>> +                all_online = false;
> 
> These two error messages can be combined:
> 
>     pr_err("Memory range [%lx %lx] not online, can't be offlined\n",
>            start, end);

Will change but it is actually s/can't be offlined/can be removed/ instead.

> 
> I think you need to return @all_online immediately, without
> checking if the subsequent sections are online or not? :)

Thinking about this again. It might be better if the notifier registration
does not depend on return value from validate_bootmem_online(). Instead it
should proceed either way but after calling out all boot memory sections
that are not online. In that case notifier will atleast prevent removal of
some parts of boot memory which are online.
