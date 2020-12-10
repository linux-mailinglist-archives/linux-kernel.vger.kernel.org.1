Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEA2D5304
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgLJFCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:02:17 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:34347 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgLJFCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:02:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607576516; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=KfsBpaVVAyJEthwLGMEAvXCj53yKpejyqx0T2n27Pnw=; b=TCfKlf5nA+Aj5bdEI7XlZLMt14k912OrMCXOiYUra4Jowz6Em8HtOqGRU7GRx028n1/DDKZW
 Fx4Z7v6WzrhAjKpkouQGf1x6o5xa3QbRs6aTmQ5j+uY3YWT7YxO9EOQUqWtdSE1Fvpohpjm/
 G+ryK7YaCA6LqEziemDEQKWn6DE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fd1ab92a18369bfbb2f9a6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 05:01:06
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2395EC43464; Thu, 10 Dec 2020 05:01:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D457C433CA;
        Thu, 10 Dec 2020 05:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D457C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     minchan@kernel.org, vincenzo.frascino@arm.com, glider@google.com,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andreyknvl@google.com, qcai@redhat.com, vjitta@codeaurora.org,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Subject: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
Date:   Thu, 10 Dec 2020 10:30:01 +0530
Message-Id: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
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
 lib/stackdepot.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 81c69c0..e0eebfd 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -30,6 +30,7 @@
 #include <linux/stackdepot.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 
 #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
 
@@ -141,14 +142,36 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 	return stack;
 }
 
-#define STACK_HASH_ORDER 20
-#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
+#define MAX_STACK_HASH_ORDER 20
+#define MAX_STACK_HASH_SIZE (1L << MAX_STACK_HASH_ORDER)
+#define STACK_HASH_SIZE (1L << stack_hash_order)
 #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
 #define STACK_HASH_SEED 0x9747b28c
 
-static struct stack_record *stack_table[STACK_HASH_SIZE] = {
-	[0 ...	STACK_HASH_SIZE - 1] = NULL
+static unsigned int stack_hash_order = 20;
+static struct stack_record *stack_table_def[MAX_STACK_HASH_SIZE] __initdata = {
+	[0 ...  MAX_STACK_HASH_SIZE - 1] = NULL
 };
+static struct stack_record **stack_table __refdata = stack_table_def;
+
+static int __init setup_stack_hash_order(char *str)
+{
+	kstrtouint(str, 0, &stack_hash_order);
+	if (stack_hash_order > MAX_STACK_HASH_ORDER)
+		stack_hash_order = MAX_STACK_HASH_ORDER;
+	return 0;
+}
+early_param("stack_hash_order", setup_stack_hash_order);
+
+static int __init init_stackdepot(void)
+{
+	size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
+
+	stack_table = vmalloc(size);
+	memcpy(stack_table, stack_table_def, size);
+	return 0;
+}
+early_initcall(init_stackdepot);
 
 /* Calculate hash for a stack */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
-- 
2.7.4
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
