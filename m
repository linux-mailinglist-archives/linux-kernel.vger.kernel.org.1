Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F01DBBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETRnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgETRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:43:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC33C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:43:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f13so4478966qkh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VBRfAgii8K8/gCukCvu8XCg+o66x9P2+cPM+CVImvio=;
        b=DnLHnQ5sjW0TrKjPiSFQuJoNHu1nh52R7i4YKRaAtQGIFAYQyxlX2Xr8mJrcX3jKww
         xuOXyXA3HijuVMJvaJw+QBdSvvEH/Kbpth1JAtrqv2DaK3zYrFXS5SN4dshFnhcvFDsj
         8S0tIUvfnho9IxPjeojIhpUzb1HuBd0c/NWqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VBRfAgii8K8/gCukCvu8XCg+o66x9P2+cPM+CVImvio=;
        b=GEvSUMqwfZZkeqpLnxohfnT/ihNyxArTwu9bA//FUrwJaWZeOGWITuunX1wpyVse9v
         Qsc/VBMnlkWSlOfb5c4E69cq2fOrwz8ovvvsiX+9IOiXbXmdLNu1PCkiaWfO4Kj06nHr
         22dnA5jxhm5t1Hy9Qa2NSXuZueZDWN0LfgZiGhGAPzFBtjWIGz5DtdtHxFQJDltP4XEr
         t847OTp+RNixRDVXIGJysk6rWneFqbkWIaAOP0IDpobJP4z54xS6qnrCLN1HuihCL4/F
         CiPJsaT277qZGyvvxbSWHoMtmsCj/tMev/vS7uacwi0/r9T1ed/DySMPm0dGKbn/gIxv
         b0ug==
X-Gm-Message-State: AOAM532MVDOBOr541v/g0gy4iSTcJxgTmptgqL3wc0s61mMbVRs1wZJ9
        4Yf9r0dgxCDeHIem46WxiGirXA==
X-Google-Smtp-Source: ABdhPJzX7+Xf26Khmb4D57YmI7QsAFvWHZ0SZ9/Q8msbMYR9tHpafxHNv4nq0+H1vkQ4JM6GKMoMbw==
X-Received: by 2002:a37:688c:: with SMTP id d134mr6066461qkc.450.1589996580324;
        Wed, 20 May 2020 10:43:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r18sm2863194qtn.1.2020.05.20.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:42:59 -0700 (PDT)
Date:   Wed, 20 May 2020 13:42:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200520174259.GA247557@google.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520120608.mwros5jurmidxxfv@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Wed, May 20, 2020 at 02:06:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 12:24:07 [+0200], Peter Zijlstra wrote:
> > On Tue, May 19, 2020 at 10:19:07PM +0200, Sebastian Andrzej Siewior wrote:
> > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 0c71505f0e19c..8d2b5f75145d7 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/module.h>
> > >  #include <linux/srcu.h>
> > > +#include <linux/locallock.h>
> > >  
> > >  #include "rcu.h"
> > >  #include "rcu_segcblist.h"
> > > @@ -735,6 +736,7 @@ static void srcu_flip(struct srcu_struct *ssp)
> > >  	smp_mb(); /* D */  /* Pairs with C. */
> > >  }
> > >  
> > > +static DEFINE_LOCAL_LOCK(sda_lock);
> > >  /*
> > >   * If SRCU is likely idle, return true, otherwise return false.
> > >   *
> > > @@ -765,13 +767,13 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> > >  	unsigned long tlast;
> > >  
> > >  	/* If the local srcu_data structure has callbacks, not idle.  */
> > > -	local_irq_save(flags);
> > > +	local_lock_irqsave(sda_lock, flags);
> > >  	sdp = this_cpu_ptr(ssp->sda);
> > >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> > > -		local_irq_restore(flags);
> > > +		local_unlock_irqrestore(sda_lock, flags);
> > >  		return false; /* Callbacks already present, so not idle. */
> > >  	}
> > > -	local_irq_restore(flags);
> > > +	local_unlock_irqrestore(sda_lock, flags);
> > 
> > Would it perhaps make sense to stick the local_lock in struct srcu_data ?
> 
> In that case we would need something for pointer stability before the
> lock is acquired.

For pointer stability, can we just use get_local_ptr() and put_local_ptr()
instead of adding an extra lock? This keeps the pointer stable while keeping
the section preemptible on -rt. And we already have a lock in rcu_data, I
prefer not to add another lock if possible.

I wrote a diff below with get_local_ptr() (just build tested). Does this
solve your issue?

> I remember Paul looked at that patch a few years ago and he said that
> that disabling interrupts here is important and matches the other part
> instance where the interrupts are disabled. Looking at it now, it seems
> that there is just pointer stability but I can't tell if
> rcu_segcblist_pend_cbs() needs more than just this.

Which 'other part' are you referring to? Your patch removed local_irq_save()
from other places as well right?

thanks,

 - Joel

---8<-----------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8ff71e5d0fe8b..5f49919205317 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -778,13 +778,17 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long tlast;
 
 	/* If the local srcu_data structure has callbacks, not idle.  */
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
+	sdp = get_local_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
+
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
-		local_irq_restore(flags);
+		spin_unlock_irqrestore_rcu_node(sdp, flags);
+		put_local_ptr(sdp);
 		return false; /* Callbacks already present, so not idle. */
 	}
-	local_irq_restore(flags);
+
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	put_local_ptr(sdp);
 
 	/*
 	 * No local callbacks, so probabalistically probe global state.
@@ -864,9 +868,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	}
 	rhp->func = func;
 	idx = srcu_read_lock(ssp);
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
-	spin_lock_rcu_node(sdp);
+	sdp = get_local_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
 	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
@@ -886,6 +889,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	else if (needexp)
 		srcu_funnel_exp_start(ssp, sdp->mynode, s);
 	srcu_read_unlock(ssp, idx);
+
+	put_local_ptr(sdp);
 }
 
 /**
