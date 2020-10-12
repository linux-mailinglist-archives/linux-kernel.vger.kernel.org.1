Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AB28ACAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgJLEIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 00:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgJLEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 00:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602475683;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPFNRicNHEm5+9nR6GRgjdYGrulZesq1Xk7YBtFZUvk=;
        b=KC26//RcOzDEkf67LmnJjdlFNKZX1QpNecLHEKoa1BNAWXj5aHfkYjdzDh5U+4U17iWWhJ
        u04cfhJfMPUPANZGiFVYBoc8Hvydg5BYL/E4AANjVQWFvB0VVNy3FlIFOgDVAUoYaXKDsg
        /PobOv87WuRP1H/93yubIqIu/eN3ePA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Tli8Zf_CNjaMJNrtgGQRbA-1; Mon, 12 Oct 2020 00:07:58 -0400
X-MC-Unique: Tli8Zf_CNjaMJNrtgGQRbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12DD780EF8B;
        Mon, 12 Oct 2020 04:07:57 +0000 (UTC)
Received: from [10.64.54.32] (vpn2-54-32.bne.redhat.com [10.64.54.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F094B19D61;
        Mon, 12 Oct 2020 04:07:53 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH V4 3/3] arm64/mm/hotplug: Ensure early memory sections are
 all online
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
 <1601387687-6077-4-git-send-email-anshuman.khandual@arm.com>
 <471fed64-0f61-9c16-3943-2bb8f77ee810@redhat.com>
 <8489f045-e94c-a3cc-3fc3-a7d92d19bca6@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <f73269a5-8236-b5eb-fb06-40f14bcb1014@redhat.com>
Date:   Mon, 12 Oct 2020 15:07:51 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8489f045-e94c-a3cc-3fc3-a7d92d19bca6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 10/6/20 2:11 PM, Anshuman Khandual wrote:
> On 10/01/2020 06:23 AM, Gavin Shan wrote:
>> On 9/29/20 11:54 PM, Anshuman Khandual wrote:
>>> This adds a validation function that scans the entire boot memory and makes
>>> sure that all early memory sections are online. This check is essential for
>>> the memory notifier to work properly, as it cannot prevent any boot memory
>>> from offlining, if all sections are not online to begin with. The notifier
>>> registration is skipped, if this validation does not go through. Although
>>> the boot section scanning is selectively enabled with DEBUG_VM.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Steve Capper <steve.capper@arm.com>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    arch/arm64/mm/mmu.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 59 insertions(+)
>>
>> I don't understand why this is necessary. The core already ensure the
>> corresponding section is online when trying to offline it. It's guranteed
>> that section is online when the notifier is triggered. I'm not sure if
>> there is anything I missed?
> 
> Current memory notifier blocks any boot memory hot removal attempt via
> blocking its offlining step itself. So if some sections in boot memory
> are not online (because of a bug or change in init sequence) by the
> time memory block device can be removed, the notifier loses the ability
> to prevent its removal. This validation here, ensures that entire boot
> memory is in online state, otherwise call out sections that are not,
> with an warning that those boot memory can be removed.
> 

Well. I think it should be very rare. I guess you don't observe the
errornous case so far? However, I think it's fine to add the check
since it's only enabled with CONFIG_DEBUG_VM.

>>   
>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 90a30f5ebfc0..b67a657ea1ad 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1522,6 +1522,62 @@ static struct notifier_block prevent_bootmem_remove_nb = {
>>>        .notifier_call = prevent_bootmem_remove_notifier,
>>>    };
>>>    +/*
>>> + * This ensures that boot memory sections on the plaltform are online
> 
> Will fix.
> 
>>                                                      ^^^^^^^^^
>>> + * during early boot. They could not be prevented from being offlined
>>> + * if for some reason they are not brought online to begin with. This
>>> + * help validate the basic assumption on which the above memory event
>>> + * notifier works to prevent boot memory offlining and it's possible
>>> + * removal.
>>> + */
>>> +static bool validate_bootmem_online(void)
>>> +{
>>> +    struct memblock_region *mblk;
>>> +    struct mem_section *ms;
>>> +    unsigned long pfn, end_pfn, start, end;
>>> +    bool all_online = true;
>>> +
>>> +    /*
>>> +     * Scanning across all memblock might be expensive
>>> +     * on some big memory systems. Hence enable this
>>> +     * validation only with DEBUG_VM.
>>> +     */
>>> +    if (!IS_ENABLED(CONFIG_DEBUG_VM))
>>> +        return all_online;
>>> +
>>> +    for_each_memblock(memory, mblk) {
>>> +        pfn = PHYS_PFN(mblk->base);
>>> +        end_pfn = PHYS_PFN(mblk->base + mblk->size);
>>> +
>>
>> It's not a good idea to access @mblk->{base, size}. There are two
>> accessors: memblock_region_memory_{base, end}_pfn().
> 
> Sure, will replace.
> 
>>
>>> +        for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>>> +            ms = __pfn_to_section(pfn);
>>> +
>>> +            /*
>>> +             * All memory ranges in the system at this point
>>> +             * should have been marked early sections.
>>> +             */
>>> +            WARN_ON(!early_section(ms));
>>> +
>>> +            /*
>>> +             * Memory notifier mechanism here to prevent boot
>>> +             * memory offlining depends on the fact that each
>>> +             * early section memory on the system is intially
>>> +             * online. Otherwise a given memory section which
>>> +             * is already offline will be overlooked and can
>>> +             * be removed completely. Call out such sections.
>>> +             */
>>
>> s/intially/initially
> 
> Will change.
> 
>>
>>> +            if (!online_section(ms)) {
>>> +                start = PFN_PHYS(pfn);
>>> +                end = start + (1UL << PA_SECTION_SHIFT);
>>> +                pr_err("Memory range [%lx %lx] is offline\n", start, end);
>>> +                pr_err("Memory range [%lx %lx] can be removed\n", start, end);
>>> +                all_online = false;
>>
>> These two error messages can be combined:
>>
>>      pr_err("Memory range [%lx %lx] not online, can't be offlined\n",
>>             start, end);
> 
> Will change but it is actually s/can't be offlined/can be removed/ instead.
> 
>>
>> I think you need to return @all_online immediately, without
>> checking if the subsequent sections are online or not? :)
> 
> Thinking about this again. It might be better if the notifier registration
> does not depend on return value from validate_bootmem_online(). Instead it
> should proceed either way but after calling out all boot memory sections
> that are not online. In that case notifier will atleast prevent removal of
> some parts of boot memory which are online.
> 

Yes, agreed. However, the most important part is to print the errornous
messages introduced in validate_bootmem_online().

Cheers,
Gavin


