Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494DC2CA654
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbgLAOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbgLAOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:52:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10481C0613D6;
        Tue,  1 Dec 2020 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=79hZSRO8jFXaFARYMzWI118qQEGUmsvhHJdNwcVa21I=; b=mi9X6HehR6l4KQKYRy/GebLKZx
        h1Pk0u4xUriQ+MV2OE4N0WH7o71QVdT0x20Ewv+vFGS7ElsE2EL5lvE52XRJ75yHMS9ChpoIPvbDK
        vXnU1skMZA3IpPtAKatQzdTH8nyOfiXuV75KaNUzMXFxRYlZv81+Blg73jQINtPjfA/G/L3Eom5bV
        HXzaXQxrZk2CvRs8xAyI+4WYXx9wah1AIqtK2T01NHJf7swhCEN3k8sQ0fVbef19X4KNrSPOlilcQ
        ZY9dCJLuB5cnsSCSKbmk7B/5BB9eigmb+JcCuNV8TLoUVjYjd6mPKqzuDftNAxHmBxBh65PzP5FRO
        xBR4/G2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk6zv-000660-8q; Tue, 01 Dec 2020 14:51:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FA293003E1;
        Tue,  1 Dec 2020 15:51:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BC9E2BAB3C8B; Tue,  1 Dec 2020 15:51:16 +0100 (CET)
Date:   Tue, 1 Dec 2020 15:51:16 +0100
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
Message-ID: <20201201145116.GX2414@hirez.programming.kicks-ass.net>
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

So the thing that got me started here was:

  https://lkml.kernel.org/r/yt9dimbm79qi.fsf@linux.ibm.com/

And I got a very similar report from Mark for arm64. I'm not sure what
you meanwhile did to get rid of that. But I'm struggling to understand
how s390 can work on v5.10-rc5.

There's just too much calling into tracing while RCU is stopped.
