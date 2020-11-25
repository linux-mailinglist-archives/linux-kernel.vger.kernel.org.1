Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098032C4756
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbgKYSNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:13:12 -0500
Received: from foss.arm.com ([217.140.110.172]:36040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730643AbgKYSNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:13:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3860C31B;
        Wed, 25 Nov 2020 10:13:11 -0800 (PST)
Received: from [172.16.1.114] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD4F33F23F;
        Wed, 25 Nov 2020 10:13:08 -0800 (PST)
Subject: Re: [PATCH v4 2/2] arm64: kvm: Introduce MTE VCPU feature
To:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20201026155727.36685-1-steven.price@arm.com>
 <20201026155727.36685-3-steven.price@arm.com> <X7P1VLZhBh045tsr@trantor>
 <f34b3d16-8bc7-af9d-c0e0-fb114d2465aa@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4212c864-805a-cef4-7138-0f8995cadf5e@arm.com>
Date:   Wed, 25 Nov 2020 18:13:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f34b3d16-8bc7-af9d-c0e0-fb114d2465aa@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven, Catalin,

On 18/11/2020 16:01, Steven Price wrote:
> On 17/11/2020 16:07, Catalin Marinas wrote:
>> On Mon, Oct 26, 2020 at 03:57:27PM +0000, Steven Price wrote:
>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>> index 19aacc7d64de..38fe25310ca1 100644
>>> --- a/arch/arm64/kvm/mmu.c
>>> +++ b/arch/arm64/kvm/mmu.c
>>> @@ -862,6 +862,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t
>>> fault_ipa,
>>>       if (vma_pagesize == PAGE_SIZE && !force_pte)
>>>           vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>>                                  &pfn, &fault_ipa);
>>> +
>>> +    /*
>>> +     * The otherwise redundant test for system_supports_mte() allows the
>>> +     * code to be compiled out when CONFIG_ARM64_MTE is not present.
>>> +     */
>>> +    if (system_supports_mte() && kvm->arch.mte_enabled && pfn_valid(pfn)) {
>>> +        /*
>>> +         * VM will be able to see the page's tags, so we must ensure
>>> +         * they have been initialised.
>>> +         */
>>> +        struct page *page = pfn_to_page(pfn);
>>> +        long i, nr_pages = compound_nr(page);
>>> +
>>> +        /* if PG_mte_tagged is set, tags have already been initialised */
>>> +        for (i = 0; i < nr_pages; i++, page++) {
>>> +            if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>>> +                mte_clear_page_tags(page_address(page));
>>> +        }
>>> +    }
>>
>> If this page was swapped out and mapped back in, where does the
>> restoring from swap happen?
> 
> Restoring from swap happens above this in the call to gfn_to_pfn_prot()
> 
>> I may have asked in the past, is user_mem_abort() the only path for
>> mapping Normal pages into stage 2?
>>
> 
> That is my understanding (and yes you asked before) and no one has corrected me! ;)

A recent discovery: Copy on write will cause kvm_set_spte_handler() to fixup the mapping
(instead of just invalidating it) on the assumption the guest is going to read whatever
was written.

Its possible user_mem_abort() will go and stomp on that mapping a second time, but if the
VMM triggers this at stage1, you won't have a vcpu for the update.


Thanks,

James
