Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7F1F225E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 01:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgFHXHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 19:07:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4574 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727798AbgFHXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 058N3nqX007127
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jun 2020 16:07:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9d4i47/Wor+EnK5dsI8GhsBJznuGMBZQECFUL1+51CY=;
 b=pEgbgoqODLHNxNjPE1G9RdNzUvM9hGx7k30i2DYc5zSawFUACqGmR7TMagkrKEaKlrgz
 wnCFeYcxy+/91TTb4JMofyce6GpK5nr7+8jHR9XDPk970o0Lah9S1JZiydsJzfY8aPGB
 4czbyaqnYMWs5iFcokkW2Y2jDekaHa1SscI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31g6tkjf3k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:07:06 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 16:07:03 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 2C6AD1D8FE3E; Mon,  8 Jun 2020 16:07:00 -0700 (PDT)
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
Subject: [PATCH v6 02/19] mm: memcg: prepare for byte-sized vmstat items
Date:   Mon, 8 Jun 2020 16:06:37 -0700
Message-ID: <20200608230654.828134-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To implement per-object slab memory accounting, we need to
convert slab vmstat counters to bytes. Actually, out of
4 levels of counters: global, per-node, per-memcg and per-lruvec
only two last levels will require byte-sized counters.
It's because global and per-node counters will be counting the
number of slab pages, and per-memcg and per-lruvec will be
counting the amount of memory taken by charged slab objects.

Converting all vmstat counters to bytes or even all slab
counters to bytes would introduce an additional overhead.
So instead let's store global and per-node counters
in pages, and memcg and lruvec counters in bytes.

To make the API clean all access helpers (both on the read
and write sides) are dealing with bytes.

To avoid back-and-forth conversions a new flavor of read-side
helpers is introduced, which always returns values in pages:
node_page_state_pages() and global_node_page_state_pages().

Actually new helpers are just reading raw values. Old helpers are
simple wrappers, which will complain on an attempt to read
byte value, because at the moment no one actually needs bytes.

Thanks to Johannes Weiner for the idea of having the byte-sized API
on top of the page-sized internal storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/base/node.c    |  2 +-
 include/linux/mmzone.h | 10 ++++++++++
 include/linux/vmstat.h | 14 +++++++++++++-
 mm/memcontrol.c        | 14 ++++++++++----
 mm/vmstat.c            | 30 ++++++++++++++++++++++++++----
 5 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 5b02f69769e8..e21e31359297 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -513,7 +513,7 @@ static ssize_t node_read_vmstat(struct device *dev,
=20
 	for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		n +=3D sprintf(buf+n, "%s %lu\n", node_stat_name(i),
-			     node_page_state(pgdat, i));
+			     node_page_state_pages(pgdat, i));
=20
 	return n;
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c4c37fd12104..fa8eb49d9898 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -206,6 +206,16 @@ enum node_stat_item {
 	NR_VM_NODE_STAT_ITEMS
 };
=20
+/*
+ * Returns true if the value is measured in bytes (most vmstat values ar=
e
+ * measured in pages). This defines the API part, the internal represent=
ation
+ * might be different.
+ */
+static __always_inline bool vmstat_item_in_bytes(enum node_stat_item ite=
m)
+{
+	return false;
+}
+
 /*
  * We do arithmetic on the LRU lists in various places in the code,
  * so it is important to keep the active lists LRU_ACTIVE higher in
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index aa961088c551..91220ace31da 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -8,6 +8,7 @@
 #include <linux/vm_event_item.h>
 #include <linux/atomic.h>
 #include <linux/static_key.h>
+#include <linux/mmdebug.h>
=20
 extern int sysctl_stat_interval;
=20
@@ -192,7 +193,8 @@ static inline unsigned long global_zone_page_state(en=
um zone_stat_item item)
 	return x;
 }
=20
-static inline unsigned long global_node_page_state(enum node_stat_item i=
tem)
+static inline
+unsigned long global_node_page_state_pages(enum node_stat_item item)
 {
 	long x =3D atomic_long_read(&vm_node_stat[item]);
 #ifdef CONFIG_SMP
@@ -202,6 +204,13 @@ static inline unsigned long global_node_page_state(e=
num node_stat_item item)
 	return x;
 }
=20
+static inline unsigned long global_node_page_state(enum node_stat_item i=
tem)
+{
+	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+
+	return global_node_page_state_pages(item);
+}
+
 static inline unsigned long zone_page_state(struct zone *zone,
 					enum zone_stat_item item)
 {
@@ -242,9 +251,12 @@ extern unsigned long sum_zone_node_page_state(int no=
de,
 extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item i=
tem);
 extern unsigned long node_page_state(struct pglist_data *pgdat,
 						enum node_stat_item item);
+extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
+					   enum node_stat_item item);
 #else
 #define sum_zone_node_page_state(node, item) global_zone_page_state(item=
)
 #define node_page_state(node, item) global_node_page_state(item)
+#define node_page_state_pages(node, item) global_node_page_state_pages(i=
tem)
 #endif /* CONFIG_NUMA */
=20
 #ifdef CONFIG_SMP
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8a91e98556b..07d02e61a73e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -681,13 +681,16 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgrou=
p_tree_per_node *mctz)
  */
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
-	long x;
+	long x, threshold =3D MEMCG_CHARGE_BATCH;
=20
 	if (mem_cgroup_disabled())
 		return;
=20
+	if (vmstat_item_in_bytes(idx))
+		threshold <<=3D PAGE_SHIFT;
+
 	x =3D val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+	if (unlikely(abs(x) > threshold)) {
 		struct mem_cgroup *mi;
=20
 		/*
@@ -718,7 +721,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, =
enum node_stat_item idx,
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
-	long x;
+	long x, threshold =3D MEMCG_CHARGE_BATCH;
=20
 	pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg =3D pn->memcg;
@@ -729,8 +732,11 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec,=
 enum node_stat_item idx,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
=20
+	if (vmstat_item_in_bytes(idx))
+		threshold <<=3D PAGE_SHIFT;
+
 	x =3D val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+	if (unlikely(abs(x) > threshold)) {
 		pg_data_t *pgdat =3D lruvec_pgdat(lruvec);
 		struct mem_cgroup_per_node *pi;
=20
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 80c9b6221535..f1c321e1d6d3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -341,6 +341,11 @@ void __mod_node_page_state(struct pglist_data *pgdat=
, enum node_stat_item item,
 	long x;
 	long t;
=20
+	if (vmstat_item_in_bytes(item)) {
+		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
+		delta >>=3D PAGE_SHIFT;
+	}
+
 	x =3D delta + __this_cpu_read(*p);
=20
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -398,6 +403,8 @@ void __inc_node_state(struct pglist_data *pgdat, enum=
 node_stat_item item)
 	s8 __percpu *p =3D pcp->vm_node_stat_diff + item;
 	s8 v, t;
=20
+	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+
 	v =3D __this_cpu_inc_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -442,6 +449,8 @@ void __dec_node_state(struct pglist_data *pgdat, enum=
 node_stat_item item)
 	s8 __percpu *p =3D pcp->vm_node_stat_diff + item;
 	s8 v, t;
=20
+	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+
 	v =3D __this_cpu_dec_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -541,6 +550,11 @@ static inline void mod_node_state(struct pglist_data=
 *pgdat,
 	s8 __percpu *p =3D pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
=20
+	if (vmstat_item_in_bytes(item)) {
+		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
+		delta >>=3D PAGE_SHIFT;
+	}
+
 	do {
 		z =3D 0;  /* overflow to node counters */
=20
@@ -989,8 +1003,8 @@ unsigned long sum_zone_numa_state(int node,
 /*
  * Determine the per node value of a stat item.
  */
-unsigned long node_page_state(struct pglist_data *pgdat,
-				enum node_stat_item item)
+unsigned long node_page_state_pages(struct pglist_data *pgdat,
+				    enum node_stat_item item)
 {
 	long x =3D atomic_long_read(&pgdat->vm_stat[item]);
 #ifdef CONFIG_SMP
@@ -999,6 +1013,14 @@ unsigned long node_page_state(struct pglist_data *p=
gdat,
 #endif
 	return x;
 }
+
+unsigned long node_page_state(struct pglist_data *pgdat,
+			      enum node_stat_item item)
+{
+	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+
+	return node_page_state_pages(pgdat, item);
+}
 #endif
=20
 #ifdef CONFIG_COMPACTION
@@ -1581,7 +1603,7 @@ static void zoneinfo_show_print(struct seq_file *m,=
 pg_data_t *pgdat,
 		seq_printf(m, "\n  per-node stats");
 		for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   node_page_state(pgdat, i));
+				   node_page_state_pages(pgdat, i));
 		}
 	}
 	seq_printf(m,
@@ -1702,7 +1724,7 @@ static void *vmstat_start(struct seq_file *m, loff_=
t *pos)
 #endif
=20
 	for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		v[i] =3D global_node_page_state(i);
+		v[i] =3D global_node_page_state_pages(i);
 	v +=3D NR_VM_NODE_STAT_ITEMS;
=20
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
--=20
2.25.4

