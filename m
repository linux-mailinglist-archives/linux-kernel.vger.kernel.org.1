Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA48A2F3568
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406317AbhALQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57340 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406235AbhALQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFX1h107499;
        Tue, 12 Jan 2021 16:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=tyPOyHcy0C0fk2HmVXtPsBQXwI8CIVo0QoSlzxuxY88=;
 b=kHvzxbBKC8yk12meq4QTYW8Ht7qBO4cfvZdq7Zx52z2ODYq9N5nUiXbzD5UHkksI+NH0
 wIPZMuJ2ieFz+OQ6xu3Ho2aqqjCf8plwxD9/cI9EaSzPYFbAV7MMbxQROtRWu7Eoqy+N
 Iwg1eRAZpPajKK0o6sRgZ8p6zCcoICDvBdUerbcALQpUryqWYs1RQqWkm1YmOqSVdB8L
 cxn1CXUJD6cQpkcR5eoXIKslIag7oHWjvqVtleoXb+5oCxNCJh89Y+NfMfpnEUF9Z+lL
 jW7tXWFh0XCzul6AmmUqcMCor3KncUtJ7HMjrrBxwc+gHF+CxXEjnvHM+5jxl1hINAJn 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 360kg1q5ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAWF1161603;
        Tue, 12 Jan 2021 16:14:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 360kf5q5bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:15 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGEE6l018218;
        Tue, 12 Jan 2021 16:14:14 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:14 -0800
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
Subject: [PATCH v2 50/70] kernel/sched/fair: Use maple tree iterators instead of linked list
Date:   Tue, 12 Jan 2021 11:12:20 -0500
Message-Id: <20210112161240.2024684-51-Liam.Howlett@Oracle.com>
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
 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba8fd4f2..1cb3a245ffd85 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2723,6 +2723,7 @@ static void task_numa_work(struct callback_head *work)
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -2775,13 +2776,16 @@ static void task_numa_work(struct callback_head *work)
 
 	if (!mmap_read_trylock(mm))
 		return;
-	vma = find_vma(mm, start);
+
+	mas_set(&mas, start);
+	vma = mas_walk(&mas);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start = 0;
-		vma = mm->mmap;
+		mas_set(&mas, start);
 	}
-	for (; vma; vma = vma->vm_next) {
+
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
-- 
2.28.0

