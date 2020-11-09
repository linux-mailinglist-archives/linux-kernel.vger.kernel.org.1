Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCEA2ABF1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgKIOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:45:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35910 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgKIOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:45:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EhnU4101173;
        Mon, 9 Nov 2020 14:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Xq5eQPfc3P6TGV2Hb1yqqRoCT3aVbMxarpCghCFU5UU=;
 b=AMrvjGvF5t/7UHbPJmyZjmxxkaGRmiPg6rGXkg60I7YX6A9GqRdbCsHDiGOXTIfUj+ZB
 Y37cTr+H1/DVPsae2d2bL3OKclUpthM2eQmDVZ6Rk8S4MqeO1ZCsc3YFilzTPo/BaTY0
 xb1U1p1D775zgLWf5nUP6IQCbKAQxq0ZYLW2hys9hTncbxyFtjoqp2weBDFKpIlrIcDV
 Clowpu5BK93opUJDoc76mcZUy/01Cc1pFziaHTsl4NPpLR/HyaEAJsv5mfWAWyK4HNTj
 PDyLqKVHv9EgovpJnOH/bBO+c345wUyjSw531J+epVZkWNRmPPs4HmJYlkueby+bvOZi jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34nh3apekb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:45:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Eem6I174408;
        Mon, 9 Nov 2020 14:43:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34p5fxs1y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9Eh9tg023958;
        Mon, 9 Nov 2020 14:43:09 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:08 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 12/24] x86/pti: Function to map per-cpu page-table entry
Date:   Mon,  9 Nov 2020 15:44:13 +0100
Message-Id: <20201109144425.270789-13-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
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

