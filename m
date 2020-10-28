Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B857529D370
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgJ1VoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:44:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59036 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgJ1Vnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ABPtItGeR+X+7i3YNqfiZCGYLEmimF/MG0DPydax2M8=; b=C3lLiHVQscuY4AofJPv950mrrQ
        kwye7LTieNv/TTwVOS5m7pTjfiSXdGrIW1yh6r9SCIX+PugnIL28BRDE3cg+vFI74qrmwHP+YYG35
        e3LXnaCN6hhXS9brEXZRTtm7pxGEW/8RfK6RxtTSgALRIOktYoc2PZ2uG4hWF153f0f9IO2avUez6
        vtTP9EHAcbx2cErQ32Scu1iEAnzR+lAhSPJc85PJNWnhs3EKaBxqtgLFfZ5bmpU0xc74QTAzCzt+8
        ojOffxNVUhMmnriNESNowYBB1Dchp04js1twOwF3PwAIvsyfyHenGf8/My0f+GbvKOPN1sWAJ9IzP
        ZnHEI0rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXref-0003iE-IT; Wed, 28 Oct 2020 20:02:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0042E301179;
        Wed, 28 Oct 2020 21:02:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E05412038A985; Wed, 28 Oct 2020 21:02:43 +0100 (CET)
Date:   Wed, 28 Oct 2020 21:02:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
 <20201028145428.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028145428.GE2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 03:54:28PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 12:07:13PM +0100, Peter Zijlstra wrote:
> > AFAICT we only need/use irq_work_queue_on() on remote CPUs, since we
> > can directly access local state.  So avoid the IRQ_WORK dependency and
> > use the unconditionally available irq_work_queue_remote().
> > 
> > This survives a number of TREE01 runs.
> 
> OK, Paul mentioned on IRC that while it is extremely unlikely, this code
> does not indeed guarantee it will not try to IPI self.
> 
> I'll try again.

This is the best I could come up with.. :/

---
Subject: rcu/tree: Use irq_work_queue_remote()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Oct 28 11:53:40 CET 2020

All sites that consume rcu_iw_gp_seq seem to have rcu_node lock held,
so setting it probably should too. Also the effect of self-IPI here
would be setting rcu_iw_gp_seq to the value we just set it to
(pointless) and clearing rcu_iw_pending, which we just set, so don't
set it.

Passes TREE01.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1308,14 +1308,16 @@ static int rcu_implicit_dynticks_qs(stru
 			resched_cpu(rdp->cpu);
 			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 		}
-#ifdef CONFIG_IRQ_WORK
+		raw_spin_lock_rcu_node(rnp);
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
+		raw_spin_unlock_rcu_node(rnp);
 	}
 
 	return 0;
