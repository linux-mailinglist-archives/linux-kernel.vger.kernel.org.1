Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8FD2F3570
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406424AbhALQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37680 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406355AbhALQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGDmah162423;
        Tue, 12 Jan 2021 16:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ag0OboaKwJiod+HfP6HsLvol3F/ZvYOkZp32m0fdIfA=;
 b=xGH09AU3d9OmHhHF8066c1l4n0gJb1zsLZDzuG0IPsdI62DmBAU66bTkMoIHOzojyjAY
 gr977AXBnEXPI3IYDwqBNqcgOz5Vet5llCDWmN/f3QKjc3qtpAI9UAyaSP64gYixjy8N
 kU/UlubunkVs0iT/Xrc7j0UqoRl9p/Lvx39KZ8S0iBRrb+ERoILossszjeDYHYfmlXcI
 He0agMWNzrJ0Ome8P3ezptkVPF0pWNfdmAs9tB1rF2rtrtaOjL3DCcKuCV3ONJXzCztD
 LqG373a+ZRJrlRJKkH77akQEaWHdbL1aT6Or6kkR69kBb/lmS6AO3TnGPTIhgmrjCSTy bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcyq5yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBYqf142775;
        Tue, 12 Jan 2021 16:14:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke6rjex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:31 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGETQe030651;
        Tue, 12 Jan 2021 16:14:29 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:29 -0800
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
Subject: [PATCH v2 60/70] mm/mprotect: Use maple tree navigation instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:30 -0500
Message-Id: <20210112161240.2024684-61-Liam.Howlett@Oracle.com>
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
 mm/mprotect.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56c02beb60414..a6208b872336e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -518,6 +518,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	const int grows = prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
 
 	start = untagged_addr(start);
 
@@ -549,11 +550,12 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	if ((pkey != -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
 
-	vma = find_vma(current->mm, start);
+	mas_set(&mas, start);
+	vma = mas_walk(&mas);
 	error = -ENOMEM;
 	if (!vma)
 		goto out;
-	prev = vma->vm_prev;
+	prev = mas_prev(&mas, 0);
 	if (unlikely(grows & PROT_GROWSDOWN)) {
 		if (vma->vm_start >= end)
 			goto out;
@@ -626,7 +628,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		if (nstart >= end)
 			goto out;
 
-		vma = prev->vm_next;
+		vma = mas_next(&mas, ULONG_MAX);
 		if (!vma || vma->vm_start != nstart) {
 			error = -ENOMEM;
 			goto out;
-- 
2.28.0

