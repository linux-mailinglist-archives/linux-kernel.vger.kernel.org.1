Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698AE277884
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgIXSaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgIXSa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:30:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBCB42311E;
        Thu, 24 Sep 2020 18:30:27 +0000 (UTC)
Date:   Thu, 24 Sep 2020 14:30:25 -0400
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
Message-ID: <20200924143025.58dc3c1f@gandalf.local.home>
In-Reply-To: <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
References: <20200924170928.466191266@goodmis.org>
        <20200924171846.993048030@goodmis.org>
        <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> > Documentation/trace/tracepoints.rst | 25 ++++++++++++++++++++++
> > include/linux/tracepoint-defs.h     | 33 +++++++++++++++++++++++++++++
> > 2 files changed, 58 insertions(+)
> > 
> > diff --git a/Documentation/trace/tracepoints.rst
> > b/Documentation/trace/tracepoints.rst
> > index 6e3ce3bf3593..833d39ee1c44 100644
> > --- a/Documentation/trace/tracepoints.rst
> > +++ b/Documentation/trace/tracepoints.rst
> > @@ -146,3 +146,28 @@ with jump labels and avoid conditional branches.
> >       define tracepoints. Check http://lwn.net/Articles/379903,
> >       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
> >       for a series of articles with more details.
> > +
> > +If you require calling a tracepoint from a header file, it is not
> > +recommended to call one directly or to use the trace_<tracepoint>_enabled()
> > +function call, as tracepoints in header files can have side effects if a
> > +header is included from a file that has CREATE_TRACE_POINTS set. Instead,
> > +include tracepoint-defs.h and use trace_enabled().  
> 
> Tracepoints per-se have no issues being used from header files. The TRACE_EVENT
> infrastructure seems to be the cause of this problem. We should fix trace events
> rather than require all users to use weird work-arounds thorough the kernel code
> base.

That's like saying "let's solve include hell". Note, in the past there has
also been issues with the headers included also having issues including
other headers and cause a dependency loop.

But the magic of trace events (for both perf and ftrace, sorry if you
refused to use it), is that people who add tracepoints do not need to know
how tracepoints work. There's no adding of registering of them, or anything
else. The formats and everything they record appear in the tracefs file
system.

How are your trace events created? All manual, or do you have helper
macros. Would these be safe if a bunch were included?

> 
> I am not against the idea of a tracepoint_enabled(tp), but I am against the
> motivation behind this patch and the new tracepoint user requirements it documents.

It removes the open coded code that has been in the kernel for the last 4
years.

> 
> > +
> > +In a C file::
> > +
> > +	void do_trace_foo_bar_wrapper(args)
> > +	{
> > +		trace_foo_bar(args);
> > +	}
> > +
> > +In the header file::
> > +
> > +	DECLEARE_TRACEPOINT(foo_bar);
> > +
> > +	static inline void some_inline_function()
> > +	{
> > +		[..]
> > +		if (trace_enabled(foo_bar))  
> 
> Is it trace_enabled() or tracepoint_enabled() ? There is a mismatch
> between the commit message/code and the documentation.

Yes, it should be tracepoint_enabled(). Thanks for catching that.

Anyway, this shouldn't affect you in any way, as it's just adding wrappers
around locations that have been doing this for years.

If you want, I can change the name to trace_event_enabled() and put the
code in trace_events-defs.h instead. Which would simply include
tracepoints-defs.h and have the exact same code.

-- Steve
