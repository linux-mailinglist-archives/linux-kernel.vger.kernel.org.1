Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC40A2F8D23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbhAPLoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D64C061793
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nu04SxRuBXiK/eFK0LcHKOkaHXs0OqeUyOqkc7y3nJ0=; b=Fl5qu2rr1xNVTmCZN2FiAucBmw
        TzdbV0rM1Ofaeebk6+93NpTzt/5L6V6CAbyPU2VWKL74vlw4Q9nWobvhpCN5lmTC5irP8Vbh68fvJ
        a3Lr7mfVENw5OrZfwVeUoLwIrd19FMSN9En353kMtaw5os1yyr68uBJQCUaR0geybOrp64zYITaSo
        g1g8ABXwm7RkNie2wSXcLb4YS4j7tA47qLdguAso3TZW/jYWq8qjYZ7wJu8Zq5ahZMtMnK1xp16Br
        NHxvtgduq8s0iFA514GCIIoMz2bhQH6xuts8R8h1iSEeg6w+rtOFZIqcs9Gdi3eKSxe6IwR36e05J
        lrYL6ZQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0jyz-0002D1-5x; Sat, 16 Jan 2021 11:43:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFB2C307697;
        Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D063202905B9; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113919.674601326@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 2/8] workqueue: Use cpu_possible_mask instead of cpu_active_mask to break affinity
References: <20210116113033.608340773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The scheduler won't break affinity for us any more, and we should
"emulate" the same behavior when the scheduler breaks affinity for
us.  The behavior is "changing the cpumask to cpu_possible_mask".

And there might be some other CPUs online later while the worker is
still running with the pending work items.  The worker should be allowed
to use the later online CPUs as before and process the work items ASAP.
If we use cpu_active_mask here, we can't achieve this goal but
using cpu_possible_mask can.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20210111152638.2417-4-jiangshanlai@gmail.com
---
 kernel/workqueue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4920,7 +4920,7 @@ static void unbind_workers(int cpu)
 		raw_spin_unlock_irq(&pool->lock);
 
 		for_each_pool_worker(worker, pool)
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 


