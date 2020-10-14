Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1228DA07
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgJNGiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgJNGiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:38:03 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89EA2222F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602657482;
        bh=4IsuT5rq1O07s6ERlPYutrDLF+75svcqaeWEiG7uh9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XcF0gGrE4dOo7kzMfqrH0yJcSQHmTWKtPiX8zzjFfnQuT4uLz+hyny+/j4FmhGPBZ
         9SyBKe4UcR+FIH5D70o3U0OPlPw7U9IvRHDrL4y46TtZ0Etdoh6PvjFl8JpnImQrt9
         EjtBhkC7S7M2JcL1vz+LEvJSZuFG0OBEtHKmgJOM=
Received: by mail-oo1-f53.google.com with SMTP id w25so508593oos.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 23:38:02 -0700 (PDT)
X-Gm-Message-State: AOAM5339Te98+1WbAAbWJS/Uj1OZL6mXeahrJ7GzvTeHmvkOoBVL1/ji
        o2G8/UNLnGWyC/Dn8FIF0aSW5NFM9SNP0fpKa3g=
X-Google-Smtp-Source: ABdhPJwWH6UKObZ+cHZXr2PPPp7tz1JRCTsbarpfF2Rqy0R2PQzsJgIebXyUG0g41stYOZw7R8IjKzMh3P9/M5xeSus=
X-Received: by 2002:a4a:5258:: with SMTP id d85mr2295994oob.13.1602657481792;
 Tue, 13 Oct 2020 23:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <20200928203539.GA12218@willie-the-truck> <09266aed-7eef-5b16-5d52-0dcb7dcb7246@arm.com>
 <20200929152221.GA13995@willie-the-truck> <f44d34df-8a21-712c-138d-f7f633b0eb6c@arm.com>
 <262f2fd8-2e0c-4eaf-d4ff-f72728049f52@arm.com> <CAMj1kXFszo8SO7eAn0FEO+AQUHV9HZyukUi7=-udKyK+mCNVRw@mail.gmail.com>
 <1ee71de5-9e16-b9de-6ea0-f17dc9a494ac@arm.com>
In-Reply-To: <1ee71de5-9e16-b9de-6ea0-f17dc9a494ac@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 14 Oct 2020 08:37:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGJKhZxd5DjgUdEpBnvyET_bgRowYvTpZA2WJQQKrK+Zg@mail.gmail.com>
Message-ID: <CAMj1kXGJKhZxd5DjgUdEpBnvyET_bgRowYvTpZA2WJQQKrK+Zg@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear mapping
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 at 07:07, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 10/12/2020 12:59 PM, Ard Biesheuvel wrote:
> > On Tue, 6 Oct 2020 at 08:36, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >>
> >> On 09/30/2020 01:32 PM, Anshuman Khandual wrote:
> >>> But if __is_lm_address() checks against the effective linear range instead
> >>> i.e [_PAGE_OFFSET(vabits_actual)..(PAGE_END - 1)], it can be used for hot
> >>> plug physical range check there after. Perhaps something like this, though
> >>> not tested properly.
> >>>
> >>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >>> index afa722504bfd..6da046b479d4 100644
> >>> --- a/arch/arm64/include/asm/memory.h
> >>> +++ b/arch/arm64/include/asm/memory.h
> >>> @@ -238,7 +238,10 @@ static inline const void *__tag_set(const void *addr, u8 tag)
> >>>   * space. Testing the top bit for the start of the region is a
> >>>   * sufficient check and avoids having to worry about the tag.
> >>>   */
> >>> -#define __is_lm_address(addr)  (!(((u64)addr) & BIT(vabits_actual - 1)))
> >>> +static inline bool __is_lm_address(unsigned long addr)
> >>> +{
> >>> +       return ((addr >= _PAGE_OFFSET(vabits_actual)) && (addr <= (PAGE_END - 1)));
> >>> +}
> >>>
> >>>  #define __lm_to_phys(addr)     (((addr) + physvirt_offset))
> >>>  #define __kimg_to_phys(addr)   ((addr) - kimage_voffset)
> >>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >>> index d59ffabb9c84..5750370a7e8c 100644
> >>> --- a/arch/arm64/mm/mmu.c
> >>> +++ b/arch/arm64/mm/mmu.c
> >>> @@ -1451,8 +1451,7 @@ static bool inside_linear_region(u64 start, u64 size)
> >>>          * address range mapped by the linear map, the start address should
> >>>          * be calculated using vabits_actual.
> >>>          */
> >>> -       return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
> >>> -                       && ((start + size) <= __pa(PAGE_END - 1)));
> >>> +       return __is_lm_address(__va(start)) && __is_lm_address(__va(start + size));
> >>>  }
> >>>
> >>>  int arch_add_memory(int nid, u64 start, u64 size,
> >>
> >> Will/Ard,
> >>
> >> Any thoughts about this ? __is_lm_address() now checks for a range instead
> >> of a bit. This will be compatible later on, even if linear mapping range
> >> changes from current lower half scheme.
> >>
> >
> > As I'm sure you have noticed, I sent out some patches that get rid of
> > physvirt_offset, and which simplify __is_lm_address() to only take
> > compile time constants into account (unless KASAN is enabled). This
> > means that in the 52-bit VA case, __is_lm_address() does not
> > distinguish between virtual addresses that can be mapped by the
> > hardware and ones that cannot.
>
> Yeah, though was bit late in getting to the series. So with that change
> there might be areas in the linear mapping which cannot be addressed by
> the hardware and hence should also need be checked apart from proposed
> linear mapping coverage test, during memory hotplug ?
>

Yes.

> >
> > In the memory hotplug case, we need to decide whether the added memory
> > will appear in the addressable area, which is a different question. So
> > it makes sense to duplicate some of the logic that exists in
> > arm64_memblock_init() (or factor it out) to decide whether this newly
> > added memory will appear in the addressable window or not.
>
> It seems unlikely that any hotplug agent (e.g. firmware) will ever push
> through a memory range which is not accessible in the hardware but then
> it is not impossible either. In summary, arch_add_memory() should check
>
> 1. Range can be covered inside linear mapping
> 2. Range is accessible by the hardware
>
> Before the VA space organization series, (2) was not necessary as it was
> contained inside (1) ?
>

Not really. We have a problem with KASLR randomization of the linear
region, which may choose memstart_addr in such a way that we lose
access to regions that are beyond the boot time value of
memblock_end_of_DRAM().

I think we should probably rework that code to take
ID_AA64MMFR0_EL1.PARange into account instead.

> >
> > So I think your original approach makes more sense here, although I
> > think you want '(start + size - 1) <= __pa(PAGE_END - 1)' in the
> > comparison above (and please drop the redundant parens)
> >
>
> Sure, will accommodate these changes.
