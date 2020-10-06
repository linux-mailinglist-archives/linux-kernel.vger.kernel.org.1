Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD72528442C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgJFDAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 23:00:03 -0400
Received: from foss.arm.com ([217.140.110.172]:36268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgJFDAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:00:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62230113E;
        Mon,  5 Oct 2020 20:00:02 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CB993F71F;
        Mon,  5 Oct 2020 19:59:59 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event
 handling
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
 <1601387687-6077-3-git-send-email-anshuman.khandual@arm.com>
 <b51676eb-eb22-41be-5ff9-de63100d2201@redhat.com>
Message-ID: <fc4560c7-989a-b77a-202c-377d48ce8401@arm.com>
Date:   Tue, 6 Oct 2020 08:29:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b51676eb-eb22-41be-5ff9-de63100d2201@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2020 05:27 AM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 9/29/20 11:54 PM, Anshuman Khandual wrote:
>> This enables MEM_OFFLINE memory event handling. It will help intercept any
>> possible error condition such as if boot memory some how still got offlined
>> even after an explicit notifier failure, potentially by a future change in
>> generic hot plug framework. This would help detect such scenarios and help
>> debug further. While here, also call out the first section being attempted
>> for offline or got offlined.
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
>>   arch/arm64/mm/mmu.c | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
> 
> This looks good to me except a nit and it can be improved if
> that looks reasonable and only when you get a chance for
> respin.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 4e70f4fea06c..90a30f5ebfc0 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1482,13 +1482,38 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
>>       unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
>>       unsigned long pfn = arg->start_pfn;
>>   -    if (action != MEM_GOING_OFFLINE)
>> +    if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
>>           return NOTIFY_OK;
>>         for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +        unsigned long start = PFN_PHYS(pfn);
>> +        unsigned long end = start + (1UL << PA_SECTION_SHIFT);
>> +
>>           ms = __pfn_to_section(pfn);
>> -        if (early_section(ms))
>> +        if (!early_section(ms))
>> +            continue;
>> +
> 
> The discussion here is irrelevant to this patch itself. It seems
> early_section() is coarse, which means all memory detected during
> boot time won't be hotpluggable?

Right, thats the policy being enforced on arm64 platform for various
critical reasons. Please refer to earlier discussions around memory
hot remove development on arm64.

> 
>> +        if (action == MEM_GOING_OFFLINE) {
>> +            pr_warn("Boot memory [%lx %lx] offlining attempted\n", start, end);
>>               return NOTIFY_BAD;
>> +        } else if (action == MEM_OFFLINE) {
>> +            /*
>> +             * This should have never happened. Boot memory
>> +             * offlining should have been prevented by this
>> +             * very notifier. Probably some memory removal
>> +             * procedure might have changed which would then
>> +             * require further debug.
>> +             */
>> +            pr_err("Boot memory [%lx %lx] offlined\n", start, end);
>> +
>> +            /*
>> +             * Core memory hotplug does not process a return
>> +             * code from the notifier for MEM_OFFLINE event.
>> +             * Error condition has been reported. Report as
>> +             * ignored.
>> +             */
>> +            return NOTIFY_DONE;
>> +        }
>>       }
>>       return NOTIFY_OK;
>>   }
>>
> 
> I think NOTIFY_BAD is returned for MEM_OFFLINE wouldn't be a
> bad idea, even the core isn't handling the errno. With this,
> the code can be simplified. However, it's not a big deal and
> you probably evaluate and change when you need another respin:
> 
>     pr_warn("Boot memory [%lx %lx] %s\n",
>             (action == MEM_GOING_OFFLINE) ? "offlining attempted" : "offlined",
>             start, end);
>     return NOTIFY_BAD;

Wondering whether returning a NOTIFY_BAD for MEM_OFFLINE event could
be somewhat risky if generic hotplug mechanism to change later. But
again, probably it might just be OK.

Regardless, also wanted to differentiate error messages for both the
cases. An warning messages i.e pr_warn() for MEM_GOING_OFFLINE which
suggests an unexpected user action but an error message i.e pr_err()
for MEM_OFFLINE which clearly indicates an error condition that needs
to be debugged further.
