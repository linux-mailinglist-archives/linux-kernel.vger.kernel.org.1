Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF72B15CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 07:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKMGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 01:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgKMGPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:15:09 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71702085B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 06:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605248107;
        bh=COucHtcUZQ0vJywCoLOJkGiDhDKyMfAcEFLg8kgnoZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ChctPHHsmcunGnudF0TCaPfmjV9W+bS5YeD1ujkUI01dK8XTL1/Ib6/eGi7J/cYMA
         ncesEJQ1xYkTRDdvPVwkJ1/byul4PqQM6B+2MFeVv1K4aw+VUgDes7Pw+Xt2YbiS8O
         2V1k+H9qgpy4RFSobkMKSL8RKhSCh7qtbcGr+NNE=
Received: by mail-oi1-f170.google.com with SMTP id m13so9292644oih.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 22:15:07 -0800 (PST)
X-Gm-Message-State: AOAM5305ucFuhzrJAkjGCMBmIvtyvWOIj5X/2nbHByGt2bIDEspzuqSu
        tN6ezhMZ9xYdrvtHLN8B/K15Li8V5hmgnLbo/d0=
X-Google-Smtp-Source: ABdhPJxsCUdwI/hg+4gvJgkWTuSi9ICNr4zk0HFK3LkMV1aHISoOKpsSLBrB0ai2VizV3pzan1sxxRn/Xcup4YJu9Ws=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr489296oif.174.1605248107101;
 Thu, 12 Nov 2020 22:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20201014081857.3288-1-ardb@kernel.org> <160503561804.1015659.16599672230432576934.b4-ty@arm.com>
 <a330440d-803b-5aa2-0092-a18317819850@arm.com> <20201112092558.GC29613@gaia> <2f0d9bc5-6288-7388-ff10-97198dabac6f@arm.com>
In-Reply-To: <2f0d9bc5-6288-7388-ff10-97198dabac6f@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 07:14:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGa-WUr8LzDHGEfgG18ctJJp1v8b4UFckbcwtzpoEv+Tw@mail.gmail.com>
Message-ID: <CAMj1kXGa-WUr8LzDHGEfgG18ctJJp1v8b4UFckbcwtzpoEv+Tw@mail.gmail.com>
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

On Fri, 13 Nov 2020 at 04:16, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/12/20 2:55 PM, Catalin Marinas wrote:
> > Hi Anshuman,
> >
> > On Wed, Nov 11, 2020 at 09:18:56AM +0530, Anshuman Khandual wrote:
> >> On 11/11/20 12:44 AM, Catalin Marinas wrote:
> >>> On Wed, 14 Oct 2020 10:18:57 +0200, Ard Biesheuvel wrote:
> >>>> As a hardening measure, we currently randomize the placement of
> >>>> physical memory inside the linear region when KASLR is in effect.
> >>>> Since the random offset at which to place the available physical
> >>>> memory inside the linear region is chosen early at boot, it is
> >>>> based on the memblock description of memory, which does not cover
> >>>> hotplug memory. The consequence of this is that the randomization
> >>>> offset may be chosen such that any hotplugged memory located above
> >>>> memblock_end_of_DRAM() that appears later is pushed off the end of
> >>>> the linear region, where it cannot be accessed.
> >>>>
> >>>> [...]
> >>>
> >>> Applied to arm64 (for-next/mem-hotplug), thanks!
> >>>
> >>> [1/1] arm64: mm: account for hotplug memory when randomizing the linear region
> >>>       https://git.kernel.org/arm64/c/97d6786e0669
> >>
> >> Got delayed and never made here in time, sorry about that. Nonetheless,
> >> I have got something working with respect to the generic mechanism that
> >> David Hildenbrand had asked for earlier.
> >>
> >> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> >
> > There was a lot of discussion around this patch but I haven't seen any
> > new version posted.
>
> Just posted before some time.
>
> https://lore.kernel.org/linux-arm-kernel/1605236574-14636-1-git-send-email-anshuman.khandual@arm.com/
>

You failed to cc me on that patch.

The logic looks correct but please fix up the comment block:
- PAGE_END is no longer defined in terms of vabits_actual
- bits [51..48] are not ignored by the MMU

Actually, I think the entire second paragraph of that comment block
can be dropped.

Please also fix up the coding style:
- put && at the end of the first line
- drop the redundant parens
- fix the indentation



> >
> >> I am wondering if we could instead consider merging the above patch with
> >> a small change that Ard had pointed out earlier [1], I will send out a
> >> revision if required.
> >
> > If your patch fixes the randomisation issue that Ard addressed, I'm
> > happy to replace that with your patch. But please post a new version and
> > get some acks in place from the parties involved in the discussion.
>
> The above patch is not a replacement for Ard's randomization patch here but
> rather complements it. Hence both these patches should be considered, which
> will make memory hotplug better on the platform.
