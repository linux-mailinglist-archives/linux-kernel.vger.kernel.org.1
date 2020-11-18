Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA532B824F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgKRQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgKRQuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:50:12 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47CF2483F;
        Wed, 18 Nov 2020 16:50:04 +0000 (UTC)
Date:   Wed, 18 Nov 2020 16:50:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
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
Subject: Re: [PATCH v4 2/2] arm64: kvm: Introduce MTE VCPU feature
Message-ID: <X7VQua7YO4isMFPU@trantor>
References: <20201026155727.36685-1-steven.price@arm.com>
 <20201026155727.36685-3-steven.price@arm.com>
 <X7P1VLZhBh045tsr@trantor>
 <f34b3d16-8bc7-af9d-c0e0-fb114d2465aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34b3d16-8bc7-af9d-c0e0-fb114d2465aa@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:01:20PM +0000, Steven Price wrote:
> On 17/11/2020 16:07, Catalin Marinas wrote:
> > On Mon, Oct 26, 2020 at 03:57:27PM +0000, Steven Price wrote:
> > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > index 19aacc7d64de..38fe25310ca1 100644
> > > --- a/arch/arm64/kvm/mmu.c
> > > +++ b/arch/arm64/kvm/mmu.c
> > > @@ -862,6 +862,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > >   	if (vma_pagesize == PAGE_SIZE && !force_pte)
> > >   		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
> > >   							   &pfn, &fault_ipa);
> > > +
> > > +	/*
> > > +	 * The otherwise redundant test for system_supports_mte() allows the
> > > +	 * code to be compiled out when CONFIG_ARM64_MTE is not present.
> > > +	 */
> > > +	if (system_supports_mte() && kvm->arch.mte_enabled && pfn_valid(pfn)) {
> > > +		/*
> > > +		 * VM will be able to see the page's tags, so we must ensure
> > > +		 * they have been initialised.
> > > +		 */
> > > +		struct page *page = pfn_to_page(pfn);
> > > +		long i, nr_pages = compound_nr(page);
> > > +
> > > +		/* if PG_mte_tagged is set, tags have already been initialised */
> > > +		for (i = 0; i < nr_pages; i++, page++) {
> > > +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> > > +				mte_clear_page_tags(page_address(page));
> > > +		}
> > > +	}
> > 
> > If this page was swapped out and mapped back in, where does the
> > restoring from swap happen?
> 
> Restoring from swap happens above this in the call to gfn_to_pfn_prot()

Looking at the call chain, gfn_to_pfn_prot() ends up with
get_user_pages() using the current->mm (the VMM) and that does a
set_pte_at(), presumably restoring the tags. Does this mean that all
memory mapped by the VMM in user space should have PROT_MTE set?
Otherwise we don't take the mte_sync_tags() path in set_pte_at() and no
tags restored from swap (we do save them since when they were mapped,
PG_mte_tagged was set).

So I think the code above should be similar to mte_sync_tags(), even
calling a common function, but I'm not sure where to get the swap pte
from.

An alternative is to only enable HCR_EL2.ATA and MTE in guest if the vmm
mapped the memory with PROT_MTE.

Yet another option is to always call mte_sync_tags() from set_pte_at()
and defer the pte_tagged() or is_swap_pte() checks to the MTE code.

-- 
Catalin
