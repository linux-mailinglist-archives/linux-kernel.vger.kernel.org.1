Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D828283927
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgJEPKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJEPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:10:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C01C0613AA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3HlhKZQ3pvdkw49M78oHLmhhJAoeRAhQ/1n3ZZIj6n8=; b=fDDcAahmyOjHuPOt4GfugbFxIs
        G2JL9MPJKuKPZAtWcZSqQoZXerGFpBtONxblxR11iQ0rLH/1ixAxU/rtSfo90qvQzI1PdIFGKXYN4
        erglP8ZgJ7bePo7ajIT71TX1inHwyKLE5ri85kKVilG729sZFx8Z9OIjJMQRGtKw/hT0IvAp2QULm
        EqmnyiKMBeieWtOV58PZze+zMfBmftWMcjjmkVs1Ojp/Qs74IIxmyewIDowaG6/VToKtfPut6kUNv
        PDZsAarZu+ejHhIVizx5sE9I9AMAjwjN6Y4kghIXZsU4CoP19GLpqp7akB7In0feq5Qio+7bk8CF2
        ogGtrL6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7U-0008OZ-RM; Mon, 05 Oct 2020 15:09:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D10D305C22;
        Mon,  5 Oct 2020 17:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CD1B829A897B6; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005150921.463998937@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 05/17] workqueue: Manually break affinity on hotplug
References: <20201005145717.346020688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rely on the scheduler to force break affinity for us -- it will
stop doing that for per-cpu-kthreads.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/workqueue.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4905,6 +4905,10 @@ static void unbind_workers(int cpu)
 		pool->flags |= POOL_DISASSOCIATED;
 
 		raw_spin_unlock_irq(&pool->lock);
+
+		for_each_pool_worker(worker, pool)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+
 		mutex_unlock(&wq_pool_attach_mutex);
 
 		/*


