Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBCE28F0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgJOLJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgJOLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:09:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C27C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=m9HVwHpECCe3RABHhWjizD2oYa6JzEPH8RIJOV5W7to=; b=vpcWzvfzAyAC22cVPsGIp3nZzp
        D3Ccdu6rP4f93plRm0WgvrrV8buXEmd/pmEAWFw0SRldlGliCePXvS+wREOGXrQ1xY4FrFniuM8m6
        2BDR4VOMGH7fGJkP3mz/Xz7ayyMhfegNeQWLphoPuiyTyhjQIoNubOoH1qO7yxzP4fQEpk0A1nwd9
        nm4YQaRTUAhaI+RQEpR2xqIK7M+MRFAV8spnQ9owYjSMH8qkjrFqR2Ebml45aM8f/8c71zARdoybv
        Evk6Sih8Ev4Gxm74XITLTQlT8LngLX8T7x/wciEGzD5K3G3n7QNnL5XW5/DIoybTpYqJv+lhFjZcX
        saDEVpxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT18f-0007wJ-Fq; Thu, 15 Oct 2020 11:09:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EA26307974;
        Thu, 15 Oct 2020 13:09:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B45E8235F4453; Thu, 15 Oct 2020 13:09:36 +0200 (CEST)
Message-ID: <20201015110924.399111220@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Oct 2020 13:05:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v3 18/19] sched: Deny self-issued __set_cpus_allowed_ptr() when migrate_disable()
References: <20201015110532.738127234@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

  migrate_disable();
  set_cpus_allowed_ptr(current, {something excluding task_cpu(current)});
  affine_move_task(); <-- never returns

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201013140116.26651-1-valentin.schneider@arm.com
---
 kernel/sched/core.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2182,8 +2182,17 @@ static int __set_cpus_allowed_ptr(struct
 		goto out;
 	}
 
-	if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
-		goto out;
+	if (!(flags & SCA_MIGRATE_ENABLE)) {
+		if (cpumask_equal(&p->cpus_mask, new_mask))
+			goto out;
+
+		if (WARN_ON_ONCE(p == current &&
+				 is_migration_disabled(p) &&
+				 !cpumask_test_cpu(task_cpu(p), new_mask))) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
 
 	/*
 	 * Picking a ~random cpu helps in cases where we are changing affinity


