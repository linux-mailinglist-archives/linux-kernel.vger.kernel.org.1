Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A17284D79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJFOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:20:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E604C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fQNQMTdNpFR2hXxPiuAoxHao1e9b1oM909lnBs1Kqak=; b=GwVjeRMFqHpxsMaT5JxvGi7Rw4
        P/eDXcDHo4LGla+cvldr3kmJdrWhOo3XZWwWh17L+04ZvRHL9JxxiTuO3qYGzden7WfC41k/V/T1u
        GOFMhBQSJl9mrhyLXEliliZcJHEjAWqZ1xTfbHabxt32VCZ1OYD06M74Qq/K/sDTRByF0ORp4w/nn
        eWknbODS/a6nNBEGKRjVSCZBhBvncwPurRyiUIWuvleVOySPrMT+VqPGQtnhhvGtwUOF6XWj9AuTb
        +glx8lqlQmkBAEvdqnBeUYC32BccOkt9lKgUD7mt9DBrRnU2mwnJIJfNjA4XtO8LN5Y66GzErMYgq
        3dFsd9yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPnoz-0005ON-89; Tue, 06 Oct 2020 14:20:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EFD03006D0;
        Tue,  6 Oct 2020 16:20:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AE6628527D6B; Tue,  6 Oct 2020 16:20:04 +0200 (CEST)
Date:   Tue, 6 Oct 2020 16:20:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 12/17] sched,rt: Use cpumask_any*_distribute()
Message-ID: <20201006142004.GX2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.156231026@infradead.org>
 <20201006140926.GI4352@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006140926.GI4352@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 04:09:26PM +0200, Juri Lelli wrote:

> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2001,7 +2001,7 @@ static int find_later_rq(struct task_str
> >  	if (this_cpu != -1)
> >  		return this_cpu;
> >  
> > -	cpu = cpumask_any(later_mask);
> > +	cpu = cpumask_any_distribute(later_mask);
> >  	if (cpu < nr_cpu_ids)
> >  		return cpu;
> 
> Think we can use cpumask_any_and_distribute() with later_mask for
> deadline as well inside the for_each_domain loop as you do for rt below.

Ah, indeed.. I missed it because it is cpumask_first, instead of
cpumask_any as with rt.

I folded the below.

---
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1981,8 +1981,8 @@ static int find_later_rq(struct task_str
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(later_mask,
-							sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(later_mask,
+							      sched_domain_span(sd));
 			/*
 			 * Last chance: if a CPU being in both later_mask
 			 * and current sd span is valid, that becomes our
