Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5C1CA16D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 05:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHDQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 23:16:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbgEHDQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 23:16:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B9F24162F1B5998915DF;
        Fri,  8 May 2020 11:16:05 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 11:15:57 +0800
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <Dave.Martin@arm.com>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <yeyunfeng@huawei.com>,
        <0x7f454c46@gmail.com>, <tglx@linutronix.de>,
        <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v2] arm64: stacktrace: Factor out some common code into
 on_stack()
Message-ID: <07b3b0e6-3f58-4fed-07ea-7d17b7508948@huawei.com>
Date:   Fri, 8 May 2020 11:15:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some common codes for stack checking, so factors it out into
the function on_stack().

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
v1 -> v2:
 - check 'low' in on_stack() and everybody call on_stack() only

 arch/arm64/include/asm/stacktrace.h | 40 +++++++++++++------------------------
 arch/arm64/kernel/sdei.c            | 28 ++------------------------
 2 files changed, 16 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index fdb913cc0bcb..fc7613023c19 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -69,12 +69,10 @@ extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,

 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);

-static inline bool on_irq_stack(unsigned long sp,
+static inline bool on_stack(unsigned long sp, unsigned long low,
+				unsigned long high, enum stack_type type,
 				struct stack_info *info)
 {
-	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
-	unsigned long high = low + IRQ_STACK_SIZE;
-
 	if (!low)
 		return false;

@@ -84,12 +82,20 @@ static inline bool on_irq_stack(unsigned long sp,
 	if (info) {
 		info->low = low;
 		info->high = high;
-		info->type = STACK_TYPE_IRQ;
+		info->type = type;
 	}
-
 	return true;
 }

+static inline bool on_irq_stack(unsigned long sp,
+				struct stack_info *info)
+{
+	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
+	unsigned long high = low + IRQ_STACK_SIZE;
+
+	return on_stack(sp, low, high, STACK_TYPE_IRQ, info);
+}
+
 static inline bool on_task_stack(const struct task_struct *tsk,
 				 unsigned long sp,
 				 struct stack_info *info)
@@ -97,16 +103,7 @@ static inline bool on_task_stack(const struct task_struct *tsk,
 	unsigned long low = (unsigned long)task_stack_page(tsk);
 	unsigned long high = low + THREAD_SIZE;

-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_TASK;
-	}
-
-	return true;
+	return on_stack(sp, low, high, STACK_TYPE_TASK, info);
 }

 #ifdef CONFIG_VMAP_STACK
@@ -118,16 +115,7 @@ static inline bool on_overflow_stack(unsigned long sp,
 	unsigned long low = (unsigned long)raw_cpu_ptr(overflow_stack);
 	unsigned long high = low + OVERFLOW_STACK_SIZE;

-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_OVERFLOW;
-	}
-
-	return true;
+	return on_stack(sp, low, high, STACK_TYPE_OVERFLOW, info);
 }
 #else
 static inline bool on_overflow_stack(unsigned long sp,
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index d6259dac62b6..3afed808b474 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -95,19 +95,7 @@ static bool on_sdei_normal_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;

-	if (!low)
-		return false;
-
-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_SDEI_NORMAL;
-	}
-
-	return true;
+	return on_stack(sp, low, high, STACK_TYPE_SDEI_NORMAL, info);
 }

 static bool on_sdei_critical_stack(unsigned long sp, struct stack_info *info)
@@ -115,19 +103,7 @@ static bool on_sdei_critical_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;

-	if (!low)
-		return false;
-
-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_SDEI_CRITICAL;
-	}
-
-	return true;
+	return on_stack(sp, low, high, STACK_TYPE_SDEI_CRITICAL, info);
 }

 bool _on_sdei_stack(unsigned long sp, struct stack_info *info)
-- 
1.8.3.1

