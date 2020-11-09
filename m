Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B912ABF19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgKIOp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:45:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgKIOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:45:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EhsB4194699;
        Mon, 9 Nov 2020 14:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=AJUnYl9q2aFNqQHIPc035IxF21kJkzcWxb0zMqd1WJ4=;
 b=hLnG20WPec9zou2miRkoQr7w0u/ilagZJ64AvL5VzJgfPJCUzj1zcTDaQNENqIFEuyO3
 B/vPc6Fw9k+LcV2wUnoMLHeEL77nwXx0uSL/wdSOmXAFtwV/JOSMYn9cvcgryEACWX33
 K49RYPp968QMju2vQlUHsHXyfjqJRIxspFYa8e2cNrhR98wAk4Taj8DpccvayloaJGvA
 FSpV8IH6FzB/PV0pm8FGF3rQUubXbnlHIXr+wl/c2O3Dp+fjobfdo9xthJY9t0NwyZsV
 PXMfXzoEnk5+zys7MpcO1M6o3cUphpdbD8FnTkzswdhtzBSY1J6pYqC6o4fM1Qz/R0US PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhkp84p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:45:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ef1T2138978;
        Mon, 9 Nov 2020 14:43:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34p5bqkakt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:06 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9Eh5CN013312;
        Mon, 9 Nov 2020 14:43:05 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:03 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 11/24] x86/pti: Function to clone page-table entries from a specified mm
Date:   Mon,  9 Nov 2020 15:44:12 +0100
Message-Id: <20201109144425.270789-12-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTI has a function to clone page-table entries but only from the
init_mm page-table. Provide a new function to clone page-table
entries from a specified mm page-table.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/pti.h | 10 ++++++++++
 arch/x86/mm/pti.c          | 32 ++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 07375b476c4f..5484e69ff8d3 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -4,9 +4,19 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
+
+enum pti_clone_level {
+	PTI_CLONE_PMD,
+	PTI_CLONE_PTE,
+};
+
+struct mm_struct;
+
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
 extern void pti_finalize(void);
+extern void pti_clone_pgtable(struct mm_struct *mm, unsigned long start,
+			      unsigned long end, enum pti_clone_level level);
 #else
 static inline void pti_check_boottime_disable(void) { }
 #endif
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1aab92930569..ebc8cd2f1cd8 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -294,14 +294,8 @@ static void __init pti_setup_vsyscall(void)
 static void __init pti_setup_vsyscall(void) { }
 #endif
 
-enum pti_clone_level {
-	PTI_CLONE_PMD,
-	PTI_CLONE_PTE,
-};
-
-static void
-pti_clone_pgtable(unsigned long start, unsigned long end,
-		  enum pti_clone_level level)
+void pti_clone_pgtable(struct mm_struct *mm, unsigned long start,
+		       unsigned long end, enum pti_clone_level level)
 {
 	unsigned long addr;
 
@@ -320,7 +314,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 		if (addr < start)
 			break;
 
-		pgd = pgd_offset_k(addr);
+		pgd = pgd_offset(mm, addr);
 		if (WARN_ON(pgd_none(*pgd)))
 			return;
 		p4d = p4d_offset(pgd, addr);
@@ -409,6 +403,12 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 	}
 }
 
+static void pti_clone_init_pgtable(unsigned long start, unsigned long end,
+				   enum pti_clone_level level)
+{
+	pti_clone_pgtable(&init_mm, start, end, level);
+}
+
 #ifdef CONFIG_X86_64
 /*
  * Clone a single p4d (i.e. a top-level entry on 4-level systems and a
@@ -476,7 +476,7 @@ static void __init pti_clone_user_shared(void)
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
+	pti_clone_init_pgtable(start, end, PTI_CLONE_PMD);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -495,9 +495,9 @@ static void __init pti_setup_espfix64(void)
  */
 static void pti_clone_entry_text(void)
 {
-	pti_clone_pgtable((unsigned long) __entry_text_start,
-			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+	pti_clone_init_pgtable((unsigned long) __entry_text_start,
+			       (unsigned long) __entry_text_end,
+			       PTI_CLONE_PMD);
 }
 
 /*
@@ -572,11 +572,11 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
+	pti_clone_init_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
 
 	/*
-	 * pti_clone_pgtable() will set the global bit in any PMDs
-	 * that it clones, but we also need to get any PTEs in
+	 * pti_clone_init_pgtable() will set the global bit in any
+	 * PMDs that it clones, but we also need to get any PTEs in
 	 * the last level for areas that are not huge-page-aligned.
 	 */
 
-- 
2.18.4

