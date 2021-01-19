Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F552FBE10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbhASPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395337AbhASOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:15:11 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 06:14:04 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w14so3272676pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzfByvGH+2qFPigxMufJUpBYVu9QZuNkPVkwM5EKNAk=;
        b=ElBPUAepVGk+Dr2dlZZ67RwjnCsG1rEwrgDebr3JYMPqhd5yWifRb+vIa7qkUpH75p
         35wfq/z/IVuShF3rPjxpZEzsWm0XMGacgVHMAPCcubhP8sZh22Wm7VOYYl/tIV2oIsbu
         aoeLvMwX65NGnZUVm2JCSj8hO35HC+2vYlDBh4j7UpmffsGmib4KKiHrwCXiYgr89RMX
         DOeoYuf5Diobesb5UP/Ibe8NA67EeW7ltz1VOnnsZgxz3mujgM9o5CA2CTW+ZInutVHu
         D/bRKgsh2aIl2dSCImyUeFZ39DKOrTnpdArDPs8Z3lnrcjEcIQftNSKaA21Ot17iGNSO
         /UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzfByvGH+2qFPigxMufJUpBYVu9QZuNkPVkwM5EKNAk=;
        b=icijNedvRXDZGv0Z21cni7DVZL+LO5TD+Rm3HfItI4Cu7BVjsQAJvej27OBf/0IyRB
         luFvixumA02xH9hdEAbTiRUgEDW1EFSGf5s/sYf+kOfDX6DqJtusrO127NkNNpwaBp14
         oETpc4jtKKVrv73//3qlKSLEjhdCMQuqSRCUo21/bi5crzMOHzfCenSOEXd1v1GtrTdn
         ynhdAQMU3IaXSlPykGYKzPd6FkTDN2ay/K09Vhoud0TZ1gNDXRoR2ojS9O9ib9M4ajfZ
         +WrAf139GpUAAbPbVVpQACsNEQMdxs4L4jaR9qsHlSiim3Q2a7QjwVXTeGJnpSDFHDWl
         SNhw==
X-Gm-Message-State: AOAM533qfGcQxLBC7UKsaE/l0Z8v7NUFIoGN7QMa1GoEklTiDof47Dxi
        UJQwp2YJn1ES7QT5ikkHGCc=
X-Google-Smtp-Source: ABdhPJyYmnTf1PaLzDNTaaZjLN8W4Ym6twccnWxiVdz1IHhqKZJ+SQ1xtM7qAYV1XgyfwaeOf3dTLQ==
X-Received: by 2002:a62:3002:0:b029:1aa:d858:cdd7 with SMTP id w2-20020a6230020000b02901aad858cdd7mr4565952pfw.1.1611065644135;
        Tue, 19 Jan 2021 06:14:04 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id b62sm8542716pfg.58.2021.01.19.06.14.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 06:14:03 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        frederic@kernel.org, bigeasy@linutronix.de, qais.yousef@arm.com,
        paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejune.deng@gmail.com>
Subject: [PATCH] smp: Modify 'int' to 'bool' in smp_call_function_single()
Date:   Tue, 19 Jan 2021 22:13:50 +0800
Message-Id: <20210119141350.80522-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In smp_call_function_single() and its caller,the 'wait' variable is only
0 and 1,a bool is a more appropriate definition.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 include/linux/smp.h | 10 +++++-----
 kernel/smp.c        |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..5f27ebd504e2 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -48,12 +48,12 @@ extern void __smp_call_single_queue(int cpu, struct llist_node *node);
 extern unsigned int total_cpus;
 
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
-			     int wait);
+			     bool wait);
 
 /*
  * Call a function on all processors
  */
-void on_each_cpu(smp_call_func_t func, void *info, int wait);
+void on_each_cpu(smp_call_func_t func, void *info, bool wait);
 
 /*
  * Call a function on processors specified by mask, which might include
@@ -117,12 +117,12 @@ extern void smp_cpus_done(unsigned int max_cpus);
 /*
  * Call a function on all other processors
  */
-void smp_call_function(smp_call_func_t func, void *info, int wait);
+void smp_call_function(smp_call_func_t func, void *info, bool wait);
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait);
 
 int smp_call_function_any(const struct cpumask *mask,
-			  smp_call_func_t func, void *info, int wait);
+			  smp_call_func_t func, void *info, bool wait);
 
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
@@ -174,7 +174,7 @@ static inline void call_function_init(void) { }
 
 static inline int
 smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
-		      void *info, int wait)
+		      void *info, bool wait)
 {
 	return smp_call_function_single(0, func, info, wait);
 }
diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070bf97bb..c72e474d53ab 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -461,7 +461,7 @@ void flush_smp_call_function_from_idle(void)
  * Returns 0 on success, else a negative status code.
  */
 int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
-			     int wait)
+			     bool wait)
 {
 	call_single_data_t *csd;
 	call_single_data_t csd_stack = {
@@ -576,7 +576,7 @@ EXPORT_SYMBOL_GPL(smp_call_function_single_async);
  *	3) any other online cpu in @mask
  */
 int smp_call_function_any(const struct cpumask *mask,
-			  smp_call_func_t func, void *info, int wait)
+			  smp_call_func_t func, void *info, bool wait)
 {
 	unsigned int cpu;
 	const struct cpumask *nodemask;
@@ -727,7 +727,7 @@ EXPORT_SYMBOL(smp_call_function_many);
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-void smp_call_function(smp_call_func_t func, void *info, int wait)
+void smp_call_function(smp_call_func_t func, void *info, bool wait)
 {
 	preempt_disable();
 	smp_call_function_many(cpu_online_mask, func, info, wait);
@@ -824,7 +824,7 @@ void __init smp_init(void)
  * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
  * of local_irq_disable/enable().
  */
-void on_each_cpu(smp_call_func_t func, void *info, int wait)
+void on_each_cpu(smp_call_func_t func, void *info, bool wait)
 {
 	unsigned long flags;
 
-- 
2.29.0

