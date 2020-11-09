Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5562AB6A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgKILWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:22:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40514 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgKILWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:22:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BFBjX114129;
        Mon, 9 Nov 2020 11:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sA/qpNQZYyp3AGChk8UuSIB6lRELpgHThtDRjIeoLvs=;
 b=qgosfl/eqvXAnefZtkDvei2aA3YcXPuolfpZAH6mU49LAkNlE+1I8x40Hf3+UOT474V6
 z0JdRxmOQVFQ95paH1zpJpae6kmT8x+rBYnrO8Tm2swQjNbrE7Ks6I64n6VweO9yM+Ro
 2bVd6XVMl51Ko2/wGMiPQv9IeKtaLqhpFduFZ0eZeXkah6C0L78EblWH2zbKJTH1lrLu
 Pn+IALJxq5HT9kn/tK2mxSXO71dSn29lOezSFKXxPwalZdrPh4H+RaC9cMMQNdt95pcG
 jUOobdxzZKkctcAjj2DpH6Pb9PgmoSSmA+Kex//mvsIRa5O3O/OZHK1rTDL1x2HghvEU hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34p72ebk2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:21:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL0o0109323;
        Mon, 9 Nov 2020 11:21:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34p5bqd06u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:21:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BLf0b014960;
        Mon, 9 Nov 2020 11:21:41 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:21:41 -0800
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
Subject: [RFC][PATCH 08/24] x86/entry: Add C version of SWAPGS and SWAPGS_UNSAFE_STACK
Date:   Mon,  9 Nov 2020 12:23:03 +0100
Message-Id: <20201109112319.264511-9-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWAPGS and SWAPGS_UNSAFE_STACK are assembly macros. Add C versions
of these macros (swapgs() and swapgs_unsafe_stack()).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/paravirt.h       | 15 +++++++++++++++
 arch/x86/include/asm/paravirt_types.h | 17 ++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d25cc6830e89..a4898130b36b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -145,6 +145,21 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
+static inline void swapgs(void)
+{
+	PVOP_VCALL0(cpu.swapgs);
+}
+
+/*
+ * If swapgs is used while the userspace stack is still current,
+ * there's no way to call a pvop.  The PV replacement *must* be
+ * inlined, or the swapgs instruction must be trapped and emulated.
+ */
+static inline void swapgs_unsafe_stack(void)
+{
+	PVOP_VCALL0_ALT(cpu.swapgs, "swapgs");
+}
+
 static inline void arch_safe_halt(void)
 {
 	PVOP_VCALL0(irq.safe_halt);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0fad9f61c76a..eea9acc942a3 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -532,12 +532,12 @@ int paravirt_disable_iospace(void);
 		      pre, post, ##__VA_ARGS__)
 
 
-#define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, pre, post, ...)	\
+#define ____PVOP_VCALL(op, insn, clbr, call_clbr, extra_clbr, pre, post, ...) \
 	({								\
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(pre					\
-			     paravirt_alt(PARAVIRT_CALL)		\
+			     paravirt_alt(insn)				\
 			     post					\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
@@ -547,12 +547,17 @@ int paravirt_disable_iospace(void);
 	})
 
 #define __PVOP_VCALL(op, pre, post, ...)				\
-	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
-		       VEXTRA_CLOBBERS,					\
+	____PVOP_VCALL(op, PARAVIRT_CALL, CLBR_ANY,			\
+		       PVOP_VCALL_CLOBBERS, VEXTRA_CLOBBERS,		\
 		       pre, post, ##__VA_ARGS__)
 
+#define __PVOP_VCALL_ALT(op, insn)					\
+	____PVOP_VCALL(op, insn, CLBR_ANY,				\
+		       PVOP_VCALL_CLOBBERS, VEXTRA_CLOBBERS,		\
+		       "", "")
+
 #define __PVOP_VCALLEESAVE(op, pre, post, ...)				\
-	____PVOP_VCALL(op.func, CLBR_RET_REG,				\
+	____PVOP_VCALL(op.func, PARAVIRT_CALL, CLBR_RET_REG,		\
 		      PVOP_VCALLEE_CLOBBERS, ,				\
 		      pre, post, ##__VA_ARGS__)
 
@@ -562,6 +567,8 @@ int paravirt_disable_iospace(void);
 	__PVOP_CALL(rettype, op, "", "")
 #define PVOP_VCALL0(op)							\
 	__PVOP_VCALL(op, "", "")
+#define PVOP_VCALL0_ALT(op, insn)					\
+	__PVOP_VCALL_ALT(op, insn)
 
 #define PVOP_CALLEE0(rettype, op)					\
 	__PVOP_CALLEESAVE(rettype, op, "", "")
-- 
2.18.4

