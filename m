Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04241290DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392796AbgJPWxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:53:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43302 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391153AbgJPWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:53:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GMquKM002361
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:53:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=+fLsw6avMA9nUUd+Oxj6oJl+xsVxclhaBM05fQcL2f0=;
 b=V8pn2+b35sDaIBrBS10Vmb0INPN3HYmqyfjbC+A9DF3AIEnu8iuF6GOChJ8EkV5Vu0Hc
 ukDBd4MJg56Lhdvy3sDRzI9pibXNuOMPNp92S5Cv6ph+mGz1023v0EpZu9CSVSijxK1B
 dI3w+vhqhej7Sdh01G74/2/TpeeSYX3l8c0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 347gmw18eh-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:53:01 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 15:52:59 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 9831916EFB78; Fri, 16 Oct 2020 15:52:56 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 1/2] mm: cma: make cma_release() non-blocking
Date:   Fri, 16 Oct 2020 15:52:53 -0700
Message-ID: <20201016225254.3853109-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201016225254.3853109-1-guro@fb.com>
References: <20201016225254.3853109-1-guro@fb.com>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_12:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 suspectscore=2 mlxlogscore=887 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010160162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
It makes it a blocking function, which complicates its usage from
non-blocking contexts. For instance, hugetlbfs code is temporarily
dropping the hugetlb_lock spinlock to call cma_release().

This patch makes cma_release non-blocking by postponing the cma
bitmap clearance. It's done later from a work context. The first page
in the cma allocation is used to store the work struct.

To make sure that subsequent cma_alloc() call will pass, cma_alloc()
flushes the corresponding workqueue.

Because CMA allocations and de-allocations are usually not that
frequent, a single global workqueue is used.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/cma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7cda9f..523cd9356bc7 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -36,10 +36,19 @@
=20
 #include "cma.h"
=20
+struct cma_clear_bitmap_work {
+	struct work_struct work;
+	struct cma *cma;
+	unsigned long pfn;
+	unsigned int count;
+};
+
 struct cma cma_areas[MAX_CMA_AREAS];
 unsigned cma_area_count;
 static DEFINE_MUTEX(cma_mutex);
=20
+struct workqueue_struct *cma_release_wq;
+
 phys_addr_t cma_get_base(const struct cma *cma)
 {
 	return PFN_PHYS(cma->base_pfn);
@@ -148,6 +157,10 @@ static int __init cma_init_reserved_areas(void)
 	for (i =3D 0; i < cma_area_count; i++)
 		cma_activate_area(&cma_areas[i]);
=20
+	cma_release_wq =3D create_workqueue("cma_release");
+	if (!cma_release_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 core_initcall(cma_init_reserved_areas);
@@ -437,6 +450,13 @@ struct page *cma_alloc(struct cma *cma, size_t count=
, unsigned int align,
 		return NULL;
=20
 	for (;;) {
+		/*
+		 * CMA bitmaps are cleared asynchronously from works,
+		 * scheduled by cma_release(). To make sure the allocation
+		 * will success, cma release workqueue is flushed here.
+		 */
+		flush_workqueue(cma_release_wq);
+
 		mutex_lock(&cma->lock);
 		bitmap_no =3D bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
@@ -495,6 +515,17 @@ struct page *cma_alloc(struct cma *cma, size_t count=
, unsigned int align,
 	return page;
 }
=20
+static void cma_clear_bitmap_fn(struct work_struct *work)
+{
+	struct cma_clear_bitmap_work *w;
+
+	w =3D container_of(work, struct cma_clear_bitmap_work, work);
+
+	cma_clear_bitmap(w->cma, w->pfn, w->count);
+
+	__free_page(pfn_to_page(w->pfn));
+}
+
 /**
  * cma_release() - release allocated pages
  * @cma:   Contiguous memory region for which the allocation is performe=
d.
@@ -507,6 +538,7 @@ struct page *cma_alloc(struct cma *cma, size_t count,=
 unsigned int align,
  */
 bool cma_release(struct cma *cma, const struct page *pages, unsigned int=
 count)
 {
+	struct cma_clear_bitmap_work *work;
 	unsigned long pfn;
=20
 	if (!cma || !pages)
@@ -521,8 +553,23 @@ bool cma_release(struct cma *cma, const struct page =
*pages, unsigned int count)
=20
 	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
=20
-	free_contig_range(pfn, count);
-	cma_clear_bitmap(cma, pfn, count);
+	/*
+	 * To make cma_release() non-blocking, cma bitmap is cleared from
+	 * a work context (see cma_clear_bitmap_fn()). The first page
+	 * in the cma allocation is used to store the work structure,
+	 * so it's released after the cma bitmap clearance. Other pages
+	 * are released immediately as previously.
+	 */
+	if (count > 1)
+		free_contig_range(pfn + 1, count - 1);
+
+	work =3D (struct cma_clear_bitmap_work *)page_to_virt(pages);
+	INIT_WORK(&work->work, cma_clear_bitmap_fn);
+	work->cma =3D cma;
+	work->pfn =3D pfn;
+	work->count =3D count;
+	queue_work(cma_release_wq, &work->work);
+
 	trace_cma_release(pfn, pages, count);
=20
 	return true;
--=20
2.26.2

