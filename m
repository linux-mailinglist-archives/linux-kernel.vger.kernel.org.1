Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7432C82B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgK3K7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:59:12 -0500
Received: from foss.arm.com ([217.140.110.172]:52392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgK3K7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:59:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F163830E;
        Mon, 30 Nov 2020 02:58:25 -0800 (PST)
Received: from [10.163.84.86] (unknown [10.163.84.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696203F66B;
        Mon, 30 Nov 2020 02:58:23 -0800 (PST)
Subject: Re: [PATCH 1/2] mm/debug_vm_pgtable/basic: Add validation for
 dirtiness after write protect
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        steven.price@arm.com, gerald.schaefer@linux.ibm.com,
        vgupta@synopsys.com, paul.walmsley@sifive.com
References: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
 <1606453584-15399-2-git-send-email-anshuman.khandual@arm.com>
 <a6f79aba-9f9f-326f-5d73-6e0175f554ab@csgroup.eu>
 <20201127094421.GA25070@gaia> <9d9e5c8b-08f6-9ed4-074c-3dafc8fa3717@arm.com>
 <20201130093841.GA3902@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <171a4e71-b1ab-3ff5-7088-54781d960b2a@arm.com>
Date:   Mon, 30 Nov 2020 16:28:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130093841.GA3902@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/20 3:08 PM, Catalin Marinas wrote:
> On Mon, Nov 30, 2020 at 09:55:00AM +0530, Anshuman Khandual wrote:
>> On 11/27/20 3:14 PM, Catalin Marinas wrote:
>>> On Fri, Nov 27, 2020 at 09:22:24AM +0100, Christophe Leroy wrote:
>>>> Le 27/11/2020 à 06:06, Anshuman Khandual a écrit :
>>>>> This adds validation tests for dirtiness after write protect conversion for
>>>>> each page table level. This is important for platforms such as arm64 that
>>>>> removes the hardware dirty bit while making it an write protected one. This
>>>>> also fixes pxx_wrprotect() related typos in the documentation file.
>>>>
>>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>>> index c05d9dcf7891..a5be11210597 100644
>>>>> --- a/mm/debug_vm_pgtable.c
>>>>> +++ b/mm/debug_vm_pgtable.c
>>>>> @@ -70,6 +70,7 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
>>>>>   	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
>>>>>   	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
>>>>>   	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
>>>>> +	WARN_ON(pte_dirty(pte_wrprotect(pte)));
>>>>
>>>> Wondering what you are testing here exactly.
>>>>
>>>> Do you expect that if PTE has the dirty bit, it gets cleared by
>>>> pte_wrprotect() ?
>>>>
>>>> Powerpc doesn't do that, it only clears the RW bit but the dirty
>>>> bit remains if it is set, until you call pte_mkclean() explicitely.
>>>
>>> Arm64 has an unusual way of setting a hardware dirty "bit", it actually
>>> clears the PTE_RDONLY bit. The pte_wrprotect() sets the PTE_RDONLY bit
>>> back and we can lose the dirty information. Will found this and posted
>>> patches to fix the arm64 pte_wprotect() to set a software PTE_DIRTY if
>>> !PTE_RDONLY (we do this for ptep_set_wrprotect() already). My concern
>>> was that we may inadvertently make a fresh/clean pte dirty with such
>>> change, hence the suggestion for the test.
>>>
>>> That said, I think we also need a test in the other direction,
>>> pte_wrprotect() should preserve any dirty information:
>>>
>>> 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>>
>> This seems like a generic enough principle which all platforms should
>> adhere to. But the proposed test WARN_ON(pte_dirty(pte_wrprotect(pte)))
>> might fail on some platforms if the page table entry came in as a dirty
>> one and pte_wrprotect() is not expected to alter the dirty state.
> 
> Ah, so do we have architectures where entries in protection_map[] are
> already dirty? If those are valid, maybe the check should be:

Okay, I did not imply that actually. The current position for these new
tests in respective pxx_basic_tests() functions is right at the end and
hence the pxx might have already gone through some changes from the time
it was originally created with pfn_pxx(). The entry here is not starting
from the beginning. It is not expected as well, per design. So dirty bit
might or might not be there depending on all the previous test sequences
leading upto these new ones.

IIUC, Christophe mentioned the fact that on platforms like powerpc, dirty
bit just remains unchanged during pte_wprotect(). So the current test
WARN_ON(pte_dirty(pte_wrprotect(pte))) will not work on powerpc if the
previous tests leading upto that point has got the dirty bit set. This is
irrespective of how it was created with pfn_pte() from protection_map[]
originally at the beginning.

> 
> 	WARN_ON(!pte_dirty(pte) && pte_dirty(pte_wrprotect(pte)));
> 
>> Instead, should we just add the following two tests, which would ensure
>> that pte_wrprotect() never alters the dirty state of a page table entry.
>>
>> WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>> WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
> 
> These should be added as additional tests. However, my initial thought

Okay, will add them.

> was to check whether pte_wrprotect() on a new pte created from a
> protection_map[] entry directly would inadvertently dirty it. On arm64,
> that means a protection_map[] entry missing PTE_RDONLY. A pte_mkclean()
> would set PTE_RDONLY, so we'd miss such check.
> 

To achieve this, we could move the test right at the beginning just after
the pxx gets created from protection_map[], with a comment explaining the
rationale. 
