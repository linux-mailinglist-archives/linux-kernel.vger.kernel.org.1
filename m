Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7A29F354
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJ2Reb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgJ2Reb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:34:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E32C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RhNMPW2jOuQLICdYpphkdfbiutZRIE/GYanmsiDaVVU=; b=B4i5FRx8q3w4DdS+yKjmuU72Nb
        87cZJVSDwh9se9L9JMdysFYSVRDVSkbbr4zOhaYYrPFedBArDs8cY4idszeOJXlq/dIbifUmZbDYe
        t6CvMrE7+hSCRVAkyDmh4i9IoqVgBHVo7nIOOv9Hs5YSQSUIs7KaEALPYjKQnnmk3muIGSiFhFSwf
        ANJP7MyINdGrWAeasircSSkRW86T4O9E7TUoSyXwVzuVzxdvcyQL6/asBGvE9A+5Scg9MhQNEpglx
        f+HYygZo0mfNHaKiF8qfPquLYdqGRRgibeNpRAz28iUrMkEVH7VG1DDPAzCtuMQ8VioFtZ9Bfa+uG
        hN2vZJMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYBoS-00004v-Sw; Thu, 29 Oct 2020 17:34:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44BEF300446;
        Thu, 29 Oct 2020 18:34:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A1B320315047; Thu, 29 Oct 2020 18:34:09 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:34:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
Message-ID: <20201029173409.GT2628@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.067278757@infradead.org>
 <jhjd011ov4y.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjd011ov4y.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 04:27:09PM +0000, Valentin Schneider wrote:
> 
> On 23/10/20 11:12, Peter Zijlstra wrote:
> > @@ -7006,15 +7024,20 @@ static bool balance_push(struct rq *rq)
> >        * Both the cpu-hotplug and stop task are in this case and are
> >        * required to complete the hotplug process.
> >        */
> > -	if (is_per_cpu_kthread(push_task)) {
> > +	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
> 
> is_migration_disabled(p) implies rq_has_pinned_tasks(task_rq(p)), right?

In general, no, in this particular case, yes. Specifically you need
migrate_disable() + schedule() in order to get nr_pinned incremented.

We just happen to run at the tail end of schedule(), so yeah, here it
works.

> So having a "simple"
> 
>   if (is_migration_disabled(push_task))
>         return;
> 
> would help simpletons like me trying to read through this.

Can do I suppose, although I'm no sure what, if anything that helps,
because then we needs yet another comment explaining things.

I ended up with the below. Is that an improvement?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d7d5b7b9c99..c9c69511ece4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7226,11 +7226,19 @@ static void balance_push(struct rq *rq)
 	lockdep_assert_held(&rq->lock);
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
 
+	/*
+	 * When migrate_disable(), we'll also have nr_pinned incremented due to
+	 * this being the tail end of schedule(). Therefore we do not need to wake
+	 * the hotplug_wait and go straight to jail^Wexit.
+	 */
+	if (is_migration_disabled(push_task))
+		return;
+
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 */
-	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
+	if (is_per_cpu_kthread(push_task)) {
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the

