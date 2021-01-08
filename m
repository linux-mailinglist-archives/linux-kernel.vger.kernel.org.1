Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D682EEB2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbhAHCE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:04:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbhAHCEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:04:25 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1081wkJt003470
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jan 2021 18:03:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=pRYJLLzOZvumxDbhEHf/OPArDN25i7TvdvWCfdrC2ZM=;
 b=BIl1yD9l+tm+SxPL2zEEE/nFL/RHIwGIwXkLvpv4YvzRuyrCw47cgFabjkeyrcehZoDv
 vNjDBUQ0XK97QhwucWl0hWFx46ZdXj8IT37Yw55JmJZqVUNFWy8QG1zvQ+0YQADSDdLA
 gji6PcMNM1zZ1HHwZAY9k7ru0oF5iLCnQsI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35wpuv64rn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 18:03:44 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 18:03:43 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 7C6942B33436; Thu,  7 Jan 2021 18:03:41 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] mm: kmem: make __memcg_kmem_(un)charge static
Date:   Thu, 7 Jan 2021 18:03:32 -0800
Message-ID: <20210108020332.4096911-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_11:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=745 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that __memcg_kmem_charge() and __memcg_kmem_uncharge()
are not used anywhere except memcontrol.c. Yet they are not declared
as non-static and are declared in memcontrol.h.

This patch makes them static.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h |  3 ---
 mm/memcontrol.c            | 11 ++++++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 41bbf71edd9f..7a38a1517a05 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1592,9 +1592,6 @@ static inline void memcg_set_shrinker_bit(struct me=
m_cgroup *memcg,
 #endif
=20
 #ifdef CONFIG_MEMCG_KMEM
-int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
-			unsigned int nr_pages);
-void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pag=
es);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
=20
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d74b80fa4de..61f7c9ca14b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -255,6 +255,11 @@ struct cgroup_subsys_state *vmpressure_to_css(struct=
 vmpressure *vmpr)
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
=20
+static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
+			       unsigned int nr_pages);
+static void __memcg_kmem_uncharge(struct mem_cgroup *memcg,
+				  unsigned int nr_pages);
+
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg =3D container_of(ref, struct obj_cgroup, refcn=
t);
@@ -3084,8 +3089,8 @@ static void memcg_free_cache_id(int id)
  *
  * Returns 0 on success, an error code on failure.
  */
-int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
-			unsigned int nr_pages)
+static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
+			       unsigned int nr_pages)
 {
 	struct page_counter *counter;
 	int ret;
@@ -3117,7 +3122,7 @@ int __memcg_kmem_charge(struct mem_cgroup *memcg, g=
fp_t gfp,
  * @memcg: memcg to uncharge
  * @nr_pages: number of pages to uncharge
  */
-void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pag=
es)
+static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int=
 nr_pages)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
--=20
2.26.2

