Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E9D2C7D90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 05:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgK3EZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 23:25:56 -0500
Received: from foss.arm.com ([217.140.110.172]:48966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgK3EZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 23:25:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7B930E;
        Sun, 29 Nov 2020 20:25:10 -0800 (PST)
Received: from [10.163.84.86] (unknown [10.163.84.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 882B03F23F;
        Sun, 29 Nov 2020 20:25:07 -0800 (PST)
Subject: Re: [PATCH 1/2] mm/debug_vm_pgtable/basic: Add validation for
 dirtiness after write protect
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        gerald.schaefer@linux.ibm.com, vgupta@synopsys.com,
        paul.walmsley@sifive.com
References: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
 <1606453584-15399-2-git-send-email-anshuman.khandual@arm.com>
 <a6f79aba-9f9f-326f-5d73-6e0175f554ab@csgroup.eu>
 <20201127094421.GA25070@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9d9e5c8b-08f6-9ed4-074c-3dafc8fa3717@arm.com>
Date:   Mon, 30 Nov 2020 09:55:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201127094421.GA25070@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/20 3:14 PM, Catalin Marinas wrote:
> On Fri, Nov 27, 2020 at 09:22:24AM +0100, Christophe Leroy wrote:
>> Le 27/11/2020 à 06:06, Anshuman Khandual a écrit :
>>> This adds validation tests for dirtiness after write protect conversion for
>>> each page table level. This is important for platforms such as arm64 that
>>> removes the hardware dirty bit while making it an write protected one. This
>>> also fixes pxx_wrprotect() related typos in the documentation file.
>>
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index c05d9dcf7891..a5be11210597 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -70,6 +70,7 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
>>>   	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
>>>   	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
>>>   	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
>>> +	WARN_ON(pte_dirty(pte_wrprotect(pte)));
>>
>> Wondering what you are testing here exactly.
>>
>> Do you expect that if PTE has the dirty bit, it gets cleared by pte_wrprotect() ?
>>
>> Powerpc doesn't do that, it only clears the RW bit but the dirty bit remains
>> if it is set, until you call pte_mkclean() explicitely.
> 
> Arm64 has an unusual way of setting a hardware dirty "bit", it actually
> clears the PTE_RDONLY bit. The pte_wrprotect() sets the PTE_RDONLY bit
> back and we can lose the dirty information. Will found this and posted
> patches to fix the arm64 pte_wprotect() to set a software PTE_DIRTY if
> !PTE_RDONLY (we do this for ptep_set_wrprotect() already). My concern
> was that we may inadvertently make a fresh/clean pte dirty with such
> change, hence the suggestion for the test.
> 
> That said, I think we also need a test in the other direction,
> pte_wrprotect() should preserve any dirty information:
> 
> 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));

This seems like a generic enough principle which all platforms should
adhere to. But the proposed test WARN_ON(pte_dirty(pte_wrprotect(pte)))
might fail on some platforms if the page table entry came in as a dirty
one and pte_wrprotect() is not expected to alter the dirty state.

Instead, should we just add the following two tests, which would ensure
that pte_wrprotect() never alters the dirty state of a page table entry.

WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));

> 
> If pte_mkwrite() makes a pte truly writable and potentially dirty, we
> could also add a test as below. However, I think that's valid for arm64,
> other architectures with a separate hardware dirty bit would fail this:
> 
> 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkwrite(pte))));

Right.
