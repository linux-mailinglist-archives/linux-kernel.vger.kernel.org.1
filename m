Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4B2F11C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbhAKLqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:46:10 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:47519 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbhAKLqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:46:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610365548; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XbNx0OdQs+h58z2IZnrdv+X6kQ7RKVI3bzyF2n2x3Wg=; b=N2lIMpmOcZXcqSyAd/9G1BPYKKWSK2Nyccd1Uy04nlFKOpKCCoa+TEhwkJsrFiaKqofq0eMf
 AKGTN8RchDRT+K5vRNJ7woPCJ1Y/TR9Mb+xslvSNz61dppSYA3Eqh+Oky67HMk0WRibsaMAW
 swg/r0vbI0lPUXdEFgfXfeBo4i8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5ffc3a6c46a6c7cde7a76d3b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:45:48
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2087CC43464; Mon, 11 Jan 2021 11:45:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BFCBC433ED;
        Mon, 11 Jan 2021 11:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BFCBC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Trace cbs accelerated without leaf rnp node lock held
Date:   Mon, 11 Jan 2021 17:15:43 +0530
Message-Id: <1610365543-7669-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace cbs which are accelerated without rnp lock help in
rcu_accelerate_cbs_unlocked().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 338b817..097990a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1473,6 +1473,17 @@ static void rcu_gp_kthread_wake(void)
 	swake_up_one(&rcu_state.gp_wq);
 }
 
+static void rcu_trace_accelerated_cbs(struct rcu_data *rdp,
+				      unsigned long gp_seq_req)
+{
+	rcu_lockdep_assert_cblist_protected(rdp);
+	/* Trace depending on how much we were able to accelerate. */
+	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
+	else
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+}
+
 /*
  * If there is room, assign a ->gp_seq number to any callbacks on this
  * CPU that have not already been assigned.  Also accelerate any callbacks
@@ -1511,12 +1522,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
 		return ret;
 	ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
-
-	/* Trace depending on how much we were able to accelerate. */
-	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
-	else
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+	rcu_trace_accelerated_cbs(rdp, gp_seq_req);
 
 	return ret;
 }
@@ -1538,7 +1544,8 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 	c = rcu_seq_snap(&rcu_state.gp_seq);
 	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
-		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
+		if (rcu_segcblist_accelerate(&rdp->cblist, c))
+			rcu_trace_accelerated_cbs(rdp, c);
 		return;
 	}
 	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

