Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD32ADEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgKJSqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:46:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgKJSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:46:21 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AAIhVex004300
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:46:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ITddvIBkBb3Qhz3BVWTO4nHuqnQYwvA66dzmBGbF/eU=;
 b=ftJis+sF20YXuY+E7tCed7JB0FvL/4BaPNeLbuTHU7anPQnVue4kbY9XZ3cPPvWvCR+O
 ddhG2oD+FbGjDG0ZHVI+9vghFw3TZKHs0WI5L3pAD/FkDJKRu3Kq5q5QNFD2TUK2fwCS
 PX4kOeZ98NXMuRuhIOz8K5OO/aGBADxfkoM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34nr4pye1n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:46:20 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 10:46:18 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 60001238474C; Tue, 10 Nov 2020 10:46:16 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] mm: memcg: fix obsolete code comments
Date:   Tue, 10 Nov 2020 10:46:15 -0800
Message-ID: <20201110184615.311974-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=709 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes/removes some obsolete comments in the code related
to the kernel memory accounting:
- kmem_cache->memcg_params.memcg_caches has been removed
  by commit 9855609bde03 ("mm: memcg/slab: use a single set of
  kmem_caches for all accounted allocations")
- memcg->kmemcg_id is not used as a gate for kmem accounting since
  commit 0b8f73e10428 ("mm: memcontrol: clean up alloc, online,
  offline, free functions")

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 6 ++----
 mm/memcontrol.c            | 6 ------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20108e426f84..01099dfa839c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -310,7 +310,6 @@ struct mem_cgroup {
 	int			tcpmem_pressure;
=20
 #ifdef CONFIG_MEMCG_KMEM
-        /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
 	struct obj_cgroup __rcu *objcg;
@@ -1641,9 +1640,8 @@ static inline void memcg_kmem_uncharge_page(struct =
page *page, int order)
 }
=20
 /*
- * helper for accessing a memcg's index. It will be used as an index in =
the
- * child cache array in kmem_cache, and also to derive its name. This fu=
nction
- * will return -1 when this is not a kmem-limited memcg.
+ * A helper for accessing memcg's kmem_id, used for getting
+ * corresponding LRU lists.
  */
 static inline int memcg_cache_id(struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69a2893a6455..62bbd48d8445 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3680,12 +3680,6 @@ static int memcg_online_kmem(struct mem_cgroup *me=
mcg)
=20
 	static_branch_enable(&memcg_kmem_enabled_key);
=20
-	/*
-	 * A memory cgroup is considered kmem-online as soon as it gets
-	 * kmemcg_id. Setting the id after enabling static branching will
-	 * guarantee no one starts accounting before all call sites are
-	 * patched.
-	 */
 	memcg->kmemcg_id =3D memcg_id;
 	memcg->kmem_state =3D KMEM_ONLINE;
=20
--=20
2.26.2

