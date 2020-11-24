Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180662C2F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404131AbgKXSDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403801AbgKXSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:03:46 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A4AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:03:46 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so11052302qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nWFv04C1aAnXjvsHTOHLO2Kr4hkB813nT+onDe8MWFw=;
        b=MRahNLdp5B6MkRwnkpsjvZLI2HqXqUCyH+f0qWb8eezThEJH0D3+nw+bmJrz3s6Jmw
         siBwHcmr/3gS3u3KmZqy/v74V/k0i8yy9n2XNJiGl+eWZislwPwWHZbMRuE1Wr/VoBiO
         PaKAprpmdDoSxZ+O0CoEUrVVYU9+pkr0SYDQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nWFv04C1aAnXjvsHTOHLO2Kr4hkB813nT+onDe8MWFw=;
        b=W2zRuhfJYW6AcMLJliOsgEOhzuKxzBxM9HU1yWttpRUiKXoTuSKUT8rB6eFxIQKyEc
         GT5GvTJ3ILo8guedT4+KZ6XTzoOBKYMTp+q2fUm6jRPO/qaaMGf1VprmIsa4zvKCf3ij
         FN3lbM+etoEPVhRKspadYnP7T6PR25sHHHf09ERbIy7NGqSUOJ4EqBhSygjrLWALHRFa
         8TXzYXpPNXsia7yF5LYPI9fjDO8rueELSJeCr/uUhtwJLhORaoqgHLCTXuC5iZ2PnSMf
         TlUOn2Kx2+cwlYoyvWqgwhvzDpgENnVTXeSb6zhK72VxAp05WyXeRmOd6Zq/AzktU8sd
         XaXA==
X-Gm-Message-State: AOAM53144yuTxwpbUA1S7xa+vW6hHnqlB0zvAsYWBCkvMyW8plzeUtsz
        Z/6lQ4IsMtmRYe3YyBowR4MZHw==
X-Google-Smtp-Source: ABdhPJzmRfD5YfH8uUoxD+cxpB69OYQ5fPW2reTpI8vtihCkYkwn/gj6qEozv+NUtJ3+0GNZmDSaDQ==
X-Received: by 2002:a0c:b351:: with SMTP id a17mr5850839qvf.7.1606241025070;
        Tue, 24 Nov 2020 10:03:45 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q34sm15454703qtq.45.2020.11.24.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:03:44 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:03:43 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 19/32] entry/idle: Enter and exit kernel protection
 during idle entry and exit
Message-ID: <20201124180343.GF1021337@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-20-joel@joelfernandes.org>
 <20201124161335.GB3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124161335.GB3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 05:13:35PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:49PM -0500, Joel Fernandes (Google) wrote:
> > Add a generic_idle_{enter,exit} helper function to enter and exit kernel
> > protection when entering and exiting idle, respectively.
> > 
> > While at it, remove a stale RCU comment.
> > 
> > Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  include/linux/entry-common.h | 18 ++++++++++++++++++
> >  kernel/sched/idle.c          | 11 ++++++-----
> >  2 files changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> > index 022e1f114157..8f34ae625f83 100644
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -454,4 +454,22 @@ static inline bool entry_kernel_protected(void)
> >  	return IS_ENABLED(CONFIG_SCHED_CORE) && sched_core_kernel_protected()
> >  		&& _TIF_UNSAFE_RET != 0;
> >  }
> > +
> > +/**
> > + * generic_idle_enter - General tasks to perform during idle entry.
> > + */
> > +static inline void generic_idle_enter(void)
> > +{
> > +	/* Entering idle ends the protected kernel region. */
> > +	sched_core_unsafe_exit();
> > +}
> > +
> > +/**
> > + * generic_idle_exit  - General tasks to perform during idle exit.
> > + */
> > +static inline void generic_idle_exit(void)
> > +{
> > +	/* Exiting idle (re)starts the protected kernel region. */
> > +	sched_core_unsafe_enter();
> > +}
> >  #endif
> 
> That naming is terrible..

Yeah sorry :-\. The naming I chose was to be aligned with the
CONFIG_GENERIC_ENTRY naming. I am open to ideas on that.

> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index 8bdb214eb78f..ee4f91396c31 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -8,6 +8,7 @@
> >   */
> >  #include "sched.h"
> >  
> > +#include <linux/entry-common.h>
> >  #include <trace/events/power.h>
> >  
> >  /* Linker adds these: start and end of __cpuidle functions */
> > @@ -54,6 +55,7 @@ __setup("hlt", cpu_idle_nopoll_setup);
> >  
> >  static noinline int __cpuidle cpu_idle_poll(void)
> >  {
> > +	generic_idle_enter();
> >  	trace_cpu_idle(0, smp_processor_id());
> >  	stop_critical_timings();
> >  	rcu_idle_enter();
> > @@ -66,6 +68,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
> >  	rcu_idle_exit();
> >  	start_critical_timings();
> >  	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> > +	generic_idle_exit();
> >  
> >  	return 1;
> >  }
> > @@ -156,11 +159,7 @@ static void cpuidle_idle_call(void)
> >  		return;
> >  	}
> >  
> > -	/*
> > -	 * The RCU framework needs to be told that we are entering an idle
> > -	 * section, so no more rcu read side critical sections and one more
> > -	 * step to the grace period
> > -	 */
> > +	generic_idle_enter();
> >  
> >  	if (cpuidle_not_available(drv, dev)) {
> >  		tick_nohz_idle_stop_tick();
> > @@ -225,6 +224,8 @@ static void cpuidle_idle_call(void)
> >  	 */
> >  	if (WARN_ON_ONCE(irqs_disabled()))
> >  		local_irq_enable();
> > +
> > +	generic_idle_exit();
> >  }
> 
> I'm confused.. arch_cpu_idle_{enter,exit}() weren't conveniently placed
> for you?

The way this patch series works, it does not depend on arch code as much as
possible. Since there are other arch that may need this patchset such as ARM,
it may be better to keep it in the generic entry code.  Thoughts?

thanks,

 - Joel

