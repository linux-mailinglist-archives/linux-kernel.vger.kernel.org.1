Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C062B050D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgKLMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:39:06 -0500
Received: from mail.monom.org ([188.138.9.77]:46498 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:39:06 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 9C4F4500596;
        Thu, 12 Nov 2020 13:39:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 28375500108;
        Thu, 12 Nov 2020 13:39:03 +0100 (CET)
Date:   Thu, 12 Nov 2020 13:39:02 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201112123902.netkfwzccwrtscdv@beryllium.lan>
References: <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
 <20201106161413.7c65uxenamy474uh@beryllium.lan>
 <20201109124718.ljf7inok4zakkjed@linutronix.de>
 <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
 <20201110180518.miuxa25j7lnn7f2q@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110180518.miuxa25j7lnn7f2q@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 07:05:18PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-09 15:37:03 [+0100], Daniel Wagner wrote:
> > > I've been staring at the code of signaltest on Friday and I might need
> > > to stare longer to figure out what it does.
> > 
> > I hear you. Anyway, I gave the current head a run with lazy preemption
> > disabled as you asked for.
> 
> I just sent a few patches your way regarding signaltest. It should help
> you with tracing. I've been playing with it on a juno box and I didn't
> see anything odd. My max value was below 200us. I added a few tracing
> bits. With sched, signal and hrtimer events you should be able to see
> what delays the RT thread. I didn't see anything odd.

With the current version signaltest + your test patch and 'taskset -c1'
the results looks good again, around 230us (running since 2 hours). I've
tested first without taskset and it took about an half hour to hit
350us. So pinning the threads on one CPU fixes it.

I think we change signaltest to use the correct affinity on
default. Also, I see that sigwaittest has some code for it, but it, but
it would be a good idea to set the defaults so that out of the box the
test does the right thing.

I'm sorry about dragging you into this problem.
