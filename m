Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2302CA596
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgLAO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:28:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731025AbgLAO2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:28:54 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1E6QfF035794;
        Tue, 1 Dec 2020 09:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=CABCI/zxhHp7/5CBrYGoKKk6ulvqgtxL1j83GdwQglo=;
 b=pkEKzApTrQu6od7Ts62/PcQs8tVkZvo2jJYlMOFWGqvKD+1dX+FUtuSx3aierTehY0U1
 M7ZMSt0ZTUtTvIiIbI1BC6a7/RtaF7tDxEXVdYciayD9/x9jmP4GdKlMnlk1kwEY/GQ2
 V6P/+HKl/NGeQTBlkOF+aviAgjTxtoawgFf3uvP42u47y+SX5Ku2IxX2X9APIsjLFgNW
 b7wqzwuqvQL7gU+WJ0uLSAaPWW4DDwvgljJnKvwYphOG/dQADDNjxeR5T+ucGPTkFQRl
 g/yTyBKUAoHWCBvjjWcPfeNYCpmqzN2WcmthtVQ9PD73IHvQ185BHnSE4Pguldl0jPf/ 5w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjnjb8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 09:28:11 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1EMd9L004320;
        Tue, 1 Dec 2020 14:28:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 353e68b82d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:28:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1ES3An64946554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 14:28:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B90EA4040;
        Tue,  1 Dec 2020 14:28:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AE11A4053;
        Tue,  1 Dec 2020 14:28:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 14:28:03 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 3FEA3E0161; Tue,  1 Dec 2020 15:28:03 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 1/5] entry: rename enter_from_user_mode()
Date:   Tue,  1 Dec 2020 15:27:51 +0100
Message-Id: <20201201142755.31931-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201142755.31931-1-svens@linux.ibm.com>
References: <20201201142755.31931-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_05:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=673
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make this function publicly available rename
it so it can still be inlined. An addtional enter_from_user_mode()
function will be added with a later commit.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/entry/common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e9e2df3f3f9e..683a8e1b5388 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -9,7 +9,7 @@
 #include <trace/events/syscalls.h>
 
 /**
- * enter_from_user_mode - Establish state when coming from user mode
+ * __enter_from_user_mode - Establish state when coming from user mode
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -18,7 +18,7 @@
  * 2) Invoke context tracking if enabled to reactivate RCU
  * 3) Trace interrupts off state
  */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
 	arch_check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -92,7 +92,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	long ret;
 
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -104,7 +104,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
@@ -270,7 +270,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
-- 
2.17.1

