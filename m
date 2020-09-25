Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935E2278753
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgIYMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgIYMfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:35:10 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FF021D7A;
        Fri, 25 Sep 2020 12:35:06 +0000 (UTC)
Date:   Fri, 25 Sep 2020 13:35:04 +0100
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
Message-ID: <20200925123503.GJ4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <17ec8af55dc0a4d3ade679feb0858f0df4c80d27.1600987622.git.andreyknvl@google.com>
 <20200925104933.GD4846@gaia>
 <CAAeHK+zLFRgR9eiLNyn7-iqbXJe6HGYpHYbBXXOVqOk4MyrhAA@mail.gmail.com>
 <20200925114703.GI4846@gaia>
 <CAAeHK+x=bchXN4DDui2Gfr_yNW4+9idc_3nQAyjRTwMN6UuvHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+x=bchXN4DDui2Gfr_yNW4+9idc_3nQAyjRTwMN6UuvHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 01:52:56PM +0200, Andrey Konovalov wrote:
> On Fri, Sep 25, 2020 at 1:47 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Sep 25, 2020 at 01:26:02PM +0200, Andrey Konovalov wrote:
> > > On Fri, Sep 25, 2020 at 12:49 PM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > > > +
> > > > >  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> > > > >                             struct pt_regs *regs)
> > > > >  {
> > > > > @@ -641,10 +647,40 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static void do_tag_recovery(unsigned long addr, unsigned int esr,
> > > > > +                        struct pt_regs *regs)
> > > > > +{
> > > > > +     static bool reported = false;
> > > > > +
> > > > > +     if (!READ_ONCE(reported)) {
> > > > > +             report_tag_fault(addr, esr, regs);
> > > > > +             WRITE_ONCE(reported, true);
> > > > > +     }
> > > >
> > > > I don't mind the READ_ONCE/WRITE_ONCE here but not sure what they help
> > > > with.
> > >
> > > The fault can happen on multiple cores at the same time, right? In
> > > that case without READ/WRITE_ONCE() we'll have a data-race here.
> >
> > READ/WRITE_ONCE won't magically solve such races. If two CPUs enter
> > simultaneously in do_tag_recovery(), they'd both read 'reported' as
> > false and both print the fault info.
> 
> They won't solve the race condition, but they will solve the data
> race. I guess here we don't really care about the race condition, as
> printing a tag fault twice is OK. But having a data race here will
> lead to KCSAN reports, although won't probably break anything in
> practice.

I agree, in practice it should be fine. Anyway, it doesn't hurt leaving
them in place.

-- 
Catalin
