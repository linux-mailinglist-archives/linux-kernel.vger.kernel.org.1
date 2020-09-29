Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC127DD27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgI2X73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:59:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13146 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgI2X72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:59:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TNtgXM016420
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=J3JR/fo4mVtkbf3ybeD8TyHNRNb5BoObkpsNWSI6exs=;
 b=nhh5fkjoZgKPAycr7N4o4xOVqCF0Tfup2AtjEOr4aq/HFmscdgDw00XYiDErq6E55o0w
 ZNrvzu6f6L/CtL0m+c/OI3vmfJ/gbX+ociYuD71JM5QaJcSIcppMBlfeXxwslGFg01oR
 N7Iez9Cm6dLAiwtc3lWZuZlGpM977IpaC1k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33t35n875g-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:59:27 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 16:59:25 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 71211D62156; Tue, 29 Sep 2020 16:59:21 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 3/4] mm: introduce page memcg flags
Date:   Tue, 29 Sep 2020 16:59:19 -0700
Message-ID: <20200929235920.537849-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200929235920.537849-1-guro@fb.com>
References: <20200929235920.537849-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=356
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290203
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
---
 include/linux/memcontrol.h | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d4d15c04bbaf..35f846c6b89b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -343,6 +343,15 @@ struct mem_cgroup {
=20
 extern struct mem_cgroup *root_mem_cgroup;
=20
+enum page_memcg_data_flags {
+	/* page->memcg_data is a pointer to an objcgs vector */
+	MEMCG_DATA_OBJCGS,
+	/* the next bit after the last actual flag */
+	__NR_MEMCG_DATA_FLAGS,
+};
+
+#define MEMCG_DATA_FLAGS_MASK ((0x1UL << __NR_MEMCG_DATA_FLAGS) - 1)
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
+	if (memcg_data & (0x1UL << MEMCG_DATA_OBJCGS))
 		return NULL;
=20
 	return (struct mem_cgroup *)memcg_data;
@@ -459,7 +462,12 @@ static inline void clear_page_memcg(struct page *pag=
e)
  */
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
-	return (struct obj_cgroup **)(READ_ONCE(page->memcg_data) & ~0x1UL);
+	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
+
+	VM_BUG_ON_PAGE(memcg_data &&
+		       !(memcg_data & (0x1UL << MEMCG_DATA_OBJCGS)), page);
+
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -474,8 +482,9 @@ static inline struct obj_cgroup **page_objcgs_check(s=
truct page *page)
 {
 	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
=20
-	if (memcg_data && (memcg_data & 0x1UL))
-		return (struct obj_cgroup **)(memcg_data & ~0x1UL);
+	if (memcg_data && (memcg_data & (0x1UL << MEMCG_DATA_OBJCGS)))
+		return (struct obj_cgroup **)
+			(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
=20
 	return NULL;
 }
@@ -490,7 +499,11 @@ static inline struct obj_cgroup **page_objcgs_check(=
struct page *page)
 static inline bool set_page_objcgs(struct page *page,
 					struct obj_cgroup **objcgs)
 {
-	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+	unsigned long memcg_data =3D (unsigned long)objcgs;
+
+	memcg_data |=3D (0x1UL << MEMCG_DATA_OBJCGS);
+
+	return !cmpxchg(&page->memcg_data, 0, memcg_data);
 }
=20
 /*
--=20
2.26.2

