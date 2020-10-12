Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9210728AC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 05:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgJLD15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727192AbgJLD1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602473273;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGTfwG3/sHnIhb0WVLgS4K0YiOCxB6397nuB7iEaVrA=;
        b=h8KpEHltuqCfCYHDmbApKtsNbo3fWuxt7wdyW6FYUQBxfZvP8XChGml9ZAO32BoVxZVpRd
        yKmjDgEBeZalT1d49Xvo6YWEE7ncD06J7rip1J5lqgF7Lp+rQVZ5DfE7XTcla8sVJC6Zty
        +rYGqMEZX9iGYmXw/Nl/yWSn0xC+Ngg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-tMrKqr33MlioX2jj67NRtw-1; Sun, 11 Oct 2020 23:27:48 -0400
X-MC-Unique: tMrKqr33MlioX2jj67NRtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B88E41868402;
        Mon, 12 Oct 2020 03:27:46 +0000 (UTC)
Received: from [10.64.54.32] (vpn2-54-32.bne.redhat.com [10.64.54.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A6E060C05;
        Mon, 12 Oct 2020 03:27:43 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH V4 2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event
 handling
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
 <1601387687-6077-3-git-send-email-anshuman.khandual@arm.com>
 <b51676eb-eb22-41be-5ff9-de63100d2201@redhat.com>
 <fc4560c7-989a-b77a-202c-377d48ce8401@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <1bf2a0d9-ef0e-2548-511f-c9ee6884a122@redhat.com>
Date:   Mon, 12 Oct 2020 14:27:41 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fc4560c7-989a-b77a-202c-377d48ce8401@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 10/6/20 1:59 PM, Anshuman Khandual wrote:
> On 10/01/2020 05:27 AM, Gavin Shan wrote:
>> On 9/29/20 11:54 PM, Anshuman Khandual wrote:
>>> This enables MEM_OFFLINE memory event handling. It will help intercept any
>>> possible error condition such as if boot memory some how still got offlined
>>> even after an explicit notifier failure, potentially by a future change in
>>> generic hot plug framework. This would help detect such scenarios and help
>>> debug further. While here, also call out the first section being attempted
>>> for offline or got offlined.
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
>>>    arch/arm64/mm/mmu.c | 29 +++++++++++++++++++++++++++--
>>>    1 file changed, 27 insertions(+), 2 deletions(-)
>>>
>>
>> This looks good to me except a nit and it can be improved if
>> that looks reasonable and only when you get a chance for
>> respin.
>>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 4e70f4fea06c..90a30f5ebfc0 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1482,13 +1482,38 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
>>>        unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
>>>        unsigned long pfn = arg->start_pfn;
>>>    -    if (action != MEM_GOING_OFFLINE)
>>> +    if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
>>>            return NOTIFY_OK;
>>>          for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>>> +        unsigned long start = PFN_PHYS(pfn);
>>> +        unsigned long end = start + (1UL << PA_SECTION_SHIFT);
>>> +
>>>            ms = __pfn_to_section(pfn);
>>> -        if (early_section(ms))
>>> +        if (!early_section(ms))
>>> +            continue;
>>> +
>>
>> The discussion here is irrelevant to this patch itself. It seems
>> early_section() is coarse, which means all memory detected during
>> boot time won't be hotpluggable?
> 
> Right, thats the policy being enforced on arm64 platform for various
> critical reasons. Please refer to earlier discussions around memory
> hot remove development on arm64.
> 

Thanks for the hints.

>>
>>> +        if (action == MEM_GOING_OFFLINE) {
>>> +            pr_warn("Boot memory [%lx %lx] offlining attempted\n", start, end);
>>>                return NOTIFY_BAD;
>>> +        } else if (action == MEM_OFFLINE) {
>>> +            /*
>>> +             * This should have never happened. Boot memory
>>> +             * offlining should have been prevented by this
>>> +             * very notifier. Probably some memory removal
>>> +             * procedure might have changed which would then
>>> +             * require further debug.
>>> +             */
>>> +            pr_err("Boot memory [%lx %lx] offlined\n", start, end);
>>> +
>>> +            /*
>>> +             * Core memory hotplug does not process a return
>>> +             * code from the notifier for MEM_OFFLINE event.
>>> +             * Error condition has been reported. Report as
>>> +             * ignored.
>>> +             */
>>> +            return NOTIFY_DONE;
>>> +        }
>>>        }
>>>        return NOTIFY_OK;
>>>    }
>>>
>>
>> I think NOTIFY_BAD is returned for MEM_OFFLINE wouldn't be a
>> bad idea, even the core isn't handling the errno. With this,
>> the code can be simplified. However, it's not a big deal and
>> you probably evaluate and change when you need another respin:
>>
>>      pr_warn("Boot memory [%lx %lx] %s\n",
>>              (action == MEM_GOING_OFFLINE) ? "offlining attempted" : "offlined",
>>              start, end);
>>      return NOTIFY_BAD;
> 
> Wondering whether returning a NOTIFY_BAD for MEM_OFFLINE event could
> be somewhat risky if generic hotplug mechanism to change later. But
> again, probably it might just be OK.
> 
> Regardless, also wanted to differentiate error messages for both the
> cases. An warning messages i.e pr_warn() for MEM_GOING_OFFLINE which
> suggests an unexpected user action but an error message i.e pr_err()
> for MEM_OFFLINE which clearly indicates an error condition that needs
> to be debugged further.
> 

Ok, fair enough and it looks good to me either.

Cheers,
Gavin


