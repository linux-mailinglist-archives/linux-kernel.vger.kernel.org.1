Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8127D29A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgI2PW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2PW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:22:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E292B208B8;
        Tue, 29 Sep 2020 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601392947;
        bh=6+pAYWhd5mLp30y8JP332t0gBBaZByzHm+u75TU8reo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkyqmMn8tbgvgvk/Min2gjrvPHuc22k13B4wYGI/3+sAHTib7cW1WS94x132d6J4p
         2Fn5gwXnAIZkyjNCJ+8HKefgu5KlDXVSHkh8cVGXOw++7g5MR4XcxtpO/bYCASWJlx
         etPrj0Ah7uY4prVUGGWJpRU9Pyjo5R9WzrAgI1ag=
Date:   Tue, 29 Sep 2020 16:22:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear
 mapping
Message-ID: <20200929152221.GA13995@willie-the-truck>
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <20200928203539.GA12218@willie-the-truck>
 <09266aed-7eef-5b16-5d52-0dcb7dcb7246@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09266aed-7eef-5b16-5d52-0dcb7dcb7246@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:34:24PM +0530, Anshuman Khandual wrote:
> 
> 
> On 09/29/2020 02:05 AM, Will Deacon wrote:
> > On Thu, Sep 17, 2020 at 02:16:42PM +0530, Anshuman Khandual wrote:
> >> During memory hotplug process, the linear mapping should not be created for
> >> a given memory range if that would fall outside the maximum allowed linear
> >> range. Else it might cause memory corruption in the kernel virtual space.
> >>
> >> Maximum linear mapping region is [PAGE_OFFSET..(PAGE_END -1)] accommodating
> >> both its ends but excluding PAGE_END. Max physical range that can be mapped
> >> inside this linear mapping range, must also be derived from its end points.
> >>
> >> When CONFIG_ARM64_VA_BITS_52 is enabled, PAGE_OFFSET is computed with the
> >> assumption of 52 bits virtual address space. However, if the CPU does not
> >> support 52 bits, then it falls back using 48 bits instead and the PAGE_END
> >> is updated to reflect this using the vabits_actual. As for PAGE_OFFSET,
> >> bits [51..48] are ignored by the MMU and remain unchanged, even though the
> >> effective start address of linear map is now slightly different. Hence, to
> >> reliably check the physical address range mapped by the linear map, the
> >> start address should be calculated using vabits_actual. This ensures that
> >> arch_add_memory() validates memory hot add range for its potential linear
> >> mapping requirement, before creating it with __create_pgd_mapping().
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: Steven Price <steven.price@arm.com>
> >> Cc: Robin Murphy <robin.murphy@arm.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/arm64/mm/mmu.c | 27 +++++++++++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>
> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index 75df62fea1b6..d59ffabb9c84 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> >> @@ -1433,11 +1433,38 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
> >>  	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
> >>  }
> >>  
> >> +static bool inside_linear_region(u64 start, u64 size)
> >> +{
> >> +	/*
> >> +	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
> >> +	 * accommodating both its ends but excluding PAGE_END. Max physical
> >> +	 * range which can be mapped inside this linear mapping range, must
> >> +	 * also be derived from its end points.
> >> +	 *
> >> +	 * With CONFIG_ARM64_VA_BITS_52 enabled, PAGE_OFFSET is defined with
> >> +	 * the assumption of 52 bits virtual address space. However, if the
> >> +	 * CPU does not support 52 bits, it falls back using 48 bits and the
> >> +	 * PAGE_END is updated to reflect this using the vabits_actual. As
> >> +	 * for PAGE_OFFSET, bits [51..48] are ignored by the MMU and remain
> >> +	 * unchanged, even though the effective start address of linear map
> >> +	 * is now slightly different. Hence, to reliably check the physical
> >> +	 * address range mapped by the linear map, the start address should
> >> +	 * be calculated using vabits_actual.
> >> +	 */
> >> +	return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
> >> +			&& ((start + size) <= __pa(PAGE_END - 1)));
> >> +}
> > 
> > Why isn't this implemented using the existing __is_lm_address()?
> 
> Not sure, if I understood your suggestion here. The physical address range
> [start..start + size] needs to be checked against maximum physical range
> that can be represented inside effective boundaries for the linear mapping
> i.e [__pa(_PAGE_OFFSET(vabits_actual)..__pa(PAGE_END - 1)].
> 
> Are you suggesting [start..start + size] should be first be converted into
> a virtual address range and then checked against __is_lm_addresses() ? But
> is not deriving the physical range from from know limits of linear mapping
> much cleaner ?

I just think having a function called "inside_linear_region()" as well as a
macro called "__is_lm_address()" is weird when they have completely separate
implementations. They're obviously trying to do the same thing, just the
first one gets given physical address as parameters.

Implementing one in terms of the other is much better for maintenance.

Will
