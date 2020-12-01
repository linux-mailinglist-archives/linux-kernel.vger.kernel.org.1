Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5E2CA334
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbgLAMxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgLAMxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:53:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F46C0613D4;
        Tue,  1 Dec 2020 04:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eFhg/PuMOFyaGES3o6MisTQ/pHI2d3l4wdhXLJMTbdo=; b=C1zB8W8J+Sm6jWREgozBBWXo35
        BjjxzDDheKVebPUlT4p0vuwuJ2HZIKfU6T3cV8/ITFox3ZR4MEwC3AKW8tTokROdNM99Utk2Nm+C5
        0Ren6IvoRMzKo8QDKLNxaX/JFyTQohFbcOOLwLnVXtvs6kyHWsprifV/Jmib0SDhOIltGyV33F4/a
        J8kmsQ6zSFwmdQzM9Ip29z7fQv5p6Yed2GL/g+bj/GZn8I4qiw4EpRRJXgJGxARVe1CP2tJYr6vMv
        c/vd8PxVE2q3ElP6uo5yFnmuGK5HIHdJ44JCJVQe5XSt1F8vgvP703UUtTmbyK7/yI7dwq8o0m+Ym
        H4wvCjFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk59E-0006BG-LK; Tue, 01 Dec 2020 12:52:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33DFD302753;
        Tue,  1 Dec 2020 13:52:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0226B236418FC; Tue,  1 Dec 2020 13:52:46 +0100 (CET)
Date:   Tue, 1 Dec 2020 13:52:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org,
        mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
Message-ID: <20201201125246.GV2414@hirez.programming.kicks-ass.net>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.594122626@infradead.org>
 <20201130210003.GA40619@roeck-us.net>
 <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
 <yt9dh7p54u50.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dh7p54u50.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:56:27PM +0100, Sven Schnelle wrote:
> Hi Peter,
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
> >> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
> >> > We call arch_cpu_idle() with RCU disabled, but then use
> >> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> >> > 
> >> > Switch all arch_cpu_idle() implementations to use
> >> > raw_local_irq_{en,dis}able() and carefully manage the
> >> > lockdep,rcu,tracing state like we do in entry.
> >> > 
> >> > (XXX: we really should change arch_cpu_idle() to not return with
> >> > interrupts enabled)
> >> > 
> >> 
> >> Has this patch been tested on s390 ? Reason for asking is that it causes
> >> all my s390 emulations to crash. Reverting it fixes the problem.
> >
> > My understanding is that it changes the error on s390. Previously it
> > would complain about the local_irq_enable() in arch_cpu_idle(), now it
> > complains when taking an interrupt during idle.
> 
> I looked into adding the required functionality for s390, but the code
> we would need to add to entry.S is rather large - as you noted we would
> have to duplicate large portions of irqentry_enter() into our code.
> Given that s390 was fine before that patch, can you revert it and submit
> it again during the next merge window?

I'm not sure I understand how s390 was fine without it, let me consdier.
Also, what's the status of ARM64, they do need this too.
