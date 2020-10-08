Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC0287722
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgJHP2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgJHP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:28:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC42C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMtKrlQQKRmARj/Su5+vTDP7DsJJNDxLBfECFqu9/4w=; b=QXd8my33emxXUIn4dhR9cR4u/q
        XcySjEJJEYIOfrVZAQHZkzraIcVO23qAUCwZr8ku5G4bK94yW2Qtq8Vg+3pJqPV3PiQs20Rclz/JW
        asDLwvS98y2rB6A14NFGwACZoDAsKVEwhN1FIRIY1wIw51PIlJPBlLa5nl2Z9wwWHXMEmTUI+gItz
        D+LrLNLsEs2E6fiD4xwutEKArs7k6QpJKr5oaBWYxSkvbSnj11xQFaja7Ed9sx2OmTd728HEsXxFG
        gy4lpQntcCC5XEuvn//sCjWJWZDPiehfuBEn5CZDFWJKzrokbK0niND7XKadD7oFdihsJy3RSnVQI
        USTwUnCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQXqX-00007Q-8J; Thu, 08 Oct 2020 15:28:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54998300B22;
        Thu,  8 Oct 2020 17:28:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 439982B7801A1; Thu,  8 Oct 2020 17:28:44 +0200 (CEST)
Date:   Thu, 8 Oct 2020 17:28:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008152844.GB2628@hirez.programming.kicks-ass.net>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008145940.GG6026@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008145940.GG6026@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 10:59:40AM -0400, Peter Xu wrote:
> On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> > +static void tick_nohz_kick_task(struct task_struct *tsk)
> > +{
> > +	int cpu = task_cpu(tsk);
> > +
> > +	/*
> > +	 * If the task concurrently migrates to another cpu,
> > +	 * we guarantee it sees the new tick dependency upon
> > +	 * schedule.
> > +	 *
> > +	 *
> > +	 * set_task_cpu(p, cpu);
> > +	 *   STORE p->cpu = @cpu
> > +	 * __schedule() (switch to task 'p')
> > +	 *   LOCK rq->lock
> > +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> > +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> > +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> > +	 */
> > +
> > +	preempt_disable();
> 
> Pure question: is preempt_disable() required here?  Same question to
> tick_nohz_full_kick_all().

I think it serializes against hotplug.

> 
> > +	if (cpu_online(cpu))
> > +		tick_nohz_full_kick_cpu(cpu);
> > +	preempt_enable();
> > +}
