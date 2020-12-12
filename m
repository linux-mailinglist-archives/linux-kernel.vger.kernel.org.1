Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9C2D8A05
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 21:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407890AbgLLUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 15:49:30 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:42394 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgLLUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 15:49:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607806146; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/AJJdvvgcxzEk2iIh8Q9OM+WIMHQvzRBydUe39VSYsA=; b=dRqaK/wyr3fgLOP6hgoDrF8e+UAC6/DqhThvEzMZ6B1hZda/tZtRubf+roPzNW8QloHSmygc
 5DPTLxMFCjmh6db0vxXKfrtKKXzq1CNGUSXcAnvv6MAW5dpGOqOgVhMQpSKeQfaY0f7T6EdP
 Xv6mo3Q2Rc3JO2WNsf6/vmz1wuc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fd52c8f35a25d1b164a9460 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Dec 2020 20:48:15
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB760C43461; Sat, 12 Dec 2020 20:48:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89FC3C433C6;
        Sat, 12 Dec 2020 20:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89FC3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tsoni@codeaurora.org, bjorn.andersson@linaro.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH] remoteproc: Create a separate workqueue for recovery tasks
Date:   Sat, 12 Dec 2020 12:48:07 -0800
Message-Id: <1607806087-27244-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an unbound high priority workqueue for recovery tasks.
Recovery time is an important parameter for a subsystem and there
might be situations where multiple subsystems crash around the same
time. Scheduling into an unbound workqueue increases parallelization
and avoids time impact. Also creating a high priority workqueue
will utilize separate worker threads with higher nice values than
normal ones.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 46c2937..8fd8166 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -48,6 +48,8 @@ static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
 static struct notifier_block rproc_panic_nb;
 
+static struct workqueue_struct *rproc_wq;
+
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
 				 void *, int offset, int avail);
 
@@ -2475,7 +2477,7 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 		rproc->name, rproc_crash_to_string(type));
 
 	/* create a new task to handle the error */
-	schedule_work(&rproc->crash_handler);
+	queue_work(rproc_wq, &rproc->crash_handler);
 }
 EXPORT_SYMBOL(rproc_report_crash);
 
@@ -2520,6 +2522,10 @@ static void __exit rproc_exit_panic(void)
 
 static int __init remoteproc_init(void)
 {
+	rproc_wq = alloc_workqueue("rproc_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!rproc_wq)
+		return -ENOMEM;
+
 	rproc_init_sysfs();
 	rproc_init_debugfs();
 	rproc_init_cdev();
@@ -2536,6 +2542,7 @@ static void __exit remoteproc_exit(void)
 	rproc_exit_panic();
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
+	destroy_workqueue(rproc_wq);
 }
 module_exit(remoteproc_exit);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

