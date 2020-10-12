Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AF28AF0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgJLH3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbgJLH3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:29:21 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7422087D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602487760;
        bh=OdMrR8xGJzTJnmyDgf3CCLPTfuDHl86rUB1Og6PyJ8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mL+jKTyqh9wSLdifqsZnmHG+3EHbKJiAKe3JF6u/udo5PAeLdV42U5FUmwDGwzYe6
         8jO2jhGP8MNDqm5DWKPYapm6fKMYlRg2HTrXbcYwX2G72uTqHB4BfkLkDvvxt4QUsi
         1SXZ8MhR/oZen4jVTzTkF1p81uTcpop3qim7N1bI=
Received: by mail-oo1-f53.google.com with SMTP id f2so3125530ooj.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:29:20 -0700 (PDT)
X-Gm-Message-State: AOAM531/4kFqo+nrJhKxyz6dW964Or86w/dL5prxiP2DgnLtBEgD2Pa0
        SdNCHOc7nVu7IjY6ESODCekqHny2SEpATzFw6zI=
X-Google-Smtp-Source: ABdhPJysZwFcTO8fLwgY5QoipxhuC1iq5Q4TNsYibm/DKqC5H/88/JbcqH7ufTbI1Q1Thv+H7f23RZxi4H5JmSUiCW0=
X-Received: by 2002:a4a:5258:: with SMTP id d85mr17666894oob.13.1602487759778;
 Mon, 12 Oct 2020 00:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <20200928203539.GA12218@willie-the-truck> <09266aed-7eef-5b16-5d52-0dcb7dcb7246@arm.com>
 <20200929152221.GA13995@willie-the-truck> <f44d34df-8a21-712c-138d-f7f633b0eb6c@arm.com>
 <262f2fd8-2e0c-4eaf-d4ff-f72728049f52@arm.com>
In-Reply-To: <262f2fd8-2e0c-4eaf-d4ff-f72728049f52@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Oct 2020 09:29:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFszo8SO7eAn0FEO+AQUHV9HZyukUi7=-udKyK+mCNVRw@mail.gmail.com>
Message-ID: <CAMj1kXFszo8SO7eAn0FEO+AQUHV9HZyukUi7=-udKyK+mCNVRw@mail.gmail.com>
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

On Tue, 6 Oct 2020 at 08:36, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 09/30/2020 01:32 PM, Anshuman Khandual wrote:
> > But if __is_lm_address() checks against the effective linear range instead
> > i.e [_PAGE_OFFSET(vabits_actual)..(PAGE_END - 1)], it can be used for hot
> > plug physical range check there after. Perhaps something like this, though
> > not tested properly.
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index afa722504bfd..6da046b479d4 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -238,7 +238,10 @@ static inline const void *__tag_set(const void *addr, u8 tag)
> >   * space. Testing the top bit for the start of the region is a
> >   * sufficient check and avoids having to worry about the tag.
> >   */
> > -#define __is_lm_address(addr)  (!(((u64)addr) & BIT(vabits_actual - 1)))
> > +static inline bool __is_lm_address(unsigned long addr)
> > +{
> > +       return ((addr >= _PAGE_OFFSET(vabits_actual)) && (addr <= (PAGE_END - 1)));
> > +}
> >
> >  #define __lm_to_phys(addr)     (((addr) + physvirt_offset))
> >  #define __kimg_to_phys(addr)   ((addr) - kimage_voffset)
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index d59ffabb9c84..5750370a7e8c 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1451,8 +1451,7 @@ static bool inside_linear_region(u64 start, u64 size)
> >          * address range mapped by the linear map, the start address should
> >          * be calculated using vabits_actual.
> >          */
> > -       return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
> > -                       && ((start + size) <= __pa(PAGE_END - 1)));
> > +       return __is_lm_address(__va(start)) && __is_lm_address(__va(start + size));
> >  }
> >
> >  int arch_add_memory(int nid, u64 start, u64 size,
>
> Will/Ard,
>
> Any thoughts about this ? __is_lm_address() now checks for a range instead
> of a bit. This will be compatible later on, even if linear mapping range
> changes from current lower half scheme.
>

As I'm sure you have noticed, I sent out some patches that get rid of
physvirt_offset, and which simplify __is_lm_address() to only take
compile time constants into account (unless KASAN is enabled). This
means that in the 52-bit VA case, __is_lm_address() does not
distinguish between virtual addresses that can be mapped by the
hardware and ones that cannot.

In the memory hotplug case, we need to decide whether the added memory
will appear in the addressable area, which is a different question. So
it makes sense to duplicate some of the logic that exists in
arm64_memblock_init() (or factor it out) to decide whether this newly
added memory will appear in the addressable window or not.

So I think your original approach makes more sense here, although I
think you want '(start + size - 1) <= __pa(PAGE_END - 1)' in the
comparison above (and please drop the redundant parens)
