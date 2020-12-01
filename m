Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973AE2C99A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgLAIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:36:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbgLAIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:36:52 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B18XxSu188812;
        Tue, 1 Dec 2020 03:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=WkHsAXQJm3l6WkGFj3oJqG2Hp9F3GURhJUV8Db3adFU=;
 b=RgaB6gzuNobD1YA/ohNOIOrb75Sr85my2dxQQ1O51Eu6v2zmXjT1XaXAQgghYWMn9T9K
 AFJMr4T5D+lT2kYNO9drnQfmFedomQThaL7p8nxBd9qGb+HEWLzt7TJCNr2TbCvyoWbY
 a2vnqfUT2S+W8e6aKEgI+sH4BvUnjjJQifSFx+5NrZMh6kYPbZxfnWoywMjuAlE1xOf/
 pC5MqYscadGhcmNusFCLa3olU2MBjG9ENqhirb6oEzPGmeSAiQKiNtP+Olumsey1Up+g
 TGLwmNdm8FFPZygwSZS2RNrABFTxrV9RrV4Gm9Q69NSiWWqg3+TIpvbxN9oGdLLd94VN QA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jaar7sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 03:36:07 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B18Wn7p016617;
        Tue, 1 Dec 2020 08:36:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 353e68awn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 08:36:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B18a0rj5636860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 08:36:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54DF11C052;
        Tue,  1 Dec 2020 08:35:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA0EF11C050;
        Tue,  1 Dec 2020 08:35:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 08:35:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 89204E24F9; Tue,  1 Dec 2020 09:35:59 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, hca@linux.ibm.com,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] entry: split lockdep and syscall work functions
Date:   Tue,  1 Dec 2020 09:35:53 +0100
Message-Id: <20201201083553.50996-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201083553.50996-1-svens@linux.ibm.com>
References: <20201201083553.50996-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_01:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=704 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390, we can not call one function which sets lockdep
state and do the syscall work at the same time. There add
make enter_from_user_mode() and exit_to_user_mode() public, and
add syscall_exit_to_user_mode1() which does the same as
syscall_exit_to_user_mode() but skips the final exit_to_user_mode().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h |  4 +++-
 kernel/entry/common.c        | 35 +++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 474f29638d2c..496c9a47eab4 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -124,7 +124,7 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
  * to be done between establishing state and handling user mode entry work.
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
-
+void enter_from_user_mode(struct pt_regs *regs);
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
  *				       a syscall
@@ -311,6 +311,8 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
  *     arch_exit_to_user_mode() to handle e.g. speculation mitigations
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
+void syscall_exit_to_user_mode1(struct pt_regs *regs);
+void exit_to_user_mode(void);
 
 /**
  * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e9e2df3f3f9e..3ad462ebfa15 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -18,7 +18,7 @@
  * 2) Invoke context tracking if enabled to reactivate RCU
  * 3) Trace interrupts off state
  */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
 	arch_check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -31,6 +31,11 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	instrumentation_end();
 }
 
+void noinstr enter_from_user_mode(struct pt_regs *regs)
+{
+	__enter_from_user_mode(regs);
+}
+
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
@@ -92,7 +97,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	long ret;
 
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -104,14 +109,14 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
 }
 
 /**
- * exit_to_user_mode - Fixup state when exiting to user mode
+ * __exit_to_user_mode - Fixup state when exiting to user mode
  *
  * Syscall/interupt exit enables interrupts, but the kernel state is
  * interrupts disabled when this is invoked. Also tell RCU about it.
@@ -122,7 +127,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
  *    mitigations, etc.
  * 4) Tell lockdep that interrupts are enabled
  */
-static __always_inline void exit_to_user_mode(void)
+static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
@@ -134,6 +139,11 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+void noinstr exit_to_user_mode(void)
+{
+	__exit_to_user_mode();
+}
+
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal(struct pt_regs *regs) { }
 
@@ -265,12 +275,21 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
+}
+
+__visible noinstr void syscall_exit_to_user_mode1(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	syscall_exit_to_user_mode_prepare(regs);
+	local_irq_disable_exit_to_user();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
@@ -278,7 +297,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
-- 
2.17.1

