Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB41B433C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgDVL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726989AbgDVL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84067C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ehpIOWWGSS04ISyZrHkdPE/uvri5Hyju2TDlwgv24JI=; b=bLuy0i+TGLRZ5iQ+DbfCuySTYy
        DngyWDyum76jFnneWLw+G02/VRKXZVaAtSUPs6hswF54RFapb6gPKwcCfeHLqgLDvJou1gW9tNi+D
        Imwvk3h219+5iIyaGhdkCQfAZES3UiK7uc6kOyeB71eIJT9SRxq+W5UfKIliIN8rqDJ1lt315f3be
        wmsaKQ0Fd/Szc5UpSib9XCpm37P008TWB276RTUF2sRugzdWML3OIoHqWnGPOz7zAcczVKmo+kZA1
        UGNqMmgcHX6XYvX5FPonmKVnF673JqCAYrr0mfYSnApS1cdHmBnBa4F8qO8WiedKSJkorjkTMZIBP
        bx6lXkjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rD-Cc; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59FC2307985;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D16E22B99F0F; Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Message-Id: <20200422112832.465990342@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, hannes@cmpxchg.org
Subject: [PATCH 21/23] sched,psi: Convert to sched_set_fifo_low()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: hannes@cmpxchg.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/psi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1100,9 +1100,6 @@ struct psi_trigger *psi_trigger_create(s
 	mutex_lock(&group->trigger_lock);
 
 	if (!rcu_access_pointer(group->poll_kworker)) {
-		struct sched_param param = {
-			.sched_priority = 1,
-		};
 		struct kthread_worker *kworker;
 
 		kworker = kthread_create_worker(0, "psimon");
@@ -1111,7 +1108,7 @@ struct psi_trigger *psi_trigger_create(s
 			mutex_unlock(&group->trigger_lock);
 			return ERR_CAST(kworker);
 		}
-		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
+		sched_set_fifo_low(kworker->task);
 		kthread_init_delayed_work(&group->poll_work,
 				psi_poll_work);
 		rcu_assign_pointer(group->poll_kworker, kworker);


