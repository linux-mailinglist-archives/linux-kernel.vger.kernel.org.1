Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26F727796B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgIXTfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgIXTfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:35:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2504923899;
        Thu, 24 Sep 2020 19:35:19 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:35:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
Message-ID: <20200924153517.73f5f257@oasis.local.home>
In-Reply-To: <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
References: <20200924170928.466191266@goodmis.org>
        <20200924171846.993048030@goodmis.org>
        <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
        <20200924143025.58dc3c1f@gandalf.local.home>
        <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 15:08:30 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Sep 24, 2020, at 2:30 PM, rostedt rostedt@goodmis.org wrote:
> 
> > On Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >> > ---
> >> > Documentation/trace/tracepoints.rst | 25 ++++++++++++++++++++++
> >> > include/linux/tracepoint-defs.h     | 33 +++++++++++++++++++++++++++++
> >> > 2 files changed, 58 insertions(+)
> >> > 
> >> > diff --git a/Documentation/trace/tracepoints.rst
> >> > b/Documentation/trace/tracepoints.rst
> >> > index 6e3ce3bf3593..833d39ee1c44 100644
> >> > --- a/Documentation/trace/tracepoints.rst
> >> > +++ b/Documentation/trace/tracepoints.rst
> >> > @@ -146,3 +146,28 @@ with jump labels and avoid conditional branches.
> >> >       define tracepoints. Check http://lwn.net/Articles/379903,
> >> >       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
> >> >       for a series of articles with more details.
> >> > +
> >> > +If you require calling a tracepoint from a header file, it is not
> >> > +recommended to call one directly or to use the trace_<tracepoint>_enabled()
> >> > +function call, as tracepoints in header files can have side effects if a
> >> > +header is included from a file that has CREATE_TRACE_POINTS set. Instead,
> >> > +include tracepoint-defs.h and use trace_enabled().  
> >> 
> >> Tracepoints per-se have no issues being used from header files. The TRACE_EVENT
> >> infrastructure seems to be the cause of this problem. We should fix trace events
> >> rather than require all users to use weird work-arounds thorough the kernel code
> >> base.  
> > 
> > That's like saying "let's solve include hell". Note, in the past there has
> > also been issues with the headers included also having issues including
> > other headers and cause a dependency loop.  
> 
> AFAIU, there are a few scenarios we care about here:
> 
> 1) Includes done by tracepoint.h (directly and indirectly). Some additional
>    includes may have crept in and bloated tracepoint.h since its original
>    implementation. We should identify and fix those.
> 
> 2) Includes done by trace event headers when CREATE_TRACE_POINTS is defined.
>    define_trace.h already takes care of #undef/#define CREATE_TRACE_POINTS to
>    prevent recursion, so it should not be an issue.
> 
> 3) Includes done by a compile unit after #define CREATE_TRACE_POINTS, but which
>    are not meant to create trace point probes. For this case, requiring to
>    #undef CREATE_TRACE_POINTS after all the relevant headers are included should
>    solve it.
> 
> So what additional issues am I missing here ?

How do we get to DECLARE_TRACE()?

Right now it requires a TRACE_EVENT() macro. Those are in the
include/trace/events/ directory and some external. The files there that
create all trace events and their tracepoints. Although you may not use
TRACE_EVENT() yourself, you use what was created by them, which
includes the trace_<tracepoint>() call.

As the TRACE_EVENT macro defines the parameters passed to the function,
it's a requirement.


> > 
> > How are your trace events created?  All manual, or do you have helper
> > macros.  
> 
> I suspect you mean LTTng's trace events. Those are created with helper macros
> (LTTNG_TRACEPOINT_EVENT) which have a few improvements over TRACE_EVENT, namely:
> 
> - Ability to create arrays of events (because lots of semicolons are removed), removing
>   the need to dynamically register each event at init time,
> - Ability to do pre-filtering of events, before they hit the ring buffer, allowed by
>   combining TP_struct and TP_fast_assign into a single structured TP_FIELDS.
> 
> LTTng also has an include pass which uses TRACE_EVENT from the kernel to perform
> tracepoint prototype signature validation of LTTNG_TRACEPOINT_EVENT against TRACE_EVENT
> prototypes.
> 
> > Would these be safe if a bunch were included?  
> 
> Can you elaborate on this question ? I have a hard time figuring out what
> scenario(s) you are after.

Actually, this doesn't matter. It's the creating of the trace_*() that
is important here, not the call backs.

> 
> >   
> >> 
> >> I am not against the idea of a tracepoint_enabled(tp), but I am against the
> >> motivation behind this patch and the new tracepoint user requirements it
> >> documents.  
> > 
> > It removes the open coded code that has been in the kernel for the last 4
> > years.  
> 
> There are indeed many cases where a tracepoint_enabled() macro makes sense. In
> some situations we encounter in user-space for lttng-ust, there is need to
> prepare data before it is passed as tracepoint arguments. Having this "enabled"
> macros allows to only prepare the data when needed.


We already have it today. It's just not safe to have in header files.
This extension allows it, but also requires adding the
DECLARE_TRACEPOINT(). Hmm, we may be able to replace the
trace_<tracepoint>_enabled() with this instead.


> > 
> > If you want, I can change the name to trace_event_enabled() and put
> > the code in trace_events-defs.h instead. Which would simply include
> > tracepoints-defs.h and have the exact same code.  
> 
> I'm ok with tracepoint_enabled(). However, I would have placed it in
> tracepoint.h rather than tracepoint-defs.h, and we should figure out
> why people complain that tracepoint.h is including headers too
> eagerly.

I could see if it would work in tracepoints.h.

It might. I was just being extra cautious.

-- Steve
