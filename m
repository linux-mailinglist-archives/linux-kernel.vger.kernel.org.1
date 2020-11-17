Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0792B5C14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgKQJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgKQJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:46:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jet1I61eSfgzRK7zbEllS/kKGywrT/l/67+QQnNONvM=; b=IQZoff32/nmRD+w0cicNPPNHB6
        ZAjzmVeojiVehfQ6QgEq8JeFXnGc0POsvvL2rznJA+XABVtidjsl+DeT3Qri4ArCT3UOMoqxuG58I
        1JvRqEPsmrmTxV6ONqBt/F4w38ByUuDkmCUUgy7G9bV/kaL2alGktaT0X725qN3G4Zr64kL6yUy7h
        dbTczWB9SLvRel6uMZY7hY7yPzJ79IOR6EeyGG1ntD/Kp/XEiqE27Mo9XY858v/7vqoSHuvOX1LE0
        v+e7lrJlRU4Ri8znl/vIr3RscbybxKJjxUhfN9Vijsr95WQQJ57xawuyRalT7eSpAvhGFBlkvavzu
        ENZ4iKZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kexZ8-0006bc-Er; Tue, 17 Nov 2020 09:46:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EC02303DA0;
        Tue, 17 Nov 2020 10:46:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8DA620116725; Tue, 17 Nov 2020 10:46:21 +0100 (CET)
Date:   Tue, 17 Nov 2020 10:46:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201117094621.GE3121429@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
 <20201117091545.GA31837@willie-the-truck>
 <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:29:36AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 09:15:46AM +0000, Will Deacon wrote:
> > On Tue, Nov 17, 2020 at 09:30:16AM +0100, Peter Zijlstra wrote:
> > >  	/* Unserialized, strictly 'current' */
> > >  
> > > +	/*
> > > +	 * p->in_iowait = 1;		ttwu()
> > > +	 * schedule()			  if (p->on_rq && ..) // false
> > > +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
> > > +	 *   deactivate_task()		      ttwu_queue_wakelist())
> > > +	 *     p->on_rq = 0;			p->sched_remote_wakeup = X;
> > > +	 *
> > > +	 * Guarantees all stores of 'current' are visible before
> > > +	 * ->sched_remote_wakeup gets used.
> > 
> > I'm still not sure this is particularly clear -- don't we want to highlight
> > that the store of p->on_rq is unordered wrt the update to
> > p->sched_contributes_to_load() in deactivate_task()?

How's this then? It still doesn't explicitly call out the specific race,
but does mention the more fundamental issue that wakelist queueing
doesn't respect the regular rules anymore.

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -775,7 +775,6 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
-	unsigned			sched_remote_wakeup:1;
 #ifdef CONFIG_PSI
 	unsigned			sched_psi_wake_requeue:1;
 #endif
@@ -785,6 +784,21 @@ struct task_struct {
 
 	/* Unserialized, strictly 'current' */
 
+	/*
+	 * This field must not be in the scheduler word above due to wakelist
+	 * queueing no longer being serialized by p->on_cpu. However:
+	 *
+	 * p->XXX = X;			ttwu()
+	 * schedule()			  if (p->on_rq && ..) // false
+	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
+	 *   deactivate_task()		      ttwu_queue_wakelist())
+	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
+	 *
+	 * guarantees all stores of 'current' are visible before
+	 * ->sched_remote_wakeup gets used, so it can be in this word.
+	 */
+	unsigned			sched_remote_wakeup:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
