Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48212768FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIXGee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:34:34 -0400
Received: from z5.mailgun.us ([104.130.96.5]:59140 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgIXGee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:34:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600929273; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SCZE0l76mOT8sBQ7aJKBqrLFMUKoKWKDRKCvf8+bXBk=; b=ko3l9p3RWzNcMReY/GjOM8r/ZcG/+Q6hXz8KB1+jAoSFFHIB4OTqZcqahmXkcJON1DGbf6No
 mRVyGUtwjqtuD29RJxPawOOMfTWwBfucRAf8roaLhRzEybGKWJ/IA+Tlwc/SwDemGMUnFCOl
 3cXH8dyLoa+kMU63075DYPCBz9o=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f6c3dea244d44dc65074235 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 06:34:18
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE6F6C43385; Thu, 24 Sep 2020 06:34:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2FA2C433C8;
        Thu, 24 Sep 2020 06:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2FA2C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
Date:   Thu, 24 Sep 2020 12:04:10 +0530
Message-Id: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the "x" in rcuox/N naming in RCU_NOCB_CPU config
description.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f..5b22747 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -227,11 +227,12 @@ config RCU_NOCB_CPU
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
-	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
-	  on the specified CPUs, but (1) the kthreads may be preempted
-	  between each callback, and (2) affinity or cgroups can be used
-	  to force the kthreads to run on whatever set of CPUs is desired.
+	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
+	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
+	  from running on the specified CPUs, but (1) the kthreads may be
+	  preempted between each callback, and (2) affinity or cgroups can
+	  be used to force the kthreads to run on whatever set of CPUs is
+	  desired.
 
 	  Say Y here if you want to help to debug reduced OS jitter.
 	  Say N here if you are unsure.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

