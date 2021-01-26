Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047C8303B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392352AbhAZLZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390474AbhAZJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:21:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E850C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q9yE/oVgRydpOnLhnRRFpkqj6GKkbjfTgZQfYqeWzUc=; b=C3Cwtcpl27yjepgQnL3krYcAf0
        vWQHfCts90VSL4frhf/kfITk3Dpjt9M4vfVJooEfkKLh/GHVrOClNNQ/s7MpLEMCYYk3uMeOYI5Yb
        +ExVFQ3lkmD8MhJ2ic1lX2kgSLT9adqCtKluK5MIszcBE/7ZsIVjW5Eq9df/AXLwyhlwykyR3/99y
        qOeOMIRWSbRAichrBdEtCAAkBYwgGzqcDTql3X40F3xtcsp8qlB3dROO6c57OmzHQB5VdkeBvFqW9
        ClGdyxCoDAxpZMZF8QyYfPJy8NmHfESCAVXMxFRzSD9FlAiUQhJA7kjDnE+HhOhMXdu29tb9Lv7/R
        IHgBcwKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4KWH-0005LY-1O; Tue, 26 Jan 2021 09:20:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A02C73019CE;
        Tue, 26 Jan 2021 10:20:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D27A209C50F2; Tue, 26 Jan 2021 10:20:13 +0100 (CET)
Date:   Tue, 26 Jan 2021 10:20:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     valentin.schneider@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: add rcu_read_lock/unlock() protection
Message-ID: <YA/ezfU+/2ggZKTy@hirez.programming.kicks-ass.net>
References: <20210126084651.32277-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126084651.32277-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 04:46:51PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Due to for_each_process_thread belongs to RCU read operation,
> need to add rcu_read_lock/unlock() protection.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8c5481077c9c..c3f0103fdf53 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7738,6 +7738,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
>  	lockdep_assert_held(&rq->lock);
>  
>  	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
> +	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		if (task_cpu(p) != cpu)
>  			continue;
> @@ -7747,6 +7748,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
>  
>  		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
>  	}
> +	rcu_read_unlock();

We're in stop machine, with IRQs disabled, please explain how this can
make any difference?
