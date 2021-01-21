Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E5D2FDFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393253AbhAUCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbhAUCSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:18:11 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41636C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 18:17:31 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so378129plh.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hH7V0AB3sGZPaIjJrxGEFMVj6MDgAtsPZB4U0znQ4jk=;
        b=BgShQykYuD2n2lXxTOZf1fpHJd1I8lkZTXsv2e7r7Umkv4ymeC0Ad3Lm1S/6AT7QQt
         xqnknVQhHnDDsiF5hyxHQZ11Pf0WE4srlMgtv8nNVPsJrcy4MZGE2M4ssejjIPwgQqyr
         WOfBM4sBRY0WydkDv1VBLxxNGC/4fBUR8aHO1Zf+Xd1JP/DhEPd0cBmJszoepMrtg5Mb
         uAgoKy0zGzrIkGzduhJil5PgySzez3NvT/XkZParzCpWQ2itYFx80GVfUWTWh3ICABQM
         YimNU5kafBGVdlXLroSK1YUq6pYhXYbhjtSWoJD06mzMb02loq+hk3u4B+CE41AQxMNx
         VCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hH7V0AB3sGZPaIjJrxGEFMVj6MDgAtsPZB4U0znQ4jk=;
        b=jWLlBkXSG9g0teoCQxmo/J9PChLrli15kFR1VEzH0s+iiwf+/b9YcDe3A/zMl9e8Fe
         5rvmXnhYKqEUWfHpZdK8xf236mRpRD0Rbl+gC8dHCmtlbiM/ndMg7LaT36e4fFzfsky5
         Di2jg84Ywq04BWlYAF9zAsbzRaIAcke141fwlga05YyjOM5FE6VzTIIgOMfWWw7g0j09
         ApiSuSqQiljIwmCfPEHpirS8dTsz7LqS5EDBEeqO7jj3Z02lWJDhCJv16rp4INLvE87G
         0EjKz2Lk/y7Ts9b5XGKh2bYoz4RH+3sJai3QKE7G9zRPDxXmbMbuVYAW1utL2COAEFPb
         QYnA==
X-Gm-Message-State: AOAM533wCsMxLJedTrQ1uI7WNvJlaLZjshbgXkh5LG0t+drgEqB7m83b
        HqiKl+9sg7SrVTOX5EdccMs=
X-Google-Smtp-Source: ABdhPJwppTvodgxyQN27U/W5m6skRkW0bEQGFsFH+3mGKerG1fpEvKm3sJma0sC2xETkpcmOHncXyA==
X-Received: by 2002:a17:90a:2e88:: with SMTP id r8mr9075148pjd.84.1611195450577;
        Wed, 20 Jan 2021 18:17:30 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id n128sm3824261pga.55.2021.01.20.18.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 18:17:29 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, bigeasy@linutronix.de, yejune.deng@gmail.com,
        paulmck@kernel.org, qais.yousef@arm.com
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] smp/up: Modify the 'wait' variable from 'int' to 'bool'
Date:   Thu, 21 Jan 2021 10:17:20 +0800
Message-Id: <20210121021720.38081-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In smp_call_function_single() and its caller,the 'wait' variable is only
0 and 1,a bool is a more appropriate definition.

Fix kernel/up.c: when CONFIG_SMP is not set
>>kernel/up.c:12:5: error: conflicting types for 'smp_call_function_single'
12 | int smp_call_function_single(int cpu, void (*func) (void *info),
 void *info,
>> kernel/up.c:39:6: error: conflicting types for 'on_each_cpu'
 39 | void on_each_cpu(smp_call_func_t func, void *info, int wait)

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 include/linux/smp.h | 10 +++++-----
 kernel/smp.c        |  8 ++++----
 kernel/up.c         |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

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
 
diff --git a/kernel/up.c b/kernel/up.c
index c6f323dcd45b..722ceec09417 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -9,8 +9,8 @@
 #include <linux/smp.h>
 #include <linux/hypervisor.h>
 
-int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
-				int wait)
+int smp_call_function_single(int cpu, void (*func) (void *info),
+			     void *info, bool wait)
 {
 	unsigned long flags;
 
@@ -36,7 +36,7 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 }
 EXPORT_SYMBOL(smp_call_function_single_async);
 
-void on_each_cpu(smp_call_func_t func, void *info, int wait)
+void on_each_cpu(smp_call_func_t func, void *info, bool wait)
 {
 	unsigned long flags;
 
-- 
2.29.0

