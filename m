Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE891C028A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD3Qai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgD3Qah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:30:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260F92070B;
        Thu, 30 Apr 2020 16:30:36 +0000 (UTC)
Date:   Thu, 30 Apr 2020 12:30:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
Message-ID: <20200430123034.5705cd47@gandalf.local.home>
In-Reply-To: <947455570.77870.1588263502669.JavaMail.zimbra@efficios.com>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200430141120.GA8135@suse.de>
        <20200430145057.GB8135@suse.de>
        <2026887875.77814.1588260015439.JavaMail.zimbra@efficios.com>
        <20200430121627.682061e2@gandalf.local.home>
        <947455570.77870.1588263502669.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 12:18:22 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 30, 2020, at 12:16 PM, rostedt rostedt@goodmis.org wrote:
> 
> > On Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> > The right fix is to call vmalloc_sync_mappings() right after allocating
> >> > tracing or perf buffers via v[zm]alloc().  
> >> 
> >> Either right after allocation, or right before making the vmalloc'd data
> >> structure visible to the instrumentation. In the case of the pid filter,
> >> that would be the rcu_assign_pointer() which publishes the new pid filter
> >> table.
> >> 
> >> As long as vmalloc_sync_mappings() is performed somewhere *between* allocation
> >> and publishing the pointer for instrumentation, it's fine.
> >> 
> >> I'll let Steven decide on which approach works best for him.  
> > 
> > As stated in the other email, I don't see it having anything to do with
> > vmalloc, but with the per_cpu() allocation. I'll test this theory out by
> > not even allocating the pid masks and touching the per cpu data at every
> > event to see if it crashes.  
> 
> As pointed out in my other email, per-cpu allocation uses vmalloc when
> size > PAGE_SIZE.

And as I replied:

	buf->data = alloc_percpu(struct trace_array_cpu);

struct trace_array_cpu {
	atomic_t		disabled;
	void			*buffer_page;	/* ring buffer spare */

	unsigned long		entries;
	unsigned long		saved_latency;
	unsigned long		critical_start;
	unsigned long		critical_end;
	unsigned long		critical_sequence;
	unsigned long		nice;
	unsigned long		policy;
	unsigned long		rt_priority;
	unsigned long		skipped_entries;
	u64			preempt_timestamp;
	pid_t			pid;
	kuid_t			uid;
	char			comm[TASK_COMM_LEN];

	bool			ignore_pid;
#ifdef CONFIG_FUNCTION_TRACER
	bool			ftrace_ignore_pid;
#endif
};

That doesn't look bigger than PAGE_SIZE to me.

-- Steve
