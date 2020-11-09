Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D067F2ABEFA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgKIOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:42:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46584 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgKIOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:42:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EYYKI186137;
        Mon, 9 Nov 2020 14:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=moHBvZsazE1U6yuvOGkS2t8B1QK80Cp4bKlBuUCXKfI=;
 b=WfH46heYnLJa2N1VXwcFP66L5L+j7b0pKDSYCSyPJmUKiUuGyDQZuDFEH539INQLWLcc
 S2NauWRTEhTqZ5jXxj91REDFlC15jPZiGMtCDWzV21MTdC/tYFUBd1IW6fdnZ2LKO4G0
 JsC4IB+VMyeuHElIvhyT/637VjZg37SuEFKcSRjsgFdluxhZXbTcw9lU4NXMRmX+NjZq
 wDae2ciXCMXXdC5nx6mC9JfH1/nVUYqjOBvft/5v9TiyIcrIi9Uzeqo8btOgIx4VtUgN
 drcz+yBifk3JbFmIOkGOYkuvqdQ7A8Wfc1TQnV+DvIW8qPFPrne1zRFG+dZTrsgvSTjc Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Eemoq174428;
        Mon, 9 Nov 2020 14:42:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34p5fxs16q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:23 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9EgLQE023416;
        Mon, 9 Nov 2020 14:42:21 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:21 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 01/24] x86/syscall: Add wrapper for invoking syscall function
Date:   Mon,  9 Nov 2020 15:44:02 +0100
Message-Id: <20201109144425.270789-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper function for invoking a syscall function.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/common.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 870efeec8bda..d222212908ad 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -35,6 +35,15 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
+static __always_inline void run_syscall(sys_call_ptr_t sysfunc,
+					struct pt_regs *regs)
+{
+	if (!sysfunc)
+		return;
+
+	regs->ax = sysfunc(regs);
+}
+
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
@@ -43,15 +52,16 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 	instrumentation_begin();
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
-		regs->ax = sys_call_table[nr](regs);
+		run_syscall(sys_call_table[nr], regs);
 #ifdef CONFIG_X86_X32_ABI
 	} else if (likely((nr & __X32_SYSCALL_BIT) &&
 			  (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
 		nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
 					X32_NR_syscalls);
-		regs->ax = x32_sys_call_table[nr](regs);
+		run_syscall(x32_sys_call_table[nr], regs);
 #endif
 	}
+
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
@@ -75,7 +85,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
 	if (likely(nr < IA32_NR_syscalls)) {
 		instrumentation_begin();
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call_table[nr](regs);
+		run_syscall(ia32_sys_call_table[nr], regs);
 		instrumentation_end();
 	}
 }
-- 
2.18.4

