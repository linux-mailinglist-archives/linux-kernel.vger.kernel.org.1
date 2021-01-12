Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984752F357D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406577AbhALQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:18:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406151AbhALQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFCJg007256;
        Tue, 12 Jan 2021 16:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=CPbrohTckVgEyhQtvclFHMkosrATpsDKnJLQsiQwSfc=;
 b=kPjLEXUUEU0lxrA0/+Ly/yNlBv2fDZsOD2J/L5A+a0IjAvu/yQUuZt6atI6Dj5SvMu0x
 0MBY7NznDMXitw3koBemTySO/GhqpJpTUPhl9PLUJnE6C+J0pqtsvlMVdyIrHRpL2fy4
 adUZ0eJ3SP4SmjJOFCeHnkOKiXKUF5/VV8ETMRGvFFC/BBEDbM9aG4GijuQFhA9apui1
 4m7AJSlYrjOTBAEUOqzc2blvgaqOzYUEFLhD3im9yXMYVl84J+psh7PJDVzJq3N9Xojo
 QvBeyina0FiUymSCyPAUUhFw79RH5lUlvPhKxbeKs60FOywQjS+QFhxgxf2C0EcEqvbM Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 360kvjy1vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:15:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA3iS094766;
        Tue, 12 Jan 2021 16:13:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360key11uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:11 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGD9It017459;
        Tue, 12 Jan 2021 16:13:09 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:09 -0800
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
Subject: [PATCH v2 09/70] mm/mmap: Change find_vma_prev() to use maple tree
Date:   Tue, 12 Jan 2021 11:11:39 -0500
Message-Id: <20210112161240.2024684-10-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120093
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
index ab1cb0efc4c65..f123f9c97dfe8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2500,23 +2500,30 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
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

