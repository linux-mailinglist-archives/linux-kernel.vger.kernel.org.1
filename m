Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D725227B70A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgI1Vde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 17:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgI1Vde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 17:33:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B262083B;
        Mon, 28 Sep 2020 21:33:33 +0000 (UTC)
Date:   Mon, 28 Sep 2020 17:33:31 -0400
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
Message-ID: <20200928173331.3ea3cfb7@oasis.local.home>
In-Reply-To: <20200928105859.GF2628@hirez.programming.kicks-ass.net>
References: <20200928104952.26892-1-quanyang.wang@windriver.com>
        <20200928105859.GF2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 12:58:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > -struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > +notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> >  {
> >  	*seq = raw_read_seqcount_latch(&cd.seq);
> >  	return cd.read_data + (*seq & 1);  
> 
> At the very least sched_clock_read_retry() should also be marked such.
> 
> But Steve, how come x86 works? Our sched_clock() doesn't have notrace on
> at all.

It's because of that magic in the Makefile that you love so much ;-)

CFLAGS_REMOVE_tsc.o = -pg

-- Steve
