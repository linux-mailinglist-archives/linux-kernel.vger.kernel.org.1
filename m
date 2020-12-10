Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77C22D64C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393040AbgLJSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:21:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48126 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403842AbgLJRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:05:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGna0h139791;
        Thu, 10 Dec 2020 17:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=/347E1vujMDUPzB7sQHqI8ty+olG6ISzvqpCNopxQXY=;
 b=Tykuo2aZI4voYgssiwQ5PMXQd9r5PULM+odtjfo2xlA2JXcawSaRUL5SMzxUCqvu+JIT
 2vm8EAkpb8ArRChbKuEa3g+QO7ARuLxbMZSJ7IQ6C1y2/REFj/RFrgSUCTAGh4txt86H
 03pHo5jRkDtfINVT+0xKeg8N6oDUk2POAeZJxSOD0oUWPyz2Wc+BmdloM4TT//2LlzAU
 x5arPRVZA7DDtbcVrRlAUOByLgZjCYvYcGsXd5cA2LxveDU/FyhRi5FiTweel7h0/3Ly
 vhP3Wm3bvKv1ZVEgPxd4YATNDh2FtNwI15JlYnP5d+wsRhLGPm+QzpgKS/gY/iJZerPV EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 357yqc6m06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGvKXE162576;
        Thu, 10 Dec 2020 17:04:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 358ksrr5d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH4nsM009036;
        Thu, 10 Dec 2020 17:04:49 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:48 -0800
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 13/28] mm/gup: Expose mm_populate_vma() for use when the vma is known
Date:   Thu, 10 Dec 2020 12:03:47 -0500
Message-Id: <20201210170402.3468568-14-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=872 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=887
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
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
index 1bfa2ee41187d..6cc8825f26414 100644
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
index 102877ed77a4b..522f8fd491ead 100644
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

