Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4A27D1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgI2OnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgI2OnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:43:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8525B2074F;
        Tue, 29 Sep 2020 14:43:09 +0000 (UTC)
Date:   Tue, 29 Sep 2020 10:43:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     quanyang.wang@windriver.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        a.darwish@linutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>, ben.dooks@codethink.co.uk
Subject: Re: [PATCH] time/sched_clock: mark sched_clock_read_begin as
 notrace
Message-ID: <20200929104307.19654426@gandalf.local.home>
In-Reply-To: <20200929071333.GK2628@hirez.programming.kicks-ass.net>
References: <20200928104952.26892-1-quanyang.wang@windriver.com>
        <20200928105859.GF2628@hirez.programming.kicks-ass.net>
        <20200928173331.3ea3cfb7@oasis.local.home>
        <20200929071333.GK2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 09:13:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 28, 2020 at 05:33:31PM -0400, Steven Rostedt wrote:
> > On Mon, 28 Sep 2020 12:58:59 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > > -struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > > > +notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > > >  {
> > > >  	*seq = raw_read_seqcount_latch(&cd.seq);
> > > >  	return cd.read_data + (*seq & 1);    
> > > 
> > > At the very least sched_clock_read_retry() should also be marked such.
> > > 
> > > But Steve, how come x86 works? Our sched_clock() doesn't have notrace on
> > > at all.  
> > 
> > It's because of that magic in the Makefile that you love so much ;-)
> > 
> > CFLAGS_REMOVE_tsc.o = -pg  
> 
> ARGH!!, I really should write a script to fix up that mess :/

Please don't.

I did this because these files contain lots of functions, that if traced
can cause function tracing to reboot without any information, and as you
have recently found, they are very hard to find when they do happen.

I much rather blacklist an entire file, than to spend time debugging what
function caused the system to reboot.

I'd be OK with both. That is, add "notrace" to all the functions in the
file that isn't traced, just for documentation purposes. Perhaps call it
something else:

  file_notrace  ?

and have a comment about it being "this is just to let you know that the
functions are not traced because of the file".

And this "file_notrace" could even be:

/*
 * Denote functions that are not traced because the make file removes the
 * tracing features via a CONFIG_REMOVE_xxx.o = CC_FLAGS_FTRACE or similar.
 * This is for documentation purposes only, to remind people why a function
 * is not being traced.
 */
#define file_notrace /* Not traced because the file is blacklisted */

We could also add:

#define dir_notrace /* Not traced because the entire directory is blacklisted */

-- Steve

