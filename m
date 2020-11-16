Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0132B4658
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgKPOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:48:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57228 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKPOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:48:41 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjXxL034206;
        Mon, 16 Nov 2020 14:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=LvZqNY30cX/oqo/N4EBwNWLkXM73qYHnqXz+hQZcxt0=;
 b=r5qaWRcnedG+daegWmFcmmx3KxorjQb/Oo06S10uwdjducnNBXlkHdtWIslacbR+xwBi
 iz82OjX0vN0LvCs6yB9yjDLo22EaX20hU0faaQ2GVNjzBAQQQzFS1XDJsAp2Y90yFUdt
 GmB/VRpxPmEBMDbU56ORhN9bDb8eJC/kUbBop+QeP0ELmwFzyLof9n2bSUM8TMEKactK
 EgtihKaA8+Z/q3Va2m2IxkTDXB6IkciHWFou84b4Zc8cNbFHabrGQV7YWRwIwAX5s8gv
 KyvdOAh5kp/mPIv92cjLCbWjOfKIPsOuTmxxgANpigrl1lri4X+lMkcpuIadBlJY/mKr Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vmwb47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:48:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjVbl056070;
        Mon, 16 Nov 2020 14:46:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34usps3stk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:46:19 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEkIsR024720;
        Mon, 16 Nov 2020 14:46:18 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:18 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 06/21] x86/pti: Provide C variants of PTI switch CR3 macros
Date:   Mon, 16 Nov 2020 15:47:42 +0100
Message-Id: <20201116144757.1920077-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Page Table Isolation (PTI) use assembly macros to switch the CR3
register between kernel and user page-tables. Add C functions which
implement the same features. For now, these C functions are not
used but they will eventually replace using the assembly macros.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/entry-common.h | 127 ++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 6fe54b2813c1..46682b1433a4 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -7,6 +7,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <asm/tlbflush.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_check_user_regs(struct pt_regs *regs)
@@ -81,4 +82,130 @@ static __always_inline void arch_exit_to_user_mode(void)
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
+static __always_inline void write_kernel_cr3(unsigned long cr3)
+{
+	if (static_cpu_has(X86_FEATURE_PCID))
+		cr3 |= X86_CR3_PCID_NOFLUSH;
+
+	native_write_cr3(cr3);
+}
+
+static __always_inline void write_user_cr3(unsigned long cr3)
+{
+	unsigned short mask;
+	unsigned long asid;
+
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		/*
+		 * Test if the ASID needs a flush.
+		 */
+		asid = cr3 & 0x7ff;
+		mask = this_cpu_read(cpu_tlbstate.user_pcid_flush_mask);
+		if (mask & (1 << asid)) {
+			/* Flush needed, clear the bit */
+			this_cpu_and(cpu_tlbstate.user_pcid_flush_mask,
+				     ~(1 << asid));
+		} else {
+			cr3 |= X86_CR3_PCID_NOFLUSH;
+		}
+	}
+
+	native_write_cr3(cr3);
+}
+
+static __always_inline void switch_to_kernel_cr3(unsigned long cr3)
+{
+	/*
+	 * Clear PCID and "PAGE_TABLE_ISOLATION bit", point CR3
+	 * at kernel pagetables.
+	 */
+	write_kernel_cr3(cr3 & ~PTI_USER_PGTABLE_AND_PCID_MASK);
+}
+
+static __always_inline void switch_to_user_cr3(unsigned long cr3)
+{
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		/* Flip the ASID to the user version */
+		cr3 |= PTI_USER_PCID_MASK;
+	}
+
+	/* Flip the PGD to the user version */
+	write_user_cr3(cr3 | PTI_USER_PGTABLE_MASK);
+}
+
+static __always_inline unsigned long save_and_switch_to_kernel_cr3(void)
+{
+	unsigned long cr3;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return 0;
+
+	cr3 = __native_read_cr3();
+	if (cr3 & PTI_USER_PGTABLE_MASK)
+		switch_to_kernel_cr3(cr3);
+
+	return cr3;
+}
+
+static __always_inline void restore_cr3(unsigned long cr3)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	if (cr3 & PTI_USER_PGTABLE_MASK) {
+		switch_to_user_cr3(cr3);
+	} else {
+		/*
+		 * The CR3 write could be avoided when not changing
+		 * its value, but would require a CR3 read.
+		 */
+		write_kernel_cr3(cr3);
+	}
+}
+
+static __always_inline void user_pagetable_enter(void)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	switch_to_user_cr3(__native_read_cr3());
+}
+
+static __always_inline void user_pagetable_exit(void)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	switch_to_kernel_cr3(__native_read_cr3());
+}
+
+
+#else /* CONFIG_PAGE_TABLE_ISOLATION */
+
+static __always_inline unsigned long save_and_switch_to_kernel_cr3(void)
+{
+	return 0;
+}
+static __always_inline void restore_cr3(unsigned long cr3) {}
+
+static __always_inline void user_pagetable_enter(void) {};
+static __always_inline void user_pagetable_exit(void) {};
+
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif /* MODULE */
+
 #endif
-- 
2.18.4

