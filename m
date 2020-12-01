Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C162A2CA5AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391358AbgLAOb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:31:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60451 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388915AbgLAOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:31:27 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1E6GEZ140158;
        Tue, 1 Dec 2020 09:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=UkNejHt6d/u1cxS1HNRvIiBgvVzhgMHWHgyUZaVTepo=;
 b=BUp4wQKeOq3UsD+0tEwrLbRQUAymK6oAKPBV4ymZGGKuGiV+6xlEUrj2BnxuO4LbWAhc
 IB7NV6sPyMdMADcS85VliPScLYA5NPwTj/xu8W1CV2ymhPU0vyo7fhKlXrkFeyW6bnMR
 WTSO9VWWQtyMW3hFvJ2kGBXux5ctIJQzZ+4nGCqStucKKjAEN5cS4SMyYYGPL0UQizsm
 YbIVYttsfZqFG2PZ4VGO+BFm2RVnkyOyc2FHq5HqRVeuU6Ez8QOdvwhVihD7O2KvYhs6
 UecezvvXYsu4+70LSNiBmy3S7xK5gzVWTtopdC1FZdHjFg1b+AuYDBCBml185XYZdsMp 8Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355k18fuwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 09:30:42 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1EMr3W020311;
        Tue, 1 Dec 2020 14:30:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 353e684st7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:30:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1ES5Mi25231630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 14:28:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67B17A4055;
        Tue,  1 Dec 2020 14:28:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56FC8A404D;
        Tue,  1 Dec 2020 14:28:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 14:28:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 1C465E0161; Tue,  1 Dec 2020 15:28:05 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 4/5] entry: add exit_to_user_mode() wrapper
Date:   Tue,  1 Dec 2020 15:27:54 +0100
Message-Id: <20201201142755.31931-5-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201142755.31931-1-svens@linux.ibm.com>
References: <20201201142755.31931-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_05:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can be called from architecture dependent code, and simply
calls __exit_to_user_mode(). This way __exit_to_user_mode()
can still be inlined because it is declared static.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 15 +++++++++++++++
 kernel/entry/common.c        | 17 +++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 28a8554fad7d..112007525f50 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -413,4 +413,19 @@ void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
  * 3) Trace interrupts off state
  */
 void enter_from_user_mode(struct pt_regs *regs);
+
+/**
+ * exit_to_user_mode - Fixup state when exiting to user mode
+ *
+ * Syscall/interrupt exit enables interrupts, but the kernel state is
+ * interrupts disabled when this is invoked. Also tell RCU about it.
+ *
+ * 1) Trace interrupts on state
+ * 2) Invoke context tracking if enabled to adjust RCU state
+ * 3) Invoke architecture specific last minute exit code, e.g. speculation
+ *    mitigations, etc.
+ * 4) Tell lockdep that interrupts are enabled
+ */
+
+void exit_to_user_mode(void);
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index ee588ee9f122..e696f6912642 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -105,18 +105,6 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-/**
- * __exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall/interupt exit enables interrupts, but the kernel state is
- * interrupts disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Invoke architecture specific last minute exit code, e.g. speculation
- *    mitigations, etc.
- * 4) Tell lockdep that interrupts are enabled
- */
 static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
@@ -129,6 +117,11 @@ static __always_inline void __exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+void noinstr exit_to_user_mode(void)
+{
+	__exit_to_user_mode();
+}
+
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal(struct pt_regs *regs) { }
 
-- 
2.17.1

