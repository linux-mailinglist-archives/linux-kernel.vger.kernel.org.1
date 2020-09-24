Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDD277958
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgIXT3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:29:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7962 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728867AbgIXT3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:29:34 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OJO1u8021679
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DMLQuQVs+jJkKU3j8qk3nRyLWAjn1h8Qya2UpIdDJzE=;
 b=VLfEUYhFW7hNnD1zOZGCcRPezKlwq66uwuAJfcR1B8Nwt962EnnMrRmRwuJAv0qlhJKI
 qKRiCg7r628OSUvinRqcHuQrWQ6iXNGXd1gE7h9Kl6j38Y9HRoxXjIUS7ngIagM3HCoO
 rcWABstCKBCcCBVjPv91VUpLCgucRKSz+ms= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp43nfm-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:29:32 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 12:27:13 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 759E199237B; Thu, 24 Sep 2020 12:27:09 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 3/4] mm: introduce page memcg flags
Date:   Thu, 24 Sep 2020 12:27:05 -0700
Message-ID: <20200924192706.3075680-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200924192706.3075680-1-guro@fb.com>
References: <20200924192706.3075680-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_14:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=305
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest bit in page->memcg_data is used to distinguish between
struct memory_cgroup pointer and a pointer to a objcgs array.
All checks and modifications of this bit are open-coded.

Let's formalize it using page memcg flags, defined in page_memcg_flags
enum, and replace all open-coded accesses with test_bit()/__set_bit().

Additional flags might be added later.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2ed36c8562ac..a498a7368cff 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -343,6 +343,15 @@ struct mem_cgroup {
=20
 extern struct mem_cgroup *root_mem_cgroup;
=20
+enum page_memcg_flags {
+	/* page->memcg_data is a pointer to an objcgs vector */
+	PG_MEMCG_OBJ_CGROUPS,
+	/* the next bit after the last actual flag */
+	PG_MEMCG_LAST_FLAG,
+};
+
+#define MEMCG_FLAGS_MASK ((1UL << PG_MEMCG_LAST_FLAG) - 1)
+
 /*
  * page_mem_cgroup - get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -371,13 +380,7 @@ static inline struct mem_cgroup *page_mem_cgroup_che=
ck(struct page *page)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
-	/*
-	 * The lowest bit set means that memcg isn't a valid
-	 * memcg pointer, but a obj_cgroups pointer.
-	 * In this case the page is shared and doesn't belong
-	 * to any specific memory cgroup.
-	 */
-	if (memcg_data & 0x1UL)
+	if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
 		return NULL;
=20
 	return (struct mem_cgroup *)memcg_data;
@@ -422,7 +425,12 @@ static inline void clear_page_mem_cgroup(struct page=
 *page)
  */
 static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
 {
-	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
+	unsigned long memcg_data =3D page->memcg_data;
+
+	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
+					       &memcg_data), page);
+
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_FLAGS_MASK);
 }
=20
 /*
@@ -437,8 +445,8 @@ static inline struct obj_cgroup **page_obj_cgroups_ch=
eck(struct page *page)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
-	if (memcg_data && (memcg_data & 0x1UL))
-		return (struct obj_cgroup **)(memcg_data & ~0x1UL);
+	if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
+		return (struct obj_cgroup **)(memcg_data & ~MEMCG_FLAGS_MASK);
=20
 	return NULL;
 }
@@ -453,7 +461,11 @@ static inline struct obj_cgroup **page_obj_cgroups_c=
heck(struct page *page)
 static inline bool set_page_obj_cgroups(struct page *page,
 					struct obj_cgroup **objcgs)
 {
-	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+	unsigned long memcg_data =3D (unsigned long)objcgs;
+
+	__set_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
+
+	return !cmpxchg(&page->memcg_data, 0, memcg_data);
 }
=20
 /*
--=20
2.26.2

