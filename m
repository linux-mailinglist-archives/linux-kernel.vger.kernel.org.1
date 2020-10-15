Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9828F494
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgJOOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgJOOUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D63C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2/Nu/TbQAWI7kI+pV0LJmIzj2CuUqC+iZEEETng9LKg=; b=UO2zenZOLW1vqWH+/8ku9PZKz5
        bGKYlbV2TV7CTRVWrHnkPYwXZxbgG5OHb7it20prDLgkkM/B6i/BW4o7YMhgJHDNrP51+3F81uwBM
        RlQKbjifCo6b5hhvPihPJDplUG7F0L+4b+I63+jKO1VAmlTHEtjthckC7hbNkekrsL1e3zymyW4C5
        R2qcvqJGpj/agFdeiI+TK4SuIE+Sth2BY0kp6nVysRbmrgLtzecRyQJDlOUdUCNPhDgtWoPluS9Q2
        zfXcZ5YgQJAMywo/8jrqDAqdUd+Ob19AyXHHL4+zi1KJrxbuz460M2WIRVfYCY3zy9o+w/4dwD/Mx
        L43Ue15w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT46o-0005VI-PZ; Thu, 15 Oct 2020 14:19:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FB1B300446;
        Thu, 15 Oct 2020 16:19:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33A7520325EC4; Thu, 15 Oct 2020 16:19:57 +0200 (CEST)
Date:   Thu, 15 Oct 2020 16:19:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v3 10/19] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
Message-ID: <20201015141957.GE2611@hirez.programming.kicks-ass.net>
References: <20201015110532.738127234@infradead.org>
 <20201015110923.910090294@infradead.org>
 <jhjo8l3r3v6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjo8l3r3v6.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:54:53PM +0100, Valentin Schneider wrote:
> 
> On 15/10/20 12:05, Peter Zijlstra wrote:
> > +static int affine_move_task(struct rq *rq, struct rq_flags *rf,
> > +			    struct task_struct *p, int dest_cpu, unsigned int flags)
> > +{
> > +	struct set_affinity_pending my_pending = { }, *pending = NULL;
> > +	struct migration_arg arg = {
> > +		.task = p,
> > +		.dest_cpu = dest_cpu,
> > +	};
> > +	bool complete = false;
> > +
> > +	/* Can the task run on the task's current CPU? If so, we're done */
> > +	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> > +		pending = p->migration_pending;
> > +		if (pending) {
> > +			p->migration_pending = NULL;
> > +			complete = true;
> 
> Deciphering my TLA+ deadlock traces leads me to think this needs
> 
>                         refcount_inc(&pending->refs);
> 
> because the 'goto do_complete' leads us to an unconditional decrement.

Hurmm. I think you're right. I've updated the patch.
