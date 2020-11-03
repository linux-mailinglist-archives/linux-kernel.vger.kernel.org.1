Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B802A5667
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgKCV1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:27:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733269AbgKCV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:27:32 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3LGpVB006776
        for <linux-kernel@vger.kernel.org>; Tue, 3 Nov 2020 13:27:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=walSf2a8YekbUAXtQSpEnloDpj3eE1RVGgH7QH26TjE=;
 b=hKuRbpZKhEyzaNo/SLPsLj4bCdvugldmLxsWcyAXAOzu5AvnaPNmBf6nBhiPZjGPscaU
 +IdNTOX+eoHgHDGMgp7hJxXQfN1/KvGmOxz+B74VX9bdFvG8n+5zpIW0C+aA6AzSFxCF
 vW/Y1m+GJo9cqlRVeqROQD5il8xUmDjfscs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34kd6j0xs9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:27:31 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 13:27:29 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 5E22E2026690; Tue,  3 Nov 2020 13:27:27 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 1/3] mm: memcg: deprecate the non-hierarchical mode
Date:   Tue, 3 Nov 2020 13:27:23 -0800
Message-ID: <20201103212725.3716088-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201103212725.3716088-1-guro@fb.com>
References: <20201103212725.3716088-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_14:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=1 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-hierarchical cgroup v1 mode is a legacy of early days
of the memory controller and doesn't bring any value today.
However, it complicates the code and creates many edge cases
all over the memory controller code.

It's a good time to deprecate it completely.

Functionally this patch enabled is by default for all cgroups
and forbids switching it off. Nothing changes if cgroup v2 is used:
hierarchical mode was enforced from scratch.

To protect the ABI memory.use_hierarchy interface is preserved
with a limited functionality: reading always returns "1", writing
of "1" passes silently, writing of any other value fails with
-EINVAL and a warning to dmesg (on the first occasion).

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h |  7 ---
 kernel/cgroup/cgroup.c     |  5 ---
 mm/memcontrol.c            | 90 ++++++--------------------------------
 3 files changed, 13 insertions(+), 89 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0f4dd7829fb2..31000929db4b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -234,11 +234,6 @@ struct mem_cgroup {
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
=20
-	/*
-	 * Should the accounting and control be hierarchical, per subtree?
-	 */
-	bool use_hierarchy;
-
 	/*
 	 * Should the OOM killer kill all belonging tasks, had it kill one?
 	 */
@@ -758,8 +753,6 @@ static inline bool mem_cgroup_is_descendant(struct me=
m_cgroup *memcg,
 {
 	if (root =3D=3D memcg)
 		return true;
-	if (!root->use_hierarchy)
-		return false;
 	return cgroup_is_descendant(memcg->css.cgroup, root->css.cgroup);
 }
=20
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f2eeff74d713..621a586e3529 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -281,9 +281,6 @@ bool cgroup_ssid_enabled(int ssid)
  * - cpuset: a task can be moved into an empty cpuset, and again it take=
s
  *   masks of ancestors.
  *
- * - memcg: use_hierarchy is on by default and the cgroup file for the f=
lag
- *   is not created.
- *
  * - blkcg: blk-throttle becomes properly hierarchical.
  *
  * - debug: disallowed on the default hierarchy.
@@ -5156,8 +5153,6 @@ static struct cgroup_subsys_state *css_create(struc=
t cgroup *cgrp,
 	    cgroup_parent(parent)) {
 		pr_warn("%s (%d) created nested cgroup for controller \"%s\" which has=
 incomplete hierarchy support. Nested cgroups may change behavior in the =
future.\n",
 			current->comm, current->pid, ss->name);
-		if (!strcmp(ss->name, "memory"))
-			pr_warn("\"memory\" requires setting use_hierarchy to 1 on the root\n=
");
 		ss->warned_broken_hierarchy =3D true;
 	}
=20
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b0cd4b78d47..2a37785e9abd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1127,12 +1127,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgro=
up *root,
 	if (prev && !reclaim)
 		pos =3D prev;
=20
-	if (!root->use_hierarchy && root !=3D root_mem_cgroup) {
-		if (prev)
-			goto out;
-		return root;
-	}
-
 	rcu_read_lock();
=20
 	if (reclaim) {
@@ -1212,7 +1206,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
=20
 out_unlock:
 	rcu_read_unlock();
-out:
 	if (prev && prev !=3D root)
 		css_put(&prev->css);
=20
@@ -3440,10 +3433,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_dat=
a_t *pgdat, int order,
 }
=20
 /*
- * Test whether @memcg has children, dead or alive.  Note that this
- * function doesn't care whether @memcg has use_hierarchy enabled and
- * returns %true if there are child csses according to the cgroup
- * hierarchy.  Testing use_hierarchy is the caller's responsibility.
+ * Test whether @memcg has children, dead or alive.
  */
 static inline bool memcg_has_children(struct mem_cgroup *memcg)
 {
@@ -3503,37 +3493,20 @@ static ssize_t mem_cgroup_force_empty_write(struc=
t kernfs_open_file *of,
 static u64 mem_cgroup_hierarchy_read(struct cgroup_subsys_state *css,
 				     struct cftype *cft)
 {
-	return mem_cgroup_from_css(css)->use_hierarchy;
+	return 1;
 }
=20
 static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
 				      struct cftype *cft, u64 val)
 {
-	int retval =3D 0;
-	struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
-	struct mem_cgroup *parent_memcg =3D mem_cgroup_from_css(memcg->css.pare=
nt);
-
-	if (memcg->use_hierarchy =3D=3D val)
+	if (val =3D=3D 1)
 		return 0;
=20
-	/*
-	 * If parent's use_hierarchy is set, we can't make any modifications
-	 * in the child subtrees. If it is unset, then the change can
-	 * occur, provided the current cgroup has no children.
-	 *
-	 * For the root cgroup, parent_mem is NULL, we allow value to be
-	 * set if there are no children.
-	 */
-	if ((!parent_memcg || !parent_memcg->use_hierarchy) &&
-				(val =3D=3D 1 || val =3D=3D 0)) {
-		if (!memcg_has_children(memcg))
-			memcg->use_hierarchy =3D val;
-		else
-			retval =3D -EBUSY;
-	} else
-		retval =3D -EINVAL;
+	pr_warn_once("Non-hierarchical mode is deprecated. "
+		     "Please report your usecase to linux-mm@kvack.org if you "
+		     "depend on this functionality.\n");
=20
-	return retval;
+	return -EINVAL;
 }
=20
 static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swa=
p)
@@ -3727,8 +3700,6 @@ static void memcg_offline_kmem(struct mem_cgroup *m=
emcg)
 		child =3D mem_cgroup_from_css(css);
 		BUG_ON(child->kmemcg_id !=3D kmemcg_id);
 		child->kmemcg_id =3D parent->kmemcg_id;
-		if (!memcg->use_hierarchy)
-			break;
 	}
 	rcu_read_unlock();
=20
@@ -5319,38 +5290,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *=
parent_css)
 	if (parent) {
 		memcg->swappiness =3D mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable =3D parent->oom_kill_disable;
-	}
-	if (!parent) {
-		page_counter_init(&memcg->memory, NULL);
-		page_counter_init(&memcg->swap, NULL);
-		page_counter_init(&memcg->kmem, NULL);
-		page_counter_init(&memcg->tcpmem, NULL);
-	} else if (parent->use_hierarchy) {
-		memcg->use_hierarchy =3D true;
+
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
-		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
-		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
-		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
-		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
-		/*
-		 * Deeper hierachy with use_hierarchy =3D=3D false doesn't make
-		 * much sense so let cgroup subsystem know about this
-		 * unfortunate state in our controller.
-		 */
-		if (parent !=3D root_mem_cgroup)
-			memory_cgrp_subsys.broken_hierarchy =3D true;
-	}
+		page_counter_init(&memcg->memory, NULL);
+		page_counter_init(&memcg->swap, NULL);
+		page_counter_init(&memcg->kmem, NULL);
+		page_counter_init(&memcg->tcpmem, NULL);
=20
-	/* The following stuff does not apply to the root */
-	if (!parent) {
 		root_mem_cgroup =3D memcg;
 		return &memcg->css;
 	}
=20
+	/* The following stuff does not apply to the root */
 	error =3D memcg_online_kmem(memcg);
 	if (error)
 		goto fail;
@@ -6187,24 +6142,6 @@ static void mem_cgroup_move_task(void)
 }
 #endif
=20
-/*
- * Cgroup retains root cgroups across [un]mount cycles making it necessa=
ry
- * to verify whether we're attached to the default hierarchy on each mou=
nt
- * attempt.
- */
-static void mem_cgroup_bind(struct cgroup_subsys_state *root_css)
-{
-	/*
-	 * use_hierarchy is forced on the default hierarchy.  cgroup core
-	 * guarantees that @root doesn't have any children, so turning it
-	 * on for the root memcg is enough.
-	 */
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		root_mem_cgroup->use_hierarchy =3D true;
-	else
-		root_mem_cgroup->use_hierarchy =3D false;
-}
-
 static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long valu=
e)
 {
 	if (value =3D=3D PAGE_COUNTER_MAX)
@@ -6542,7 +6479,6 @@ struct cgroup_subsys memory_cgrp_subsys =3D {
 	.can_attach =3D mem_cgroup_can_attach,
 	.cancel_attach =3D mem_cgroup_cancel_attach,
 	.post_attach =3D mem_cgroup_move_task,
-	.bind =3D mem_cgroup_bind,
 	.dfl_cftypes =3D memory_files,
 	.legacy_cftypes =3D mem_cgroup_legacy_files,
 	.early_init =3D 0,
--=20
2.26.2

