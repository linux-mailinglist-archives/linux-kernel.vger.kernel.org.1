Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522B429F36F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgJ2Riu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgJ2Rit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:38:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF66C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AzibmD5dY6ZURAduUrkITiJkxpnpdJiU2llTZ8l++is=; b=SUA4XGVJI2Kkq6MNymzNarznE0
        ittvatb0mv8U3z20MjuuHI/VHbetAeBq9X/iI+O8YEjXk1NnAOV/tu6z8xQtRSVq1/YIM7XW9h/vt
        DOIkzR/02KAlDVIoZu10hR/5kKJZcbA0QrkU3Nn4P+5Ar+hJiF+zy86jKseSKSvCRfyNYGMqMnlRH
        Klq4ItI2BcDUusmClwdFkZCsCtEvti8GYM0R7XrjFKnFLowxErarpjcD2Fu85P3Z23aXAEEu8kiBR
        8MvOLP5Ttr6qErfdezqhUsbcvyesuqNQV5pBj9RBM9jckWN5wF04Kqy/LR2ap7I3m2fCNN2wmnYky
        wR3CnQyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYBsf-0000N5-Ae; Thu, 29 Oct 2020 17:38:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4A8E300455;
        Thu, 29 Oct 2020 18:38:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90FBA20315047; Thu, 29 Oct 2020 18:38:32 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:38:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 14/19] sched, lockdep: Annotate ->pi_lock recursion
Message-ID: <20201029173832.GU2628@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.406912197@infradead.org>
 <jhjblglov4r.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjblglov4r.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 04:27:16PM +0000, Valentin Schneider wrote:
> 
> On 23/10/20 11:12, Peter Zijlstra wrote:
> > @@ -2617,6 +2618,20 @@ void sched_set_stop_task(int cpu, struct
> >               sched_setscheduler_nocheck(stop, SCHED_FIFO, &param);
> >
> >               stop->sched_class = &stop_sched_class;
> > +
> > +		/*
> > +		 * The PI code calls rt_mutex_setprio() with ->pi_lock held to
> > +		 * adjust the effective priority of a task. As a result,
> > +		 * rt_mutex_setprio() can trigger (RT) balancing operations,
> > +		 * which can then trigger wakeups of the stop thread to push
> > +		 * around the current task.
> > +		 *
> > +		 * The stop task itself will never be part of the PI-chain, it
> > +		 * never blocks, therefore that ->pi_lock recursion is safe.
> 
> Isn't it that the stopper task can only run when preemption is re-enabled,
> and the ->pi_lock is dropped before then?
> 
> If we were to have an SCA-like function that would kick the stopper but
> "forget" to release the pi_lock, then we would very much like lockdep to
> complain, right? Or is that something else entirely?

You've forgotten the other, and original, purpose of ->pi_lock, guarding
the actual PI chain. Please have a look at rt_mutex_adjust_prio_chain()
and its comment.

But no, this isn't about running, this is about doing an actual wakeup
(of the stopper task) while holding an ->pi_lock instance (guaranteed
not the stopper task's). And since wakeup will take ->pi_lock, lockdep
will get all whiny about ->pi_lock self recursion.

> > +		 * Tell lockdep about this by placing the stop->pi_lock in its
> > +		 * own class.
> > +		 */
> > +		lockdep_set_class(&stop->pi_lock, &stop_pi_lock);
> >       }
> >
> >       cpu_rq(cpu)->stop = stop;
