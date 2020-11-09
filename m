Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBB2ABF12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbgKIOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:44:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbgKIOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:44:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EXior185360;
        Mon, 9 Nov 2020 14:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sA/qpNQZYyp3AGChk8UuSIB6lRELpgHThtDRjIeoLvs=;
 b=R42XtPd5Dj09GXKZCffm5rVBnor2o0GkfVyYKoiLVDz7Td4BJ8teItXl3RtrIHTKKhlG
 yJiIiYIROj4N25JV6KMXaQeh+PkJdwSvmAE/ARilHa2dQNp/OhNggMR4LjIQNQM5kptR
 w9UPXJIOz0QKLOkmeeA6UijR86lGLEbfEsf5yrqJFhNDHbgbrwkXczq4kNIx//5JeUOI
 FHy95gZx6dgEEm1ttXtSmbJq1cQQzln41duJgN16Qdl5YXiVt6zMHXw9m33IEF+BasP1
 t/QFQHDm8rHxlgkYoIQ14HmDZFKyZU0T81dLfxLdAJOhzRIe6B5+ByDfQZEfqZXDKZbs vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EenFB174623;
        Mon, 9 Nov 2020 14:42:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34p5fxs1m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9EgpUh023770;
        Mon, 9 Nov 2020 14:42:51 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:51 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 08/24] x86/entry: Add C version of SWAPGS and SWAPGS_UNSAFE_STACK
Date:   Mon,  9 Nov 2020 15:44:09 +0100
Message-Id: <20201109144425.270789-9-alexandre.chartre@oracle.com>
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

