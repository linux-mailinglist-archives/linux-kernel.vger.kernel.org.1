Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F281B255170
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 00:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgH0W7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 18:59:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48722 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728010AbgH0W7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:59:25 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RMxIh1029747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:59:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sklp+IHvv9QC8xSZEbMJuDDVHQhUm1zwj1uRypGXaic=;
 b=IrBc9zRlud0NC3ZW+z+YC//P9egx45odDxmsDmbR06Q3+XNC6048muvgYaiPAvapDepi
 dIkt9uxgyw2wCL28AOP2fja1P6M3mMuL8EhAWOYftuL+BMY9/VNBR9wn1pDWdNMgZE7I
 lkXKG96e5quEzWkdYabh7xaCKp8bzsnoNHo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 335up67yce-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:59:24 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 15:58:46 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 6D093393DEE3; Thu, 27 Aug 2020 15:58:44 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH v1 3/4] mm: kmem: prepare remote memcg charging infra for interrupt contexts
Date:   Thu, 27 Aug 2020 15:58:42 -0700
Message-ID: <20200827225843.1270629-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200827225843.1270629-1-guro@fb.com>
References: <20200827225843.1270629-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=5 mlxlogscore=662
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270174
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote memcg charging API uses current->active_memcg to store the
currently active memory cgroup, which overwrites the memory cgroup
of the current process. It works well for normal contexts, but doesn't
work for interrupt contexts: indeed, if an interrupt occurs during
the execution of a section with an active memcg set, all allocations
inside the interrupt will be charged to the active memcg set (given
that we'll enable accounting for allocations from an interrupt
context). But because the interrupt might have no relation to the
active memcg set outside, it's obviously wrong from the accounting
prospective.

To resolve this problem, let's add a global percpu int_active_memcg
variable, which will be used to store an active memory cgroup which
will be used from interrupt contexts. set_active_memcg() will
transparently use current->active_memcg or int_active_memcg depending
on the context.

To make the read part simple and transparent for the caller, let's
introduce two new functions:
  - struct mem_cgroup *active_memcg(void),
  - struct mem_cgroup *get_active_memcg(void).

They are returning the active memcg if it's set, hiding all
implementation details: where to get it depending on the current context.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/sched/mm.h | 13 +++++++++--
 mm/memcontrol.c          | 48 ++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 4c69a4349ac1..030a1cf77b8a 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -304,6 +304,7 @@ static inline void memalloc_nocma_restore(unsigned in=
t flags)
 #endif
=20
 #ifdef CONFIG_MEMCG
+DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
  * set_active_memcg - Starts the remote memcg charging scope.
  * @memcg: memcg to charge.
@@ -318,8 +319,16 @@ static inline void memalloc_nocma_restore(unsigned i=
nt flags)
 static inline struct mem_cgroup *
 set_active_memcg(struct mem_cgroup *memcg)
 {
-	struct mem_cgroup *old =3D current->active_memcg;
-	current->active_memcg =3D memcg;
+	struct mem_cgroup *old;
+
+	if (in_interrupt()) {
+		old =3D this_cpu_read(int_active_memcg);
+		this_cpu_write(int_active_memcg, memcg);
+	} else {
+		old =3D current->active_memcg;
+		current->active_memcg =3D memcg;
+	}
+
 	return old;
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d847257a639..a51a6066079e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -73,6 +73,9 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
=20
 struct mem_cgroup *root_mem_cgroup __read_mostly;
=20
+/* Active memory cgroup to use from an interrupt context */
+DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
+
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket;
=20
@@ -1069,26 +1072,43 @@ struct mem_cgroup *get_mem_cgroup_from_page(struc=
t page *page)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_page);
=20
-/**
- * If current->active_memcg is non-NULL, do not fallback to current->mm-=
>memcg.
- */
-static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(vo=
id)
+static __always_inline struct mem_cgroup *active_memcg(void)
 {
-	if (memcg_kmem_bypass())
-		return NULL;
+	if (in_interrupt())
+		return this_cpu_read(int_active_memcg);
+	else
+		return current->active_memcg;
+}
=20
-	if (unlikely(current->active_memcg)) {
-		struct mem_cgroup *memcg;
+static __always_inline struct mem_cgroup *get_active_memcg(void)
+{
+	struct mem_cgroup *memcg;
=20
-		rcu_read_lock();
+	rcu_read_lock();
+	memcg =3D active_memcg();
+	if (memcg) {
 		/* current->active_memcg must hold a ref. */
-		if (WARN_ON_ONCE(!css_tryget(&current->active_memcg->css)))
+		if (WARN_ON_ONCE(!css_tryget(&memcg->css)))
 			memcg =3D root_mem_cgroup;
 		else
 			memcg =3D current->active_memcg;
-		rcu_read_unlock();
-		return memcg;
 	}
+	rcu_read_unlock();
+
+	return memcg;
+}
+
+/**
+ * If active memcg is set, do not fallback to current->mm->memcg.
+ */
+static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(vo=
id)
+{
+	if (memcg_kmem_bypass())
+		return NULL;
+
+	if (unlikely(active_memcg()))
+		return get_active_memcg();
+
 	return get_mem_cgroup_from_mm(current->mm);
 }
=20
@@ -2920,8 +2940,8 @@ __always_inline struct obj_cgroup *get_obj_cgroup_f=
rom_current(void)
 		return NULL;
=20
 	rcu_read_lock();
-	if (unlikely(current->active_memcg))
-		memcg =3D rcu_dereference(current->active_memcg);
+	if (unlikely(active_memcg()))
+		memcg =3D active_memcg();
 	else
 		memcg =3D mem_cgroup_from_task(current);
=20
--=20
2.26.2

