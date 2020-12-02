Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63072CBC64
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgLBMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:05:42 -0500
Received: from foss.arm.com ([217.140.110.172]:37478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgLBMFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:05:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B039101E;
        Wed,  2 Dec 2020 04:04:55 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086703F718;
        Wed,  2 Dec 2020 04:04:52 -0800 (PST)
Subject: Re: [PATCH V2 1/2] mm/debug_vm_pgtable/basic: Add validation for
 dirtiness after write protect
To:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        christophe.leroy@csgroup.eu, gerald.schaefer@linux.ibm.com,
        vgupta@synopsys.com, paul.walmsley@sifive.com
References: <1606825169-5229-1-git-send-email-anshuman.khandual@arm.com>
 <1606825169-5229-2-git-send-email-anshuman.khandual@arm.com>
 <5d07e798-aa91-ec00-36af-108ff0b19709@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a43f5d6e-2454-1400-fe8a-36b415ff9f9a@arm.com>
Date:   Wed, 2 Dec 2020 17:34:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5d07e798-aa91-ec00-36af-108ff0b19709@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/20 4:46 PM, Steven Price wrote:
> On 01/12/2020 12:19, Anshuman Khandual wrote:
>> This adds validation tests for dirtiness after write protect conversion for
>> each page table level. There are two new separate test types involved here.
>>
>> The first test ensures that a given page table entry does not become dirty
>> after pxx_wrprotect(). This is important for platforms like arm64 which
>> transfers and drops the hardware dirty bit (!PTE_RDONLY) to the software
>> dirty bit while making it an write protected one. This test ensures that
>> no fresh page table entry could be created with hardware dirty bit set.
>> The second test ensures that a given page table entry always preserve the
>> dirty information across pxx_wrprotect().
>>
>> This adds two previously missing PUD level basic tests and while here fixes
>> pxx_wrprotect() related typos in the documentation file.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   Documentation/vm/arch_pgtable_helpers.rst |  8 ++---
>>   mm/debug_vm_pgtable.c                     | 42 +++++++++++++++++++++++
>>   2 files changed, 46 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
>> index f3591ee3aaa8..552567d863b8 100644
>> --- a/Documentation/vm/arch_pgtable_helpers.rst
>> +++ b/Documentation/vm/arch_pgtable_helpers.rst
>> @@ -50,7 +50,7 @@ PTE Page Table Helpers
>>   +---------------------------+--------------------------------------------------+
>>   | pte_mkwrite               | Creates a writable PTE                           |
>>   +---------------------------+--------------------------------------------------+
>> -| pte_mkwrprotect           | Creates a write protected PTE                    |
>> +| pte_wrprotect             | Creates a write protected PTE                    |
>>   +---------------------------+--------------------------------------------------+
>>   | pte_mkspecial             | Creates a special PTE                            |
>>   +---------------------------+--------------------------------------------------+
>> @@ -120,7 +120,7 @@ PMD Page Table Helpers
>>   +---------------------------+--------------------------------------------------+
>>   | pmd_mkwrite               | Creates a writable PMD                           |
>>   +---------------------------+--------------------------------------------------+
>> -| pmd_mkwrprotect           | Creates a write protected PMD                    |
>> +| pmd_wrprotect             | Creates a write protected PMD                    |
>>   +---------------------------+--------------------------------------------------+
>>   | pmd_mkspecial             | Creates a special PMD                            |
>>   +---------------------------+--------------------------------------------------+
>> @@ -186,7 +186,7 @@ PUD Page Table Helpers
>>   +---------------------------+--------------------------------------------------+
>>   | pud_mkwrite               | Creates a writable PUD                           |
>>   +---------------------------+--------------------------------------------------+
>> -| pud_mkwrprotect           | Creates a write protected PUD                    |
>> +| pud_wrprotect             | Creates a write protected PUD                    |
>>   +---------------------------+--------------------------------------------------+
>>   | pud_mkdevmap              | Creates a ZONE_DEVICE mapped PUD                 |
>>   +---------------------------+--------------------------------------------------+
>> @@ -224,7 +224,7 @@ HugeTLB Page Table Helpers
>>   +---------------------------+--------------------------------------------------+
>>   | huge_pte_mkwrite          | Creates a writable HugeTLB                       |
>>   +---------------------------+--------------------------------------------------+
>> -| huge_pte_mkwrprotect      | Creates a write protected HugeTLB                |
>> +| huge_pte_wrprotect        | Creates a write protected HugeTLB                |
>>   +---------------------------+--------------------------------------------------+
>>   | huge_ptep_get_and_clear   | Clears a HugeTLB                                 |
>>   +---------------------------+--------------------------------------------------+
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index c05d9dcf7891..c6fffea54522 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -63,6 +63,17 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
>>       pte_t pte = pfn_pte(pfn, prot);
>>         pr_debug("Validating PTE basic\n");
>> +
>> +    /*
>> +     * This test needs to execute right after the given page
>> +     * table entry is created with pfn_pte() to make sure that
>> +     * protection_map[idx] does not have the dirty bit enabled
>> +     * from the beginning. This is particularly important for
>> +     * platforms like arm64 where (!PTE_RDONLY) indicate dirty
>> +     * bit being set.
>> +     */
> 
> Unless I'm seriously mistaken this comment is misleading - the likes of pte_wrprotect() take the PTE *by value* and return the modified version. So none of these tests actually modify the variable 'pte'. So there shouldn't actually be any restrictions on the ordering.
> 
> Or am I missing something?

No, you are right. Seems like I might have confused this for other page
table entry altering tests here (via pointers). Although it might still
be better to have these tests at the beginning as not to miss a freshly
created page table entry. That way the test would not be forgotten and
invalidated, in case the subsequent tests in the function change in the
future. So yes, the there is no restriction on the ordering here, as I
might have mentioned previously.

Looking at the comments again. It still seems to be applicable and valid
as it does not explicitly refer to the restriction on ordering here. It
just stresses on the point that it needs to execute right after creation
to test what was in protection_map[idx].
