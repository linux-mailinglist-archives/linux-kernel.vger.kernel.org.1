Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF92046EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbgFWB7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 21:59:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58444 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731916AbgFWB6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:58:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05N1wElY003333
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:58:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pNPRuF5LajF9VNFx2UDWcECUyJwt02enUzuyXlWJX/A=;
 b=PN0FUSV5FKlBizfu8v2GUC/b920MIWFbwVbREK9jJ6OygdWkaiMa+D76OrYcJg/tsf0o
 5cGFk9o2zTykFxpk4e7ZSQytendkn7/oRVcxCaSfKa6Qtf0zH0pjjMTypBWfI6F/3ai9
 oyrEslu/cPWzI00b1UNEjfYWDioWN7bj1hI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31se4nknfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:58:54 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 18:58:53 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 2F36E26DD01A; Mon, 22 Jun 2020 18:58:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1291.vll0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: vll0c01
Subject: [PATCH v7 01/19] mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
Date:   Mon, 22 Jun 2020 18:58:28 -0700
Message-ID: <20200623015846.1141975-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623015846.1141975-1-guro@fb.com>
References: <20200623015846.1141975-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_16:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230012
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To convert memcg and lruvec slab counters to bytes there must be a way to
change these counters without touching node counters.  Factor out
__mod_memcg_lruvec_state() out of __mod_lruvec_state().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 17 +++++++++++++++
 mm/memcontrol.c            | 43 +++++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e77197a62809..b250f8197710 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -679,11 +679,23 @@ static inline unsigned long lruvec_page_state_local=
(struct lruvec *lruvec,
 	return x;
 }
=20
+void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item=
 idx,
+			      int val);
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
 void mod_memcg_obj_state(void *p, int idx, int val);
=20
+static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
+					  enum node_stat_item idx, int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_memcg_lruvec_state(lruvec, idx, val);
+	local_irq_restore(flags);
+}
+
 static inline void mod_lruvec_state(struct lruvec *lruvec,
 				    enum node_stat_item idx, int val)
 {
@@ -1057,6 +1069,11 @@ static inline unsigned long lruvec_page_state_loca=
l(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
=20
+static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+					    enum node_stat_item idx, int val)
+{
+}
+
 static inline void __mod_lruvec_state(struct lruvec *lruvec,
 				      enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 19622328e4b5..13ab84c7e4ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -713,30 +713,13 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int=
 nid)
 	return mem_cgroup_nodeinfo(parent, nid);
 }
=20
-/**
- * __mod_lruvec_state - update lruvec memory statistics
- * @lruvec: the lruvec
- * @idx: the stat item
- * @val: delta to add to the counter, can be negative
- *
- * The lruvec is the intersection of the NUMA node and a cgroup. This
- * function updates the all three counters that are affected by a
- * change of state at this level: per-node, per-cgroup, per-lruvec.
- */
-void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			int val)
+void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item=
 idx,
+			      int val)
 {
-	pg_data_t *pgdat =3D lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
 	long x;
=20
-	/* Update node */
-	__mod_node_page_state(pgdat, idx, val);
-
-	if (mem_cgroup_disabled())
-		return;
-
 	pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg =3D pn->memcg;
=20
@@ -748,6 +731,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum n=
ode_stat_item idx,
=20
 	x =3D val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
 	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+		pg_data_t *pgdat =3D lruvec_pgdat(lruvec);
 		struct mem_cgroup_per_node *pi;
=20
 		for (pi =3D pn; pi; pi =3D parent_nodeinfo(pi, pgdat->node_id))
@@ -757,6 +741,27 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum =
node_stat_item idx,
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
 }
=20
+/**
+ * __mod_lruvec_state - update lruvec memory statistics
+ * @lruvec: the lruvec
+ * @idx: the stat item
+ * @val: delta to add to the counter, can be negative
+ *
+ * The lruvec is the intersection of the NUMA node and a cgroup. This
+ * function updates the all three counters that are affected by a
+ * change of state at this level: per-node, per-cgroup, per-lruvec.
+ */
+void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			int val)
+{
+	/* Update node */
+	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
+
+	/* Update memcg and lruvec */
+	if (!mem_cgroup_disabled())
+		__mod_memcg_lruvec_state(lruvec, idx, val);
+}
+
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 {
 	pg_data_t *pgdat =3D page_pgdat(virt_to_page(p));
--=20
2.26.2

