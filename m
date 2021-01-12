Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2632F3588
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406640AbhALQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:20:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbhALQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9JVp181293;
        Tue, 12 Jan 2021 16:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=GATyrgnrAPJ7W3/LYCuskrOyWVSXhcn70yXiblTNsK0=;
 b=rNSPLVTG9zl3EJ5QNRQABbIY6R+Xfv5gV/x4qC7x3NGEHi9YusvxxHTcBazaEBFGEzuv
 p5Fe7Z1ms28iSt4HFJuQSVamsBgSvEnQm7h798Pcf1zm9K8ZGpYRJKJu/TQUFf43jRir
 5q1WQ6+e+4fYn6v7qOy1wLgksFP+BgE5Mi/rCQLzkWs+fe+Qf1LhXrOH9d/sRdhnQ9pN
 sYhvMc4KFqe75qto25mY4ZZjlx5p8C1KcMVqHSoxLXvpwIB9NQWZGMV4BA39l/9M/BAO
 5KWDZhILMIbAV2n9C1azmsOSBuquQPUFiClOrqDcG+j0kC502NVMo8p26zYhTyQPuUDf +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjy1qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBZl0142973;
        Tue, 12 Jan 2021 16:14:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360ke6rhus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:14 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGE9wS018142;
        Tue, 12 Jan 2021 16:14:10 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:09 -0800
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
Subject: [PATCH v2 47/70] kernel/acct: Use maple tree iterators instead of linked list
Date:   Tue, 12 Jan 2021 11:12:17 -0500
Message-Id: <20210112161240.2024684-48-Liam.Howlett@Oracle.com>
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
 kernel/acct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index f175df8f6aa4a..bcfe2cf7c7c0f 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -537,16 +537,14 @@ void acct_collect(long exitcode, int group_dead)
 	struct pacct_struct *pacct = &current->signal->pacct;
 	u64 utime, stime;
 	unsigned long vsize = 0;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
 	if (group_dead && current->mm) {
 		struct vm_area_struct *vma;
 
 		mmap_read_lock(current->mm);
-		vma = current->mm->mmap;
-		while (vma) {
+		mas_for_each(&mas, vma, -1)
 			vsize += vma->vm_end - vma->vm_start;
-			vma = vma->vm_next;
-		}
 		mmap_read_unlock(current->mm);
 	}
 
-- 
2.28.0

