Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72822F36A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392468AbhALRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392398AbhALRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:06:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30928C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=30aDxoAMRsl6PuAR3aNPhMGA4ITZLSnZpz11h6PoaaE=; b=YX1RnUDU9M0YVbXatKTBkaAg7M
        2Wur2szkUn9NwPsWALB6U4YPNip14T9za0PPtTIgO4POaD9Vnx2MipN81iPFD4nK9pFQTSF4+nxdU
        T3m5cpEloiPNRr+VgqEIkfmHqlCwS+dFlJFSnfL3bo0Z/uyQwdmMDnrvLXzhjL4Bz6D4zYDWVQs7E
        BL1snqbi36dZdczZwySjP5QoKCGkseGyOCGhVFlY9QJ22Eu9R7ewopseJApMVLysfroAO1TaEOcq1
        CxCTI60aWTB5pbpSHSw4nEfgotaP8x5onxG+PKn0SX+vDtYrGVous8HV9OaOngl7MuLfQA+G2XwX8
        mDJfJ9vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzN59-0054gE-B9; Tue, 12 Jan 2021 17:04:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCE7930504E;
        Tue, 12 Jan 2021 18:03:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E0A821071094; Tue, 12 Jan 2021 18:03:45 +0100 (CET)
Date:   Tue, 12 Jan 2021 18:03:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] perf/x86: Only expose userspace rdpmc for events on
 current CPU
Message-ID: <X/3WcQD/OzlgXyH5@hirez.programming.kicks-ass.net>
References: <20210108000136.1556129-1-robh@kernel.org>
 <X/3BDlQxTCYd2HJs@hirez.programming.kicks-ass.net>
 <CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:16:50AM -0600, Rob Herring wrote:
> On Tue, Jan 12, 2021 at 9:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jan 07, 2021 at 05:01:36PM -0700, Rob Herring wrote:
> > > Userspace access using rdpmc only makes sense if the event is valid for
> > > the current CPU. However, cap_user_rdpmc is currently set no matter which
> > > CPU the event is associated with. The result is userspace reading another
> > > CPU's event thinks it can use rdpmc to read the counter. In doing so, the
> > > wrong counter will be read.
> >
> > Don't do that then?
> 
> I could check this in userspace I suppose, but then it's yet another
> thing the rdpmc loop has to check. I think it's better to not add more
> overhead there.

So all this was designed for self monitoring; attempting rdpmc on an
event not for yourself is out of spec.

> > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > index a88c94d65693..6e6d4c1d03ca 100644
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -2490,7 +2490,8 @@ void arch_perf_update_userpage(struct perf_event *event,
> > >       userpg->cap_user_time = 0;
> > >       userpg->cap_user_time_zero = 0;
> > >       userpg->cap_user_rdpmc =
> > > -             !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
> > > +             !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
> > > +             (event->oncpu == smp_processor_id());
> > >       userpg->pmc_width = x86_pmu.cntval_bits;
> > >
> > >       if (!using_native_sched_clock() || !sched_clock_stable())
> >
> > Isn't that a nop? That is, from the few sites I checked, we're always
> > calling this on the event's CPU.
> 
> If cpu0 opens and mmaps an event for cpu1, then cpu0 will see
> cap_user_rdpmc set and think it can use rdpmc.

I don't think your check helps with that. IIRC we always call
arch_perf_update_userpage() on the CPU the event actually runs on. So
it's always true.
