Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C542CE898
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgLDH0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:26:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39875 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLDH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:26:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id q22so4653889qkq.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/0GhBP/RuBAMOpO8cPBTzjnAd3MRpvfIHK1+5TlA8k=;
        b=A5yYJ/TjsQJP/90T3ewuKN6g6uN/mn5XQsZBDm5aF/wLRBMH9mlV3zC0co/ezE9AS6
         fRbQvj0271Kiyv/jI0Z535stG/Cy9znQRvJDc9YgqS+GpdQB4ZopO/OJdg125jK1Gx32
         PWleYOsVZmWqfHuEKKpGVBWto0GPSakFIoT6vYyJxKuMjYEfpf6AM9RTkuU2PT8pEo8E
         ymeOeSk7Xnna9A504GUBgThCqIW+U8M6sCAqTqug9U8CUHgitKBE7e+yydMUieW8tMpp
         /5xT4QuNb2iqPR1FxlgmxBcIw5g7UkD569yvsq4wv6Kbp4NR8fh83WMw+/ybDvzEc/LW
         yZiQ==
X-Gm-Message-State: AOAM533y0vfUNU24IJCLKEfDatM3xBN6kKCNmLrOxYyAa81uaTu2qLT9
        cCvqLTWPMDPoAeW7ytwJnYVlhn5wDM8QUzcRlvE=
X-Google-Smtp-Source: ABdhPJwuPk9ogjToCG9p8jXzeIY1Z73x4maAPgGzuPCOtkrr9k7RXFOuzz2p03n5Xtev4Zk512j1TZJzUWBe1ud5Mzc=
X-Received: by 2002:a05:620a:990:: with SMTP id x16mr7300508qkx.316.1607066750554;
 Thu, 03 Dec 2020 23:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.35750-1-namhyung@kernel.org> <20201202161934.GL3021@hirez.programming.kicks-ass.net>
 <CAM9d7cjMsofCLNbBWisd6d03q6Ucx2FG9xxV2mALp+gykDkAyg@mail.gmail.com> <20201203074522.GD2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201203074522.GD2414@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 4 Dec 2020 16:25:39 +0900
Message-ID: <CAM9d7chHVWTJbQD9WDRBJ1JrVD9=+Nw_6HN-94-ZS1dZjf2=3g@mail.gmail.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 4:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 03, 2020 at 11:10:30AM +0900, Namhyung Kim wrote:
> > On Thu, Dec 3, 2020 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index 9a38f579bc76..5eb284819ee5 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -1174,25 +1174,19 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
> > >   * which is guaranteed by us not actually scheduling inside other swevents
> > >   * because those disable preemption.
> > >   */
> > > -static __always_inline void
> > > -perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
> > > +static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
> >
> > It'd be nice to avoid the __ prefix if possible.
>
> Not having __ would seem to suggest its a function of generic utility.
> Still, *shrug* ;-)

Ok, noted.

>
> > >  {
> > > -       if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
> > > -               return true;
> > > -       return false;
> > > +       return static_key_false(&perf_swevent_enabled[swevt]);
> > >  }
> > >
> > >  static inline void perf_event_task_migrate(struct task_struct *task)
> > > @@ -1207,11 +1201,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
> > >         if (static_branch_unlikely(&perf_sched_events))
> > >                 __perf_event_task_sched_in(prev, task);
> > >
> > > -       if (perf_sw_migrate_enabled() && task->sched_migrated) {
> > > -               struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
> > > -
> > > -               perf_fetch_caller_regs(regs);
> > > -               ___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
> > > +       if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
> > > +           task->sched_migrated) {
> >
> > It seems task->sched_migrate is set only if the event is enabled,
> > then can we just check the value here?
>
> Why suffer the unconditional load and test? Your L1 too big?

I just wanted to avoid typing long lines.. ;-p

>
> > > +               __perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
> > >                 task->sched_migrated = 0;
> > >         }
> > >  }
> > > @@ -1219,7 +1211,13 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
> > >  static inline void perf_event_task_sched_out(struct task_struct *prev,
> > >                                              struct task_struct *next)
> > >  {
> > > -       perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> > > +       if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
> > > +               __perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> > > +
> > > +       if (__perf_sw_enabled(PERF_COUNT_SW_CGROUP_SWITCHES) &&
> > > +           (task_css_check(prev, perf_event_cgrp_id, 1)->cgroup !=
> > > +            task_css_check(next, perf_event_cgrp_id, 1)->cgroup))
> > > +               __perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> >
> > I was not clear about the RCU protection here.  Is it ok to access
> > the task's css_set directly?
>
> We're here with preemption and IRQs disabled, good luck trying to get
> RCU to consider that not a critical section and spirit things away under
> us.

Ok, someday I'll go reading the RCU code.. :)

Thanks,
Namhyung
