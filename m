Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2D2F3CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437315AbhALVeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436692AbhALUKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:10:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0254622B4B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 20:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610482175;
        bh=OoYkJWig81+BLsMtH2SEGTExQlUNYyGQyTx34KaajxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KWapfUdqJnBGitI9Pd2VyimO2ggvlG0I8ae9S7ySiVNHTfWx54WwjTtMWPMMvVtZV
         /zaI6MQ6exsxyg/Hd5jfdAEg2RN92UxFNI3u7Xz3Zyc2OnL7k2fx0ZvIJAEurvhpRS
         9T4lgxd1PK9uuWbhVSGB4MVbwmE5lnnABfIL9nB06XIKmBhslDWI6Z4A9nyLKeafJM
         p8ssbIVkkQEx2mmCpsJc2hXuUvb4leMEOXXk/3APzuff5eoc2LfS/CEMvyy7CaIToy
         x2stdx1YOidJBZcRc13tNKDIPVtcJT1+3NoTEH2ATGLI/iqfOHanw0K8hbFBY62YQN
         khjU//xRcBLrA==
Received: by mail-ed1-f47.google.com with SMTP id u19so3782957edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:09:34 -0800 (PST)
X-Gm-Message-State: AOAM532fNeNvA1f+muxEQkXOOEM+TDLsNik1MbNvASMxw9eb3EcXy8zn
        jkZvLyYimrvvI7o6tkRO6/7oc+JvvS+ogNIFgw==
X-Google-Smtp-Source: ABdhPJxXvSKtIIHAXr5WVzrbECWj1IFHtP/H7ch1e6HfvJMIOf5QzsQNHUSr4pTQNSn4ynNF2DfjMsSRVJYhWpss0Wk=
X-Received: by 2002:aa7:d154:: with SMTP id r20mr711848edo.258.1610482173431;
 Tue, 12 Jan 2021 12:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20210108000136.1556129-1-robh@kernel.org> <X/3BDlQxTCYd2HJs@hirez.programming.kicks-ass.net>
 <CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com> <X/3WcQD/OzlgXyH5@hirez.programming.kicks-ass.net>
In-Reply-To: <X/3WcQD/OzlgXyH5@hirez.programming.kicks-ass.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Jan 2021 14:09:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLDE9iHyrfPN42dn06dfoVVbzf+VkqGhBwpvhBQL7zfA@mail.gmail.com>
Message-ID: <CAL_JsqKLDE9iHyrfPN42dn06dfoVVbzf+VkqGhBwpvhBQL7zfA@mail.gmail.com>
Subject: Re: [RFC] perf/x86: Only expose userspace rdpmc for events on current CPU
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 12, 2021 at 10:16:50AM -0600, Rob Herring wrote:
> > On Tue, Jan 12, 2021 at 9:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Jan 07, 2021 at 05:01:36PM -0700, Rob Herring wrote:
> > > > Userspace access using rdpmc only makes sense if the event is valid for
> > > > the current CPU. However, cap_user_rdpmc is currently set no matter which
> > > > CPU the event is associated with. The result is userspace reading another
> > > > CPU's event thinks it can use rdpmc to read the counter. In doing so, the
> > > > wrong counter will be read.
> > >
> > > Don't do that then?
> >
> > I could check this in userspace I suppose, but then it's yet another
> > thing the rdpmc loop has to check. I think it's better to not add more
> > overhead there.
>
> So all this was designed for self monitoring; attempting rdpmc on an
> event not for yourself is out of spec.
>
> > > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > > index a88c94d65693..6e6d4c1d03ca 100644
> > > > --- a/arch/x86/events/core.c
> > > > +++ b/arch/x86/events/core.c
> > > > @@ -2490,7 +2490,8 @@ void arch_perf_update_userpage(struct perf_event *event,
> > > >       userpg->cap_user_time = 0;
> > > >       userpg->cap_user_time_zero = 0;
> > > >       userpg->cap_user_rdpmc =
> > > > -             !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
> > > > +             !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
> > > > +             (event->oncpu == smp_processor_id());
> > > >       userpg->pmc_width = x86_pmu.cntval_bits;
> > > >
> > > >       if (!using_native_sched_clock() || !sched_clock_stable())
> > >
> > > Isn't that a nop? That is, from the few sites I checked, we're always
> > > calling this on the event's CPU.
> >
> > If cpu0 opens and mmaps an event for cpu1, then cpu0 will see
> > cap_user_rdpmc set and think it can use rdpmc.
>
> I don't think your check helps with that. IIRC we always call
> arch_perf_update_userpage() on the CPU the event actually runs on. So
> it's always true.

My testing says otherwise. I tested this change on the arm64 version
of arch_perf_update_userpage, but I don't think x86 should be any
different here.

I'm testing with libperf test_stat_cpu() modified to mmap each cpu
event. Without the change I get the following result:

# taskset 2 test-evsel-a -v
- running test-evsel.c...
mmap base 0xffff9fd77000
userspace counter access enabled on cpu0            <<<<< Reflects
cap_user_rdpmc state
cpu0: count = 0x72cf, ena = 0x1a838, run = 0x1a838  <<<<< count is from rdpmc
mmap base 0xffff9fd76000
userspace counter access enabled on cpu1
cpu1: count = 0xc978, ena = 0x163e6, run = 0x163e6  <<<<< count is from rdpmc

cpu0 is idle here, so we'd expect count to be near zero, but it's not.

Then with the change, I get the following:

# taskset 2 test-evsel-a -v
- running test-evsel.c...
mmap base 0xffffa742d000
cpu0: count = 0xddb, ena = 0x3f8d6, run = 0x3f8d6  <<<<< count is from read()
mmap base 0xffffa742c000
userspace counter access enabled on cpu1
cpu1: count = 0xb538, ena = 0x154f0, run = 0x154f0 <<<<< count is from rdpmc

# taskset 1 test-evsel-a -v
- running test-evsel.c...
mmap base 0xffff8b008000
userspace counter access enabled on cpu0
cpu0: count = 0x7c21, ena = 0x18574, run = 0x18574
mmap base 0xffff8b007000
cpu1: count = 0xb3c, ena = 0x61aa8, run = 0x61aa8

As you can see, count tracks the idle and not idle cpu, and
cap_user_rdpmc is only set for the cpu event matching the cpu we are
running on.

Rob
