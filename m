Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC7327863C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgIYLrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYLrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:47:09 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A792083B;
        Fri, 25 Sep 2020 11:47:06 +0000 (UTC)
Date:   Fri, 25 Sep 2020 12:47:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: Re: [PATCH v3 26/39] arm64: mte: Add in-kernel tag fault handler
Message-ID: <20200925114703.GI4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <17ec8af55dc0a4d3ade679feb0858f0df4c80d27.1600987622.git.andreyknvl@google.com>
 <20200925104933.GD4846@gaia>
 <CAAeHK+zLFRgR9eiLNyn7-iqbXJe6HGYpHYbBXXOVqOk4MyrhAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zLFRgR9eiLNyn7-iqbXJe6HGYpHYbBXXOVqOk4MyrhAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 01:26:02PM +0200, Andrey Konovalov wrote:
> On Fri, Sep 25, 2020 at 12:49 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index a3bd189602df..d110f382dacf 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -33,6 +33,7 @@
> > >  #include <asm/debug-monitors.h>
> > >  #include <asm/esr.h>
> > >  #include <asm/kprobes.h>
> > > +#include <asm/mte.h>
> > >  #include <asm/processor.h>
> > >  #include <asm/sysreg.h>
> > >  #include <asm/system_misc.h>
> > > @@ -294,6 +295,11 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> > >       do_exit(SIGKILL);
> > >  }
> > >
> > > +static void report_tag_fault(unsigned long addr, unsigned int esr,
> > > +                          struct pt_regs *regs)
> > > +{
> > > +}
> >
> > Do we need to introduce report_tag_fault() in this patch? It's fine but
> > add a note in the commit log that it will be populated in a subsequent
> > patch.
> 
> I did, see the last line of the commit description.

Sorry, I missed that.

> > > +
> > >  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> > >                             struct pt_regs *regs)
> > >  {
> > > @@ -641,10 +647,40 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> > >       return 0;
> > >  }
> > >
> > > +static void do_tag_recovery(unsigned long addr, unsigned int esr,
> > > +                        struct pt_regs *regs)
> > > +{
> > > +     static bool reported = false;
> > > +
> > > +     if (!READ_ONCE(reported)) {
> > > +             report_tag_fault(addr, esr, regs);
> > > +             WRITE_ONCE(reported, true);
> > > +     }
> >
> > I don't mind the READ_ONCE/WRITE_ONCE here but not sure what they help
> > with.
> 
> The fault can happen on multiple cores at the same time, right? In
> that case without READ/WRITE_ONCE() we'll have a data-race here.

READ/WRITE_ONCE won't magically solve such races. If two CPUs enter
simultaneously in do_tag_recovery(), they'd both read 'reported' as
false and both print the fault info.

If you really care about this race, you need to atomically both read and
update the variable with an xchg() or cmpxchg().

-- 
Catalin
