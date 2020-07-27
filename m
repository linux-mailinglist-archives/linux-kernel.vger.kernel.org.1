Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5422FAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG0U4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 16:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgG0U4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:56:17 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A1F20809;
        Mon, 27 Jul 2020 20:56:16 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:56:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH v2] sched,tracing: Convert to sched_set_fifo()
Message-ID: <20200727165614.5d0f4346@oasis.local.home>
In-Reply-To: <20200725165816.GE10769@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
        <20200709124505.GT597537@hirez.programming.kicks-ass.net>
        <20200709115818.36a956a4@oasis.local.home>
        <20200720214918.GM5523@worktop.programming.kicks-ass.net>
        <20200724213911.GX119549@hirez.programming.kicks-ass.net>
        <20200724174618.7487ee7c@oasis.local.home>
        <20200724215003.GY119549@hirez.programming.kicks-ass.net>
        <20200724181846.415bfd43@oasis.local.home>
        <20200725165816.GE10769@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 18:58:16 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jul 24, 2020 at 06:18:46PM -0400, Steven Rostedt wrote:
> > On Fri, 24 Jul 2020 23:50:03 +0200
> > peterz@infradead.org wrote:
> >   
> > > -	if (producer_fifo < 0)
> > > +	if (producer_fifo)
> > > +		trace_printk("Running Producer at SCHED_FIFO %s\n",
> > > +			     consumer_fifo == 1 ? "low" : "high");  
> > 
> > I'm going to take cut-and-paste away from you!  
> 
> Well, yes, I said so, I also already have it fixed.

I thought you're comment on IRC was about v1, as I read it before
seeing v2.

> 
> Aside from that, is the patch ok?

Beside this, yes.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
