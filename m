Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5747426E601
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgIQUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgIQUAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:00:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA0721D92;
        Thu, 17 Sep 2020 19:43:00 +0000 (UTC)
Date:   Thu, 17 Sep 2020 15:42:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Yafang Shao <laoar.shao@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
Message-ID: <20200917154258.1a364cdf@gandalf.local.home>
In-Reply-To: <20200917181347.1359365-1-axelrasmussen@google.com>
References: <20200917181347.1359365-1-axelrasmussen@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 11:13:47 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> +/*
> + * Trace calls must be in a separate file, as otherwise there's a circuclar
> + * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> + */
> +
> +static void trace_start_locking(struct mm_struct *mm, bool write)

Please don't use "trace_" for functions, as that should be reserved for the
actual tracepoint functions. Please use "do_trace_" or whatever so there's
no confusion about this being a tracepoint, even if it's just a function
that calls the tracepoint.

> +{
> +	TRACE_MMAP_LOCK_EVENT(start_locking, mm, 0, write, true);
> +}
> +
> +static void trace_acquire_returned(struct mm_struct *mm, u64 start_time_ns,
> +				   bool write, bool success)
> +{
> +	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm,
> +			      sched_clock() - start_time_ns, write, success);
> +}
> +
> +static void trace_released(struct mm_struct *mm, bool write)
> +{
> +	TRACE_MMAP_LOCK_EVENT(released, mm, 0, write, true);
> +}
> +

> +static inline void lock_impl(struct mm_struct *mm,
> +			     void (*lock)(struct rw_semaphore *), bool write)
> +{
> +	u64 start_time_ns;
> +
> +	trace_start_locking(mm, write);
> +	start_time_ns = sched_clock();
> +	lock(&mm->mmap_lock);
> +	trace_acquire_returned(mm, start_time_ns, write, true);
> +}
> +

Why record the start time and pass it in for return, when this can be done
by simply recording the start and return and then using the timestamps of
the trace events to calculate the duration, offline or as synthetic events:


 # cd /sys/kernel/tracing/
 # echo 'duration u64 time' > synthetic_events
 # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs" > events/mmap_lock/mmap_lock_start_locking/trigger
 # echo 'hist:keys=common_pid:dur=common_timestamp.usecs-$ts0:onmatch(mmap_lock.mmap_lock_start_locking).trace(duration,$dur)" > events/mmap_lock/mmap_lock_acquire_returned/trigger
 # echo 1 > events/synthetic/duration/enable
 # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 148/148   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            bash-1613  [007] ...3  3186.431687: duration: time=3
            bash-1613  [007] ...3  3186.431722: duration: time=2
            bash-1613  [007] ...3  3186.431772: duration: time=2
            bash-1613  [001] ...3  3188.372001: duration: time=6
            bash-1613  [001] ...3  3188.372324: duration: time=6
            bash-1613  [001] ...3  3188.372332: duration: time=4
            bash-1613  [001] ...3  3188.373557: duration: time=5
            bash-1613  [001] ...3  3188.373595: duration: time=3
             cat-1868  [002] ...3  3188.373608: duration: time=8
            bash-1613  [001] ...3  3188.373613: duration: time=4
            bash-1613  [001] ...3  3188.373635: duration: time=3
             cat-1868  [002] ...3  3188.373646: duration: time=4
            bash-1613  [001] ...3  3188.373652: duration: time=3
            bash-1613  [001] ...3  3188.373669: duration: time=3

 # echo 'hist:keys=time' > events/synthetic/duration/trigger
 # cat events/synthetic/duration/hist
# event histogram
#
# trigger info: hist:keys=time:vals=hitcount:sort=hitcount:size=2048 [active]
#

{ time:        114 } hitcount:          1
{ time:         15 } hitcount:          1
{ time:         11 } hitcount:          1
{ time:         21 } hitcount:          1
{ time:         10 } hitcount:          1
{ time:         46 } hitcount:          1
{ time:         29 } hitcount:          1
{ time:         13 } hitcount:          2
{ time:         16 } hitcount:          3
{ time:          9 } hitcount:          3
{ time:          8 } hitcount:          3
{ time:          7 } hitcount:          8
{ time:          6 } hitcount:         10
{ time:          5 } hitcount:         28
{ time:          4 } hitcount:        121
{ time:          1 } hitcount:        523
{ time:          3 } hitcount:        581
{ time:          2 } hitcount:        882

Totals:
    Hits: 2171
    Entries: 18
    Dropped: 0

And with this I could do a bunch of things like stack trace on max hits and
other features that the tracing histograms give us.

-- Steve
