Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F51296CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462225AbgJWKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462209AbgJWKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BB9C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=m9HVwHpECCe3RABHhWjizD2oYa6JzEPH8RIJOV5W7to=; b=zoTPj6VsMs50X9U1n3aItb2czZ
        w6VSVYAvFiJ+fN3Gr0ucZ3iuOxXMI1I9VpLN8ul9fbON+xqwH340nvO2uy9KFWgtTsLB2NtMNFtu/
        4N9KflAvx8Ffh0CYUWrXH7o8/tFVD2Ulv/HhTWUFpoyBQYFXPyLxRGn/DUAceg1bMzmCnGGAy/R7H
        8bx8J1Xy+5LgULq6EM7g9/Woq19T7T8mrh4sRrnoxJma0pTglqMAtggO6yy8VlsGw85xs4dFLkAkm
        2iSqL3vSEYTPLCKDlcjAcxYS0JORWzuBEMUERPn+if626XQl1G6xdis1GrxWxfzlxHIxBI0/7RF8d
        YL4UKZiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFp-0003BS-VG; Fri, 23 Oct 2020 10:25:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3A56307983;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8093329DDA667; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102347.786713233@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 18/19] sched: Deny self-issued __set_cpus_allowed_ptr() when migrate_disable()
References: <20201023101158.088940906@infradead.org>
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


