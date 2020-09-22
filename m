Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF60274A87
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVVCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:02:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgIVVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:02:09 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08MKYnaV016640
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:37:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OWbgJScCJjF4/NDWKw0S32FO6Lo1EgQ3Xsl+NSkPRIo=;
 b=SxjqcTLZqfEwQjEkJs1vmv07QIDmijGLUukfXm6S3ebLowY9/p8zh6P3u1jgjOcChTrQ
 j7Nx8Icpc8dXrqp84FnQtw/OUcBPDOD8UlcJS5xbExDlKw8Bb5QghKpcl8lEav3ZOgd5
 o5VAziIpDIQHjpQjeR5Airn6nz7B2/QHglg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 33qn0as92x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:37:27 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 13:37:26 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id D5FB2864B5E; Tue, 22 Sep 2020 13:37:21 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 3/4] mm: introduce page memcg flags
Date:   Tue, 22 Sep 2020 13:36:59 -0700
Message-ID: <20200922203700.2879671-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200922203700.2879671-1-guro@fb.com>
References: <20200922203700.2879671-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_18:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=266 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest bit in page->memcg_data is used to distinguish between
struct memory_cgroup pointer and a pointer to a objcgs array.
All checks and modifications of this bit are open-coded.

Let's formalize it using page memcg flags, defined in page_memcg_flags
enum and replace all open-coded accesses with test_bit()/__set_bit().

Few additional flags might be added later. Flags are intended to be
mutually exclusive.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab3ea3e90583..9a49f1e1c0c7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -343,6 +343,11 @@ struct mem_cgroup {
=20
 extern struct mem_cgroup *root_mem_cgroup;
=20
+enum page_memcg_flags {
+	/* page->memcg_data is a pointer to an objcgs vector */
+	PG_MEMCG_OBJ_CGROUPS,
+};
+
 /*
  * page_mem_cgroup - get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -371,13 +376,7 @@ static inline struct mem_cgroup *page_mem_cgroup_che=
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
@@ -422,7 +421,13 @@ static inline void clear_page_mem_cgroup(struct page=
 *page)
  */
 static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
 {
-	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
+	unsigned long memcg_data =3D page->memcg_data;
+
+	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
+					       &memcg_data), page);
+	__clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
+
+	return (struct obj_cgroup **)memcg_data;
 }
=20
 /*
@@ -437,7 +442,7 @@ static inline struct obj_cgroup **page_obj_cgroups_ch=
eck(struct page *page)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
-	if (memcg_data && (memcg_data & 0x1UL))
+	if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
 		return (struct obj_cgroup **)memcg_data;
=20
 	return NULL;
@@ -453,7 +458,11 @@ static inline struct obj_cgroup **page_obj_cgroups_c=
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

