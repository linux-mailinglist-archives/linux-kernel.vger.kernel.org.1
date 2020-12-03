Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757182CD089
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbgLCHqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387585AbgLCHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:46:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870E6C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rEW+7i7I0qpFZ3Yw3/hjlLvCvJchz8ADOsmXvZqf1Ms=; b=Qd5Cao+LWDPBH1ql1ftk1mKXY/
        J3LLek6cP1BcTViDKv2LpH7Uvd0C/eZkkqAtZF/bI9QQCjsxvQdOxUnoo2pKmz+iDAvFRSB0LDeRK
        YPijnlpdJF4/IHfkmgnQB+vuoY2nDbAQjWYjT8SjNzugku9NhaXJPcTkvMLnYd2Aj6lmYjutmW/gM
        Uh2Vd7FX/+jrBc+W0mM8w1Zehc94kYw1bXb7fawMrp99zjr2feAN7/eRERLEdjYy8P/JX8SLQbWQG
        1XIyXqCcuTCy8n3yYaluceHECzJqB/R9/6SyTHRWKBvXPTi3ffOUeC4MvmZHeZsF2McPugLPK2G6g
        sYfNlqvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkjIs-0006wS-NQ; Thu, 03 Dec 2020 07:45:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22072302753;
        Thu,  3 Dec 2020 08:45:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2C78201BAA6D; Thu,  3 Dec 2020 08:45:22 +0100 (CET)
Date:   Thu, 3 Dec 2020 08:45:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Message-ID: <20201203074522.GD2414@hirez.programming.kicks-ass.net>
References: <20201202150205.35750-1-namhyung@kernel.org>
 <20201202161934.GL3021@hirez.programming.kicks-ass.net>
 <CAM9d7cjMsofCLNbBWisd6d03q6Ucx2FG9xxV2mALp+gykDkAyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjMsofCLNbBWisd6d03q6Ucx2FG9xxV2mALp+gykDkAyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:10:30AM +0900, Namhyung Kim wrote:
> On Thu, Dec 3, 2020 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 9a38f579bc76..5eb284819ee5 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1174,25 +1174,19 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
> >   * which is guaranteed by us not actually scheduling inside other swevents
> >   * because those disable preemption.
> >   */
> > -static __always_inline void
> > -perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
> > +static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
> 
> It'd be nice to avoid the __ prefix if possible.

Not having __ would seem to suggest its a function of generic utility.
Still, *shrug* ;-)

> >  {
> > -       if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
> > -               return true;
> > -       return false;
> > +       return static_key_false(&perf_swevent_enabled[swevt]);
> >  }
> >
> >  static inline void perf_event_task_migrate(struct task_struct *task)
> > @@ -1207,11 +1201,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
> >         if (static_branch_unlikely(&perf_sched_events))
> >                 __perf_event_task_sched_in(prev, task);
> >
> > -       if (perf_sw_migrate_enabled() && task->sched_migrated) {
> > -               struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
> > -
> > -               perf_fetch_caller_regs(regs);
> > -               ___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
> > +       if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
> > +           task->sched_migrated) {
> 
> It seems task->sched_migrate is set only if the event is enabled,
> then can we just check the value here?

Why suffer the unconditional load and test? Your L1 too big?

> > +               __perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
> >                 task->sched_migrated = 0;
> >         }
> >  }
> > @@ -1219,7 +1211,13 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
> >  static inline void perf_event_task_sched_out(struct task_struct *prev,
> >                                              struct task_struct *next)
> >  {
> > -       perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> > +       if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
> > +               __perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> > +
> > +       if (__perf_sw_enabled(PERF_COUNT_SW_CGROUP_SWITCHES) &&
> > +           (task_css_check(prev, perf_event_cgrp_id, 1)->cgroup !=
> > +            task_css_check(next, perf_event_cgrp_id, 1)->cgroup))
> > +               __perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> 
> I was not clear about the RCU protection here.  Is it ok to access
> the task's css_set directly?

We're here with preemption and IRQs disabled, good luck trying to get
RCU to consider that not a critical section and spirit things away under
us.
