Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41D2B77F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKRIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:05:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3YV100sViLRH3FnelBDRzH39rC5gys0VAUVXrzrueWQ=; b=JseLfYVBXlZAqzdoJk+VsN1VBh
        1GBYMxovrTJt8hSBeQB4UEHxvPee8q2cyeXD5yqZebpoNXH0JD5MH9nEpFQyN1Fmr5+9Ml1HVyU7L
        0RvBXfoVjaNsXU9fxqn2X/R58D9X9qeJ76HfDTXLUeej2lcnEs+sHmI8NufFzsom4hTgOK322E/z3
        VO8UhxYaUpd9TLMb03652XSuvoux6yXsT0vCUu3uXn6QZDLHylkUdm/rWK8laABaQyLnJQOPxjgnn
        qEiVOlUEPjhtfYeCgyaHY+0iFAdmMBp3XTFy+ilU0aCeQPOPS2o+/nOQpoF65Twnv8NYD1vpn6hnE
        xUBHzGIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfISt-0004Te-2Z; Wed, 18 Nov 2020 08:05:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CA2B301959;
        Wed, 18 Nov 2020 09:05:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 178C8200E0A33; Wed, 18 Nov 2020 09:05:15 +0100 (CET)
Date:   Wed, 18 Nov 2020 09:05:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201118080515.GR3121392@hirez.programming.kicks-ass.net>
References: <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
 <20201117091545.GA31837@willie-the-truck>
 <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
 <20201117094621.GE3121429@hirez.programming.kicks-ass.net>
 <jhjv9e4w3gj.mognet@arm.com>
 <jhjtutovvtm.mognet@arm.com>
 <20201117161318.GP3121392@hirez.programming.kicks-ass.net>
 <jhjo8jvwzi7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjo8jvwzi7.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:32:16PM +0000, Valentin Schneider wrote:
> 
> On 17/11/20 16:13, Peter Zijlstra wrote:
> > On Tue, Nov 17, 2020 at 03:37:24PM +0000, Valentin Schneider wrote:
> >
> >> >> +	/*
> >> >> +	 * This field must not be in the scheduler word above due to wakelist
> >> >> +	 * queueing no longer being serialized by p->on_cpu. However:
> >> >> +	 *
> >> >> +	 * p->XXX = X;			ttwu()
> >> >> +	 * schedule()			  if (p->on_rq && ..) // false
> >> >> +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
> >> >> +	 *   deactivate_task()		      ttwu_queue_wakelist())
> >> >> +	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
> >> >> +	 *
> >> >> +	 * guarantees all stores of 'current' are visible before
> >> >> +	 * ->sched_remote_wakeup gets used, so it can be in this word.
> >> >> +	 */
> >> >
> >> > Isn't the control dep between that ttwu() p->on_rq read and
> >> > p->sched_remote_wakeup write "sufficient"?
> >> 
> >> smp_acquire__after_ctrl_dep() that is, since we need
> >>   ->on_rq load => 'current' bits load + store
> >
> > I don't think we need that extra barrier; after all, there will be a
> > complete schedule() between waking the task and it actually becoming
> > current.
> 
> Apologies for the messy train of thought; what I was trying to say is that
> we have already the following, which AIUI is sufficient:
> 
> 	* p->XXX = X;			ttwu()
> 	* schedule()			  if (p->on_rq && ..) // false
> 	*   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
> 	*   deactivate_task()		  ttwu_queue_wakelist()
> 	*     p->on_rq = 0;		    p->sched_remote_wakeup = Y;
> 

Ah, you meant the existing smp_acquire__after_ctrl_dep(). Yeah, that's
not required here either ;-)

The reason I had the ->on_cpu thing in there is because it shows we
violate the regular ->on_cpu handoff rules, not for the acquire.

The only ordering that matters on the RHS of that thing is the ->on_rq
load to p->sched_remote_wakeup store ctrl dep. That, combined with the
LHS, guarantees there is a strict order on the stores.

Makes sense?
