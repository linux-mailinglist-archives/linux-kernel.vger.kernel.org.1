Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92929D45C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgJ1Vvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:51:45 -0400
Received: from casper.infradead.org ([90.155.50.34]:44160 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgJ1Vvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nRbxEu5PHWvaZU3cUIDAJ1KT7k+wxj/W0tlXERUkaAk=; b=YtufiS6TFoTGsEomrgrre39K0p
        P2O2XgMJ/8XAYkSmikRvG5Pt02tBpMvKFSTmsnMQhmHWZYxBI+g77MRHvqhvPEImJF03euGcOeVez
        AOnSVBa7b591V8joDArJh+sXAnJQfzXbJ8f0xR9F5TgSdXw3CqfMZ/JZ4hHPWB3aY2DQVX2TWtIAX
        Z7MDQzk1FZx+NMtP0hYmXKuostdncwxv32Fi73Q4hZjleYQpshkbC1nlaan7t8xkw1QOZQZ32pgDU
        dyDR0mwviJSvglDW7zaa6zFdjaMkiCGIbYewYEQWH4YkUTmZr/gImANe3Y4kBkT0PBylB8r/H/c9j
        uL1U7tGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXjON-0000Pv-AI; Wed, 28 Oct 2020 11:13:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E03E3062EA;
        Wed, 28 Oct 2020 12:13:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DAD6A20B285AC; Wed, 28 Oct 2020 12:13:21 +0100 (CET)
Message-ID: <20201028111221.584884062@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 12:07:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
References: <20201028110707.971887448@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICT we only need/use irq_work_queue_on() on remote CPUs, since we
can directly access local state.  So avoid the IRQ_WORK dependency and
use the unconditionally available irq_work_queue_remote().

This survives a number of TREE01 runs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1308,14 +1308,12 @@ static int rcu_implicit_dynticks_qs(stru
 			resched_cpu(rdp->cpu);
 			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 		}
-#ifdef CONFIG_IRQ_WORK
 		if (!rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
-			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
+			irq_work_queue_remote(rdp->cpu, &rdp->rcu_iw);
 		}
-#endif
 	}
 
 	return 0;


