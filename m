Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2D2F356F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406411AbhALQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37670 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406373AbhALQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGDrks162468;
        Tue, 12 Jan 2021 16:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=s5wOQs4E2UMANYKBguwi8PhZn25BJquE5iaO2T91ll4=;
 b=DxQ5liZ6HGTgU7D0IHExsN6T+fwfBLnhWpqlCxgifgOWQJGRAwZ+ggDOj8V/epzq1N8w
 Vepd2QTdx4nhNW3SLtCfTXNgUJtAImqGOVhl0YaFtTi8UDQKqZxWP0G2Zmon8viEmlrh
 MC0TeL23WOw4NqmpBq2J3XSbvXCZEyW//GjPTDyK6rznBy+tmzKw7KZ5aH/kygE4sDxE
 77H6bOL9zbCkcMsuRWfFu3P5rQNeT6Uexm6OUvW7TtosoEdFL8JyWw6ZumkibAPr66mk
 +zLKo69vTo7/JqejVIMxr9FL5aIbC0iDPV3HTXR9Cb/MlpDtQgzLFta7wTxcRiOB3mc6 cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyq5y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA3ix094766;
        Tue, 12 Jan 2021 16:14:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 360key13gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGER2X005062;
        Tue, 12 Jan 2021 16:14:27 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:27 -0800
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
Subject: [PATCH v2 59/70] mm/mlock: Use maple tree iterators instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:29 -0500
Message-Id: <20210112161240.2024684-60-Liam.Howlett@Oracle.com>
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
 mm/mlock.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 884b1216da6a6..2c27597ebcf6b 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -591,6 +591,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct * vma, * prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
 
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len != PAGE_ALIGN(len));
@@ -599,11 +600,11 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 		return -EINVAL;
 	if (end == start)
 		return 0;
-	vma = find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma = mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
 
-	prev = vma->vm_prev;
+	prev = mas_prev(&mas, 0);
 	if (start > vma->vm_start)
 		prev = vma;
 
@@ -625,7 +626,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 		if (nstart >= end)
 			break;
 
-		vma = prev->vm_next;
+		vma = vma_next(prev->vm_mm, prev);
 		if (!vma || vma->vm_start != nstart) {
 			error = -ENOMEM;
 			break;
@@ -646,15 +647,12 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count = 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
 
 	if (mm == NULL)
 		mm = current->mm;
 
-	vma = find_vma(mm, start);
-	if (vma == NULL)
-		vma = mm->mmap;
-
-	for (; vma ; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, start + len) {
 		if (start >= vma->vm_end)
 			continue;
 		if (start + len <=  vma->vm_start)
@@ -769,6 +767,7 @@ static int apply_mlockall_flags(int flags)
 {
 	struct vm_area_struct * vma, * prev = NULL;
 	vm_flags_t to_add = 0;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
 	current->mm->def_flags &= VM_LOCKED_CLEAR_MASK;
 	if (flags & MCL_FUTURE) {
@@ -787,7 +786,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |= VM_LOCKONFAULT;
 	}
 
-	for (vma = current->mm->mmap; vma ; vma = prev->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
 
 		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -795,6 +794,7 @@ static int apply_mlockall_flags(int flags)
 
 		/* Ignore errors */
 		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		mas_pause(&mas);
 		cond_resched();
 	}
 out:
-- 
2.28.0

