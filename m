Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A692F355A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406131AbhALQQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:16:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55884 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405691AbhALQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9WZ1086475;
        Tue, 12 Jan 2021 16:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=5JMKG5mzngO+DSmQ38/aX+NCjBemRbcIpRNfQpqvLQQ=;
 b=u79uZI2SbKAnFMxgjdSKANDXCdiROsSR/4jiC4PchPJUlklDiF9iZERIGLndh2aKPDWE
 yg0F05q4HrPbWz+dlO8W1N39xDIRM2qJrozw1EXX/FnPO+WuYI5S2DsdirMJjEoSNVNO
 rnLWcHACGAAEcU6kvL2BfW4KL9d/c91YRH3iDAdZe4S9nc/2BCPES3D+n/afR7WDv5yz
 EHXRi5Lczta1bHMwJAsV4HRnDszZRRChMOHM/BlfU/MsNsjE2jrA9kqqXDREnW5CLimP
 XhXvsP7XE6Bxd7FPMhg3rv0ynXirbMK5ovMU/yH0TTPv+K4o7qnuFXq8r6OdCtIoOJyf YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg1q54t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:15:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBaNn143216;
        Tue, 12 Jan 2021 16:13:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 360ke6rg2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGD8Iu019404;
        Tue, 12 Jan 2021 16:13:08 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:07 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 08/70] mm/mmap: Change find_vma() to use the maple tree
Date:   Tue, 12 Jan 2021 11:11:38 -0500
Message-Id: <20210112161240.2024684-9-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start using the maple tree to find VMA entries in an mm_struct.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 65789b188c380..ab1cb0efc4c65 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2474,10 +2474,17 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 EXPORT_SYMBOL(get_unmapped_area);
 
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.  May return
+ * NULL in the case of no vma at addr or above
+ * @mm The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA assoicated with addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
 
 	/* Check the cache first. */
@@ -2485,24 +2492,10 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 	if (likely(vma))
 		return vma;
 
-	rb_node = mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma = tmp;
-			if (tmp->vm_start <= addr)
-				break;
-			rb_node = rb_node->rb_left;
-		} else
-			rb_node = rb_node->rb_right;
-	}
-
+	vma = mt_find(&mm->mm_mt, &addr, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
+
 	return vma;
 }
 EXPORT_SYMBOL(find_vma);
-- 
2.28.0

