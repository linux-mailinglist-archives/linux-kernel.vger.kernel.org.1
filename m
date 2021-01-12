Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E252F3534
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392734AbhALQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34308 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392714AbhALQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9vL6142092;
        Tue, 12 Jan 2021 16:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YsorAUClrkEHgOJBLUL/TyvuzbM5YDyx1ZYDISzNn40=;
 b=OMCG7OuuCXQzmIsnJyJxB5R23lu6ABxtH9oyG/RZ2g0g2Kfb9nIGLe5sTJqbQA2yw9gB
 2zgBl8H9w7/wbsVthjpZRTauZCvM7PsnDMk6xZyBWPG3k4Ehltmkja3Dtq9qPQtmgV7l
 5NyqIh6hX7Ny/+ocmyvn+tz3Tc2/hX7r4HWVBcnMLIyKhJL5hHulal4oLa2TdMsdGAio
 v1TGkCWO1z2ugXuB9MQN1VQNiRyTjUZGH1MWJeGnN8cbjngPq2pHArXBZdyT/BAVUDb+
 dd4MP+waz++rpDcTMXrxrplg0ezwrwACbruKUBH01WoBDCgnZaYCNogH8hLmiHSzS+Mg og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 360kcyq5ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAWwo161712;
        Tue, 12 Jan 2021 16:13:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 360kf5q3uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDFlY004266;
        Tue, 12 Jan 2021 16:13:15 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:15 -0800
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
Subject: [PATCH v2 13/70] mm/gup: Add mm_populate_vma() for use when the vma is known
Date:   Tue, 12 Jan 2021 11:11:43 -0500
Message-Id: <20210112161240.2024684-14-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=958 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=967 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a vma is known, avoid calling mm_populate to search for the vma to
populate.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |  4 ++++
 mm/gup.c           | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dbb83118eba09..baaad07c43c99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2587,8 +2587,12 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
 	/* Ignore errors */
 	(void) __mm_populate(addr, len, 1);
 }
+extern void mm_populate_vma(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
 #else
 static inline void mm_populate(unsigned long addr, unsigned long len) {}
+void mm_populate_vma(struct vm_area_struct *vma, unsigned long start,
+		     unsigned long end) {}
 #endif
 
 /* These take the mm semaphore themselves */
diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6d2609c..b06e2a6d90187 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1431,6 +1431,26 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 				NULL, NULL, locked);
 }
 
+/*
+ * mm_populate_vma() - Populate a single range in a single vma.
+ * @vma: The vma to populate.
+ * @start: The start address to populate
+ * @end: The end address to stop populating
+ *
+ * Note: Ignores errors.
+ */
+void mm_populate_vma(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end)
+{
+	struct mm_struct *mm = current->mm;
+	int locked = 1;
+
+	mmap_read_lock(mm);
+	populate_vma_page_range(vma, start, end, &locked);
+	if (locked)
+		mmap_read_unlock(mm);
+}
+
 /*
  * __mm_populate - populate and/or mlock pages within a range of address space.
  *
-- 
2.28.0

