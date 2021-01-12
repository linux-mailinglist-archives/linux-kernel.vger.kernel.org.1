Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E456D2F3573
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406464AbhALQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46848 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406412AbhALQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFIne007309;
        Tue, 12 Jan 2021 16:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=WQFaa+YXTGz1oOVUz4VXZYaNPdsTuENWyigxNY/aJp4=;
 b=XuvzbqxKBJOuX/CPh44s4sLBXfcntyQ+hKLnJjGucwNuGNRjlVogXDgP6CLg8xZnGByS
 KCSqp/5z6UKWEuF55+R9K7wNTTW7o3vItEXgFr4xuD0W9MbV/MTisI6vU/ci2P0hbhPd
 iR8sU24TNsRHetgH4zLmleLIDELqe2HP4GXch4mDDABtAULmgNJ+CP+VomaxwxBoghg8
 r07YUC77rLvgm5IYkdIGKx3NGjFs5f8On/X9cHe6RrIZYaFVWCQKRyO0fODhXfmBabgy
 44EX2gVXmKSnaZfOJjgCt96OzFxZJLhOw2sxI7h+aPVRkF6tmPa6ovuKL9H9IHOhbChF Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjy275-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBY64142829;
        Tue, 12 Jan 2021 16:14:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 360ke6rjtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGEeNo020349;
        Tue, 12 Jan 2021 16:14:40 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:40 -0800
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
Subject: [PATCH v2 67/70] mm/nommu: Stop inserting into the vma linked list
Date:   Tue, 12 Jan 2021 11:12:37 -0500
Message-Id: <20210112161240.2024684-68-Liam.Howlett@Oracle.com>
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
 engine=8.12.0-2009150000 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/nommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 4e5cc63728b65..a3f97a612f16a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -617,8 +617,6 @@ static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 	prev = NULL;
 	if (rb_prev)
 		prev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-
-	__vma_link_list(mm, vma, prev);
 }
 
 /*
@@ -653,8 +651,6 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
 
 	/* remove from the MM's tree and list */
 	rb_erase(&vma->vm_rb, &mm->mm_rb);
-
-	__vma_unlink_list(mm, vma);
 }
 
 /*
-- 
2.28.0

