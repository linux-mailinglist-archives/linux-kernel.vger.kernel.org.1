Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058F72778F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgIXTIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:08:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:57764 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgIXTIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:08:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0BD502D74C6;
        Thu, 24 Sep 2020 15:08:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AWGcBecf2P6b; Thu, 24 Sep 2020 15:08:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 786A42D74C5;
        Thu, 24 Sep 2020 15:08:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 786A42D74C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600974510;
        bh=QQ832Ql0B4lOHZSpslyUU8YUFE+Gdy5myHTqnjEwSPY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tpavRvlH+3rhDI0+Q1CYUKE4K+SzdLzd6PIkMXUuQHFpVKirqzKRB7qP/EteQpbAx
         eP5c15bQ8eDJc9jy8PGB4fFHwW9uT6Od3hxA5ErUSdiZ1FzSdfQDS0//rJNPaLAstQ
         9AtvjK3EvP2zLO2L8xaSJvlsMyffdt1xvxnGzUMQ64wfCGMlczSbkia9U2rP6cf+B1
         ca3ZU2LJdHXArxEHRkx9lgu/Dbhq+IrwsUbSuS0FmEklCnJ/t8OYY1ZA17kPjpUkt4
         ABM6XHC2m/MMwYrwfNcf48rSNf/t0rWQcBe8/dfc1+a+Lye7VPY7KRjFgbxD8j6mwG
         V4xgSD4sLdqNA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KN9TxhwJ7evq; Thu, 24 Sep 2020 15:08:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 611652D7726;
        Thu, 24 Sep 2020 15:08:30 -0400 (EDT)
Date:   Thu, 24 Sep 2020 15:08:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Message-ID: <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200924143025.58dc3c1f@gandalf.local.home>
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org> <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com> <20200924143025.58dc3c1f@gandalf.local.home>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: sYabWHEckaDFXTKHcpAU36fPALdS1g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Sep 24, 2020, at 2:30 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> > ---
>> > Documentation/trace/tracepoints.rst | 25 ++++++++++++++++++++++
>> > include/linux/tracepoint-defs.h     | 33 +++++++++++++++++++++++++++++
>> > 2 files changed, 58 insertions(+)
>> > 
>> > diff --git a/Documentation/trace/tracepoints.rst
>> > b/Documentation/trace/tracepoints.rst
>> > index 6e3ce3bf3593..833d39ee1c44 100644
>> > --- a/Documentation/trace/tracepoints.rst
>> > +++ b/Documentation/trace/tracepoints.rst
>> > @@ -146,3 +146,28 @@ with jump labels and avoid conditional branches.
>> >       define tracepoints. Check http://lwn.net/Articles/379903,
>> >       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
>> >       for a series of articles with more details.
>> > +
>> > +If you require calling a tracepoint from a header file, it is not
>> > +recommended to call one directly or to use the trace_<tracepoint>_enabled()
>> > +function call, as tracepoints in header files can have side effects if a
>> > +header is included from a file that has CREATE_TRACE_POINTS set. Instead,
>> > +include tracepoint-defs.h and use trace_enabled().
>> 
>> Tracepoints per-se have no issues being used from header files. The TRACE_EVENT
>> infrastructure seems to be the cause of this problem. We should fix trace events
>> rather than require all users to use weird work-arounds thorough the kernel code
>> base.
> 
> That's like saying "let's solve include hell". Note, in the past there has
> also been issues with the headers included also having issues including
> other headers and cause a dependency loop.

AFAIU, there are a few scenarios we care about here:

1) Includes done by tracepoint.h (directly and indirectly). Some additional
   includes may have crept in and bloated tracepoint.h since its original
   implementation. We should identify and fix those.

2) Includes done by trace event headers when CREATE_TRACE_POINTS is defined.
   define_trace.h already takes care of #undef/#define CREATE_TRACE_POINTS to
   prevent recursion, so it should not be an issue.

3) Includes done by a compile unit after #define CREATE_TRACE_POINTS, but which
   are not meant to create trace point probes. For this case, requiring to
   #undef CREATE_TRACE_POINTS after all the relevant headers are included should
   solve it.

So what additional issues am I missing here ?

> 
> But the magic of trace events (for both perf and ftrace, sorry if you
> refused to use it),

I cannot not use it to this day because changes I needed to upstream in order
to make it useful to me were rejected.

> is that people who add tracepoints do not need to know
> how tracepoints work. There's no adding of registering of them, or anything
> else. The formats and everything they record appear in the tracefs file
> system.

That's all fine by me.

> 
> How are your trace events created?  All manual, or do you have helper
> macros.

I suspect you mean LTTng's trace events. Those are created with helper macros
(LTTNG_TRACEPOINT_EVENT) which have a few improvements over TRACE_EVENT, namely:

- Ability to create arrays of events (because lots of semicolons are removed), removing
  the need to dynamically register each event at init time,
- Ability to do pre-filtering of events, before they hit the ring buffer, allowed by
  combining TP_struct and TP_fast_assign into a single structured TP_FIELDS.

LTTng also has an include pass which uses TRACE_EVENT from the kernel to perform
tracepoint prototype signature validation of LTTNG_TRACEPOINT_EVENT against TRACE_EVENT
prototypes.

> Would these be safe if a bunch were included?

Can you elaborate on this question ? I have a hard time figuring out what
scenario(s) you are after.

> 
>> 
>> I am not against the idea of a tracepoint_enabled(tp), but I am against the
>> motivation behind this patch and the new tracepoint user requirements it
>> documents.
> 
> It removes the open coded code that has been in the kernel for the last 4
> years.

There are indeed many cases where a tracepoint_enabled() macro makes sense. In
some situations we encounter in user-space for lttng-ust, there is need to
prepare data before it is passed as tracepoint arguments. Having this "enabled"
macros allows to only prepare the data when needed.

> 
>> 
>> > +
>> > +In a C file::
>> > +
>> > +	void do_trace_foo_bar_wrapper(args)
>> > +	{
>> > +		trace_foo_bar(args);
>> > +	}
>> > +
>> > +In the header file::
>> > +
>> > +	DECLEARE_TRACEPOINT(foo_bar);
>> > +
>> > +	static inline void some_inline_function()
>> > +	{
>> > +		[..]
>> > +		if (trace_enabled(foo_bar))
>> 
>> Is it trace_enabled() or tracepoint_enabled() ? There is a mismatch
>> between the commit message/code and the documentation.
> 
> Yes, it should be tracepoint_enabled(). Thanks for catching that.
> 
> Anyway, this shouldn't affect you in any way, as it's just adding wrappers
> around locations that have been doing this for years.
> 
> If you want, I can change the name to trace_event_enabled() and put the
> code in trace_events-defs.h instead. Which would simply include
> tracepoints-defs.h and have the exact same code.

I'm ok with tracepoint_enabled(). However, I would have placed it in tracepoint.h
rather than tracepoint-defs.h, and we should figure out why people complain that
tracepoint.h is including headers too eagerly.

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
