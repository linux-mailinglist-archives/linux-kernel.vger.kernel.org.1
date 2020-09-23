Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C64027638E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIWWHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbgIWWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:07:48 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36DF52311A;
        Wed, 23 Sep 2020 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600898867;
        bh=0fg/tb6x79NpfaENSuZB9fy5mCBrCQVJCLJcpSvFpiI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LesMBUzt5w6X01kIdhbbunu2wqZKZ38mrkV+KD6mevo2h2vwmPjKVo2v/liuQ7wBZ
         ud6IY8Ja9ayPiAAypw/o6dD7I8TeFvYoDbV/dB+9M1zDi4o7Kwonbjti3gy9wNBBIP
         TfOHMAWN9htukuhtJc5flkOzZFiBZ3LlbBL6zbp4=
Message-ID: <59a36732a8c09ecf31b6bc2bf6fe1629b9625b7c.camel@kernel.org>
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Date:   Wed, 23 Sep 2020 17:07:44 -0500
In-Reply-To: <20200918164150.5a34de1b@gandalf.local.home>
References: <20200917181347.1359365-1-axelrasmussen@google.com>
         <20200917154258.1a364cdf@gandalf.local.home>
         <CAJHvVcjvhGJ-hPokv+dWSDybetEcDHTme0JAM5Rac4hXVYAagg@mail.gmail.com>
         <20200918164150.5a34de1b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, Axel,

On Fri, 2020-09-18 at 16:41 -0400, Steven Rostedt wrote:
> On Fri, 18 Sep 2020 13:26:37 -0700
> Axel Rasmussen <axelrasmussen@google.com> wrote:
> 
> > On Thu, Sep 17, 2020 at 12:43 PM Steven Rostedt <
> > rostedt@goodmis.org> wrote:
> > > 
> > > On Thu, 17 Sep 2020 11:13:47 -0700
> > > Axel Rasmussen <axelrasmussen@google.com> wrote:
> > >  
> > > > +/*
> > > > + * Trace calls must be in a separate file, as otherwise
> > > > there's a circuclar
> > > > + * dependency between linux/mmap_lock.h and
> > > > trace/events/mmap_lock.h.
> > > > + */
> > > > +
> > > > +static void trace_start_locking(struct mm_struct *mm, bool
> > > > write)  
> > > 
> > > Please don't use "trace_" for functions, as that should be
> > > reserved for the
> > > actual tracepoint functions. Please use "do_trace_" or whatever
> > > so there's
> > > no confusion about this being a tracepoint, even if it's just a
> > > function
> > > that calls the tracepoint.  
> > 
> > Done; I'll send a v2 with this change.
> > 
> > >  
> > > > +{
> > > > +     TRACE_MMAP_LOCK_EVENT(start_locking, mm, 0, write, true);
> > > > +}
> > > > +
> > > > +static void trace_acquire_returned(struct mm_struct *mm, u64
> > > > start_time_ns,
> > > > +                                bool write, bool success)
> > > > +{
> > > > +     TRACE_MMAP_LOCK_EVENT(acquire_returned, mm,
> > > > +                           sched_clock() - start_time_ns,
> > > > write, success);
> > > > +}
> > > > +
> > > > +static void trace_released(struct mm_struct *mm, bool write)
> > > > +{
> > > > +     TRACE_MMAP_LOCK_EVENT(released, mm, 0, write, true);
> > > > +}
> > > > +  
> > > 
> > >  
> > > > +static inline void lock_impl(struct mm_struct *mm,
> > > > +                          void (*lock)(struct rw_semaphore *),
> > > > bool write)
> > > > +{
> > > > +     u64 start_time_ns;
> > > > +
> > > > +     trace_start_locking(mm, write);
> > > > +     start_time_ns = sched_clock();
> > > > +     lock(&mm->mmap_lock);
> > > > +     trace_acquire_returned(mm, start_time_ns, write, true);
> > > > +}
> > > > +  
> > > 
> > > Why record the start time and pass it in for return, when this
> > > can be done
> > > by simply recording the start and return and then using the
> > > timestamps of
> > > the trace events to calculate the duration, offline or as
> > > synthetic events:  
> > 
> > First, thanks for the detailed feedback! As a newbie this is very
> > helpful. :)
> > 
> > I agree in principle, and I almost have a working version as you
> > suggest, but I can't see a way to get string fields working.
> > 
> > I believe in trace event headers the typical way to define a string
> > field  is as a "const char *", with the __string, __assign_str, and
> > __get_str helpers. But, from reading trace_events_synth.c, this
> > isn't
> > really supported, in that it only supports "char []". But, the hist
> > trigger code just does a strcmp() of the type string, it doesn't do
> > any type conversion, so it considers these types incompatible:
> > 
> > After this:
> > # echo 'mmap_lock_latency u64 time; char memcg_path[256]' >
> > /sys/kernel/tracing/synthetic_events
> > 
> > Trying to setup the hist trigger gives (the ^ points to the
> > beginning
> > of keys=>m<emcg_path ... not sure the formatting will be preserved
> > properly in e-mail):
> > # cat /sys/kernel/tracing/error_log
> > [   15.823725] hist:mmap_lock:mmap_lock_acquire_returned: error:
> > Param
> > type doesn't match synthetic event field type
> >   Command: hist:keys=memcg_path:latency=common_timestamp.usecs-
> > $ts0:onmatch(mmap_lock.mmap_lock_start_locking).mmap_lock_latency($
> > latency,memcg_path)
> >                      ^
> > 
> > I tried grepping "char [^\[]+\[" in include/trace/events/, and it
> > seems nobody is defining fixed-length string fields like that, so I
> > think that's the wrong solution. I checked the docs about defining
> > variables (
> > https://www.kernel.org/doc/html/v5.2/trace/histogram.html)
> > and it doesn't support anything complex like a cast, just - and +.
> > 
> > Any advice?
> 
> Tom,
> 
> Do you think we could make histograms support the above somehow?
> 

Sorry for the delayed reply - was out on vacation.

Yeah, currently the synthetic events only support constant-length
strings, which should match with __array()s in the tracepoints, but I
think they should also be made to support variable-length arrays that
would match __string() etc.

I'm thinking an array field without length specifier could be used to
in the synthetic event specification for that e.g.:

  # echo 'mmap_lock_latency u64 time; char memcg_path[]' > /sys/kernel/tracing/synthetic_events

I'll work on adding that over the next couple days or so...

Tom

> -- Steve
> 
> > 
> > 
> > 
> > > 
> > > 
> > >  # cd /sys/kernel/tracing/
> > >  # echo 'duration u64 time' > synthetic_events
> > >  # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs" >
> > > events/mmap_lock/mmap_lock_start_locking/trigger
> > >  # echo 'hist:keys=common_pid:dur=common_timestamp.usecs-
> > > $ts0:onmatch(mmap_lock.mmap_lock_start_locking).trace(duration,$d
> > > ur)" > events/mmap_lock/mmap_lock_acquire_returned/trigger
> > >  # echo 1 > events/synthetic/duration/enable
> > >  # cat trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 148/148   #P:8
> > > #
> > > #                              _-----=> irqs-off
> > > #                             / _----=> need-resched
> > > #                            | / _---=> hardirq/softirq
> > > #                            || / _--=> preempt-depth
> > > #                            ||| /     delay
> > > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > > #              | |       |   ||||       |         |
> > >             bash-1613  [007] ...3  3186.431687: duration: time=3
> > >             bash-1613  [007] ...3  3186.431722: duration: time=2
> > >             bash-1613  [007] ...3  3186.431772: duration: time=2
> > >             bash-1613  [001] ...3  3188.372001: duration: time=6
> > >             bash-1613  [001] ...3  3188.372324: duration: time=6
> > >             bash-1613  [001] ...3  3188.372332: duration: time=4
> > >             bash-1613  [001] ...3  3188.373557: duration: time=5
> > >             bash-1613  [001] ...3  3188.373595: duration: time=3
> > >              cat-1868  [002] ...3  3188.373608: duration: time=8
> > >             bash-1613  [001] ...3  3188.373613: duration: time=4
> > >             bash-1613  [001] ...3  3188.373635: duration: time=3
> > >              cat-1868  [002] ...3  3188.373646: duration: time=4
> > >             bash-1613  [001] ...3  3188.373652: duration: time=3
> > >             bash-1613  [001] ...3  3188.373669: duration: time=3
> > > 
> > >  # echo 'hist:keys=time' > events/synthetic/duration/trigger
> > >  # cat events/synthetic/duration/hist
> > > # event histogram
> > > #
> > > # trigger info:
> > > hist:keys=time:vals=hitcount:sort=hitcount:size=2048 [active]
> > > #
> > > 
> > > { time:        114 } hitcount:          1
> > > { time:         15 } hitcount:          1
> > > { time:         11 } hitcount:          1
> > > { time:         21 } hitcount:          1
> > > { time:         10 } hitcount:          1
> > > { time:         46 } hitcount:          1
> > > { time:         29 } hitcount:          1
> > > { time:         13 } hitcount:          2
> > > { time:         16 } hitcount:          3
> > > { time:          9 } hitcount:          3
> > > { time:          8 } hitcount:          3
> > > { time:          7 } hitcount:          8
> > > { time:          6 } hitcount:         10
> > > { time:          5 } hitcount:         28
> > > { time:          4 } hitcount:        121
> > > { time:          1 } hitcount:        523
> > > { time:          3 } hitcount:        581
> > > { time:          2 } hitcount:        882
> > > 
> > > Totals:
> > >     Hits: 2171
> > >     Entries: 18
> > >     Dropped: 0
> > > 
> > > And with this I could do a bunch of things like stack trace on
> > > max hits and
> > > other features that the tracing histograms give us.
> > > 
> > > -- Steve  
> 
> 

