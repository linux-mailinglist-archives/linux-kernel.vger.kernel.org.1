Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09FE299ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440776AbgJ0AR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:17:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411559AbgJ0ARN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:17:13 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09R0ECNM021692
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:17:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3rIRSirqbzeluC/DfnXT13ZlbHjK+JwhEzfsOd/ByQU=;
 b=eaC16wdkYCbuqawmvGz3hPrTmO2OKQBi7llbd8v5QVXzd/cGAqSjtaoBx/lsYgXEuMJz
 l26INIS8/xQYAVGNolJlDDo/LE2J7zcXjSk3t54sOWSLN+B2mgeH/Y4O7iJNBd4jZhb+
 q+HuC5vd2bwzSPT/MVuKcXDUyGTEROe+MNc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34d43k8agr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:17:13 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 17:17:11 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 80EFA1C56459; Mon, 26 Oct 2020 17:17:04 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v6 3/4] mm: introduce page memcg flags
Date:   Mon, 26 Oct 2020 17:16:56 -0700
Message-ID: <20201027001657.3398190-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201027001657.3398190-1-guro@fb.com>
References: <20201027001657.3398190-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_17:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=328 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270000
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c7ac0a5b8989..99a4841d658b 100644
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
@@ -429,7 +432,11 @@ static inline struct mem_cgroup *page_memcg_check(st=
ruct page *page)
  */
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
-	return (struct obj_cgroup **)(READ_ONCE(page->memcg_data) & ~0x1UL);
+	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
+
+	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), page);
+
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -444,10 +451,10 @@ static inline struct obj_cgroup **page_objcgs_check=
(struct page *page)
 {
 	unsigned long memcg_data =3D READ_ONCE(page->memcg_data);
=20
-	if (memcg_data && (memcg_data & 0x1UL))
-		return (struct obj_cgroup **)(memcg_data & ~0x1UL);
+	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
+		return NULL;
=20
-	return NULL;
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
=20
 /*
@@ -460,7 +467,8 @@ static inline struct obj_cgroup **page_objcgs_check(s=
truct page *page)
 static inline bool set_page_objcgs(struct page *page,
 					struct obj_cgroup **objcgs)
 {
-	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs |
+			MEMCG_DATA_OBJCGS);
 }
 #else
 static inline struct obj_cgroup **page_objcgs(struct page *page)
--=20
2.26.2

