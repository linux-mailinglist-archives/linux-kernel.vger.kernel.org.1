Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721C1276774
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIXDvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:51:44 -0400
Received: from foss.arm.com ([217.140.110.172]:33398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgIXDvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:51:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CADAC30E;
        Wed, 23 Sep 2020 20:51:43 -0700 (PDT)
Received: from [10.163.75.147] (unknown [10.163.75.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69FAF3F73B;
        Wed, 23 Sep 2020 20:51:40 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event
 handling
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.com>,
        catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, will@kernel.org
References: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
 <1600689908-28213-3-git-send-email-anshuman.khandual@arm.com>
 <d4e90ed2-f348-0d80-b3d7-d156abe05a90@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <520ea3e4-59ee-deca-3847-c57272e4fc8e@arm.com>
Date:   Thu, 24 Sep 2020 09:21:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d4e90ed2-f348-0d80-b3d7-d156abe05a90@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/2020 12:01 PM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 9/21/20 10:05 PM, Anshuman Khandual wrote:
>> This enables MEM_OFFLINE memory event handling. It will help intercept any
>> possible error condition such as if boot memory some how still got offlined
>> even after an explicit notifier failure, potentially by a future change in
>> generic hot plug framework. This would help detect such scenarios and help
>> debug further.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Steve Capper <steve.capper@arm.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
> 
> I'm not sure if it makes sense since MEM_OFFLINE won't be triggered
> after NOTIFY_BAD is returned from MEM_GOING_OFFLINE. NOTIFY_BAD means
> the whole offline process is stopped. It would be guranteed by generic
> framework from syntax standpoint.

Right but the intent here is to catch any deviation in generic hotplug
semantics going forward.
 > 
> However, this looks good if MEM_OFFLINE is triggered without calling
> into MEM_GOING_OFFLINE previously, but it would be a bug from generic
> framework.

Exactly, this will just ensure that we know about any change or a bug
in the generic framework. But if required, this additional check can
be enabled only with DEBUG_VM.

> 
>>   arch/arm64/mm/mmu.c | 37 ++++++++++++++++++++++++++++++++-----
>>   1 file changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index df3b7415b128..6b171bd88bcf 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1482,13 +1482,40 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
>>       unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
>>       unsigned long pfn = arg->start_pfn;
>>   -    if (action != MEM_GOING_OFFLINE)
>> +    if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
>>           return NOTIFY_OK;
>>   -    for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> -        ms = __pfn_to_section(pfn);
>> -        if (early_section(ms))
>> -            return NOTIFY_BAD;
>> +    if (action == MEM_GOING_OFFLINE) {
>> +        for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +            ms = __pfn_to_section(pfn);
>> +            if (early_section(ms)) {
>> +                pr_warn("Boot memory offlining attempted\n");
>> +                return NOTIFY_BAD;
>> +            }
>> +        }
>> +    } else if (action == MEM_OFFLINE) {
>> +        for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +            ms = __pfn_to_section(pfn);
>> +            if (early_section(ms)) {
>> +
>> +                /*
>> +                 * This should have never happened. Boot memory
>> +                 * offlining should have been prevented by this
>> +                 * very notifier. Probably some memory removal
>> +                 * procedure might have changed which would then
>> +                 * require further debug.
>> +                 */
>> +                pr_err("Boot memory offlined\n");
>> +
>> +                /*
>> +                 * Core memory hotplug does not process a return
>> +                 * code from the notifier for MEM_OFFLINE event.
>> +                 * Error condition has been reported. Report as
>> +                 * ignored.
>> +                 */
>> +                return NOTIFY_DONE;
>> +            }
>> +        }
>>       }
>>       return NOTIFY_OK;
>>   }
>>
> 
> It's pretty much irrelevant comment if the patch doesn't make sense:
> the logical block for MEM_GOING_OFFLINE would be reused by MEM_OFFLINE
> as they looks similar except the return value and error message :)

This can be reorganized in the above mentioned format as well. Without
much additional code or iteration, it might not need DEBUG_VM as well.

for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
	ms = __pfn_to_section(pfn);
	if (!early_section(ms))
		continue;

	if (action == MEM_GOING_OFFLINE) {
		pr_warn("Boot memory offlining attempted\n");
		return NOTIFY_BAD;
	}
	else if (action == MEM_OFFLINE) {
		pr_err("Boot memory offlined\n");
		return NOTIFY_DONE;
	}
}
return NOTIFY_OK;
