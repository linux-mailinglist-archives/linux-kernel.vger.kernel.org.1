Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C23A28F0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbgJOLKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgJOLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:10:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF008C0613DB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5cargVhZdFOSA61ytegyb7AVxqvGZs2FPfNrM3FomIo=; b=WZM4TB00npe/6poXrrzlji+pe9
        xGUq5RvLNiRZojZttHQdQ0RXz4D4nwXOO9RuoIs9bQJ8wSshL+Q+5Br4dbCGOQTB8+EnX5nDDyHP5
        ijycVYdhFpe/FyjTLlfpPHObVV0oJ5b0PH9iHdPDioWFKEG0Bfw8WL+r4MXYKyhNOCCziiJ+klkYZ
        PwWLSFWFtopbLp5IBEn1O7A66Pc3VLVPUwKpkzByFo9bsXhvrmXnHEvTUfoV0HKcj3wWbVX+Sjtlz
        bLDM+/Id5Ir0CkP/OomTcOh5Am5xkZA5JjhUk4GeYkV651peC6+0cvapVW38T10U8EtFvp0YrzvSt
        EDoPgVFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT18d-0002OI-7G; Thu, 15 Oct 2020 11:09:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 053AF306BCA;
        Thu, 15 Oct 2020 13:09:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 77993235F4448; Thu, 15 Oct 2020 13:09:36 +0200 (CEST)
Message-ID: <20201015110923.605880079@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Oct 2020 13:05:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v3 05/19] workqueue: Manually break affinity on hotplug
References: <20201015110532.738127234@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rely on the scheduler to force break affinity for us -- it will
stop doing that for per-cpu-kthreads.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
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


