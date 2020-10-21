Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF782952FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504997AbgJUTdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:33:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30518 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504781AbgJUTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:33:53 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09LJOx5L018484;
        Wed, 21 Oct 2020 12:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4hLLvQV9rYghnASbRR5Tcrfq2Td7XiYda4vsSeNbCP8=;
 b=fPJ5Gi4Hza50Rt1SLSU1sUmaQ8x1/VNS+ki2nP2E0EhnmpBj8ggO076sOG0MueOXg1bB
 u6VYgoh7OA35Qs9SgW0PxIzMIrlc9apim+StGoGAUKCtkajkhAvFV9jfE+lB9lwantf6
 KIh2LewuWbWLihkTS73DwMSvO6XLQ2djsdg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34a1tt7rpj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Oct 2020 12:33:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 21 Oct 2020 12:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs/iWmuX9V9aCUQOh1UnW0R/hCBfr/tmU1IeRKDUV7fBY4ZscWMS30P/Qx2FQBPNc3hQIn+4GlDsdPCEeTcTh5ndvUKgDE8zSG3mCpY/FrgoeXLEAPsY/skAu/+xjAXaf3L7tRVK0p1JaXo+DjL2HdkoXvX55fJkf+W56DZ75Bqrexi5Ho0N7JEjsPvJkCGTUVizoRUDjzKBv8zjgGgFdU/dFwo20bW7fAmNHY276cyUSrr0sHLCdreUE618MVl0xxRiwuRiQFVH29Spfs9w9sJwXx1iiTg7uKBar7Da9ZCPdRPTsmxlMj7X9vIWt/nSV7Hg9tGQELcRavGR3Wx99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hLLvQV9rYghnASbRR5Tcrfq2Td7XiYda4vsSeNbCP8=;
 b=U04/DktwgiCCuzszMjQKxuWYjf3s6K5kRVn2iOA9jVBp7N7Jz2OnragPdOOwjT70ilczGP73qRkEUHT59084jaVrVGk0ri4bBcMI7J3OGZGG4TOgFq2GcBrIDifdt0sKkjfDGGSiYmKgTSqCDUn7PX8ccALPrZngvks+92mx+HIP/cQhMC6tzxODorliUL1jSZaV6kskEtLfxiro3yrJh7zOMHHMjfLthoFGcccTG7zSqr/GhpGV903/aITMGeCtBquQpjVgMA3Np70K9psoKZAb5R6eU7xDGe8RdCZ8q3TU/pvz+ptOODtoFcyigQ6Usw00xVzF4COjGdhDHd3Z9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hLLvQV9rYghnASbRR5Tcrfq2Td7XiYda4vsSeNbCP8=;
 b=HPXdcVIcd9JD2JP06xJT5y/Ue8lZh9RnKlkbZ47nx+4F7vXvtpTT1PRnlEAFFe7x4GOhSieItZc3siMEhDZXgHg+Vaadi2Q+dBi78s0O1R0k6i2JjkNAdjK5wtKejo5lYEFCh1oQQreQtTG+V1nVLEnlLtcgHn/DpOOL+waXedQ=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3158.namprd15.prod.outlook.com (2603:10b6:a03:104::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 19:33:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 19:33:28 +0000
Date:   Wed, 21 Oct 2020 12:33:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        <ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
 <20201020181822.GA397401@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020181822.GA397401@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:5b8e]
X-ClientProxiedBy: CO2PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:104:1::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5b8e) by CO2PR05CA0097.namprd05.prod.outlook.com (2603:10b6:104:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.13 via Frontend Transport; Wed, 21 Oct 2020 19:33:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00b83e78-0c32-4900-9f32-08d875f82f3b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3158:
X-Microsoft-Antispam-PRVS: <BYAPR15MB315811C352F8D9ACBB7A72C4BE1C0@BYAPR15MB3158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjpqc5pEC3ubFon7eg19b2dmJ0yW+ZnkmW9CHSls0sOLZnUphSiXH6WbhzAtRLO3vS0vCUufn6FuHoHWGrqVGI3QbsIarblRw438zL/90eVTZgOYAwUHW5wYfCxgMRQ9wJBcAIUIy8wRilPL8+L1Cn3DST9vGNb12vY9iMKuDDP5qLHGcMqhdqA3O1DR17PcuwEfXkUY7z5ZZS7Vf5IdaCDJkctpGJla5cvP6IBFUTMO0QS00V0H7Xb31mSMRrF2gI4+JGTMZZc3iVkqHx2XSF81gSJ909AYZkEqr+KSTYEtL/i8AlHPyL9j/9PY2t5IHwATxDtC+TNMHqX97KCN9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(396003)(136003)(8676002)(86362001)(9686003)(478600001)(7416002)(5660300002)(33656002)(4326008)(6916009)(2906002)(1076003)(52116002)(8936002)(30864003)(6506007)(16526019)(7696005)(66946007)(55016002)(53546011)(6666004)(186003)(54906003)(66556008)(83380400001)(316002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hSHaWWrjOqDR0D2XW4AWYvqCGiHc7cZio5jXCnimpi2+DGFF7H0R8Y98SlvObGQmK6BUkWI5qHd4sAcsgbEzm0kpkhDl3DacCuD3MmXLYUJWSwr9oZHy+u8ujAjHpzSy/qLboxpPHdltPEL9UTYtgaqiiDusm8ZEFuzWbb3NLkcLPY/fHPmtWbMvqnVPqw+yxxud0ByyXkCfs0q7ZC0YGIp1ckpKAqysiz5h3oZNEtVnRSdJ+Gy1apAl+seDSixWrVy79PYvi/UxGl3r34AHxxdgA9LkAYM/ad6mJej0jaxJ6Ra60EgkHx+H0yS2tvKmt0Qm8acd2Rp+cqacihcVFRCpWs5MT/EA1HnLo2WRWV36E6lsyv4DNaGocajn0Vp2Yppqmvmax/U2hoEZW5SPGKC+u8qvuEoldhcEH44CgU7youQ9cXpc5cwJKckYvJL+my+Lz2Ni+it8hK6Sw1lfMnHLzw6FKUvR2t9DU7C0H8DRou3YcvKjgvo5OQ7/EH4TyGh6K6QWxrlrPa3wwLjUtz+dFr2ubJS3AKTxZiYQGAXB7YZ81RFyDws3eqAWB/Z0z12SQITJ3eFCQbVX2ijClHes8kp+zkmQEQlrW5cAQ0GLT9rlVT1WtIN8G8tFMZN8YksfjQncg/cTuWNbzGnYSww0aTAAc6UQ372JCb+znPc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b83e78-0c32-4900-9f32-08d875f82f3b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 19:33:28.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF+n1/BRH1WJlF2xaWasWiPHfUAwmj7lG9+bvSEhhM85UUiDF1yNh+cF6hW4HuCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3158
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_12:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=7
 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010210138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:18:22PM -0400, Johannes Weiner wrote:
> On Tue, Oct 20, 2020 at 10:07:17AM -0700, Roman Gushchin wrote:
> > If we want these counter to function properly, then we should go into the opposite
> > direction and remove the special handling of the root memory cgroup in many places.
> 
> I suspect this is also by far the most robust solution from a code and
> maintenance POV.
> 
> I don't recall the page counter at the root level having been a
> concern in recent years, even though it's widely used in production
> environments. It's lockless and cache compact. It's also per-cpu
> batched, which means it isn't actually part of the memcg hotpath.


I agree.

Here is my first attempt. Comments are welcome!

It doesn't solve the original problem though (use_hierarchy == false and
objcg reparenting), I'll send a separate patch for that.

Thanks!

--

From 9c7d94a3f999447417b02a7100527ce1922bc252 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Tue, 20 Oct 2020 18:05:43 -0700
Subject: [PATCH RFC] mm: memcontrol: do not treat the root memory cgroup
 specially

Currently the root memory cgroup is treated in a special way:
it's not charged and uncharged directly (only indirectly with their
descendants), processes belonging to the root memory cgroup are exempt
from the kernel- and the socket memory accounting.

At the same time some of root level statistics and data are available
to a user:
  - cgroup v2: memory.stat
  - cgroup v1: memory.stat, memory.usage_in_bytes, memory.memsw.usage_in_bytes,
               memory.kmem.usage_in_bytes and memory.kmem.tcp.usage_in_bytes

Historically the reason for a special treatment was an avoidance
of extra performance cost, however now it's unlikely a good reason:
over years there was a significant improvement in the performance
of the memory cgroup code. Also on a modern system actively using
cgroups (e.g. managed by systemd) there are usually no (significant)
processes in the root memory cgroup.

The special treatment of the root memory cgroups creates a number of
issues visible to a user:
1) slab stats on the root level do not include the slab memory
   consumed by processes in the root memory cgroup
2) non-slab kernel memory consumed by processes in the root memory cgroup
   is not included into memory.kmem.usage_in_bytes
3) socket memory consumed by processes in the root memory cgroup
   is not included into memory.kmem.tcp.usage_in_bytes

It complicates the code and increases a risk of new bugs.

This patch removes a number of exceptions related to the handling of
the root memory cgroup. With this patch applied the root memory cgroup
is treated uniformly to other cgroups in the following cases:
1) root memory cgroup is charged and uncharged directly, try_charge()
   and cancel_charge() do not return immediately if the root memory
   cgroups is passed. uncharge_batch() and __mem_cgroup_clear_mc()
   do not handle the root memory cgroup specially.
2) per-memcg slab statistics is gathered for the root memory cgroup
3) shrinkers infra treats the root memory cgroup as any other memory
   cgroup
4) non-slab kernel memory accounting doesn't exclude pages allocated
   by processes belonging to the root memory cgroup
5) if a socket is opened by a process in the root memory cgroup,
   the socket memory is accounted
6) root cgroup is charged for the used swap memory.

Signed-off-by: Roman Gushchin <guro@fb.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  3 +-
 mm/memcontrol.c            | 82 ++++++++++++++------------------------
 mm/vmscan.c                |  9 +----
 3 files changed, 31 insertions(+), 63 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e391e3c56de5..d3653eb5d1b2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -416,8 +416,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
 {
 	/*
-	 * The root memcg doesn't account charges, and doesn't support
-	 * protection.
+	 * The root memcg doesn't support memory protection.
 	 */
 	return !mem_cgroup_disabled() && !mem_cgroup_is_root(memcg);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..a8bdca0f58f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -438,9 +438,6 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
 	struct memcg_shrinker_map *map;
 	int nid;
 
-	if (mem_cgroup_is_root(memcg))
-		return;
-
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
 		map = rcu_dereference_protected(pn->shrinker_map, true);
@@ -455,9 +452,6 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 	struct memcg_shrinker_map *map;
 	int nid, size, ret = 0;
 
-	if (mem_cgroup_is_root(memcg))
-		return 0;
-
 	mutex_lock(&memcg_shrinker_map_mutex);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
@@ -489,8 +483,6 @@ int memcg_expand_shrinker_maps(int new_id)
 		goto unlock;
 
 	for_each_mem_cgroup(memcg) {
-		if (mem_cgroup_is_root(memcg))
-			continue;
 		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
@@ -506,7 +498,7 @@ int memcg_expand_shrinker_maps(int new_id)
 
 void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
-	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
+	if (shrinker_id >= 0 && memcg) {
 		struct memcg_shrinker_map *map;
 
 		rcu_read_lock();
@@ -868,7 +860,7 @@ void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 	memcg = mem_cgroup_from_obj(p);
 
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg || memcg == root_mem_cgroup) {
+	if (!memcg) {
 		__mod_node_page_state(pgdat, idx, val);
 	} else {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -2439,8 +2431,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							     gfp_mask, true);
 		psi_memstall_leave(&pflags);
-	} while ((memcg = parent_mem_cgroup(memcg)) &&
-		 !mem_cgroup_is_root(memcg));
+	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	return nr_reclaimed;
 }
@@ -2532,8 +2523,7 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 		overage = calculate_overage(page_counter_read(&memcg->memory),
 					    READ_ONCE(memcg->memory.high));
 		max_overage = max(overage, max_overage);
-	} while ((memcg = parent_mem_cgroup(memcg)) &&
-		 !mem_cgroup_is_root(memcg));
+	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	return max_overage;
 }
@@ -2548,8 +2538,7 @@ static u64 swap_find_max_overage(struct mem_cgroup *memcg)
 		if (overage)
 			memcg_memory_event(memcg, MEMCG_SWAP_HIGH);
 		max_overage = max(overage, max_overage);
-	} while ((memcg = parent_mem_cgroup(memcg)) &&
-		 !mem_cgroup_is_root(memcg));
+	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	return max_overage;
 }
@@ -2686,8 +2675,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	unsigned long pflags;
 
-	if (mem_cgroup_is_root(memcg))
-		return 0;
 retry:
 	if (consume_stock(memcg, nr_pages))
 		return 0;
@@ -2873,9 +2860,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 #if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
 static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	if (mem_cgroup_is_root(memcg))
-		return;
-
 	page_counter_uncharge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
@@ -2978,7 +2962,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	else
 		memcg = mem_cgroup_from_task(current);
 
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
 		objcg = rcu_dereference(memcg->objcg);
 		if (objcg && obj_cgroup_tryget(objcg))
 			break;
@@ -3096,15 +3080,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	int ret = 0;
 
 	memcg = get_mem_cgroup_from_current();
-	if (memcg && !mem_cgroup_is_root(memcg)) {
-		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
-		if (!ret) {
-			page->mem_cgroup = memcg;
-			__SetPageKmemcg(page);
-			return 0;
-		}
-		css_put(&memcg->css);
+	if (!memcg)
+		return 0;
+
+	ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
+	if (!ret) {
+		page->mem_cgroup = memcg;
+		__SetPageKmemcg(page);
+		return 0;
 	}
+	css_put(&memcg->css);
 	return ret;
 }
 
@@ -3121,7 +3106,6 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	if (!memcg)
 		return;
 
-	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	page->mem_cgroup = NULL;
 	css_put(&memcg->css);
@@ -5913,8 +5897,7 @@ static void __mem_cgroup_clear_mc(void)
 	/* we must fixup refcnts and charges */
 	if (mc.moved_swap) {
 		/* uncharge swap account from the old cgroup */
-		if (!mem_cgroup_is_root(mc.from))
-			page_counter_uncharge(&mc.from->memsw, mc.moved_swap);
+		page_counter_uncharge(&mc.from->memsw, mc.moved_swap);
 
 		mem_cgroup_id_put_many(mc.from, mc.moved_swap);
 
@@ -5922,8 +5905,7 @@ static void __mem_cgroup_clear_mc(void)
 		 * we charged both to->memory and to->memsw, so we
 		 * should uncharge to->memory.
 		 */
-		if (!mem_cgroup_is_root(mc.to))
-			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
+		page_counter_uncharge(&mc.to->memory, mc.moved_swap);
 
 		mc.moved_swap = 0;
 	}
@@ -6824,14 +6806,12 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long flags;
 
-	if (!mem_cgroup_is_root(ug->memcg)) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
-		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
-			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
-		memcg_oom_recover(ug->memcg);
-	}
+	page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
+	if (do_memsw_account())
+		page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
+		page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
+	memcg_oom_recover(ug->memcg);
 
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
@@ -7013,8 +6993,6 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(current);
-	if (memcg == root_mem_cgroup)
-		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
 		goto out;
 	if (css_tryget(&memcg->css))
@@ -7195,12 +7173,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 
 	page->mem_cgroup = NULL;
 
-	if (!mem_cgroup_is_root(memcg))
-		page_counter_uncharge(&memcg->memory, nr_entries);
+	page_counter_uncharge(&memcg->memory, nr_entries);
 
 	if (!cgroup_memory_noswap && memcg != swap_memcg) {
-		if (!mem_cgroup_is_root(swap_memcg))
-			page_counter_charge(&swap_memcg->memsw, nr_entries);
+		page_counter_charge(&swap_memcg->memsw, nr_entries);
 		page_counter_uncharge(&memcg->memsw, nr_entries);
 	}
 
@@ -7249,7 +7225,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 
 	memcg = mem_cgroup_id_get_online(memcg);
 
-	if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg) &&
+	if (!cgroup_memory_noswap &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
@@ -7281,7 +7257,7 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
-		if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg)) {
+		if (!cgroup_memory_noswap) {
 			if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 				page_counter_uncharge(&memcg->swap, nr_pages);
 			else
@@ -7299,7 +7275,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 
 	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return nr_swap_pages;
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
+	for (; memcg; memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
 				      READ_ONCE(memcg->swap.max) -
 				      page_counter_read(&memcg->swap));
@@ -7321,7 +7297,7 @@ bool mem_cgroup_swap_full(struct page *page)
 	if (!memcg)
 		return false;
 
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
 		unsigned long usage = page_counter_read(&memcg->swap);
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d848c76e035a..fb6b3cbe0764 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -651,14 +651,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
 
-	/*
-	 * The root memcg might be allocated even though memcg is disabled
-	 * via "cgroup_disable=memory" boot parameter.  This could make
-	 * mem_cgroup_is_root() return false, then just run memcg slab
-	 * shrink, but skip global shrink.  This may result in premature
-	 * oom.
-	 */
-	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_disabled())
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
-- 
2.26.2

