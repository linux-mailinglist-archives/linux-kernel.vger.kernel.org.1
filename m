Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A917F27787B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgIXS1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:27:45 -0400
Received: from mail.efficios.com ([167.114.26.124]:44950 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIXS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:27:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1BDDD2D6C6C;
        Thu, 24 Sep 2020 14:27:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O-AltDfoQ3vZ; Thu, 24 Sep 2020 14:27:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 896212D6C6B;
        Thu, 24 Sep 2020 14:27:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 896212D6C6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600972063;
        bh=00aK33s9fewc8pvGQLHe9Nk+O73RBiJ0jm84/j672Xs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dz//ljFAyFBJbUzJ2g0iTI7S4WB+bHQztxMiiDECyBXvyVowiSgNgzNTIqTJT9768
         8CuAyjmJd5phO837AQE0/eiMUyJJ2iqrKTupFDCOOQsHppodp0Lw8rXixu6E167esd
         nVx0kyNtVuqo6QAUwKSYig2gkxLDNGtCALTZNKtfbbZrI0RFsKfNjkLrSWDp00mF9v
         SZ7sCR+SbHldUj5R1/dSAozlNOjqZ75EztJHnc4G7C7YdcHzL7WvPAf8fJ7OXOi911
         AdjT7ZgR7FQH3vTK0oawaNBrPt7ZIknhQorhOWNQDbMNJTUNBiAfcwLeBc8LGUtK8H
         ByLjL3Er5xvWQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8J5XDJS6vpNk; Thu, 24 Sep 2020 14:27:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 790562D6EA5;
        Thu, 24 Sep 2020 14:27:43 -0400 (EDT)
Date:   Thu, 24 Sep 2020 14:27:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Message-ID: <1383330755.68272.1600972063386.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJHvVcjcehxKV2dmc8+j5ke-JcqGRvGoQTf2iKSN4istLQKseQ@mail.gmail.com>
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org> <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com> <CAJHvVcjcehxKV2dmc8+j5ke-JcqGRvGoQTf2iKSN4istLQKseQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: k2Cg2dA8peJiqXUB0Yj03qNzuvJBFw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 24, 2020, at 2:19 PM, Axel Rasmussen axelrasmussen@google.com wrote:

> On Thu, Sep 24, 2020 at 10:42 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Sep 24, 2020, at 1:09 PM, rostedt rostedt@goodmis.org wrote:
>>
>> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>> >
>> > As tracepoints are discouraged from being added in a header because it can
>> > cause side effects if other tracepoints are in headers, the common
>> > workaround is to add a function call that calls a wrapper function in a
>> > C file that then calls the tracepoint. But as function calls add overhead,
>> > this function should only be called when the tracepoint in question is
>> > enabled. To get around the overhead, a static_branch can be used that only
>> > gets set when the tracepoint is enabled, and then inside the block of the
>> > static branch can contain the call to the tracepoint wrapper.
>> >
>> > Add a tracepoint_enabled(tp) macro that gets passed the name of the
>> > tracepoint, and this becomes a static_branch that is enabled when the
>> > tracepoint is enabled and is a nop when the tracepoint is disabled.
>> >
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
>>
>> I am not against the idea of a tracepoint_enabled(tp), but I am against the
>> motivation behind this patch and the new tracepoint user requirements it
>> documents.
> 
> Perhaps anecdotally, I've found that the situation Steven described
> occurs not just because of the TRACE_EVENT infrastructure. We also run
> into this problem when adding tracepoints under any "very core" APIs,
> i.e. anything that is transiently included from linux/tracepoint.h.
> For example, I ran into this issue while adding tracepoints under the
> linux/mmap_lock.h API, because that header is somehow transiently
> included by linux/tracepoint.h (sorry, I don't have the exact
> transient include path on hand; I can dig it up if it would be
> useful).

If it's not too much trouble, it would be useful to know what headers
included from tracepoint.h are problematic. When I originally wrote
tracepoint.h, I made sure to include the minimum set needed, but I
suspect some feature-creep may have ended up including additional
headers which are not strictly needed for the core instrumentation.

Once we identify those, we can then make sure we split tracepoint.h
into a "core instrumentation" header (tracepoint.h) and non-core
stuff (e.g. tracepoint-utils.h or better name).

Another possible approach is to make sure that whatever is included
by the tracepoint.h "core" is split into *.h and *-{defs,types}.h, for
cases where all we need from tracepoint.h is type declarations.

Thanks,

Mathieu

> 
> 
> 
>>
>> > +
>> > +In a C file::
>> > +
>> > +     void do_trace_foo_bar_wrapper(args)
>> > +     {
>> > +             trace_foo_bar(args);
>> > +     }
>> > +
>> > +In the header file::
>> > +
>> > +     DECLEARE_TRACEPOINT(foo_bar);
>> > +
>> > +     static inline void some_inline_function()
>> > +     {
>> > +             [..]
>> > +             if (trace_enabled(foo_bar))
>>
>> Is it trace_enabled() or tracepoint_enabled() ? There is a mismatch
>> between the commit message/code and the documentation.
>>
>> Thanks,
>>
>> Mathieu
>>
>> > +                     do_trace_foo_bar_wrapper(args);
>> > +             [..]
>> > +     }
>> > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
>> > index b29950a19205..ca2f1f77f6f8 100644
>> > --- a/include/linux/tracepoint-defs.h
>> > +++ b/include/linux/tracepoint-defs.h
>> > @@ -48,4 +48,37 @@ struct bpf_raw_event_map {
>> >       u32                     writable_size;
>> > } __aligned(32);
>> >
>> > +/*
>> > + * If a tracepoint needs to be called from a header file, it is not
>> > + * recommended to call it directly, as tracepoints in header files
>> > + * may cause side-effects. Instead, use trace_enabled() to test
>> > + * if the tracepoint is enabled, then if it is, call a wrapper
>> > + * function defined in a C file that will then call the tracepoint.
>> > + *
>> > + * For "trace_foo()", you would need to create a wrapper function
>> > + * in a C file to call trace_foo():
>> > + *   void trace_bar(args) { trace_foo(args); }
>> > + * Then in the header file, declare the tracepoint:
>> > + *   DECLARE_TRACEPOINT(foo);
>> > + * And call your wrapper:
>> > + *   static inline void some_inlined_function() {
>> > + *            [..]
>> > + *            if (tracepoint_enabled(foo))
>> > + *                    trace_bar(args);
>> > + *            [..]
>> > + *   }
>> > + *
>> > + * Note: tracepoint_enabled(foo) is equivalent to trace_foo_enabled()
>> > + *   but is safe to have in headers, where trace_foo_enabled() is not.
>> > + */
>> > +#define DECLARE_TRACEPOINT(tp) \
>> > +     extern struct tracepoint __tracepoint_##tp
>> > +
>> > +#ifdef CONFIG_TRACEPOINTS
>> > +# define tracepoint_enabled(tp) \
>> > +     static_key_false(&(__tracepoint_##tp).key)
>> > +#else
>> > +# define tracepoint_enabled(tracepoint) false
>> > +#endif
>> > +
>> > #endif
>> > --
>> > 2.28.0
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
