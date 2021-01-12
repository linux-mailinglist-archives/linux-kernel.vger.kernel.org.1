Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BD2F3537
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392832AbhALQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54370 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392754AbhALQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9W3F086453;
        Tue, 12 Jan 2021 16:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=apzdIZ8vuj1ecGqsyGRAlQ5xYt+Oblu6uUMfHVLV8FY=;
 b=ftX58V5O4KE4S6Q9BMJB8gzh8aRoMdyH2n/Sk2FzKSw32S/x5Yzfl10tWnmuLdb/ivzA
 j0GM2gmREHqjHrujV0Kz81kFnoMJl1KdkrIfZvo5nYv3jZksdX+Hi+YFuPa4lVoGrPvd
 k/8OnAPtlpO2zq1iLDAG7M+07TvWVbGJaRCj+n/hq6Wvx0Ji8d+r9pbUsLDg5wc5vwre
 g73JImFrZQ0kBXFvRAN00oGJxF7IMLUD99TBsvApMtj3HvJcrUkcPS3EZCz5V0VMImsd
 y/rPUntauGcVjkoMugjatcHAn0zHLJjzHkg54mVIk0JA85cE69+PW8yYkf/7lUgn08V3 Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1q4vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA2bF094456;
        Tue, 12 Jan 2021 16:13:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 360key12d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:38 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDbsx004396;
        Tue, 12 Jan 2021 16:13:37 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:37 -0800
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
Subject: [PATCH v2 27/70] mm: Introduce vma_next() and vma_prev()
Date:   Tue, 12 Jan 2021 11:11:57 -0500
Message-Id: <20210112161240.2024684-28-Liam.Howlett@Oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 680dcfe07dbb6..99b1dec97495a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1647,7 +1647,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
 void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+		struct ma_state *mas, unsigned long start, unsigned long end);
 
 struct mmu_notifier_range;
 
@@ -2654,6 +2654,24 @@ extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned lon
 extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
 		     unsigned long start_addr, unsigned long end_addr);
 
+static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+			const struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
+	mas_set(&mas, vma->vm_end);
+	return mas_next(&mas, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct mm_struct *mm,
+			const struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
+	mas_set(&mas, vma->vm_start);
+	return mas_prev(&mas, 0);
+}
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start = vma->vm_start;
@@ -2695,6 +2713,21 @@ static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 	return vma;
 }
 
+static inline struct vm_area_struct *vma_mas_next(struct ma_state *mas)
+{
+	struct ma_state tmp;
+
+	memcpy(&tmp, mas, sizeof(tmp));
+	return mas_next(&tmp, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_mas_prev(struct ma_state *mas)
+{
+	struct ma_state tmp;
+
+	memcpy(&tmp, mas, sizeof(tmp));
+	return mas_prev(&tmp, 0);
+}
 static inline bool range_in_vma(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
-- 
2.28.0

