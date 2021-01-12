Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF972F3554
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393138AbhALQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35352 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393116AbhALQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGDmFd162404;
        Tue, 12 Jan 2021 16:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+rFWgbvOBxhIq06qQzTdCcHgsPMpd04bwD2fWaLP3IM=;
 b=QxabFgV9O6q/V+OyUO2KAmmxHEBcZVrCSaz5CwBtidWIe1tE2xtWCTD0qSiNjhwrkX10
 yeVgJ8H1yeB/FhZGd8o3S8lg+dygUP0mr6RzeZ13sQWdZiZCtZm7TwSdgKNqTZAJHORq
 AZ42nWGn+LmR6zdCG0Q9mdfKLkw2ZrFw5qPKFlVuaueZoG0Gjy6ccmgxpQeq6PxPnSaI
 OZeB3EuUf8eEXlYlOcLB2IY6Kw9py9/AIeOWI6Da4QLDaHbyR2McXa/PS14UetvRWAJa
 P5uJtKvaZWz67BRhX7PL0pdHC8/KDFYgB0l8XmdlggfAyN4HS6YUIFp7Z+fCvH1i4x28 Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyq5hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA2b1094590;
        Tue, 12 Jan 2021 16:14:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360key13cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:22 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGEK3G018310;
        Tue, 12 Jan 2021 16:14:20 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:20 -0800
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
Subject: [PATCH v2 54/70] mm/khugepaged: Use maple tree iterators instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:24 -0500
Message-Id: <20210112161240.2024684-55-Liam.Howlett@Oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/khugepaged.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4e3dff13eb70c..fbfcee552da6c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2049,6 +2049,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress = 0;
+	MA_STATE(mas, NULL, 0, 0);
 
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2065,18 +2066,20 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 	khugepaged_collapse_pte_mapped_thps(mm_slot);
 
 	mm = mm_slot->mm;
+	mas.tree = &mm->mm_mt;
 	/*
 	 * Don't wait for semaphore (to avoid long wait times).  Just move to
 	 * the next mm on the list.
 	 */
 	vma = NULL;
+	mas_set(&mas, khugepaged_scan.address);
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
 	if (likely(!khugepaged_test_exit(mm)))
-		vma = find_vma(mm, khugepaged_scan.address);
+		vma = mas_find(&mas, ULONG_MAX);
 
 	progress++;
-	for (; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long hstart, hend;
 
 		cond_resched();
-- 
2.28.0

