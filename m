Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852772779E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgIXUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:05:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:60140 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:05:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7C3AB2D8B2B;
        Thu, 24 Sep 2020 16:05:36 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qwKKxYtgAltj; Thu, 24 Sep 2020 16:05:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DE3032D8B29;
        Thu, 24 Sep 2020 16:05:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DE3032D8B29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600977935;
        bh=wPBfoiM5raIuMndnFb1jHBDI02WcJ9fXEeL+3HBjjPA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QW7mmLvElq9v4Efw9gk7rGfdIzlUeX61ZIRi6IMJaI86KtoU5lmR27cGNLTp5To8f
         q1ErlgLqcol+yqesreU8lZ6ULjVGr7fKs2TTi6Md/ZhKTN6HOLde4o2fLEvESJw/J+
         yDupF+cAQlx/kCpBOBd1ff983FQ4rdmEKG2SSTXpYxAo0u2S68u4BtoGXem2wVz6Yv
         haX6Du5UpTsjVxh7D5+pwhzlWNzI2Dwomx+z1CbazOA6S4QETqOCBTGmvcYczqX5aE
         0u2Szh91K9XmnE0Hzp6VsuEJ4C65IJBppJQxqdR+oGducehNg2ApF56DKBg+MmqnJn
         F2ffifY/3T53A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kUVK2XB7hcQK; Thu, 24 Sep 2020 16:05:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BBD3C2D87CB;
        Thu, 24 Sep 2020 16:05:35 -0400 (EDT)
Date:   Thu, 24 Sep 2020 16:05:35 -0400 (EDT)
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
Message-ID: <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200924153517.73f5f257@oasis.local.home>
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org> <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com> <20200924143025.58dc3c1f@gandalf.local.home> <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com> <20200924153517.73f5f257@oasis.local.home>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: JDYB8tf5vIf49yNrKj5Aek9KBmNm9g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 24, 2020, at 3:35 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 24 Sep 2020 15:08:30 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Sep 24, 2020, at 2:30 PM, rostedt rostedt@goodmis.org wrote:
>> 
>> > On Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> >   
>> >> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> >> > ---
>> >> > Documentation/trace/tracepoints.rst | 25 ++++++++++++++++++++++
>> >> > include/linux/tracepoint-defs.h     | 33 +++++++++++++++++++++++++++++
>> >> > 2 files changed, 58 insertions(+)
>> >> > 
>> >> > diff --git a/Documentation/trace/tracepoints.rst
>> >> > b/Documentation/trace/tracepoints.rst
>> >> > index 6e3ce3bf3593..833d39ee1c44 100644
>> >> > --- a/Documentation/trace/tracepoints.rst
>> >> > +++ b/Documentation/trace/tracepoints.rst
>> >> > @@ -146,3 +146,28 @@ with jump labels and avoid conditional branches.
>> >> >       define tracepoints. Check http://lwn.net/Articles/379903,
>> >> >       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
>> >> >       for a series of articles with more details.
>> >> > +
>> >> > +If you require calling a tracepoint from a header file, it is not
>> >> > +recommended to call one directly or to use the trace_<tracepoint>_enabled()
>> >> > +function call, as tracepoints in header files can have side effects if a
>> >> > +header is included from a file that has CREATE_TRACE_POINTS set. Instead,
>> >> > +include tracepoint-defs.h and use trace_enabled().
>> >> 
>> >> Tracepoints per-se have no issues being used from header files. The TRACE_EVENT
>> >> infrastructure seems to be the cause of this problem. We should fix trace events
>> >> rather than require all users to use weird work-arounds thorough the kernel code
>> >> base.
>> > 
>> > That's like saying "let's solve include hell". Note, in the past there has
>> > also been issues with the headers included also having issues including
>> > other headers and cause a dependency loop.
>> 
>> AFAIU, there are a few scenarios we care about here:
>> 
>> 1) Includes done by tracepoint.h (directly and indirectly). Some additional
>>    includes may have crept in and bloated tracepoint.h since its original
>>    implementation. We should identify and fix those.
>> 
>> 2) Includes done by trace event headers when CREATE_TRACE_POINTS is defined.
>>    define_trace.h already takes care of #undef/#define CREATE_TRACE_POINTS to
>>    prevent recursion, so it should not be an issue.
>> 
>> 3) Includes done by a compile unit after #define CREATE_TRACE_POINTS, but which
>>    are not meant to create trace point probes. For this case, requiring to
>>    #undef CREATE_TRACE_POINTS after all the relevant headers are included should
>>    solve it.
>> 
>> So what additional issues am I missing here ?
> 
> How do we get to DECLARE_TRACE()?
> 
> Right now it requires a TRACE_EVENT() macro. Those are in the
> include/trace/events/ directory and some external. The files there that
> create all trace events and their tracepoints. Although you may not use
> TRACE_EVENT() yourself, you use what was created by them, which
> includes the trace_<tracepoint>() call.

Just to be clear: LTTng (the kernel tracer) uses the TP_PROTO() field of the
TRACE_EVENT(). So it does need it as well for prototype validation.

> As the TRACE_EVENT macro defines the parameters passed to the function,
> it's a requirement.

Yes.

So is the underlying issue caused by headers under include/trace/events/ including
various headers which are only needed for probe creation with CREATE_TRACE_PROBES,
but useless for TP_PROTO() ? If so, those includes could easily be wrapped with
#ifndef CREATE_TRACE_POINTS / #include .... / #endif. module.h, sched.h and writeback.h
already use that trick to only create static inline helpers when included from
probe creation context.

> 
> 
>> > 
>> > How are your trace events created?  All manual, or do you have helper
>> > macros.
>> 
>> I suspect you mean LTTng's trace events. Those are created with helper macros
>> (LTTNG_TRACEPOINT_EVENT) which have a few improvements over TRACE_EVENT, namely:
>> 
>> - Ability to create arrays of events (because lots of semicolons are removed),
>> removing
>>   the need to dynamically register each event at init time,
>> - Ability to do pre-filtering of events, before they hit the ring buffer,
>> allowed by
>>   combining TP_struct and TP_fast_assign into a single structured TP_FIELDS.
>> 
>> LTTng also has an include pass which uses TRACE_EVENT from the kernel to perform
>> tracepoint prototype signature validation of LTTNG_TRACEPOINT_EVENT against
>> TRACE_EVENT
>> prototypes.
>> 
>> > Would these be safe if a bunch were included?
>> 
>> Can you elaborate on this question ? I have a hard time figuring out what
>> scenario(s) you are after.
> 
> Actually, this doesn't matter. It's the creating of the trace_*() that
> is important here, not the call backs.

Right. But headers included as dependencies for the call backs might be the
root cause of our descent into #include hell. ;-)

> 
>> 
>> >   
>> >> 
>> >> I am not against the idea of a tracepoint_enabled(tp), but I am against the
>> >> motivation behind this patch and the new tracepoint user requirements it
>> >> documents.
>> > 
>> > It removes the open coded code that has been in the kernel for the last 4
>> > years.
>> 
>> There are indeed many cases where a tracepoint_enabled() macro makes sense. In
>> some situations we encounter in user-space for lttng-ust, there is need to
>> prepare data before it is passed as tracepoint arguments. Having this "enabled"
>> macros allows to only prepare the data when needed.
> 
> 
> We already have it today. It's just not safe to have in header files.
> This extension allows it, but also requires adding the
> DECLARE_TRACEPOINT(). Hmm, we may be able to replace the
> trace_<tracepoint>_enabled() with this instead.

Yes. It could probably look like the tracepoint_enabled() macro in lttng-ust [1].
It does not require any special "DECLARE_TRACEPOINT". The only difference in
the Linux kernel is that it should support static branches/asm gotos.

> 
> 
>> > 
>> > If you want, I can change the name to trace_event_enabled() and put
>> > the code in trace_events-defs.h instead. Which would simply include
>> > tracepoints-defs.h and have the exact same code.
>> 
>> I'm ok with tracepoint_enabled(). However, I would have placed it in
>> tracepoint.h rather than tracepoint-defs.h, and we should figure out
>> why people complain that tracepoint.h is including headers too
>> eagerly.
> 
> I could see if it would work in tracepoints.h.
> 
> It might. I was just being extra cautious.

If headers included by tracepoint.h are an issue, we should look into that and
remove what is unneeded.

If headers which happens to be included by include/trace/events/ headers are
the issue, and they happen to only be needed by CREATE_TRACE_PROBES, then we
should consider wrapping those #include with #ifdef CREATE_TRACE_PROBES guards.

> 
> -- Steve

[1] http://git.lttng.org/?p=lttng-ust.git;a=blob;f=include/lttng/tracepoint.h;h=1cf02188f37f78eafb1f61a32b56e99f748b697e;hb=HEAD#l64

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
