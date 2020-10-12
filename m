Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6212828B3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgJLL2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbgJLL2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:28:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD601C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PpONMJX6Ovvx5TzUoS9zwvJeYk6DHjL244IX/UZUnvo=; b=kArmmlsFCP43044VNkMy/TAPYD
        FdQqfQJTt+3deZpUMYsO8Gnq4H1NMaI7sZ/Cdj/71qQYw2vMCofO1Dfrd8R9Fu7EkJeLCcHm8S92S
        fAnWDfIPWQ/Vh5PsYg2RXTi5LKwgPVdus9ZKpvQG+riykwJZnW0cntnSuOlo28mW8v/WyHNHl7NKJ
        BPjaYMmyMLTQ1z/HPsVJB1yxCk3yeciR3w2InU5/SJ5NASqMW42lJpdtGEtRt/6k1Q1+0Xh0jRGf9
        /1+MQZ+qlpqJkFsUHxVI3OjqmGbHXJbw2eEsV0EN7VYGd9nN2b/Dg1BcY1vdk9JR0E+R6dEA7PZRc
        OEJRJBbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRw0A-0008MU-JQ; Mon, 12 Oct 2020 11:28:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C731A304BAE;
        Mon, 12 Oct 2020 13:28:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADA4B20A2950E; Mon, 12 Oct 2020 13:28:24 +0200 (CEST)
Date:   Mon, 12 Oct 2020 13:28:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201012112824.GU2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <54bebe28-1d6d-5f71-da57-deb2eee111d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54bebe28-1d6d-5f71-da57-deb2eee111d3@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:56:09AM +0200, Dietmar Eggemann wrote:
> On 05/10/2020 16:57, Peter Zijlstra wrote:
> 
> [...]
> 
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1859,7 +1859,7 @@ static struct task_struct *pick_next_pus
> >   * running task can migrate over to a CPU that is running a task
> >   * of lesser priority.
> >   */
> > -static int push_rt_task(struct rq *rq)
> > +static int push_rt_task(struct rq *rq, bool pull)
> >  {
> >  	struct task_struct *next_task;
> >  	struct rq *lowest_rq;
> > @@ -1873,6 +1873,34 @@ static int push_rt_task(struct rq *rq)
> >  		return 0;
> >  
> >  retry:
> > +	if (is_migration_disabled(next_task)) {
> > +		struct task_struct *push_task = NULL;
> > +		int cpu;
> > +
> > +		if (!pull || rq->push_busy)
> > +			return 0;
> 
> Shouldn't there be the same functionality in push_dl_task(), i.e.
> returning 0 earlier for a task with migration_disabled?

No, deadline didn't implement HAVE_RT_PUSH_IPI.
