Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D432F3545
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405553AbhALQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43328 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405340AbhALQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9HuU181264;
        Tue, 12 Jan 2021 16:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2GNyy1mtDWBZ+UM5iOZvDqZctgoqrghZKyKRMvetYVc=;
 b=V8CDCYMk8JGD0fNBgPvVH1It2gOuGO/TfP0at70WK6O2smKRlpos+slHZPImfmFIHyCI
 UQL61cDhVA5CszNiNZutViJQeWdZ24cxijepsGO9h2eVyxpmmJMmcPFPndRtoLRqyQxg
 UMlxls7rX8wU3i5Un/SpSXHrbqE8sUQhXw8VHQzwFUfqoLQkMuar6UBmYmGxwu/OhKro
 jMKuhJ6n7uyMT1VHHk0ZScyYHnLpFkcywZpFV9q3KwfcdPFYmDqReI3cFpwcU2DYNBDY
 ow1hNSp93qQd/obn9YoQWQzeASKoSUGKdNC0dk3MDe/ukYREAE3W8l0w4KMsfQ3/moXa 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjy1sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBYBF142750;
        Tue, 12 Jan 2021 16:14:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360ke6rjk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGEXNL005098;
        Tue, 12 Jan 2021 16:14:33 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:33 -0800
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
Subject: [PATCH v2 63/70] mm/nommu: Use maple tree iterators instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:33 -0500
Message-Id: <20210112161240.2024684-64-Liam.Howlett@Oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/nommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 0faf39b32cdb9..4e5cc63728b65 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -677,6 +677,7 @@ static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	/* check the cache first */
 	vma = vmacache_find(mm, addr);
@@ -685,7 +686,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 
 	/* trawl the list (there may be multiple mappings in which addr
 	 * resides) */
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->vm_start > addr)
 			return NULL;
 		if (vma->vm_end > addr) {
@@ -726,6 +727,7 @@ static struct vm_area_struct *find_vma_exact(struct mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long end = addr + len;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	/* check the cache first */
 	vma = vmacache_find_exact(mm, addr, end);
@@ -734,7 +736,7 @@ static struct vm_area_struct *find_vma_exact(struct mm_struct *mm,
 
 	/* trawl the list (there may be multiple mappings in which addr
 	 * resides) */
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->vm_start < addr)
 			continue;
 		if (vma->vm_start > addr)
@@ -1485,7 +1487,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
 				return -EINVAL;
 			if (end == vma->vm_end)
 				goto erase_whole_vma;
-			vma = vma->vm_next;
+			vma = vma_next(vma);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1543,7 +1545,7 @@ void exit_mmap(struct mm_struct *mm)
 	mm->total_vm = 0;
 
 	while ((vma = mm->mmap)) {
-		mm->mmap = vma->vm_next;
+		mm->mmap = vma_next(vma);
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
-- 
2.28.0

