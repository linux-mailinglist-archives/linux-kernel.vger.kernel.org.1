Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21C72CA5A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbgLAOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:30:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgLAOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:30:07 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1E7m0p082478;
        Tue, 1 Dec 2020 09:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=2ay65fnpiYH6fk7W8MhRyUurQtFhxhuJknzjFw+pZpE=;
 b=BVpfgO3bNOkWGjVJhgJsyImM298tqXDTeQM3Xn35bs194VreFyxaPj3/MLaF0t6tArqE
 ALgcowKHfCrS8wlnoMpuvjSeKysQSXyoTi3K8biTCwXImCm0oiN6d2XOclGZPcaBWwtS
 sKSlgYOPWLhe8/SpvdYRN38bMzu9ESAWKk9fvPHnvqCBHM9apfUfEmdR2vKAt8S4WEjs
 0FJWiZ1P3clKF4NYSzAHSyHNIjX21QrvFdUw/O2e8ehSCA3nuQRrr9q/MxpyQjExsjHH
 LzKKpePQyJsCNkA4NZkUGAkf5Xe9PDHwsz0v1UNI8JAM+s+WkssJzDNCabU+4mKhNpJt pA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jab268h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 09:29:24 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1EMr3P020311;
        Tue, 1 Dec 2020 14:29:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 353e684sr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:29:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1ES47Y10093282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 14:28:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39083A4040;
        Tue,  1 Dec 2020 14:28:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2831FA4055;
        Tue,  1 Dec 2020 14:28:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 14:28:04 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id E1D26E0161; Tue,  1 Dec 2020 15:28:03 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 2/5] entry: rename exit_from_user_mode()
Date:   Tue,  1 Dec 2020 15:27:52 +0100
Message-Id: <20201201142755.31931-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201142755.31931-1-svens@linux.ibm.com>
References: <20201201142755.31931-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_05:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make this function publicly available rename
it so it can still be inlined. An additional exit_from_user_mode()
function will be added with a later commit.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/entry/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 683a8e1b5388..076ee1cde67f 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -111,7 +111,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 }
 
 /**
- * exit_to_user_mode - Fixup state when exiting to user mode
+ * __exit_to_user_mode - Fixup state when exiting to user mode
  *
  * Syscall/interupt exit enables interrupts, but the kernel state is
  * interrupts disabled when this is invoked. Also tell RCU about it.
@@ -122,7 +122,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
  *    mitigations, etc.
  * 4) Tell lockdep that interrupts are enabled
  */
-static __always_inline void exit_to_user_mode(void)
+static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
@@ -265,7 +265,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
@@ -278,7 +278,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
-- 
2.17.1

