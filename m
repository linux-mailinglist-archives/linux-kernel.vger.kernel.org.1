Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134B62F3542
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393109AbhALQPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393090AbhALQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9E0i181223;
        Tue, 12 Jan 2021 16:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=CKNOaXE603xYDlXVu5vV2MSmT5RVKv/hfkhzQwz6Its=;
 b=VGPwHtrtk7627TM9FGj6/rLJM8WEBpez/NoxutuEkqknpl11YFJqsW593uvrTZOzBQQt
 Cnf9WAuP8Act2DPrVmnkrDSOZMyLywErv740WM3zb2V+Neemzbbi+3e9pXweDkHMkHpr
 fuDnJHM8DZIP9GHndszMF7WzpEyic7SjYytcS0dt1W6HJwTzV3uzC6FCOkBofC8RRSfh
 1fXVYPcq6JWTsPoagd0atVFrXi2kHcxMcIR/kConByaw4wBz7dkU1e6krM3en1QT4tmG
 XCgiRmCFaBuJVMH7yv2C4KW+UEXCqf3lp1xfoQg/pj3VDC+7oGK2u9lK3LadyiFkGO/U fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjy1kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBYtw142754;
        Tue, 12 Jan 2021 16:13:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360ke6rgr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDYvx004379;
        Tue, 12 Jan 2021 16:13:34 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:34 -0800
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
Subject: [PATCH v2 25/70] mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
Date:   Tue, 12 Jan 2021 11:11:55 -0500
Message-Id: <20210112161240.2024684-26-Liam.Howlett@Oracle.com>
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

do_brk_munmap() already has aligned addresses.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9be91b47db6b4..f750e85d4dc2c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3004,12 +3004,13 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret = 1;
+	int ret;
 
 	arch_unmap(mm, newbrk, oldbrk);
 
 	if (likely(vma->vm_start >= newbrk)) { // remove entire mapping(s)
-		ret = do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret = do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
 
-- 
2.28.0

