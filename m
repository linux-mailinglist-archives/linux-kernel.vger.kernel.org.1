Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79AB2FACF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbhARVo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:44:29 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:46832 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbhARJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:57:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610963856; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Dw13t5mqcoj16A09Cz3kq7wmMl1NbIYm6m5GOEhs0TU=; b=pvBvISJeMwMEv2ujRiqm6X4NIHR9Czo+v9Jt8XHS4Wya28VZIJyyBlMcQy3Hy7BiEJLoVcXP
 BqXrza9T8+bbOJM6lqx37WNG/FX8xOlgr8XKLWC/asPdhVrA1T/Mbixax/YbPlVnLq03IwIL
 MSBsHLXsO2kuk6UwgXJgSPe/H/g=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60055b6f21210999ed2032e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 09:57:03
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DBEAEC43461; Mon, 18 Jan 2021 09:57:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03F80C433CA;
        Mon, 18 Jan 2021 09:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03F80C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     minchan@kernel.org, glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, vjitta@codeaurora.org,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Subject: [PATCH v5 2/2] lib: stackdepot: Add support to disable stack depot
Date:   Mon, 18 Jan 2021 15:26:42 +0530
Message-Id: <1610963802-11042-2-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
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
 include/linux/stackdepot.h |  1 +
 init/main.c                |  2 ++
 lib/stackdepot.c           | 33 +++++++++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 24d49c7..eafd9aa 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -21,4 +21,5 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 
 unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
 
+int stack_depot_init(void);
 #endif
diff --git a/init/main.c b/init/main.c
index 32b2a8a..8fcf9bb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -98,6 +98,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
+#include <linux/stackdepot.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -827,6 +828,7 @@ static void __init mm_init(void)
 	page_ext_init_flatmem();
 	init_debug_pagealloc();
 	report_meminit();
+	stack_depot_init();
 	mem_init();
 	kmem_cache_init();
 	kmemleak_init();
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index dff8521..d20e6fd 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -31,6 +31,8 @@
 #include <linux/stackdepot.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <linux/memblock.h>
 
 #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
 
@@ -146,9 +148,32 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
 #define STACK_HASH_SEED 0x9747b28c
 
-static struct stack_record *stack_table[STACK_HASH_SIZE] = {
-	[0 ...	STACK_HASH_SIZE - 1] = NULL
-};
+static bool stack_depot_disable;
+static struct stack_record **stack_table;
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
+int __init stack_depot_init(void)
+{
+	if (!stack_depot_disable) {
+		size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
+		int i;
+
+		stack_table = memblock_alloc(size, size);
+		for (i = 0; i < STACK_HASH_SIZE;  i++)
+			stack_table[i] = NULL;
+	}
+	return 0;
+}
 
 /* Calculate hash for a stack */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
@@ -242,7 +267,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 	unsigned long flags;
 	u32 hash;
 
-	if (unlikely(nr_entries == 0))
+	if (unlikely(nr_entries == 0) || stack_depot_disable)
 		goto fast_exit;
 
 	hash = hash_stack(entries, nr_entries);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

