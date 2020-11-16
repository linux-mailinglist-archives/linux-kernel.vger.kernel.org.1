Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC882B462A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgKPOq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:46:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54970 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgKPOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:46:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjXx9034206;
        Mon, 16 Nov 2020 14:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=moHBvZsazE1U6yuvOGkS2t8B1QK80Cp4bKlBuUCXKfI=;
 b=z5GK9uC2aM0UaQGSAf1SJtn0J5ei3hJ6fvgfzocWk6C39HgTjeeS9ylstBiyt+zpttlr
 Rz823Z809hnJ/v4MEmSXpoO+z4nX8I5sv5VpS74/4/1Bh9CsCIkh9NtKz5iUjs3fj7rK
 DBtPhc8wst4+gg+JCsUAXHm3XrUTKlY2iemoRIhgzi++9oWdXHKP8mYTjXJbrqylAtbK
 Cw2lt9LPU7+xU9KthwOta7+UbAeA1FiiBShrKx40fUas2hc1NE8rQbGm0M5FZGus7xrp
 +ed/lbr+COdKN1LYKcE2mSijvOWiWbArAORPqRGYGmnBtDBoSuV6MnhkKhL1YN9/BOPN 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vmwam0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:45:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjPap051679;
        Mon, 16 Nov 2020 14:45:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ts0phaha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:45:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEjpxi024535;
        Mon, 16 Nov 2020 14:45:51 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:45:49 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 01/21] x86/syscall: Add wrapper for invoking syscall function
Date:   Mon, 16 Nov 2020 15:47:37 +0100
Message-Id: <20201116144757.1920077-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
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

