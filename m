Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380E02A11A8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ3Xba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJ3Xb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:31:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF4E52076D;
        Fri, 30 Oct 2020 23:31:26 +0000 (UTC)
Date:   Fri, 30 Oct 2020 19:31:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
Message-ID: <20201030193124.7a1ba64e@oasis.local.home>
In-Reply-To: <87v9erl5tx.fsf@nanos.tec.linutronix.de>
References: <20201030151345.540479897@infradead.org>
        <20201030151955.187580298@infradead.org>
        <20201030181138.215b2b6a@carbon>
        <20201030162248.58e388f0@oasis.local.home>
        <87v9erl5tx.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 23:14:18 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, Oct 30 2020 at 16:22, Steven Rostedt wrote:
> > As this is something that ftrace recursion also does, perhaps we should
> > move this into interrupt.h so that anyone that needs a counter can get  
> 
> Not in interrupt.h please. We should create kernel/include/ for stuff
> which really should only be available in the core kernel code.
> 

The recursion protection is needed for anything that registers a
callback to ftrace. I have patches that already basically do the same
thing (although, with branches) that I'm going to place in
include/linux/trace_recursion.h, so that there are helper functions
that ftrace callbacks can use, instead of having to implement their own
recursion protection. After fixing two bugs in the recursion protection
code, it's something that should be reused, instead of everyone making
similar mistakes.

Note, I thought that in_nmi() and friends was in interrupt.h, but is
really in preempt.h. All the values used in Peter's code is also
defined in preempt.h, so why not have something like that there?

I take back adding it to interrupt.h but have it in preempt.h, as it's
not defining anything new there.

-- Steve
