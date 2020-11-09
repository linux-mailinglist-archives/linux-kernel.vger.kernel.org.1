Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC412AB6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgKILWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:22:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44164 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgKILWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:22:09 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BDodl109794;
        Mon, 9 Nov 2020 11:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=UW0VIDt1iiUlHKb4j989DFWx4AVfytJw/CLC5IrAf7U=;
 b=DKf3qrIIJA6mokW7+865xHCeFjeDyrr6A85E/MI8J+DcnNwweJtF87beBtPqJrROks7I
 TT/25PzQmMqtT7tVAd3mZExp2dRzhVR8DPHm3vCBelmaqD0EosiaDmOjVdl1HbHQXWdw
 aW3Co4ZlA3fjNXLMwGdZduoFxN0TNx40+uTQiyu/oU7tUJyuHu/Xhqr6c/s/mt9+82Ck
 H1UHT7sxAkCx7K5xrNtSkw7CC28qnYxugew101b3dkxX1O+EeAzZOq16hWETohmwi0ye
 b33bjUnwhLCjr4UpZKYJEVut4SIGjGd14H4qnos6tQGzTxhkymnRbG7l30q/JpB00hau rA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34nh3ankp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:21:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BKmgE147340;
        Mon, 9 Nov 2020 11:21:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34p5fxjvba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:21:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BLXLL014937;
        Mon, 9 Nov 2020 11:21:33 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:21:33 -0800
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
Subject: [RFC][PATCH 06/24] x86/pti: Provide C variants of PTI switch CR3 macros
Date:   Mon,  9 Nov 2020 12:23:01 +0100
Message-Id: <20201109112319.264511-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page Table Isolation (PTI) use assembly macros to switch the CR3
register between kernel and user page-tables. Add C functions which
implement the same features. For now, these C functions are not
used but they will eventually replace using the assembly macros.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/common.c             | 44 +++++++++++++++
 arch/x86/include/asm/entry-common.h | 84 +++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7ee15a12c115..d09b1ded5287 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -343,3 +343,47 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	}
 }
 #endif /* CONFIG_XEN_PV */
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+
+static __always_inline unsigned long save_and_switch_to_kernel_cr3(void)
+{
+	unsigned long cr3, saved_cr3;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return 0;
+
+	saved_cr3 = cr3 = __read_cr3();
+	if (cr3 & PTI_USER_PGTABLE_MASK) {
+		adjust_kernel_cr3(&cr3);
+		native_write_cr3(cr3);
+	}
+
+	return saved_cr3;
+}
+
+static __always_inline void restore_cr3(unsigned long cr3)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		if (cr3 & PTI_USER_PGTABLE_MASK)
+			adjust_user_cr3(&cr3);
+		else
+			cr3 |= X86_CR3_PCID_NOFLUSH;
+	}
+
+	native_write_cr3(cr3);
+}
+
+#else /* CONFIG_PAGE_TABLE_ISOLATION */
+
+static __always_inline unsigned long save_and_switch_to_kernel_cr3(void)
+{
+	return 0;
+}
+
+static __always_inline void restore_cr3(unsigned long cr3) {}
+
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 6fe54b2813c1..b05b212f5ebc 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -7,6 +7,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <asm/tlbflush.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_check_user_regs(struct pt_regs *regs)
@@ -81,4 +82,87 @@ static __always_inline void arch_exit_to_user_mode(void)
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+#ifndef MODULE
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+
+/*
+ * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
+ * halves:
+ */
+#define PTI_USER_PGTABLE_BIT		PAGE_SHIFT
+#define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
+#define PTI_USER_PCID_BIT		X86_CR3_PTI_PCID_USER_BIT
+#define PTI_USER_PCID_MASK		(1 << PTI_USER_PCID_BIT)
+#define PTI_USER_PGTABLE_AND_PCID_MASK  \
+	(PTI_USER_PCID_MASK | PTI_USER_PGTABLE_MASK)
+
+static __always_inline void adjust_kernel_cr3(unsigned long *cr3)
+{
+	if (static_cpu_has(X86_FEATURE_PCID))
+		*cr3 |= X86_CR3_PCID_NOFLUSH;
+
+	/*
+	 * Clear PCID and "PAGE_TABLE_ISOLATION bit", point CR3
+	 * at kernel pagetables.
+	 */
+	*cr3 &= ~PTI_USER_PGTABLE_AND_PCID_MASK;
+}
+
+static __always_inline void adjust_user_cr3(unsigned long *cr3)
+{
+	unsigned short mask;
+	unsigned long asid;
+
+	/*
+	 * Test if the ASID needs a flush.
+	 */
+	asid = *cr3 & 0x7ff;
+	mask = this_cpu_read(cpu_tlbstate.user_pcid_flush_mask);
+	if (mask & (1 << asid)) {
+		/* Flush needed, clear the bit */
+		this_cpu_and(cpu_tlbstate.user_pcid_flush_mask, ~(1 << asid));
+	} else {
+		*cr3 |= X86_CR3_PCID_NOFLUSH;
+	}
+}
+
+static __always_inline void switch_to_kernel_cr3(void)
+{
+	unsigned long cr3;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	cr3 = __read_cr3();
+	adjust_kernel_cr3(&cr3);
+	native_write_cr3(cr3);
+}
+
+static __always_inline void switch_to_user_cr3(void)
+{
+	unsigned long cr3;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	cr3 = __read_cr3();
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		adjust_user_cr3(&cr3);
+		/* Flip the ASID to the user version */
+		cr3 |= PTI_USER_PCID_MASK;
+	}
+
+	/* Flip the PGD to the user version */
+	cr3 |= PTI_USER_PGTABLE_MASK;
+	native_write_cr3(cr3);
+}
+
+#else /* CONFIG_PAGE_TABLE_ISOLATION */
+
+static inline void switch_to_kernel_cr3(void) {}
+static inline void switch_to_user_cr3(void) {}
+
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif /* MODULE */
+
 #endif
-- 
2.18.4

