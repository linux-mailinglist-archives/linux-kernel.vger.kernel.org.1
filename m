Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE02D64A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403944AbgLJRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:06:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48322 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403877AbgLJRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:05:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnYpd139742;
        Thu, 10 Dec 2020 17:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=wlqpJ80r34Xh6wCOg0t2jdOcQW7Oo4RXUBKNikBAtik=;
 b=SBvCPzzHtJ/EvLbCr6Ov931vXUXTZgfx/5egEfxokcYvIgVYucZK156waHux3eZT4CvG
 J8IYZbXXabQKW+h06fY15TDeBTXdBE5vMkQd8+FEkHcHLimP/J3H8IKdnnoMGaWeseST
 Hmpwgy+y0nHDC6yomLLuSdQ6+o9YDUcuQkznsfNAoBZfTBq+82dasrLTqU0FhY4+oUTA
 oRKCrJ6AGLO5FYxLMhcuWE5+k7wrco3kQ7qqiRu+RZ6D+lYueZvGo1vcvez79lqOfePg
 3HssyP5CSRMhshw8C0ZTe+8vlMc7+Cx6X8f1Y8Bg9k47yFqOJlOEYxHEYWrJRNfzR7vh 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 357yqc6m12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGvxEq033003;
        Thu, 10 Dec 2020 17:04:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 358m52gbmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:58 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4vR4012910;
        Thu, 10 Dec 2020 17:04:57 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:57 -0800
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
Subject: [PATCH 20/28] mm/mmap: Change __do_munmap() to avoid unnecessary lookups.
Date:   Thu, 10 Dec 2020 12:03:54 -0500
Message-Id: <20201210170402.3468568-21-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no longer a vmacache, find_vma() is more expensive and so
avoid doing them

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c3ac4d6f970d3..15616f105d051 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2720,7 +2720,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (!vma)
 		return 0;
 
-	prev = vma->vm_prev;
 	/* we have start < vma->vm_end  */
 
 	/*
@@ -2744,16 +2743,24 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		if (error)
 			return error;
 		prev = vma;
+		vma = vma_next(mm, prev);
+	} else {
+		prev = vma->vm_prev;
 	}
 
+	if (vma->vm_end >= end)
+		last = vma;
+	else
+		last = find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last = find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error = __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
+		vma = vma_next(mm, prev);
 	}
-	vma = vma_next(mm, prev);
+
 
 	if (unlikely(uf)) {
 		/*
@@ -2766,6 +2773,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error = userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
-- 
2.28.0

