Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7D2F3547
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405686AbhALQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43762 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405340AbhALQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9BHL181204;
        Tue, 12 Jan 2021 16:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=429ZZ5MtKZd01eVUl4NGeUb2aUMBCpsBlaD29WHQ2MM=;
 b=iFtkyjMSenp6N+S8Wwyqg41IPNxZV7ExHhekvNHc8QxdHF8rv4PT7VasYSYz1GO35VKd
 154xt8MsQRmBM+O6O9abOA0mUjndbB9HN/oRB9ZeTXa1C1YVdXJ2t7KTKo38/ob9YucW
 xHDKj9gFKC8n/5R6I3cnZumKeSzksH7vFdK6BhmUaYT2BgWbzEb/zcXWigsi9hNkDKj/
 cjisdJozMZhUAbTEeP+JFFufeOPkyMR7ki/UY1LJa+zQ6/MxMIeR4rGMiCIsE2NU2AFY
 qwek8HNgc4RDobXW9yrpLi43F42vVn3TXL+qt7cpGNSq1PHHEvH7bji5d7eptVqB+Ugj Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy1t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAaKS100407;
        Tue, 12 Jan 2021 16:14:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360keh7m0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:43 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGEfXJ030862;
        Tue, 12 Jan 2021 16:14:41 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:41 -0800
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
Subject: [PATCH v2 68/70] mm/util: Remove __vma_link_list() and __vma_unlink_list()
Date:   Tue, 12 Jan 2021 11:12:38 -0500
Message-Id: <20210112161240.2024684-69-Liam.Howlett@Oracle.com>
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/util.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 48c79f2784eca..74888472a0848 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -271,46 +271,6 @@ void *memdup_user_nul(const void __user *src, size_t len)
 }
 EXPORT_SYMBOL(memdup_user_nul);
 
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	struct vm_area_struct *next;
-
-	vma->vm_prev = prev;
-	if (prev) {
-		next = prev->vm_next;
-		prev->vm_next = vma;
-	} else {
-		next = mm->mmap;
-		mm->mmap = vma;
-	}
-	vma->vm_next = next;
-	if (next)
-		next->vm_prev = vma;
-	else
-		mm->highest_vm_end = vm_end_gap(vma);
-}
-
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	struct vm_area_struct *prev, *next;
-
-	next = vma->vm_next;
-	prev = vma->vm_prev;
-	if (prev)
-		prev->vm_next = next;
-	else
-		mm->mmap = next;
-	if (next)
-		next->vm_prev = prev;
-	else {
-		if (prev)
-			mm->highest_vm_end = vm_end_gap(prev);
-		else
-			mm->highest_vm_end = 0;
-	}
-}
-
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
-- 
2.28.0

