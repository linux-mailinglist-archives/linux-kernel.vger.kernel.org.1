Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897B5296CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462377AbgJWK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462240AbgJWKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5cargVhZdFOSA61ytegyb7AVxqvGZs2FPfNrM3FomIo=; b=AQY4+43SWj8Onn6ZQQh0JAQPsC
        icj672sTxfjwI4VhqxdjPQFrC4kI+0Usswrbexye8qTu2b8HcFolDY+Yqbop3jegmYKidLdrBTCn3
        T/Scta4FCdOuso97BQpqFtd5xBTxm1Rv0oq8otNOXYbtai30cFjshnb3MFmiJY+5dvKvsmBwD4Of/
        Ztr4HEHHr69NlDoSf0XQErA4tVB0G9ZlQ7pqNK1mrtNy1KFoCqHUujH6u9OFiRkIl6m1A5TTumyXS
        ncgFh5/ZFXkqNpgR5QXbIGgZ5EIcrt/Sv1o30xs7CLGcRb0/74Q66eKik9Y8Ore+K/zKNcLBXwXvt
        51G0jckA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFo-0002t8-C9; Fri, 23 Oct 2020 10:25:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D12953069B1;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 48D4429DDA65C; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102346.464718669@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 05/19] workqueue: Manually break affinity on hotplug
References: <20201023101158.088940906@infradead.org>
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


