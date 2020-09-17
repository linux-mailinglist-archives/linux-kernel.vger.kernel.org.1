Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E9526E0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgIQQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:31:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgIQQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:30:08 -0400
Date:   Thu, 17 Sep 2020 18:30:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600360203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXpBybO4CWXGQ/MADYCmIruC1fes9wIrjOBI4fqmH1g=;
        b=NlA6pC8S1cHhI/0T1uK8i1fVc0zGUz3app9gBMKbZuPQe7DcdG4TmQ/5y+AomaqbDihJNp
        hvwGnpXP6URbpV5PyAGSYkJ9uACmbz/MlIgGC7R5+v1a6nXGvRBXhEmn8OQpVqcJkX21N0
        1CsR6jqKDiuq7kYVxQyRk8X7n29azvL7078OfUoMe7izNnDyygxlqDi+wbxnvRsLxxkwEZ
        P5t6cg7rKN6Ard14oB0HMZyZbU2xQWM9ehMSW9esybhY7Ck03m0aEufV6U3R942/nEgBoM
        Iye5T7fj5OamXjRd5rAgwQ1FP9uH7zh212nEB7NVOsJHNnLdRzKS4/JMO9pM9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600360203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXpBybO4CWXGQ/MADYCmIruC1fes9wIrjOBI4fqmH1g=;
        b=7kSqDZphcWT1gjtxzsYa0nOdlLSZqvHOORKVB1nvwfJcQKywJY3+QqNXTbsqN6OIuQgrHw
        c/VhXZBvEhWSNJCw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200917163001.5ksl5vjwi35ozzsv@linutronix.de>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
 <20200917143850.25akkvr32ojtwohy@linutronix.de>
 <20200917144937.GI1362448@hirez.programming.kicks-ass.net>
 <20200917151341.2ilqamtnc6hperix@linutronix.de>
 <20200917155410.GK1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200917155410.GK1362448@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 17:54:10 [+0200], peterz@infradead.org wrote:
> I'm not sure what the problem with FPU was, I was throwing alternatives
> at tglx to see what would stick, in part to (re)discover the design
> constraints of this thing.

was this recent or distant in the time line?

> One reason for not allowing migrate_disable() to sleep was: FPU code.
>=20
> Could it be it does something like:
>=20
> 	preempt_disable();
> 	spin_lock();
>=20
> 	spin_unlock();
> 	preempt_enable();
>=20
> Where we'll never get preempted while migrate_disable()'d and thus never
> trigger any of the sleep paths?

I try to get rid of something like that. This doesn't work either way
because the spin_lock() may block which it can't with disabled
preemption.

Looking at my queue, FPU related is crypto. And here we break the loops
mostly due to the construct:
	kernel_fpu_begin();
	while (bytes)
		crypto_thingy();
		skcipher_walk_done()

and skcipher_walk_done() could allocate/free/map memory. This is
independent.

Ah. We used to have migrate_disable() in pagefault_disable(). The x86
FPU code does
	preempt_disable();
	=E2=80=A6
	pagefault_disable();

but that migrate_disable() was moved from pagefault_disable() to
kmap_atomic(). We shouldn't have
	preempt_disable(); || local_irq_disable();
	kmap_atomic();

on RT. I've been running around removing those. See
   a10dcebacdb0c ("fs/ntfs/aops.c: don't disable interrupts during kmap_ato=
mic()")
   ce1e518190ea7 ("ide: don't disable interrupts during kmap_atomic()")
   f3a1075e5fc34 ("block: don't disable interrupts during kmap_atomic()")

Sebastian
