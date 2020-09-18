Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A0270706
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRU1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:27:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8430EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:27:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so4696358pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PT4Tal3/t4OKAkdxZvc0uyLrxNmarJh8q2gShqXYJ/4=;
        b=pmIun508/ZS1R6f9q4PlAgNA4IYSUmD4tJzmeRlhljg6jvk1mQlGe035SLNdWquMFv
         Kn3SQp3Cl8qe1hTZWWrY2DNdkBXR0cQJl/Xhs42qc9oeBe5vnUhAqIrousaER53muSz+
         CA3pEsc07hrE49dEfkcYttf24JyTg7cShw+lRDDMbUccPIfhXast+T+aheOYhXUwghO+
         2ep9wpnCAL5t1P0ZbuRYTmimhaRiu6D1d1l4ClDaaUBu6LH75TK75MM/l0qgiifE/FrD
         NiM+xPFAd9syCdZCqEfYoTqd5VDc4ZlfjETzq8+FM1kTUmX1R7LWzB3hWm7wFj9JDpsq
         SFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PT4Tal3/t4OKAkdxZvc0uyLrxNmarJh8q2gShqXYJ/4=;
        b=p5ZiwNCaXLxIWR++y+Z5di7u3GtYV2zArch+GTGEexAjkwHDVI4pUykrbqSPJRYwvX
         8+RCYBMyU9jeO5VatrzWL77nEKnfqzyCtkNVZK2P43KHJRl2T4LGCphjKYEV3LvAS2QB
         Sz32XRNc4g2ktf6tIpRyUSc+5ZbQQWnsxanRxt+TT27RMPoLzQhBDj8Gfmb70gdGagjF
         Lh/kOnu0rYlnnHPWCGL9qe7crxxqr7WE2sfHHxvynNtpbjny5V5nuyf+HerEx6DEpGP1
         44E2fhHP+IT/yprL//cjM2OwNi7Ozv1P+MwcNCKBVvoWGunMuYWIEvWvgCgTUpjERtHL
         o9SQ==
X-Gm-Message-State: AOAM533uiw3Mw5R09CVDmk/6Xn8TlKyyJHPQk3Rt6mAIBkQCabiFO0r/
        fHwbkyzrp98130Zui2il8eOfTzW1baAYHvg+4cWIqA==
X-Google-Smtp-Source: ABdhPJxscdqApl2yRhXufXwxU/nGg/b3hiHHa5fv3rtIz3RK6kyP7mKvmeZ2XLtQDSa89SrqQvkX2FeuSFU4Ls4BGrs=
X-Received: by 2002:a17:902:c3d3:b029:d1:e5e7:c4da with SMTP id
 j19-20020a170902c3d3b02900d1e5e7c4damr17771000plj.46.1600460834797; Fri, 18
 Sep 2020 13:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200917181347.1359365-1-axelrasmussen@google.com> <20200917154258.1a364cdf@gandalf.local.home>
In-Reply-To: <20200917154258.1a364cdf@gandalf.local.home>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 18 Sep 2020 13:26:37 -0700
Message-ID: <CAJHvVcjvhGJ-hPokv+dWSDybetEcDHTme0JAM5Rac4hXVYAagg@mail.gmail.com>
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 17 Sep 2020 11:13:47 -0700
> Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > +/*
> > + * Trace calls must be in a separate file, as otherwise there's a circuclar
> > + * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> > + */
> > +
> > +static void trace_start_locking(struct mm_struct *mm, bool write)
>
> Please don't use "trace_" for functions, as that should be reserved for the
> actual tracepoint functions. Please use "do_trace_" or whatever so there's
> no confusion about this being a tracepoint, even if it's just a function
> that calls the tracepoint.

Done; I'll send a v2 with this change.

>
> > +{
> > +     TRACE_MMAP_LOCK_EVENT(start_locking, mm, 0, write, true);
> > +}
> > +
> > +static void trace_acquire_returned(struct mm_struct *mm, u64 start_time_ns,
> > +                                bool write, bool success)
> > +{
> > +     TRACE_MMAP_LOCK_EVENT(acquire_returned, mm,
> > +                           sched_clock() - start_time_ns, write, success);
> > +}
> > +
> > +static void trace_released(struct mm_struct *mm, bool write)
> > +{
> > +     TRACE_MMAP_LOCK_EVENT(released, mm, 0, write, true);
> > +}
> > +
>
> > +static inline void lock_impl(struct mm_struct *mm,
> > +                          void (*lock)(struct rw_semaphore *), bool write)
> > +{
> > +     u64 start_time_ns;
> > +
> > +     trace_start_locking(mm, write);
> > +     start_time_ns = sched_clock();
> > +     lock(&mm->mmap_lock);
> > +     trace_acquire_returned(mm, start_time_ns, write, true);
> > +}
> > +
>
> Why record the start time and pass it in for return, when this can be done
> by simply recording the start and return and then using the timestamps of
> the trace events to calculate the duration, offline or as synthetic events:

First, thanks for the detailed feedback! As a newbie this is very helpful. :)

I agree in principle, and I almost have a working version as you
suggest, but I can't see a way to get string fields working.

I believe in trace event headers the typical way to define a string
field  is as a "const char *", with the __string, __assign_str, and
__get_str helpers. But, from reading trace_events_synth.c, this isn't
really supported, in that it only supports "char []". But, the hist
trigger code just does a strcmp() of the type string, it doesn't do
any type conversion, so it considers these types incompatible:

After this:
# echo 'mmap_lock_latency u64 time; char memcg_path[256]' >
/sys/kernel/tracing/synthetic_events

Trying to setup the hist trigger gives (the ^ points to the beginning
of keys=>m<emcg_path ... not sure the formatting will be preserved
properly in e-mail):
# cat /sys/kernel/tracing/error_log
[   15.823725] hist:mmap_lock:mmap_lock_acquire_returned: error: Param
type doesn't match synthetic event field type
  Command: hist:keys=memcg_path:latency=common_timestamp.usecs-$ts0:onmatch(mmap_lock.mmap_lock_start_locking).mmap_lock_latency($latency,memcg_path)
                     ^

I tried grepping "char [^\[]+\[" in include/trace/events/, and it
seems nobody is defining fixed-length string fields like that, so I
think that's the wrong solution. I checked the docs about defining
variables (https://www.kernel.org/doc/html/v5.2/trace/histogram.html)
and it doesn't support anything complex like a cast, just - and +.

Any advice?



>
>
>  # cd /sys/kernel/tracing/
>  # echo 'duration u64 time' > synthetic_events
>  # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs" > events/mmap_lock/mmap_lock_start_locking/trigger
>  # echo 'hist:keys=common_pid:dur=common_timestamp.usecs-$ts0:onmatch(mmap_lock.mmap_lock_start_locking).trace(duration,$dur)" > events/mmap_lock/mmap_lock_acquire_returned/trigger
>  # echo 1 > events/synthetic/duration/enable
>  # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 148/148   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             bash-1613  [007] ...3  3186.431687: duration: time=3
>             bash-1613  [007] ...3  3186.431722: duration: time=2
>             bash-1613  [007] ...3  3186.431772: duration: time=2
>             bash-1613  [001] ...3  3188.372001: duration: time=6
>             bash-1613  [001] ...3  3188.372324: duration: time=6
>             bash-1613  [001] ...3  3188.372332: duration: time=4
>             bash-1613  [001] ...3  3188.373557: duration: time=5
>             bash-1613  [001] ...3  3188.373595: duration: time=3
>              cat-1868  [002] ...3  3188.373608: duration: time=8
>             bash-1613  [001] ...3  3188.373613: duration: time=4
>             bash-1613  [001] ...3  3188.373635: duration: time=3
>              cat-1868  [002] ...3  3188.373646: duration: time=4
>             bash-1613  [001] ...3  3188.373652: duration: time=3
>             bash-1613  [001] ...3  3188.373669: duration: time=3
>
>  # echo 'hist:keys=time' > events/synthetic/duration/trigger
>  # cat events/synthetic/duration/hist
> # event histogram
> #
> # trigger info: hist:keys=time:vals=hitcount:sort=hitcount:size=2048 [active]
> #
>
> { time:        114 } hitcount:          1
> { time:         15 } hitcount:          1
> { time:         11 } hitcount:          1
> { time:         21 } hitcount:          1
> { time:         10 } hitcount:          1
> { time:         46 } hitcount:          1
> { time:         29 } hitcount:          1
> { time:         13 } hitcount:          2
> { time:         16 } hitcount:          3
> { time:          9 } hitcount:          3
> { time:          8 } hitcount:          3
> { time:          7 } hitcount:          8
> { time:          6 } hitcount:         10
> { time:          5 } hitcount:         28
> { time:          4 } hitcount:        121
> { time:          1 } hitcount:        523
> { time:          3 } hitcount:        581
> { time:          2 } hitcount:        882
>
> Totals:
>     Hits: 2171
>     Entries: 18
>     Dropped: 0
>
> And with this I could do a bunch of things like stack trace on max hits and
> other features that the tracing histograms give us.
>
> -- Steve
