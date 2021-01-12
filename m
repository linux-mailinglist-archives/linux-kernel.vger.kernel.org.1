Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B32F357F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406592AbhALQTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:19:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55878 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406055AbhALQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9WkN086449;
        Tue, 12 Jan 2021 16:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=LJqNKU4ZDwEbrq1UDmTtG0wzK2wcPF6eoRTKRKC2T9M=;
 b=NDw+XGE4kEtOevddPhZ11eLESYbsfyVNXmJGkZHOQfwE8VyRaODDYg46uKnoaE7iN21J
 CNDfR8ztCAgREjZ2/fANqqkyNp7uOj33gLX7d+QZe6X7/vsup2tpXtaFxIqjzQ+ru+xp
 iO1MRr7KgIJSv02Oe8u7IVc1LauZxZe3onjeCN+xJvHjtptxYWazxh94ZR56kt4CLP8N
 PgOQCW22GI2VAJoiyS3VXxnscaAya2Zm5SEcVlXQE5SAfkOI0MJ8r8poMkK2nfb/p6fo
 dG8TsTzcS1CMzXMU0LnxYINuGnzJSN/BdGIhqq0myjsEqdptWYxGH6+KG1TZ4eNfFviJ +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 360kg1q504-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAV2g161581;
        Tue, 12 Jan 2021 16:14:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 360kf5q56t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGE8wu004749;
        Tue, 12 Jan 2021 16:14:08 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:08 -0800
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
Subject: [PATCH v2 46/70] ipc/shm: Stop using the vma linked list
Date:   Tue, 12 Jan 2021 11:12:16 -0500
Message-Id: <20210112161240.2024684-47-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for a VMA, a maple state can be used instead of the linked list in
the mm_struct

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index e25c7c6106bcf..4ad8788352099 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1631,6 +1631,7 @@ long ksys_shmdt(char __user *shmaddr)
 	loff_t size = 0;
 	struct file *file;
 	struct vm_area_struct *next;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 #endif
 
 	if (addr & ~PAGE_MASK)
@@ -1660,11 +1661,11 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma = find_vma(mm, addr);
 
 #ifdef CONFIG_MMU
+	vma = mas_find(&mas, ULONG_MAX);
 	while (vma) {
-		next = vma->vm_next;
+		next = mas_find(&mas, ULONG_MAX);
 
 		/*
 		 * Check if the starting address would match, i.e. it's
@@ -1703,21 +1704,21 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size = PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <= size) {
-		next = vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
 		    (vma->vm_file == file))
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma = next;
+
+		vma = mas_find(&mas, addr + size - 1);
 	}
 
 #else	/* CONFIG_MMU */
+	vma = mas_walk(&mas);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
-	if (vma && vma->vm_start == addr && vma->vm_ops == &shm_vm_ops) {
+	if (vma && vma->vm_ops == &shm_vm_ops) {
 		do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
 		retval = 0;
 	}
-- 
2.28.0

