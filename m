Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6352280ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgGUNaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 09:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgGUNaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:30:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16189206E9;
        Tue, 21 Jul 2020 13:30:12 +0000 (UTC)
Date:   Tue, 21 Jul 2020 09:30:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200721093010.1c8bd787@oasis.local.home>
In-Reply-To: <20200721083643.GG119549@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
        <20200709124505.GT597537@hirez.programming.kicks-ass.net>
        <20200709115818.36a956a4@oasis.local.home>
        <20200720214918.GM5523@worktop.programming.kicks-ass.net>
        <20200720181943.7d8efc65@oasis.local.home>
        <20200721083643.GG119549@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 10:36:43 +0200
peterz@infradead.org wrote:

> > Yeah, that's fine. You don't have any sched_fifo_high() ?  
> 
> Thanks! and no.
> 
> I'll go write a Changelog and add it to tip/sched/fifo, so that
> hopefully, sfr can stop complaining about this build fail ;-)
> 
> I've even argued we should rename fifo_low() to something else, but
> failed to come up with a sensible name. The intended case is for when
> you want something above normal but don't particularly care about RT at
> all.
> 
> The thing is, once you start adding priorities, even low,med,high, we're
> back to where we were. And the whole argument is that the kernel cannot
> set priorities in any sensible fashion.

Actually, I was wondering about a "sched_fifo_benchmark()" used
specifically for internal testing, where you *want* to disrupt the
system. Perhaps have it depend on CONFIG_DEBUG to at least scare
people away from using it for normal production code. Or make it print
a nasty banner like trace_printk() does. That worked pretty well at
keeping people from using it ;-)

-- Steve
