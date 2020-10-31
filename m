Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04822A154D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgJaKrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 06:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgJaKrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 06:47:55 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1023922246
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604141274;
        bh=V1iu1KT8r8Cx0HsatLRzfzAoIca0ncRgqSMr23EZDgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CNy1G/cAYqP6E1o+YBmxY+iGiqgQV11YfyJmzdDQxMfsY7PBegI5lCu+VOSZ5knHX
         uz2VgKuBcSouDQBjUOaOE01v+ayog5oxpjDMJGEpbxC6RjOb8ji9mFksdWBaactAKX
         3eEBKUBQ8LnRzaWzaeofi0AbQEqjDP23DKnWxI9E=
Received: by mail-ot1-f54.google.com with SMTP id b2so7974081ots.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 03:47:54 -0700 (PDT)
X-Gm-Message-State: AOAM532w3U7Uh3EJEaemE3hAN+sLsalGAEcaL5XjIsN3LTG/w8LUXtUx
        DHEI77JQub0zvI1mYDFUFK3J70O5vDzIlJWPNLE=
X-Google-Smtp-Source: ABdhPJwylZ3lAPir9dbaXUGttYgqRBvgqMyryr+RfpQmZ0wmv7bur/O7o0oW2czCLtJl/xePTMkuw4Vxjxu1JTQh4go=
X-Received: by 2002:a05:6830:1f13:: with SMTP id u19mr4849702otg.108.1604141273335;
 Sat, 31 Oct 2020 03:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201031094345.6984-1-rppt@kernel.org> <20201031103312.GI1551@shell.armlinux.org.uk>
In-Reply-To: <20201031103312.GI1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 31 Oct 2020 11:47:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGPtXsq+26OTr49NXk5uZVt82++-8Ug_E-DYYYJ6WEbWw@mail.gmail.com>
Message-ID: <CAMj1kXGPtXsq+26OTr49NXk5uZVt82++-8Ug_E-DYYYJ6WEbWw@mail.gmail.com>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 at 11:33, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, Oct 31, 2020 at 11:43:45AM +0200, Mike Rapoport wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > free_highpages() iterates over the free memblock regions in high
> > memory, and marks each page as available for the memory management
> > system.
> >
> > Until commit cddb5ddf2b76 ("arm, xtensa: simplify initialization of
> > high memory pages") it rounded beginning of each region upwards and end of
> > each region downwards.
> >
> > However, after that commit free_highmem() rounds the beginning and end of
> > each region downwards, and we may end up freeing a page that is
> > memblock_reserve()d, resulting in memory corruption.
> >
> > Restore the original rounding of the region boundaries to avoid freeing
> > reserved pages.
> >
> > Fixes: cddb5ddf2b76 ("arm, xtensa: simplify initialization of high memory pages")
> > Link: https://lore.kernel.org/r/20201029110334.4118-1-ardb@kernel.org/
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Co-developed-by:  Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >
> > Max, Russell,
> >
> > Please let me know how do you prefer to take it upstream.
> > If needed this can go via memblock tree.
> >
> > v2: fix words order in the commit message
>
> I really don't understand what is going on here; there seems to be a
> total disconnect of communication between yourself and Ard. Ard has
> already submitted a different patch for this to the patch system
> already, sent yesterday.
>
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9021/1
>
> Please discuss between yourselves how you want to solve the problem,
> and then submit an agreed and tested patch to those of us upstream;
> please don't make it for those upstream to pick one of your patches
> as you are at present.
>

Apologies for creating this confusion. I posted a patch and dropped it
into the patch system when I found the bug.

However, only when Florian asked about a 'fixes' tag, I went back to
the history, and realized that the issue was introduced by Mike during
the most recent merge window, and affects xtensa as well.

I don't have a preference which patch gets applied, though, so please
indicate your preference, and we will adapt accordingly.


> >
> >  arch/arm/mm/init.c    | 4 ++--
> >  arch/xtensa/mm/init.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index d57112a276f5..c23dbf8bebee 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -354,8 +354,8 @@ static void __init free_highpages(void)
> >       /* set highmem page free */
> >       for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
> >                               &range_start, &range_end, NULL) {
> > -             unsigned long start = PHYS_PFN(range_start);
> > -             unsigned long end = PHYS_PFN(range_end);
> > +             unsigned long start = PFN_UP(range_start);
> > +             unsigned long end = PFN_DOWN(range_end);
> >
> >               /* Ignore complete lowmem entries */
> >               if (end <= max_low)
> > diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
> > index c6fc83efee0c..8731b7ad9308 100644
> > --- a/arch/xtensa/mm/init.c
> > +++ b/arch/xtensa/mm/init.c
> > @@ -89,8 +89,8 @@ static void __init free_highpages(void)
> >       /* set highmem page free */
> >       for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
> >                               &range_start, &range_end, NULL) {
> > -             unsigned long start = PHYS_PFN(range_start);
> > -             unsigned long end = PHYS_PFN(range_end);
> > +             unsigned long start = PFN_UP(range_start);
> > +             unsigned long end = PFN_DOWN(range_end);
> >
> >               /* Ignore complete lowmem entries */
> >               if (end <= max_low)
> > --
> > 2.28.0
> >
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
