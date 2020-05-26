Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1FE1C3D92
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgEDOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 10:51:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38002 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEDOvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:51:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9le024704;
        Mon, 4 May 2020 14:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Hw8EHa7s5kuPup58M+aztcjQP7OcZEWmGUe+ltkfQS8=;
 b=S/XXinXDNwkGl1a9virUpZ6znnfR5WHBbm0PASLZbG6/Nvz6L5GOMKA3lJlUX5u9Vvft
 PYuZh8gDmX47NAYHOLnsTgkVpDqlX7itpoTqu6V36zIRqL5MQYV0YTJJyv3FIE8G9P2N
 +0ZoBlHMkq8Dmdeta5YVqSujVcfpONrZw/RYwnAqy5CQWMja3etewQmyMkUP4+38eQ7K
 G3CPbhoQVm0NfHu9rg30d3UHJuLQZxl8QbPgIya9tvWj9Gp7hyw1VjSMwQR2pzM91rJW
 mcdtRv2GmhUoQYWsKaQqCy7ypq7U1FD3j/ftsVj3T1K1UIYHUnoue/QLUGv9rQVHW7lC Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30s0tm7bk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elb6P053467;
        Mon, 4 May 2020 14:51:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r2e0y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044Ep9YN022491;
        Mon, 4 May 2020 14:51:09 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:51:08 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-1 2/7] mm/asi: ASI entry/exit interface
Date:   Mon,  4 May 2020 16:49:34 +0200
Message-Id: <20200504144939.11318-3-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504144939.11318-1-alexandre.chartre@oracle.com>
References: <20200504144939.11318-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address Space Isolation (ASI) is entered by calling asi_enter() which
switches the kernel page-table to the ASI page-table. Isolation is then
exited by calling asi_exit() which switches the page-table back to the
original kernel page-table.

The ASI being used and its state is tracked in a per-cpu ASI session
structure (struct asi_session).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h         |  4 ++
 arch/x86/include/asm/asi_session.h | 17 ++++++
 arch/x86/include/asm/mmu_context.h | 19 ++++++-
 arch/x86/include/asm/tlbflush.h    | 12 ++++
 arch/x86/mm/asi.c                  | 90 ++++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/asi_session.h

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 844a81fb84d2..29b745ab393e 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -44,6 +44,8 @@
 
 #include <linux/export.h>
 
+#include <asm/asi_session.h>
+
 struct asi_type {
 	int			pcid_prefix;	/* PCID prefix */
 };
@@ -80,6 +82,8 @@ struct asi {
 extern struct asi *asi_create(struct asi_type *type);
 extern void asi_destroy(struct asi *asi);
 extern void asi_set_pagetable(struct asi *asi, pgd_t *pagetable);
+extern int asi_enter(struct asi *asi);
+extern void asi_exit(struct asi *asi);
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/asi_session.h b/arch/x86/include/asm/asi_session.h
new file mode 100644
index 000000000000..9d39c936a4ee
--- /dev/null
+++ b/arch/x86/include/asm/asi_session.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_X86_MM_ASI_SESSION_H
+#define ARCH_X86_MM_ASI_SESSION_H
+
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+
+struct asi;
+
+struct asi_session {
+	struct asi		*asi;		/* ASI for this session */
+	unsigned long		isolation_cr3;	/* cr3 when ASI is active */
+	unsigned long		original_cr3;	/* cr3 before entering ASI */
+};
+
+#endif	/* CONFIG_ADDRESS_SPACE_ISOLATION */
+
+#endif
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 4e55370e48e8..9b03bad00b81 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/asi.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -234,8 +235,22 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
  */
 static inline unsigned long __get_current_cr3_fast(void)
 {
-	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
-		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+	unsigned long cr3;
+
+	/*
+	 * If isolation is active then we need to return the CR3 for the
+	 * currently active ASI. This value is stored in the isolation_cr3
+	 * field of the ASI session.
+	 */
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION) &&
+	    this_cpu_read(cpu_asi_session.asi)) {
+		cr3 = this_cpu_read(cpu_asi_session.isolation_cr3);
+		/* CR3 read never returns with the NOFLUSH bit */
+		cr3 &= ~X86_CR3_PCID_NOFLUSH;
+	} else {
+		cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+				this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+	}
 
 	/* For now, be very restrictive about when this can be called. */
 	VM_WARN_ON(in_nmi() || preemptible());
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6f66d841262d..241058ff63ba 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -12,6 +12,7 @@
 #include <asm/invpcid.h>
 #include <asm/pti.h>
 #include <asm/processor-flags.h>
+#include <asm/asi.h>
 
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -239,9 +240,20 @@ struct tlb_state {
 	 * context 0.
 	 */
 	struct tlb_context ctxs[TLB_NR_DYN_ASIDS];
+
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	/*
+	 * The ASI session tracks the ASI being used and its state.
+	 */
+	struct asi_session asi_session;
+#endif
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
 
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+#define cpu_asi_session	(cpu_tlbstate.asi_session)
+#endif
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 0a0ac9d6d078..9fbc92122ce2 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -10,6 +10,8 @@
 
 #include <asm/asi.h>
 #include <asm/bug.h>
+#include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
 
 struct asi *asi_create(struct asi_type *type)
 {
@@ -58,3 +60,91 @@ void asi_set_pagetable(struct asi *asi, pgd_t *pagetable)
 
 }
 EXPORT_SYMBOL(asi_set_pagetable);
+
+static void asi_switch_to_asi_cr3(struct asi *asi)
+{
+	unsigned long original_cr3, asi_cr3;
+	struct asi_session *asi_session;
+	u16 pcid;
+
+	WARN_ON(!irqs_disabled());
+
+	original_cr3 = __get_current_cr3_fast();
+
+	/* build the ASI cr3 value */
+	asi_cr3 = asi->base_cr3;
+	if (boot_cpu_has(X86_FEATURE_PCID)) {
+		pcid = original_cr3 & ASI_KERNEL_PCID_MASK;
+		asi_cr3 |= pcid;
+	}
+
+	/* get the ASI session ready for entering ASI */
+	asi_session = &get_cpu_var(cpu_asi_session);
+	asi_session->asi = asi;
+	asi_session->original_cr3 = original_cr3;
+	asi_session->isolation_cr3 = asi_cr3;
+
+	/* Update CR3 to immediately enter ASI */
+	native_write_cr3(asi_cr3);
+}
+
+static void asi_switch_to_kernel_cr3(struct asi *asi)
+{
+	struct asi_session *asi_session;
+	unsigned long original_cr3;
+
+	WARN_ON(!irqs_disabled());
+
+	original_cr3 = this_cpu_read(cpu_asi_session.original_cr3);
+	if (boot_cpu_has(X86_FEATURE_PCID))
+		original_cr3 |= X86_CR3_PCID_NOFLUSH;
+	native_write_cr3(original_cr3);
+
+	asi_session = &get_cpu_var(cpu_asi_session);
+	asi_session->asi = NULL;
+}
+
+int asi_enter(struct asi *asi)
+{
+	struct asi *current_asi;
+	unsigned long flags;
+
+	/*
+	 * We can re-enter isolation, but only with the same ASI (we don't
+	 * support nesting isolation).
+	 */
+	current_asi = this_cpu_read(cpu_asi_session.asi);
+	if (current_asi) {
+		if (current_asi != asi) {
+			WARN_ON(1);
+			return -EBUSY;
+		}
+		return 0;
+	}
+
+	local_irq_save(flags);
+	asi_switch_to_asi_cr3(asi);
+	local_irq_restore(flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(asi_enter);
+
+void asi_exit(struct asi *asi)
+{
+	struct asi *current_asi;
+	unsigned long flags;
+
+	current_asi = this_cpu_read(cpu_asi_session.asi);
+	if (!current_asi) {
+		/* already exited */
+		return;
+	}
+
+	WARN_ON(current_asi != asi);
+
+	local_irq_save(flags);
+	asi_switch_to_kernel_cr3(asi);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(asi_exit);
-- 
2.18.2

