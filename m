Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8AF1DE78D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 15:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgEVNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 09:02:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53150 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgEVNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=schAI1KEx7KNmq1FcXBSmkj+86fakkSnCFzhDEJB56w=; b=jwt89y9XcWsCGjwp1oP2k3HS2Y
        Iu4yOCrI4ggdtju9GOlHtfZuDnQbo+9CEE8yV3z954ZM6Ib+TJS8e7Zn8FyV2tsj0sKWJx90ZHSwL
        ustqPrpyHhAl+7jn5U/7Ym38WzOVTrqrD8M35QfFkj3GXtCa3AjLRx7ZXdzfdJT3dP8cBLXz3yxFO
        XBrrsf8EdPsEfv869H3DRmp908E1Kv5/OhUCYfhHJOSAMgzNsNarjMkB0QBlXypLi/C4gVEq1QJAx
        VTNGYsxyVtJjDa7GKxfyM0SH98E6CFwoqxpyZSixF2srcXn2b5Q+rh6X0N73kteol7LMNHyt24ItD
        F/bQt5rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc7J9-0001Xi-2E; Fri, 22 May 2020 13:01:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CAA13011E8;
        Fri, 22 May 2020 15:01:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F76A20BE0DD1; Fri, 22 May 2020 15:01:45 +0200 (CEST)
Date:   Fri, 22 May 2020 15:01:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/8] locking: Introduce local_lock()
Message-ID: <20200522130145.GN325280@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-2-bigeasy@linutronix.de>
 <20200520120450.GL317569@hirez.programming.kicks-ass.net>
 <20200522110556.czizy72ak2nr32ve@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522110556.czizy72ak2nr32ve@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 01:05:56PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 14:04:50 [+0200], Peter Zijlstra wrote:
> > On Tue, May 19, 2020 at 10:19:05PM +0200, Sebastian Andrzej Siewior wrote:
> > > +/**
> > > + * DEFINE_LOCAL_LOCK - Define and initialize a per CPU local lock
> > > + * @lock:	Name of the lock instance
> > > + */
> > > +#define DEFINE_LOCAL_LOCK(lvar)					\
> > > +	DEFINE_PER_CPU(struct local_lock, lvar) = { INIT_LOCAL_LOCK(lvar) }
> > > +
> > > +/**
> > > + * DECLARE_LOCAL_LOCK - Declare a defined per CPU local lock
> > > + * @lock:	Name of the lock instance
> > > + */
> > > +#define DECLARE_LOCAL_LOCK(lvar)				\
> > > +	DECLARE_PER_CPU(struct local_lock, lvar)
> > 
> > So I think I'm going to argue having these is a mistake. The local_lock
> > should be put in a percpu structure along with the data it actually
> > protects.
> 
> So I got rid of these and made the local_lock part of the per-CPU
> struct.

Great!

> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +# define LL_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
> > 
> > That wants to be:
> > 
> > 	.dep_map = {
> > 		.name = #lockname,
> > 		.wait_type_inner = LD_WAIT_SPIN,
> 
> Why LD_WAIT_SPIN and not LD_WAIT_SLEEP? On RT the lock becomes sleeping
> and none of the SPIN restrictions apply. 

Ah, then it wants to be LD_WAIT_CONFIG. I completely forgot what RT did
here.
