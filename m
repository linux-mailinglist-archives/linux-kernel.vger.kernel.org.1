Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74F2B4651
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgKPOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:48:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34118 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgKPOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:48:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiMPl143581;
        Mon, 16 Nov 2020 14:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Xq5eQPfc3P6TGV2Hb1yqqRoCT3aVbMxarpCghCFU5UU=;
 b=xB0oLl21ZDd3PY3EngdGXv/L/C96ndliVRFK8tjMCTicm4YGddtVWwY5tEq9AlIDjOWG
 9u2BgErEPmNgE2zuWGFPPYngHqTYc4ve4BC1fHUIkErE7bCV/t4rW8PPjjuLqFlw+bM4
 xxhaoIAXi+rmNKjPM0txxtEtXkFOjPQXmFYSDHbg8wBtGGDjQ3Om5IWH4XtyNQ20c7Ek
 VEaJdd0Fe+BS/bMf16z+3tZW2/JlYzjPkZlwxNZLGDmUhoQb3L8Arjs6N8yVf5VWa6SR
 RlS2o31IUuHZo4OL+rwd6YsUT35T7G1/Ev92YK6nYyATIFzw9DbILggAmqHBhFcQ9VcF MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34t4ranhjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:46:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjPN6051747;
        Mon, 16 Nov 2020 14:46:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34ts0phbd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:46:45 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGEkiU2014824;
        Mon, 16 Nov 2020 14:46:44 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:43 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 10/21] x86/pti: Function to map per-cpu page-table entry
Date:   Mon, 16 Nov 2020 15:47:46 +0100
Message-Id: <20201116144757.1920077-11-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
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

