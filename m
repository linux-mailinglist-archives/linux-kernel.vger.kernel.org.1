Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1126F1BACD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgD0Seq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 14:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgD0Sep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:34:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7079D214AF;
        Mon, 27 Apr 2020 18:34:43 +0000 (UTC)
Date:   Mon, 27 Apr 2020 14:34:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace
 trampolines
Message-ID: <20200427143442.14d929f0@gandalf.local.home>
In-Reply-To: <76de871f-fb0a-6918-68a9-94aa7b049d6b@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
        <20200405201327.7332-9-adrian.hunter@intel.com>
        <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
        <ce16611a-8b6c-765d-c254-5bb98493b082@intel.com>
        <20200422114659.GE20730@hirez.programming.kicks-ass.net>
        <76de871f-fb0a-6918-68a9-94aa7b049d6b@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 10:23:05 +0300
Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 22/04/20 2:46 pm, Peter Zijlstra wrote:
> > On Wed, Apr 22, 2020 at 10:39:06AM +0300, Adrian Hunter wrote:  
> >> On 21/04/20 4:45 pm, Peter Zijlstra wrote:  
> >>> On Sun, Apr 05, 2020 at 11:13:20PM +0300, Adrian Hunter wrote:  
> >>>> Add perf text poke events for ftrace trampolines when created and when
> >>>> freed.  
> >>>
> >>> Maybe also put in a little more detail on the various events. Because
> >>> arch_ftrace_update_trampoline() can also generate text_poke_bp() events,
> >>> to update an existing trampoline.
> >>>
> >>> A diagram, like with the kprobes thing perhaps.  
> >>
> >> How about adding this:
> >>
> >> There can be 3 text_poke events for ftrace trampolines:
> >>
> >> 1. NULL -> trampoline
> >>    By ftrace_update_trampoline() when !ops->trampoline
> >>    Trampoline created
> >>
> >> 2. [e.g. on x86] CALL rel32 -> CALL rel32
> >>    By arch_ftrace_update_trampoline() when ops->trampoline and
> >>                         ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
> >>    [e.g. on x86] via text_poke_bp() which generates text poke events
> >>    Trampoline-called function target updated
> >>
> >> 3. trampoline -> NULL
> >>    By ftrace_trampoline_free() when ops->trampoline and
> >>                  ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
> >>    Trampoline freed  
> > 
> > Yes, very nice. Thanks!  
> 
> Arnaldo, do you have this patchset on your radar?

Arnaldo deals with the userspace perf code. This looks like it needs to go
through the x86 tree.

-- Steve
