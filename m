Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB572AB6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgKILYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:24:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42288 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgKILYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:24:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BFBjf114129;
        Mon, 9 Nov 2020 11:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=AJUnYl9q2aFNqQHIPc035IxF21kJkzcWxb0zMqd1WJ4=;
 b=PJMTRxvQulCA4nNzcGMVtiIVQasfS/90GSCauX2zTZUltL/oU03D7XcWZaMoRb2uLNEg
 NMGXnkMD0FQqywincPKn0gP23a3kWgTC8dHBp0fYEBb5Tx0RmNO0DFDp/5fWNsH/CEnO
 05yKbDZNvxCV6xPGbbFdLNTqVDE8+iFpEd26eSbPVoWC2boMJQYl5o+CoHXioxP2XjG2
 1CZsHvHfOCyLJ4lJObIrDcBWN5o4AzY2ou0R2l4xsExuYro8UeYUGdSBRzF4nbz9kImZ
 Qj2jYO7ogV7SLRi1ix5kl1QIItzyf9TfkJawDrEN3RGD9LbgS+fBCAhdJgQF8dzck3Fm Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72ebkb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:23:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BK5iH116573;
        Mon, 9 Nov 2020 11:21:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34p5gv4wtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:21:57 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BLtRl028968;
        Mon, 9 Nov 2020 11:21:55 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:21:55 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@userv0121.oracle.com,
        "mingo@redhat.com"@userv0121.oracle.com,
        "bp@alien8.de"@userv0121.oracle.com,
        "hpa@zytor.com"@userv0121.oracle.com,
        "x86@kernel.org"@userv0121.oracle.com,
        "dave.hansen@linux.intel.com"@userv0121.oracle.com,
        "luto@kernel.org"@userv0121.oracle.com,
        "peterz@infradead.org"@userv0121.oracle.com,
        "linux-kernel@vger.kernel.org"@userv0121.oracle.com,
        "thomas.lendacky@amd.com"@userv0121.oracle.com,
        "jroedel@suse.de"@userv0121.oracle.com
Cc:     "konrad.wilk@oracle.com"@userv0121.oracle.com,
        "jan.setjeeilers@oracle.com"@userv0121.oracle.com,
        "junaids@google.com"@userv0121.oracle.com,
        "oweisse@google.com"@userv0121.oracle.com,
        "rppt@linux.vnet.ibm.com"@userv0121.oracle.com,
        "graf@amazon.de"@userv0121.oracle.com,
        "mgross@linux.intel.com"@userv0121.oracle.com,
        "kuzuno@gmail.com"@userv0121.oracle.com,
        "alexandre.chartre@oracle.com"@userv0121.oracle.com
Subject: [RFC][PATCH 11/24] x86/pti: Function to clone page-table entries from a specified mm
Date:   Mon,  9 Nov 2020 12:23:06 +0100
Message-Id: <20201109112319.264511-12-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
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

