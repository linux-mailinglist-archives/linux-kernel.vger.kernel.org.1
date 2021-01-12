Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB082F356B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406356AbhALQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406311AbhALQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGDxUd162569;
        Tue, 12 Jan 2021 16:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=n+OkY7vhX4e0NqHx6SdCYivsmVbNl6OwZOjgoRuVG84=;
 b=xsSgth9hT/blHaHXm8zotgCapUEQoQ5nDXbznTcUVeMZz9yoZJn2pLzmTDW8+HWXzqEz
 D5Qy4BmvxgAEqgy9fTuWyFiMyWNK2LtXk/960gxSd3wnLEqInt94nnMq35YyD/TZAIPV
 rqfFp9raY8E44Cc82JEe/wYkv3H6j2FicDEVbTWiVZk7qToSa+ziZ3fLP9fE97qvAJt9
 8Qm/px2bTohWpFbb4FiPJcs8rAbOyHcLtZNTkZa4HaBiDWZBJnV868HHda21u+4qZkif
 13QvrnfOSzqE/d6Yo5EHPHqRtnq/BA9xxX+qG7SKR4u6M1i02cPU+ACGCIKiT15BrX7S Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcyq5y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBYc5142767;
        Tue, 12 Jan 2021 16:14:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 360ke6rj7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:22 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGELhS020057;
        Tue, 12 Jan 2021 16:14:21 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:21 -0800
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
Subject: [PATCH v2 55/70] mm/ksm: Use maple tree iterators instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:25 -0500
Message-Id: <20210112161240.2024684-56-Liam.Howlett@Oracle.com>
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
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 0960750bb316d..9aa579cef7614 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -975,10 +975,12 @@ static int unmerge_and_remove_all_rmap_items(void)
 	spin_unlock(&ksm_mmlist_lock);
 
 	for (mm_slot = ksm_scan.mm_slot;
-			mm_slot != &ksm_mm_head; mm_slot = ksm_scan.mm_slot) {
-		mm = mm_slot->mm;
+			mm_slot != &ksm_mm_head; mm_slot = ksm_scan.mm_slot, mm = mm_slot->mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
+
 		mmap_read_lock(mm);
-		for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		mas_set(&mas, 0);
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2286,13 +2288,14 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 	}
 
 	mm = slot->mm;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma = NULL;
-	else
-		vma = find_vma(mm, ksm_scan.address);
+		goto no_vmas;
 
-	for (; vma; vma = vma->vm_next) {
+	mas_set(&mas, ksm_scan.address);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2330,6 +2333,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 	}
 
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address = 0;
 		ksm_scan.rmap_list = &slot->rmap_list;
 	}
-- 
2.28.0

