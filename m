Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA629E70B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgJ2JPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgJ2JPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:15:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HPE0ACEf6W8DQ5FCmdGG8czPfeEBhPvB2gnXlAsfIN0=; b=zl2TnM+bFwrXMMfByOij8+J3jr
        u3SMLV7iROfgKOBljVRI8NkZ+XwFFbAg8KYGQBkQZoFI1yGPIONdzhWcdCdu3MvPgskxDmDr7IHTB
        FatIGysZNRLLw5cz6iPTVm34H6LkWWUmr+NMZjqeIDj5CcsRqYZ1ga5+bIskJwiCbBXJrINdf5iCE
        WknJR91gpSFjAfUYvYmkPaVFyzMKg7ASA3uKWHJENmNTftu4Ryjrts0fCs4lZyHdpcEU1B7ZL9RlJ
        gtdzZVth8x8s3nxMd1/NA/8Q/408rbMV2sWFvV+PPhXvUxp0A2Z3XyGtqlhNMveIQ9tfqpTejOyCY
        JvdX8mog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY41v-0005ZW-Kv; Thu, 29 Oct 2020 09:15:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48CB03006D0;
        Thu, 29 Oct 2020 10:15:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 365A82BECFBBC; Thu, 29 Oct 2020 10:15:34 +0100 (CET)
Date:   Thu, 29 Oct 2020 10:15:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201029091534.GH2628@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
 <20201028145428.GE2628@hirez.programming.kicks-ass.net>
 <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
 <20201028201554.GE3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028201554.GE3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:15:54PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 28, 2020 at 09:02:43PM +0100, Peter Zijlstra wrote:
> > -#ifdef CONFIG_IRQ_WORK
> > +		raw_spin_lock_rcu_node(rnp);
> 
> The caller of rcu_implicit_dynticks_qs() already holds this lock.
> Please see the force_qs_rnp() function and its second call site,
> to which rcu_implicit_dynticks_qs() is passed as an argument.

Like this then.

---
Subject: rcu/tree: Use irq_work_queue_remote()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Oct 28 11:53:40 CET 2020

The effect of an self-IPI here would be setting rcu_iw_gp_seq to the
value we just set it to (pointless) and clearing rcu_iw_pending, which
we just set, so don't set it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1204,6 +1204,8 @@ static int rcu_implicit_dynticks_qs(stru
 	bool *ruqp;
 	struct rcu_node *rnp = rdp->mynode;
 
+	raw_lockdep_assert_held_rcu_node(rnp);
+
 	/*
 	 * If the CPU passed through or entered a dynticks idle phase with
 	 * no active irq/NMI handlers, then we can safely pretend that the CPU
@@ -1308,14 +1310,14 @@ static int rcu_implicit_dynticks_qs(stru
 			resched_cpu(rdp->cpu);
 			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 		}
-#ifdef CONFIG_IRQ_WORK
 		if (!rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
-			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
-			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
+			if (likely(rdp->cpu != smp_processor_id())) {
+				rdp->rcu_iw_pending = true;
+				irq_work_queue_remote(rdp->cpu, &rdp->rcu_iw);
+			}
 		}
-#endif
 	}
 
 	return 0;
