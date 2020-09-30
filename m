Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B327E754
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgI3LCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3LCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:02:09 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2066F2071E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601463728;
        bh=nvVPSoKRhObWOZ2KtSKQHeSXtoGqWb/uiSd2fSRne8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xw8228Uz9QHJ9x9s3AzjPWXHcL3NDq0UqXFaJe5gAFS8HvE9cJRRHooxsAtcVmBK6
         3IVtOshBRezgmj8s/tcZB31mRkJr5ykAlk3OllA26r3hHkEmnPQ231vRPo/yO1z36n
         AsI2i63VNHckQDZy/qZsvF7bc9bG7bIfO05PLwtc=
Received: by mail-ot1-f47.google.com with SMTP id u25so1379060otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 04:02:08 -0700 (PDT)
X-Gm-Message-State: AOAM532xAEQuuPee/L9fpvLtBboqbR9E1lFxAZwMbUvb8XiNq8UF1toP
        Ocg7N4G7vdmXIH04SPqSen6gLLcrkWRxkBpuLWQ=
X-Google-Smtp-Source: ABdhPJyyYn7NkxZU/TLSnwDtnjsRQlSSUkbd55I5RxAogRYHH6tvYKc/dFNmVM+ivoll/kJfNr1yX350lhgV4TYDxa8=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr1275655otk.77.1601463727306;
 Wed, 30 Sep 2020 04:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <20200928203539.GA12218@willie-the-truck> <09266aed-7eef-5b16-5d52-0dcb7dcb7246@arm.com>
 <20200929152221.GA13995@willie-the-truck> <f44d34df-8a21-712c-138d-f7f633b0eb6c@arm.com>
In-Reply-To: <f44d34df-8a21-712c-138d-f7f633b0eb6c@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Sep 2020 13:01:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGhja2cxQOpnboj1mos314Nku209dkgmmz74X3wq=j8Rg@mail.gmail.com>
Message-ID: <CAMj1kXGhja2cxQOpnboj1mos314Nku209dkgmmz74X3wq=j8Rg@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear mapping
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 10:03, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 09/29/2020 08:52 PM, Will Deacon wrote:
> > On Tue, Sep 29, 2020 at 01:34:24PM +0530, Anshuman Khandual wrote:
> >>
> >>
> >> On 09/29/2020 02:05 AM, Will Deacon wrote:
> >>> On Thu, Sep 17, 2020 at 02:16:42PM +0530, Anshuman Khandual wrote:
> >>>> During memory hotplug process, the linear mapping should not be created for
> >>>> a given memory range if that would fall outside the maximum allowed linear
> >>>> range. Else it might cause memory corruption in the kernel virtual space.
> >>>>
> >>>> Maximum linear mapping region is [PAGE_OFFSET..(PAGE_END -1)] accommodating
> >>>> both its ends but excluding PAGE_END. Max physical range that can be mapped
> >>>> inside this linear mapping range, must also be derived from its end points.
> >>>>
> >>>> When CONFIG_ARM64_VA_BITS_52 is enabled, PAGE_OFFSET is computed with the
> >>>> assumption of 52 bits virtual address space. However, if the CPU does not
> >>>> support 52 bits, then it falls back using 48 bits instead and the PAGE_END
> >>>> is updated to reflect this using the vabits_actual. As for PAGE_OFFSET,
> >>>> bits [51..48] are ignored by the MMU and remain unchanged, even though the
> >>>> effective start address of linear map is now slightly different. Hence, to
> >>>> reliably check the physical address range mapped by the linear map, the
> >>>> start address should be calculated using vabits_actual. This ensures that
> >>>> arch_add_memory() validates memory hot add range for its potential linear
> >>>> mapping requirement, before creating it with __create_pgd_mapping().
> >>>>
> >>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Cc: Will Deacon <will@kernel.org>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: Ard Biesheuvel <ardb@kernel.org>
> >>>> Cc: Steven Price <steven.price@arm.com>
> >>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>> Cc: David Hildenbrand <david@redhat.com>
> >>>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
> >>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>> ---
> >>>>  arch/arm64/mm/mmu.c | 27 +++++++++++++++++++++++++++
> >>>>  1 file changed, 27 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >>>> index 75df62fea1b6..d59ffabb9c84 100644
> >>>> --- a/arch/arm64/mm/mmu.c
> >>>> +++ b/arch/arm64/mm/mmu.c
> >>>> @@ -1433,11 +1433,38 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
> >>>>    free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
> >>>>  }
> >>>>
> >>>> +static bool inside_linear_region(u64 start, u64 size)
> >>>> +{
> >>>> +  /*
> >>>> +   * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
> >>>> +   * accommodating both its ends but excluding PAGE_END. Max physical
> >>>> +   * range which can be mapped inside this linear mapping range, must
> >>>> +   * also be derived from its end points.
> >>>> +   *
> >>>> +   * With CONFIG_ARM64_VA_BITS_52 enabled, PAGE_OFFSET is defined with
> >>>> +   * the assumption of 52 bits virtual address space. However, if the
> >>>> +   * CPU does not support 52 bits, it falls back using 48 bits and the
> >>>> +   * PAGE_END is updated to reflect this using the vabits_actual. As
> >>>> +   * for PAGE_OFFSET, bits [51..48] are ignored by the MMU and remain
> >>>> +   * unchanged, even though the effective start address of linear map
> >>>> +   * is now slightly different. Hence, to reliably check the physical
> >>>> +   * address range mapped by the linear map, the start address should
> >>>> +   * be calculated using vabits_actual.
> >>>> +   */
> >>>> +  return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
> >>>> +                  && ((start + size) <= __pa(PAGE_END - 1)));
> >>>> +}
> >>>
> >>> Why isn't this implemented using the existing __is_lm_address()?
> >>
> >> Not sure, if I understood your suggestion here. The physical address range
> >> [start..start + size] needs to be checked against maximum physical range
> >> that can be represented inside effective boundaries for the linear mapping
> >> i.e [__pa(_PAGE_OFFSET(vabits_actual)..__pa(PAGE_END - 1)].
> >>
> >> Are you suggesting [start..start + size] should be first be converted into
> >> a virtual address range and then checked against __is_lm_addresses() ? But
> >> is not deriving the physical range from from know limits of linear mapping
> >> much cleaner ?
> >
> > I just think having a function called "inside_linear_region()" as well as a
> > macro called "__is_lm_address()" is weird when they have completely separate
> > implementations. They're obviously trying to do the same thing, just the
> > first one gets given physical address as parameters.
> >
> > Implementing one in terms of the other is much better for maintenance.
>
> /*
>  * The linear kernel range starts at the bottom of the virtual address
>  * space. Testing the top bit for the start of the region is a
>  * sufficient check and avoids having to worry about the tag.
>  */
> #define __is_lm_address(addr)   (!(((u64)addr) & BIT(vabits_actual - 1)))
>
> __is_lm_address() currently just check the highest bit in a virtual address
> where the linear mapping ends i.e the lower half and all other kernel mapping
> starts i.e the upper half. But I would believe, it misses the blind range
> [_PAGE_OFFSET(VA_BITS).._PAGE_OFFSET(vabits_actual)] in some configurations,
> even though it does not really affect anything because it gets ignored by the
> MMU. Hence in current form __is_lm_address() cannot be used to derive maximum
> linear range and it's corresponding physical range for hotplug range check.
>

This is actually something that I brought up when the 52-bit VA
changes were under review: currently, we split the VA space in half,
and use the lower half for the linear range, and the upper half for
vmalloc, kernel, modules, vmemmap etc

When we run a 48-bit kernel on 52-bit capable hardware, we mostly
stick with the same arrangement: 2^51 bytes of linear range, but only
2^47 bytes of vmalloc range (as the size is fixed), and so we are
wasting 15/16 of the vmalloc region (2^51 - 2^47), by not using it to
map anything.

So it would be better to get away from this notion that the VA space
is divided evenly between linear and vmalloc regions, and use the
entire range between ~0 << 52 and ~0 << 47 for the linear region (Note
that the KASAN region defimnition will overlap the linear region in
this case, by we should be able to sort that at runtime)

-- 
Ard.
