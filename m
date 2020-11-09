Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F335F2AB6A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgKILWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:22:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56462 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgKILWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:22:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BETlu023354;
        Mon, 9 Nov 2020 11:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=moHBvZsazE1U6yuvOGkS2t8B1QK80Cp4bKlBuUCXKfI=;
 b=v85qIcineTcrAg+DWee3BRlHJdX2P5HNQPtFwX7edVsG5+0CnSJ25uf+WJIgMkG7JSX1
 r1gTGy1fcGrSoD6le0eokRRaImrCCvFcEtpwJp49Ds1Y+bIJbgkZk2wwubAeSnpyT3/C
 MxjcUISO6qgR3J5YWV/QET+8kiyQ7ssLm5DclxhAhSJe6U8JQIXcqpVqOOkrPvWCqr7j
 kcATSTPxcdV8nHobJt8czvHNe7OXEQPpe0305d1uju3+P+bVsje+Vah7KWxAejY5Pg36
 p82qUtXXWRdl6xbxHkPiNCH1pIwcl5pqIdseWKDPc4jRqOhmOOWWu867ekRF7y1cTzi0 QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34nkhknd1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:21:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL90u177805;
        Mon, 9 Nov 2020 11:21:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55ku18p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:21:18 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BLC91014684;
        Mon, 9 Nov 2020 11:21:14 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:21:12 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@aserv0122.oracle.com,
        "mingo@redhat.com"@aserv0122.oracle.com,
        "bp@alien8.de"@aserv0122.oracle.com,
        "hpa@zytor.com"@aserv0122.oracle.com,
        "x86@kernel.org"@aserv0122.oracle.com,
        "dave.hansen@linux.intel.com"@aserv0122.oracle.com,
        "luto@kernel.org"@aserv0122.oracle.com,
        "peterz@infradead.org"@aserv0122.oracle.com,
        "linux-kernel@vger.kernel.org"@aserv0122.oracle.com,
        "thomas.lendacky@amd.com"@aserv0122.oracle.com,
        "jroedel@suse.de"@aserv0122.oracle.com
Cc:     "konrad.wilk@oracle.com"@aserv0122.oracle.com,
        "jan.setjeeilers@oracle.com"@aserv0122.oracle.com,
        "junaids@google.com"@aserv0122.oracle.com,
        "oweisse@google.com"@aserv0122.oracle.com,
        "rppt@linux.vnet.ibm.com"@aserv0122.oracle.com,
        "graf@amazon.de"@aserv0122.oracle.com,
        "mgross@linux.intel.com"@aserv0122.oracle.com,
        "kuzuno@gmail.com"@aserv0122.oracle.com,
        "alexandre.chartre@oracle.com"@aserv0122.oracle.com
Subject: [RFC][PATCH 01/24] x86/syscall: Add wrapper for invoking syscall function
Date:   Mon,  9 Nov 2020 12:22:56 +0100
Message-Id: <20201109112319.264511-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
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

