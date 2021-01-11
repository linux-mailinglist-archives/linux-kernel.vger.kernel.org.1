Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92292F11CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbhAKLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:46:59 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:44092 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbhAKLq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:46:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610365595; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rnRdrDWBNH7ytJ2L7yW9zQIx4N3YeZuP+scDtavI6Qs=; b=UBqRsy8Z0ezCU+O9WO4U6S/zlmXp0gc1Zo+nNZTIe0LMP4Ysi2COQVy2U/QHVx8TQ753zki3
 Tzp8xYRU0ZNfTfB7lhKXHi1wwyWrrOd7Vhw5kHoljSBS2f7GGdwO+H1B6K2TW5b+QLsbYd7a
 HvHNgNilCnbiIGNH7kHVG6iK6MU=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ffc3a7d4dcca124755058c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:46:05
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 659ECC433C6; Mon, 11 Jan 2021 11:46:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD103C433CA;
        Mon, 11 Jan 2021 11:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD103C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Correct cpu offline trace in rcutree_dying_cpu
Date:   Mon, 11 Jan 2021 17:15:58 +0530
Message-Id: <1610365558-8330-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correctly trace whether the outgoing cpu blocks current gp in
rcutree_dying_cpu().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 097990a..1f4bff4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2364,7 +2364,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
-			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
+			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

