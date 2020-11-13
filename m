Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19082B1630
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgKMHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgKMHG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:06:28 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1922137B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605251187;
        bh=WbJxdX7i65iGGj/6JCfUwtS00InwXWVNH2dZ9vBzjzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BkXLBtxos2+dHXQKR73xsRhlNE/ZBRkb8xI71J38UxTAr6a88WPHgg5lIHl36Bnyv
         iWZ2s85aHkIzRr+J2YJvyzXEeKJytTKxMX3ZWxW91kEeO42AfAMJd7rNuopfexmQ72
         sBHhr3rCXARFX1MypejNSy8Yr+Hkcu20oVDitjJk=
Received: by mail-oi1-f174.google.com with SMTP id c128so1068191oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:06:27 -0800 (PST)
X-Gm-Message-State: AOAM5338r+qNrrMzd8gatpqFoOjjnMQW6ePLci80OWiB7qTtKLV1qsF2
        ejqw/bobY9j6c+NGlH4BugJ3kL2uCBov7aTQsEE=
X-Google-Smtp-Source: ABdhPJzEAFrL833vXXI/5kawhAcABgyWROXiFnbyR8XMw9mygPbwEZ+qGU6FZYqPVTU6pFU6ws0nE8vnDdjAw5T9vVg=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr589488oif.174.1605251186667;
 Thu, 12 Nov 2020 23:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20201014081857.3288-1-ardb@kernel.org> <160503561804.1015659.16599672230432576934.b4-ty@arm.com>
 <a330440d-803b-5aa2-0092-a18317819850@arm.com> <20201112092558.GC29613@gaia>
 <2f0d9bc5-6288-7388-ff10-97198dabac6f@arm.com> <CAMj1kXGa-WUr8LzDHGEfgG18ctJJp1v8b4UFckbcwtzpoEv+Tw@mail.gmail.com>
 <ae1bdb23-4e44-bc6f-bdf0-a4efbcb5a3cb@arm.com>
In-Reply-To: <ae1bdb23-4e44-bc6f-bdf0-a4efbcb5a3cb@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 08:06:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXESYQjtuWOBVz=2=GwrczohUDqCTfQVOYmyj4wkdpUYnA@mail.gmail.com>
Message-ID: <CAMj1kXESYQjtuWOBVz=2=GwrczohUDqCTfQVOYmyj4wkdpUYnA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        gshan@redhat.com, Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 at 08:03, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/13/20 11:44 AM, Ard Biesheuvel wrote:
> > On Fri, 13 Nov 2020 at 04:16, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >>
> >> On 11/12/20 2:55 PM, Catalin Marinas wrote:
> >>> Hi Anshuman,
> >>>
> >>> On Wed, Nov 11, 2020 at 09:18:56AM +0530, Anshuman Khandual wrote:
> >>>> On 11/11/20 12:44 AM, Catalin Marinas wrote:
> >>>>> On Wed, 14 Oct 2020 10:18:57 +0200, Ard Biesheuvel wrote:
> >>>>>> As a hardening measure, we currently randomize the placement of
> >>>>>> physical memory inside the linear region when KASLR is in effect.
> >>>>>> Since the random offset at which to place the available physical
> >>>>>> memory inside the linear region is chosen early at boot, it is
> >>>>>> based on the memblock description of memory, which does not cover
> >>>>>> hotplug memory. The consequence of this is that the randomization
> >>>>>> offset may be chosen such that any hotplugged memory located above
> >>>>>> memblock_end_of_DRAM() that appears later is pushed off the end of
> >>>>>> the linear region, where it cannot be accessed.
> >>>>>>
> >>>>>> [...]
> >>>>>
> >>>>> Applied to arm64 (for-next/mem-hotplug), thanks!
> >>>>>
> >>>>> [1/1] arm64: mm: account for hotplug memory when randomizing the linear region
> >>>>>       https://git.kernel.org/arm64/c/97d6786e0669
> >>>>
> >>>> Got delayed and never made here in time, sorry about that. Nonetheless,
> >>>> I have got something working with respect to the generic mechanism that
> >>>> David Hildenbrand had asked for earlier.
> >>>>
> >>>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> >>>
> >>> There was a lot of discussion around this patch but I haven't seen any
> >>> new version posted.
> >>
> >> Just posted before some time.
> >>
> >> https://lore.kernel.org/linux-arm-kernel/1605236574-14636-1-git-send-email-anshuman.khandual@arm.com/
> >>
> >
> > You failed to cc me on that patch.
>
> I could see 'ardb@kernel.org' marked as a copy on the patch. You
> did not receive the email ? The CC list is in the commit message
> itself. Even the lore.kernel.org based URL does list you email
> as well. Not sure what might have happened.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
>

Right. Not sure what happened there, I may have deleted it by
accident. Apologies.

> >
> > The logic looks correct but please fix up the comment block:
> > - PAGE_END is no longer defined in terms of vabits_actual
> > - bits [51..48] are not ignored by the MMU
> >
> > Actually, I think the entire second paragraph of that comment block
> > can be dropped.
>
> And from the commit message as well, had reused it in both places.
>
> >
> > Please also fix up the coding style:
> > - put && at the end of the first line
> > - drop the redundant parens
> > - fix the indentation
>
> Does this look okay ?
>
> static bool inside_linear_region(u64 start, u64 size)
> {
>         /*
>          * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>          * accommodating both its ends but excluding PAGE_END. Max physical
>          * range which can be mapped inside this linear mapping range, must
>          * also be derived from its end points.
>          */
>         return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
>                         (start + size - 1) <= __pa(PAGE_END - 1);
> }

Not sure whether the whitespace has been mangled by the email client,
but the first ( on the second line should align vertically with the
's' of 'start' on the first line
