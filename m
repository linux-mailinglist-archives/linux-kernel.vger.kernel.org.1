Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A402922B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgJSG5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:57:09 -0400
Received: from foss.arm.com ([217.140.110.172]:50572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbgJSG5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:57:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3F94D6E;
        Sun, 18 Oct 2020 23:57:07 -0700 (PDT)
Received: from [10.163.77.151] (unknown [10.163.77.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFA253F66E;
        Sun, 18 Oct 2020 23:57:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: allow hotpluggable sections to be offlined
To:     David Hildenbrand <david@redhat.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <c5f96b483158871ff65377884955fb0106e43951.1602899443.git.sudaraja@codeaurora.org>
 <04C5B822-70DF-47CF-9F76-2A31843B01E8@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7b614485-fe2d-9167-dfc9-d6affdb28c88@arm.com>
Date:   Mon, 19 Oct 2020 12:26:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <04C5B822-70DF-47CF-9F76-2A31843B01E8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2020 01:04 PM, David Hildenbrand wrote:
> 
>> Am 17.10.2020 um 04:03 schrieb Sudarshan Rajagopalan <sudaraja@codeaurora.org>:
>>
>> ﻿On receiving the MEM_GOING_OFFLINE notification, we disallow offlining of
>> any boot memory by checking if section_early or not. With the introduction
>> of SECTION_MARK_HOTPLUGGABLE, allow boot mem sections that are marked as
>> hotpluggable with this bit set to be offlined and removed. This now allows
>> certain boot mem sections to be offlined.
>>
> 
> The check (notifier) is in arm64 code. I don‘t see why you cannot make such decisions completely in arm64 code? Why would you have to mark sections?
> 
> Also, I think I am missing from *where* the code that marks sections removable is even called? Who makes such decisions?

From the previous patch.

+EXPORT_SYMBOL_GPL(mark_memory_hotpluggable);

> 
> This feels wrong. 
> 
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Gavin Shan <gshan@redhat.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> ---
>> arch/arm64/mm/mmu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 75df62fea1b6..fb8878698672 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1487,7 +1487,7 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
>>
>>    for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>>        ms = __pfn_to_section(pfn);
>> -        if (early_section(ms))
>> +        if (early_section(ms) && !removable_section(ms))

Till challenges related to boot memory removal on arm64 platform get
resolved, no portion of boot memory can be offlined. Let alone via a
driver making such decisions.

>>            return NOTIFY_BAD;
>>    }
>>    return NOTIFY_OK;
>> -- 
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 
> 
