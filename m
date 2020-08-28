Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286332556FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgH1I6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgH1I56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:57:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3634C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jh+K2Qasy0dQnK1uvT/EeMP7bA1n+DIGMgJY0Q/GdaY=; b=bhk52EPRlRQtj4hjNqp2dQAUpT
        p3wGac0Y0OZ6DzlywXgXj41nddyy8whMv5LL9btkjpdv3axErC6Ln0H0WLitbTwDOJZw6QsMTZdeI
        GsH0FhxdW8rby/mg6NsiufBuiBVahRG14moyK+Zn3NNForrenMJPrm2D6Io6pWbqSzaJtN7qjIzmE
        nVE6hfqk7je4xJhdqgN1VfePSI6Mu283M6DIz6hFcgFmuBm54NaIMIbqdLZhGaHd2LEwxIAgAECrw
        Pv9i2Cg17VqlYPM2x71q7ifb/r2KkjjCpdMPaQm9u5OEhHdOuIh3XH4AHDu6e8nSJNDVvBAHLT5hE
        YC4c+lGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBaCl-0005ds-D5; Fri, 28 Aug 2020 08:57:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D96733003E5;
        Fri, 28 Aug 2020 10:57:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5F242C56E648; Fri, 28 Aug 2020 10:57:50 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:57:50 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] seqlock: seqcount_LOCKTYPE_t: Introduce
 PREEMPT_RT support
Message-ID: <20200828085750.GR1362448@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-5-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828010710.5407-5-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:07:09AM +0200, Ahmed S. Darwish wrote:
> +/*
> + * Automatically disable preemption for seqcount_LOCKTYPE_t writers, if the
> + * associated lock does not implicitly disable preemption.
> + *
> + * Don't do it for PREEMPT_RT. Check __SEQ_LOCK().
> + */
> +#define __seq_enforce_preemption_protection(s)				\
> +	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))

Hurph, so basically you want to make __seqcount_lock_preemptible()
return true PREEMPT_RT ? Should we then not muck about with the propery
instead of this?

ISTR I had something like the below, would that not be the same but much
clearer ?

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 300cbf312546..3b5ad026ddfb 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -211,11 +211,13 @@ static inline void __seqcount_assert(seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
-SEQCOUNT_LOCKTYPE(raw_spinlock_t,	raw_spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(spinlock_t,		spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		false,	s->lock)
-SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,	s->lock)
-SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
+#define __PREEMPT_RT	IS_BUILTIN(CONFIG_PREEMPT_RT)
+
+SEQCOUNT_LOCKTYPE(raw_spinlock_t,	raw_spinlock,	false,		s->lock)
+SEQCOUNT_LOCKTYPE(spinlock_t,		spinlock,	__PREEMPT_RT,	s->lock)
+SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		__PREEMPT_RT,	s->lock)
+SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,		s->lock)
+SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,		&s->lock->base)
 
 /*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t

