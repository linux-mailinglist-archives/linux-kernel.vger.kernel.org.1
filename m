Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1B2C4E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 05:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbgKZEoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 23:44:17 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:53520 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731686AbgKZEoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:44:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606365856; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=JSPVZUJfrhFGcM62y2MiWrkRMono5giHdlPyGnNXdec=; b=u3O1L+/Hpo7znghDeZm3a231kbg9Yn0+GJQQmpbz67QXj8A//tEJg4tlNFETzQLJHxYKM5vK
 32pPbJFLgCoeaf5KJPMuGWSG3xal75rhMnm4p/IdgZAACP7646BrxJvCDyfLaTTZHimHHRti
 Iewt25Kic+HWw2ZtPsuzj+84i3A=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fbf329e1b731a5d9c8d8c27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Nov 2020 04:44:14
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD5BEC43464; Thu, 26 Nov 2020 04:44:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF0BCC433ED;
        Thu, 26 Nov 2020 04:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF0BCC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     minchan@kernel.org, glider@google.com, dan.j.williams@intel.com,
        broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        vjitta@codeaurora.org, ylal@codeaurora.org, vinmenon@codeaurora.org
Subject: [PATCH v2] lib: stackdepot: Add support to configure STACK_HASH_SIZE
Date:   Thu, 26 Nov 2020 10:13:55 +0530
Message-Id: <1606365835-3242-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Lal <ylal@codeaurora.org>

Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE.

Aim is to have configurable value for STACK_HASH_SIZE, so that one
can configure it depending on usecase there by reducing the static
memory overhead.

One example is of Page Owner, default value of STACK_HASH_SIZE lead
stack depot to consume 8MB of static memory. Making it configurable
and use lower value helps to enable features like CONFIG_PAGE_OWNER
without any significant overhead.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 lib/stackdepot.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 81c69c0..ce53598 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -141,14 +141,31 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 	return stack;
 }
 
-#define STACK_HASH_ORDER 20
-#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
+static unsigned int stack_hash_order = 20;
+#define STACK_HASH_SIZE (1L << stack_hash_order)
 #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
 #define STACK_HASH_SEED 0x9747b28c
 
-static struct stack_record *stack_table[STACK_HASH_SIZE] = {
-	[0 ...	STACK_HASH_SIZE - 1] = NULL
-};
+static struct stack_record **stack_table;
+
+static int __init setup_stack_hash_order(char *str)
+{
+	kstrtouint(str, 0, &stack_hash_order);
+	return 0;
+}
+early_param("stack_hash_order", setup_stack_hash_order);
+
+static int __init init_stackdepot(void)
+{
+	int i;
+
+	stack_table = kvmalloc(sizeof(struct stack_record *) * STACK_HASH_SIZE, GFP_KERNEL);
+	for (i = 0; i < STACK_HASH_SIZE; i++)
+		stack_table[i] = NULL;
+	return 0;
+}
+
+early_initcall(init_stackdepot);
 
 /* Calculate hash for a stack */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

