Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5C2F3548
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405807AbhALQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:16:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405691AbhALQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG97Jw181150;
        Tue, 12 Jan 2021 16:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=BuWKeQe0Y2qDF6GWqtgEciNAxxLm2HjEdE6veDvoAis=;
 b=xyEduvhN9tqDY43bl7jQBApjOiLxZqrKdUxXkPkp+MuvndnjArwPVxJ55Nx9paxQ16T0
 Z7K1WLtN/e+FBMeYgBdePWiAg4kiwItteMWwkADzg0AyE6tgiyQnirNc91M9wNNrECON
 T18kYq8Dxv3qWVcLwU6az3uWLyirx7XcjwokZYpu8eT42j+lIrkB8dS5dR97fYkPSFBP
 S0X8oG9byTNUDkpCtDCVNH2X+ATvUTVoLiBr/yksAccboxMlEK9sk9mQ3PC0WRujv4RO
 htK2Kk9XWvKjJ4ic6+WKTLmJzcUGGAZgUvxSlCxNo1NPcXfaeRv155jiPwzn4T8mx+af tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy1t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAcT8100736;
        Tue, 12 Jan 2021 16:14:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 360keh7m30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGEiNl005146;
        Tue, 12 Jan 2021 16:14:44 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:44 -0800
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
Subject: [PATCH v2 70/70] mm/mmap: Convert __insert_vm_struct to use mas, convert vma_link to use vma_mas_link()
Date:   Tue, 12 Jan 2021 11:12:40 -0500
Message-Id: <20210112161240.2024684-71-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
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

Drop unused vma_store()

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ce8857b9abd89..b4ed8be4899b8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -514,21 +514,9 @@ static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
 
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct address_space *mapping = NULL;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end - 1);
 
-	if (vma->vm_file) {
-		mapping = vma->vm_file->f_mapping;
-		i_mmap_lock_write(mapping);
-	}
-
-	vma_mt_store(mm, vma);
-	__vma_link_file(vma);
-
-	if (mapping)
-		i_mmap_unlock_write(mapping);
-
-	mm->map_count++;
-	validate_mm(mm);
+	vma_mas_link(mm, vma, &mas);
 }
 
 /*
@@ -538,9 +526,13 @@ static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 static inline void __insert_vm_struct(struct mm_struct *mm,
 				      struct vm_area_struct *vma)
 {
-	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end - 1);
+
+	if (mas_find(&mas, vma->vm_end - 1))
 		BUG();
-	vma_mt_store(mm, vma);
+
+	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
+	vma_mas_store(vma, &mas);
 	mm->map_count++;
 }
 
-- 
2.28.0

