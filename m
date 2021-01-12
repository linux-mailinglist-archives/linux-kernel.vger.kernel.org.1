Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062252F3571
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406438AbhALQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57618 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406398AbhALQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFWCY107454;
        Tue, 12 Jan 2021 16:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=tGZQNHUS7fI5+R93oLoGHzYTKp6wZPegoOK2g10RR8g=;
 b=LJG+yzAr7EEau4IyD7FnVys4JV7F5E1cVURgCg9beUL0AuPznz5WwpOaZ81ehtlvHYog
 xKjcyq7Ot+HEOZ+Nk4v7ogjHQtsa7DPzO5E8f4VJ109ZTCM9LfgSALFReJoERXEkfEvP
 dBQ11fSBPuthlY8jQD8VG/bVGGL0JfdufMZGkIA/eThczcPCCqojIlRKFUq6rzVZQPLQ
 i//cCz1T0KXCJkyTNj1Jv7CMrqqEu6ah21oC+zKfDLVf4obYrb/Y+XjE22f3UabsvVYm
 LeaftSB4V3xWTagsrbvdKA9Yc1NbSYI+Oyc/EP+DBij9k6YnSxQTc84ThCVX4O//LwtR 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg1q5ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBZ2p142889;
        Tue, 12 Jan 2021 16:14:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke6rjgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:32 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGEUaK030664;
        Tue, 12 Jan 2021 16:14:30 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:30 -0800
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
Subject: [PATCH v2 61/70] mm/mremap: Use vma_next() instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:31 -0500
Message-Id: <20210112161240.2024684-62-Liam.Howlett@Oracle.com>
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
 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index a7526a8c1fe5a..3b6e7f0324635 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -465,7 +465,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (excess) {
 		vma->vm_flags |= VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |= VM_ACCOUNT;
+			vma_next(mm, vma)->vm_flags |= VM_ACCOUNT;
 	}
 
 	return new_addr;
@@ -638,9 +638,11 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end = vma->vm_end + delta;
+	struct vm_area_struct *next;
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	next = vma_next(vma->vm_mm, vma);
+	if (next && next->vm_start < end) /* intersection */
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
-- 
2.28.0

