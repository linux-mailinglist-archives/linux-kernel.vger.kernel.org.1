Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB74B2D6496
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392778AbgLJSMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:12:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403837AbgLJRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnOGg044303;
        Thu, 10 Dec 2020 17:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=EHI9EXTDB7bNKY9p6xmQoh3Jw5G8x8vXTTyZtM9sATw=;
 b=XQzFup8ZYfWJrHhuM9msSFtjXWvn4U6AW0JvUD+V8WFoJVbVqulunITnDS4DLaSrS1vj
 JruTvOemFPHd7+wqCx7K8ik0mXwMefpeOKCluvLTQkxOIrd+I7+Wc61l2YQbKqRZatnq
 ZTGaNo/RIFCcJERrJ/Y/Ft7+THJxSk+OzKvVrBPSleXkEwYd57gQG2WQbcFtoZ+VDGPd
 SPB8jVMwt7yLvQCpLMmJqcoGnooWQc62ZKpL57CWgjvgjW1tQYPlb62tqTAS46VH+Pbr
 0M55jhwMVOXFBHCZjmfVIY3NfeBp5Xavnjo5j1y7J/dSH0L0jW4+Hjo2gG+Q9g6KzpvY ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825mehfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:06:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGw0cL033196;
        Thu, 10 Dec 2020 17:04:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 358m52gban-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:45 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4ivD012779;
        Thu, 10 Dec 2020 17:04:44 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:43 -0800
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 09/28] mm/mmap: Change find_vma_prev() to use maple tree
Date:   Thu, 10 Dec 2020 12:03:43 -0500
Message-Id: <20201210170402.3468568-10-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the implementation of find_vma_prev to use the new maple tree
data structure.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 53876d66a27ea..3a9e04df021e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2510,23 +2510,30 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
 
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * sets %pprev to the previous VMA, if any.
+ * @mm The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
-			struct vm_area_struct **pprev)
+	      struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 
-	vma = find_vma(mm, addr);
-	if (vma) {
-		*pprev = vma->vm_prev;
-	} else {
-		struct rb_node *rb_node = rb_last(&mm->mm_rb);
+	rcu_read_lock();
+	vma = mas_find(&mas, ULONG_MAX);
+	if (!vma)
+		mas_reset(&mas);
 
-		*pprev = rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : NULL;
-	}
+	*pprev = mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return vma;
 }
 
-- 
2.28.0

