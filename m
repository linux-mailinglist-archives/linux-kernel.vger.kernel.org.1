Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F02CA597
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgLAO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:28:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731028AbgLAO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:28:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1E82VP011682;
        Tue, 1 Dec 2020 09:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=VpOcsmZTE3VC5RIaXiIHR+Zp8f5/KA8dPjVm8isOLfo=;
 b=U6GeIYHqVaKw+J9sN2z1BAqXpLBOqC2CEfEI2Q+kyhhd5Dxi1ihzj8lif72B44tCqthJ
 QbUV/YGh07eXjgKEv+H5ypAnvuB0nLcNfup+iN9tFwWWJ/Gl7ypdLvc3If3GvTKzLrpf
 8CqSD3QsxH0bUtptrwiwl1VieNcb2wA6Mjzx5ZROgKdn4ihXIJ1fmwnhJTahlwJ/+l5F
 a0TwN58MD/9ygfPkA/0RkttDnEQQkh7cs0spfmKRDxhDeatj4PvMaYZwHPWMVuk8ALVJ
 KKG+gRKCP0dluq5VR4oZwCxHLMxLG/qiDMih6Wb5UZ9zeer/7EjRCwtHgnbE9d4458mx Zg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355j4q393e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 09:28:12 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1EMWt0029199;
        Tue, 1 Dec 2020 14:28:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 353dth9nyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:28:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1ES6pt9044700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 14:28:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09BB342045;
        Tue,  1 Dec 2020 14:28:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC2844203F;
        Tue,  1 Dec 2020 14:28:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 14:28:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id A92B8E0161; Tue,  1 Dec 2020 15:28:05 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 5/5] entry: add syscall_exit_to_user_mode_work()
Date:   Tue,  1 Dec 2020 15:27:55 +0100
Message-Id: <20201201142755.31931-6-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201142755.31931-1-svens@linux.ibm.com>
References: <20201201142755.31931-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_05:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=604 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same as syscall_exit_to_user_mode() but without
calling exit_to_user_mode(). This is useful if a syscall has to be
restarted without leaving to user space.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h |  9 +++++++++
 kernel/entry/common.c        | 14 ++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 112007525f50..bdf6b005bbfb 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -312,6 +312,15 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 
+/**
+ * syscall_exit_to_user_mode_work - Handle work before returning to user mode
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Same as syscall_exit_to_user_mode() but without calling exit_to_user_mode()
+ * to perform the final transition to user mode.
+ */
+void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+
 /**
  * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
  * @regs:	Pointer to currents pt_regs
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e696f6912642..c3c4ba21824a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -246,12 +246,22 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 		syscall_exit_work(regs, cached_flags);
 }
 
-__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
+static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
 {
-	instrumentation_begin();
 	syscall_exit_to_user_mode_prepare(regs);
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
+}
+
+void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	__syscall_exit_to_user_mode_work(regs);
+}
+
+__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
 }
-- 
2.17.1

