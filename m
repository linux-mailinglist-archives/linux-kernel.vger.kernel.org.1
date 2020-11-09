Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013392ABF04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbgKIOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:43:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46978 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbgKIOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:43:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EXplf185443;
        Mon, 9 Nov 2020 14:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=UW0VIDt1iiUlHKb4j989DFWx4AVfytJw/CLC5IrAf7U=;
 b=vnxqlBbIS7K1GpNRM8HE3F4x2CjczyR7h+dnbpN2D+lUPa+FTf0wuJJVZ0ZSmQpnsb0y
 f0+ILpVIA1Tp7nJAgsOGbiVJNipNWu7sZNuZlIsO+tf5VDm15psDk9tnCsXiXu1qkPK+
 JMMnKW4jnjz83yO9yp0RWtyGvGca9zpdXkjzcH46ebDraJLgs/dYaXIFxWVO4SoThCjF
 NYw1Pm5I3CdcEUasrtNr00Epv7blrELP2ydEqx0luTm3udu5PsiI530TpvpY3AljrbWT
 yEQyjAUJSjrpZ3apsXvxBo+B+7Yf1RJ0sHvmbFQXjQIqHkrKAbtzrKA0lxi1DsMNI8fB iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ee4bi154643;
        Mon, 9 Nov 2020 14:42:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34p5gvbb6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:46 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9Egjvf018337;
        Mon, 9 Nov 2020 14:42:45 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:41 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 06/24] x86/pti: Provide C variants of PTI switch CR3 macros
Date:   Mon,  9 Nov 2020 15:44:07 +0100
Message-Id: <20201109144425.270789-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
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

