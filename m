Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB922546CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgH0O3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgH0OVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:21:37 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FEC2177B;
        Thu, 27 Aug 2020 14:21:33 +0000 (UTC)
Date:   Thu, 27 Aug 2020 15:21:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 32/35] kasan, arm64: print report from tag fault handler
Message-ID: <20200827142131.GN29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <4691d6019ef00c11007787f5190841b47ba576c4.1597425745.git.andreyknvl@google.com>
 <20200827104816.GI29264@gaia>
 <CAAeHK+zO8EJrmX5NjkKTB35eot1rDLjoqGyfoqF_quDV=VEvrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zO8EJrmX5NjkKTB35eot1rDLjoqGyfoqF_quDV=VEvrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:34:31PM +0200, Andrey Konovalov wrote:
> On Thu, Aug 27, 2020 at 12:48 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Aug 14, 2020 at 07:27:14PM +0200, Andrey Konovalov wrote:
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index c62c8ba85c0e..cf00b3942564 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/mm.h>
> > >  #include <linux/hardirq.h>
> > >  #include <linux/init.h>
> > > +#include <linux/kasan.h>
> > >  #include <linux/kprobes.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/page-flags.h>
> > > @@ -314,11 +315,19 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
> > >  {
> > >       bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> > >
> > > +#ifdef CONFIG_KASAN_HW_TAGS
> > > +     /*
> > > +      * SAS bits aren't set for all faults reported in EL1, so we can't
> > > +      * find out access size.
> > > +      */
> > > +     kasan_report(addr, 0, is_write, regs->pc);
> > > +#else
> > >       pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
> > >       pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
> > >       pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
> > >                       mte_get_ptr_tag(addr),
> > >                       mte_get_mem_tag((void *)addr));
> > > +#endif
> > >  }
> >
> > More dead code. So what's the point of keeping the pr_alert() introduced
> > earlier? CONFIG_KASAN_HW_TAGS is always on for in-kernel MTE. If MTE is
> > disabled, this function isn't called anyway.
> 
> I was considering that we can enable in-kernel MTE without enabling
> CONFIG_KASAN_HW_TAGS, but perhaps this isn't what we want. I'll drop
> this part in v2, but then we also need to make sure that in-kernel MTE
> is only enabled when CONFIG_KASAN_HW_TAGS is enabled. Do we need more
> ifdefs in arm64 patches when we write to MTE-related registers, or
> does this work as is?

I think the in-kernel MTE for the time being should only mean
CONFIG_KASAN_HW_TAGS, with a dependency on CONFIG_MTE. KASAN carries
some additional debugging features but if we can trim it down, we may
not need a separate in-kernel MTE option for production systems (maybe a
CONFIG_KASAN_HW_TAGS_LITE).

-- 
Catalin
