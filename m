Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C843A1CCB36
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 14:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEJM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 08:57:07 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:25770 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgEJM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:57:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589115425; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xbNlNcKRFd58rmwKnqoHJadbCNL3+FrGOdfqkWJ4rUI=; b=UeUEESe2AXb7xpDp0Ud+yu1mgizU4Bkwq7s8k6xPhUkq5v3wAiHHkm5uJbj/0GKPUU6y7Z1n
 pbtoqFGOG/I8M8WZ/J10Mux2JD1OCX9AAkJIRDZjNXxjW7pHJEz9oAFMW439m6iXG9KkDxYt
 Zdv4/ca2ZR+vVdxjytKXJXnc3Os=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb7fa21.7f5a2c165c38-smtp-out-n05;
 Sun, 10 May 2020 12:57:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3DEA1C44788; Sun, 10 May 2020 12:57:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C134DC433F2;
        Sun, 10 May 2020 12:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C134DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] sched/debug: Fix requested task uclamp values shown in procfs
Date:   Sun, 10 May 2020 18:26:41 +0530
Message-Id: <1589115401-26391-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention of commit 96e74ebf8d59 ("sched/debug: Add task uclamp
values to SCHED_DEBUG procfs") was to print requested and effective
task uclamp values. The requested values printed are read from p->uclamp,
which holds the last effective values. Fix this by printing the values
from p->uclamp_req.

Fixes: 96e74ebf8d59 ("sched/debug: Add task uclamp values to SCHED_DEBUG procfs")
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 kernel/sched/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a562df5..239970b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -948,8 +948,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_est.enqueued);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
-	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
-	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
+	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
 	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
 	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
