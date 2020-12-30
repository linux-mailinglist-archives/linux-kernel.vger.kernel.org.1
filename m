Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3502E78A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgL3Mra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:47:30 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:25612 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgL3Mra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:47:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609332430; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ly3gsXeefuZH74zrL6lb4LYyeGAoKUKhNu8gNQ3x8WU=; b=ZQY9Em+K0G3TQEOEwUC3UzrYTAV20IjUDyUFoXGmj4ZeJkvubceprvNEunVkkyoAzsO/FVMC
 NBu62FqQ5j1Utb87M8yw6dgZjMfx3qg/yyPiVztE57HTedt8qhkxH400FuRtwPyntwEtJwJX
 UGqnZdxVl+JeFxbIM9YBr3tRFp0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fec769cd3eb3c36b435d40d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Dec 2020 12:46:20
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 215C1C43465; Wed, 30 Dec 2020 12:46:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4149CC433CA;
        Wed, 30 Dec 2020 12:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4149CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     minchan@kernel.org, glider@google.com, dan.j.williams@intel.com,
        broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        vjitta@codeaurora.org, ylal@codeaurora.org, vinmenon@codeaurora.org
Subject: [PATCH v4 2/2] lib: stackdepot: Add support to disable stack depot
Date:   Wed, 30 Dec 2020 18:15:31 +0530
Message-Id: <1609332331-2456-2-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
References: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

Add a kernel parameter stack_depot_disable to disable
stack depot. So that stack hash table doesn't consume
any memory when stack depot is disabled.

Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 lib/stackdepot.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 614ac28..72b9050 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -30,6 +30,7 @@
 #include <linux/stackdepot.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 
 #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
 
@@ -145,10 +146,36 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
 #define STACK_HASH_SEED 0x9747b28c
 
-static struct stack_record *stack_table[STACK_HASH_SIZE] = {
+static struct stack_record *stack_table_tmp[STACK_HASH_SIZE] __initdata = {
 	[0 ...	STACK_HASH_SIZE - 1] = NULL
 };
 
+static bool stack_depot_disable;
+static struct stack_record **stack_table __refdata = stack_table_tmp;
+
+static int __init is_stack_depot_disabled(char *str)
+{
+	kstrtobool(str, &stack_depot_disable);
+	if (stack_depot_disable) {
+		pr_info("Stack Depot is disabled\n");
+		stack_table = NULL;
+	}
+	return 0;
+}
+early_param("stack_depot_disable", is_stack_depot_disabled);
+
+static int __init init_stackdepot(void)
+{
+	if (!stack_depot_disable) {
+		size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
+
+		stack_table = vmalloc(size);
+		memcpy(stack_table, stack_table_tmp, size);
+	}
+	return 0;
+}
+early_initcall(init_stackdepot);
+
 /* Calculate hash for a stack */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 {
@@ -230,7 +257,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 	unsigned long flags;
 	u32 hash;
 
-	if (unlikely(nr_entries == 0))
+	if (unlikely(nr_entries == 0) || !stack_table)
 		goto fast_exit;
 
 	hash = hash_stack(entries, nr_entries);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

