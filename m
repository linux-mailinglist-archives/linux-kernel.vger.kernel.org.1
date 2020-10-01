Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1527F6AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgJAA1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:27:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63106 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731915AbgJAA1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:27:23 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0910QS08029753
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dpxtskcYy2IkajGXOLE8b65py0lMSTMcjWtCzd6f9dY=;
 b=efLaWR9ljHfMH5Pl3RQHXtqbQsWhYxNTyWt6iYxQcp0d2qllX1K4Nsa1xdE2anPm6Zx1
 dADG/Z75emros7uXWfQZ8PIf5aGwyGRvCiBVgtB2vNZRJbHYmTbHJYsJia5k/3pKusmN
 Pjng3XWmc98pvU2RK45NwncSLyFPzBOgQK8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33vtgc3pqb-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:27:22 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 17:27:21 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id CD2D2DE966B; Wed, 30 Sep 2020 17:27:17 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 3/4] mm: introduce page memcg flags
Date:   Wed, 30 Sep 2020 17:27:09 -0700
Message-ID: <20201001002710.748166-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201001002710.748166-1-guro@fb.com>
References: <20201001002710.748166-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_13:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=406 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest bit in page->memcg_data is used to distinguish between
struct memory_cgroup pointer and a pointer to a objcgs array.
All checks and modifications of this bit are open-coded.

Let's formalize it using page memcg flags, defined in enum
page_memcg_data_flags.

Additional flags might be added later.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7e3da7cdc1ba..5e05599e1f74 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -343,6 +343,15 @@ struct mem_cgroup {
=20
 extern struct mem_cgroup *root_mem_cgroup;
=20
+enum page_memcg_data_flags {
+	/* page->memcg_data is a pointer to an objcgs vector */
+	MEMCG_DATA_OBJCGS =3D (1UL << 0),
+	/* the next bit after the last actual flag */
+	__NR_MEMCG_DATA_FLAGS  =3D (1UL << 1),
+};
+
+#define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
+
 /*
  * page_memcg - get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -404,13 +413,7 @@ static inline struct mem_cgroup *page_memcg_check(st=
ruct page *page)
 	 */
 	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
=20
-	/*
-	 * The lowest bit set means that memcg isn't a valid
-	 * memcg pointer, but a obj_cgroups pointer.
-	 * In this case the page is shared and doesn't belong
-	 * to any specific memory cgroup.
-	 */
-	if (memcg_data & 0x1UL)
+	if (memcg_data & MEMCG_DATA_OBJCGS)
 		return NULL;
=20
 	return (struct mem_cgroup *)memcg_data;
@@ -448,7 +451,12 @@ static inline void set_page_memcg(struct page *page,=
 struct mem_cgroup *memcg)
  */
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
-	return (struct obj_cgroup **)(READ_ONCE(page->memcg_data) & ~0x1UL);
+	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
+
+	VM_BUG_ON_PAGE(memcg_data &&
+		       !(memcg_data & MEMCG_DATA_OBJCGS), page);
+
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -463,8 +471,9 @@ static inline struct obj_cgroup **page_objcgs_check(s=
truct page *page)
 {
 	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
=20
-	if (memcg_data && (memcg_data & 0x1UL))
-		return (struct obj_cgroup **)(memcg_data & ~0x1UL);
+	if (memcg_data && (memcg_data & MEMCG_DATA_OBJCGS))
+		return (struct obj_cgroup **)
+			(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
=20
 	return NULL;
 }
@@ -479,7 +488,11 @@ static inline struct obj_cgroup **page_objcgs_check(=
struct page *page)
 static inline bool set_page_objcgs(struct page *page,
 					struct obj_cgroup **objcgs)
 {
-	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+	unsigned long memcg_data =3D (unsigned long)objcgs;
+
+	memcg_data |=3D MEMCG_DATA_OBJCGS;
+
+	return !cmpxchg(&page->memcg_data, 0, memcg_data);
 }
 #else
 static inline struct obj_cgroup **page_objcgs(struct page *page)
--=20
2.26.2

