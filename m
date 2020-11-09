Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F82AB6B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgKILYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:24:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgKILYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:24:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BNs27030674;
        Mon, 9 Nov 2020 11:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Xq5eQPfc3P6TGV2Hb1yqqRoCT3aVbMxarpCghCFU5UU=;
 b=aaUGufq+aG4ufBbZNDj5XpVtnruDa37OMeu847cbG/VBaERWJ3u43Snl+qGgaqKZnQvA
 IqGW7bZlhvW/raSeOG/XB3qeNJD2/CjhJQ+wrQxf33RpTNiSnQnQDnbNnaWOv1ML6Je8
 qV9GXxICjNr5/5d9ouHTAC+kd8oWGlP7pl+wIy9wQ7ZnpTYXvY44NDUNmhQQ6dvR5aWc
 yRgKrTR7+69k54z7epi0jlRPYkA2V8UkbdB5mI40ksY86POZG5FNaPYnxZSS9vDGLACA
 Bjl+J19zzEcaLwXtNZ3t8UiMSKJ8VlqC0eWcLZyt7xygRGrVEANJv9fQ3S+nEDqgDoPV aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkndcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:24:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BK5Xt116562;
        Mon, 9 Nov 2020 11:22:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34p5gv4wxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BLxSs015021;
        Mon, 9 Nov 2020 11:21:59 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:21:59 -0800
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
Subject: [RFC][PATCH 12/24] x86/pti: Function to map per-cpu page-table entry
Date:   Mon,  9 Nov 2020 12:23:07 +0100
Message-Id: <20201109112319.264511-13-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the code used by PTI to map a per-cpu page-table entry into
a new function so that this code can be re-used to map other
per-cpu entries.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/mm/pti.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ebc8cd2f1cd8..71ca245d7b38 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -428,6 +428,21 @@ static void __init pti_clone_p4d(unsigned long addr)
 	*user_p4d = *kernel_p4d;
 }
 
+/*
+ * Clone a single percpu page.
+ */
+static void __init pti_clone_percpu_page(void *addr)
+{
+	phys_addr_t pa = per_cpu_ptr_to_phys(addr);
+	pte_t *target_pte;
+
+	target_pte = pti_user_pagetable_walk_pte((unsigned long)addr);
+	if (WARN_ON(!target_pte))
+		return;
+
+	*target_pte = pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL);
+}
+
 /*
  * Clone the CPU_ENTRY_AREA and associated data into the user space visible
  * page table.
@@ -448,16 +463,8 @@ static void __init pti_clone_user_shared(void)
 		 * This is done for all possible CPUs during boot to ensure
 		 * that it's propagated to all mms.
 		 */
+		pti_clone_percpu_page(&per_cpu(cpu_tss_rw, cpu));
 
-		unsigned long va = (unsigned long)&per_cpu(cpu_tss_rw, cpu);
-		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
-		pte_t *target_pte;
-
-		target_pte = pti_user_pagetable_walk_pte(va);
-		if (WARN_ON(!target_pte))
-			return;
-
-		*target_pte = pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL);
 	}
 }
 
-- 
2.18.4

