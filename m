Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE4296776
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373106AbgJVWxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:53:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S373099AbgJVWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:53:18 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MMiSIN008606
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:53:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Yr1xrojJjtI4pSCSS8C4LN1/v3pKcraNnqvQv1M5jcE=;
 b=j0ejsR2Zy2sL003ci/clcfhthc9j1bpRT+AArNLykKxYFgEC3vV8SfJ+JGqf9zVkvEGI
 yxra5QFllhqGGCF9URPz6iHD6LKQC+pSU6rOSEldCM+tKV+0mDCgOMHmxrlqn6kFxYPG
 BzDnNYiW3sZV8SeCbg151aBM0XvnTuA+/iI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34a57yx3fb-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:53:17 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 15:53:16 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id E94601A3AE4A; Thu, 22 Oct 2020 15:53:12 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 1/2] mm: cma: introduce cma_release_nowait()
Date:   Thu, 22 Oct 2020 15:53:07 -0700
Message-ID: <20201022225308.2927890-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201022225308.2927890-1-guro@fb.com>
References: <20201022225308.2927890-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_17:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=2
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010220145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
It makes it a blocking function, which complicates its usage from
non-blocking contexts. For instance, hugetlbfs code is temporarily
dropping the hugetlb_lock spinlock to call cma_release().

This patch introduces a non-blocking cma_release_nowait(), which
postpones the cma bitmap clearance. It's done later from a work
context. The first page in the cma allocation is used to store
the work struct. Because CMA allocations and de-allocations are
usually not that frequent, a single global workqueue is used.

To make sure that subsequent cma_alloc() call will pass, cma_alloc()
flushes the cma_release_wq workqueue. To avoid a performance
regression in the case when only cma_release() is used, gate it
by a per-cma area flag, which is set by the first call
of cma_release_nowait().

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/cma.h |  2 +
 mm/cma.c            | 93 +++++++++++++++++++++++++++++++++++++++++++++
 mm/cma.h            |  5 +++
 3 files changed, 100 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 217999c8a762..497eca478c2f 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -47,6 +47,8 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys=
_addr_t size,
 extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned in=
t align,
 			      bool no_warn);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsig=
ned int count);
+extern bool cma_release_nowait(struct cma *cma, const struct page *pages=
,
+			       unsigned int count);
=20
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), voi=
d *data);
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7cda9f..9fcfddcf1a6c 100644
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
@@ -205,6 +218,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, ph=
ys_addr_t size,
=20
 	cma->base_pfn =3D PFN_DOWN(base);
 	cma->count =3D size >> PAGE_SHIFT;
+	cma->flags =3D 0;
 	cma->order_per_bit =3D order_per_bit;
 	*res_cma =3D cma;
 	cma_area_count++;
@@ -437,6 +451,14 @@ struct page *cma_alloc(struct cma *cma, size_t count=
, unsigned int align,
 		return NULL;
=20
 	for (;;) {
+		/*
+		 * If the CMA bitmap is cleared asynchronously after
+		 * cma_release_nowait(), cma release workqueue has to be
+		 * flushed here in order to make the allocation succeed.
+		 */
+		if (test_bit(CMA_DELAYED_RELEASE, &cma->flags))
+			flush_workqueue(cma_release_wq);
+
 		mutex_lock(&cma->lock);
 		bitmap_no =3D bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
@@ -528,6 +550,77 @@ bool cma_release(struct cma *cma, const struct page =
*pages, unsigned int count)
 	return true;
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
+/**
+ * cma_release_nowait() - release allocated pages without blocking
+ * @cma:   Contiguous memory region for which the allocation is performe=
d.
+ * @pages: Allocated pages.
+ * @count: Number of allocated pages.
+ *
+ * Similar to cma_release(), this function releases memory allocated
+ * by cma_alloc(), but unlike cma_release() is non-blocking and can be
+ * called from an atomic context.
+ * It returns false when provided pages do not belong to contiguous area
+ * and true otherwise.
+ */
+bool cma_release_nowait(struct cma *cma, const struct page *pages,
+			unsigned int count)
+{
+	struct cma_clear_bitmap_work *work;
+	unsigned long pfn;
+
+	if (!cma || !pages)
+		return false;
+
+	pr_debug("%s(page %p)\n", __func__, (void *)pages);
+
+	pfn =3D page_to_pfn(pages);
+
+	if (pfn < cma->base_pfn || pfn >=3D cma->base_pfn + cma->count)
+		return false;
+
+	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
+
+	/*
+	 * Set CMA_DELAYED_RELEASE flag: subsequent cma_alloc()'s
+	 * will wait for the async part of cma_release_nowait() to
+	 * finish.
+	 */
+	if (unlikely(!test_bit(CMA_DELAYED_RELEASE, &cma->flags)))
+		set_bit(CMA_DELAYED_RELEASE, &cma->flags);
+
+	/*
+	 * To make cma_release_nowait() non-blocking, cma bitmap is cleared
+	 * from a work context (see cma_clear_bitmap_fn()). The first page
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
+	trace_cma_release(pfn, pages, count);
+
+	return true;
+}
+
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data=
)
 {
 	int i;
diff --git a/mm/cma.h b/mm/cma.h
index 42ae082cb067..e9293871d122 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -7,6 +7,7 @@
 struct cma {
 	unsigned long   base_pfn;
 	unsigned long   count;
+	unsigned long   flags;
 	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	struct mutex    lock;
@@ -18,6 +19,10 @@ struct cma {
 	char name[CMA_MAX_NAME];
 };
=20
+enum cma_flags {
+	CMA_DELAYED_RELEASE, /* cma bitmap is cleared asynchronously */
+};
+
 extern struct cma cma_areas[MAX_CMA_AREAS];
 extern unsigned cma_area_count;
=20
--=20
2.26.2

