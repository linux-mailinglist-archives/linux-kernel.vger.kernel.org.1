Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07465293137
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgJSW3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:29:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64328 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729625AbgJSW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:29:13 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JMKJid024176;
        Mon, 19 Oct 2020 15:28:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=3zne088JCB09pKGPe3xJNAWp1z23jWP4o8YmeSDsrbs=;
 b=dYtByGZ2Vrj5zB7wFeuebHD04fGrckXRJzg5niTXo+DPF0q5qjdBaV/JFsqhM/IOH/oh
 5O7uRbelbcD1z00kvyf0XIUSh45G11nXu/OKo3bql2ICvVlUKhR5V2B16pLXH5N3ImQ8
 VfBGmfbeqAM8IabfzyTD+Mwt91Nc1qSn5ZI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 347x4k27js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Oct 2020 15:28:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 19 Oct 2020 15:28:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuiajxLZAYTSukmZQITuk6eoyCof0mhhAHs1vfljQ/NsUjNPeRcQHZriDvhSp+HQPfQ2e3t+qhxPFHOIHA6yHC5DuKHkhGLBX0QZvys49hEV6j913BtLoqHWpBxrVuD72rCl2qGNUohd227TIC1bSQLCxaus3wueNW9gGp8+zB6WMLq/yNO56+oLcpIJuPMe7aqxSK/m9oIsDKfvK2fMh78r3NZS5XKdWRlcrO/h2pm/XDcxJ8fXRdWSNttBVSwOGrWVwu4o1qjF9mHKrJ6PfXxM+LAhr0YhJ7/lXef19XYk7+Pi6v1fW9bzusVLyH7zkl6UvnPoVHkKsJ1Gw7mq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zne088JCB09pKGPe3xJNAWp1z23jWP4o8YmeSDsrbs=;
 b=e6lM//znZJcMMeBaPf8iCRni84yEcgvEs/6ll5BV6xTlnjPW9iQV60LrZm1XI8D4LbnIMuyOxWOupCeijTyNBDh8NEppzFHFUW3g9UAi6K9bE3OClcU0Km7zpgaes1S51JN7UYAgk/1H6hyx0DEFJm5ca6wwLMqFLcchKgvTA3kKtm1gPqCe1dDJSsbx8lepXI3sM8UfeNZ3M+9LfGX7vSoGo9vBNB9xHZn5egDeNFyT0EfXBqWGb+D/b3k2yzu8/kGZCwE/nbofnwXL0aSoGA7ghO0ej/Lc/eOpkmLhY/1hEHBCS8aaN2SyVLGuXw0ikxhWptPb4FN1XX3rJubxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zne088JCB09pKGPe3xJNAWp1z23jWP4o8YmeSDsrbs=;
 b=F4eemJoti55zpf5BX7r1sX3Bcf/y5QinHuUebAHEByBeqqwyE3fZW1hrmho0e6YEwWn9r0E2sISu2nWgHWJItLiWsRuOjK0p8o/1uPyo2wBsYyU5nOErvRTGcfpSOIdqzQTLN1B8Z1mi4pOT14mue/aCWZK458sXNtulavOTA/k=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2663.namprd15.prod.outlook.com (2603:10b6:a03:15c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 19 Oct
 2020 22:28:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 22:28:51 +0000
Date:   Mon, 19 Oct 2020 15:28:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        <ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
In-Reply-To: <20201016171502.GA102311@blackbook>
X-Originating-IP: [2620:10d:c090:400::5:a109]
X-ClientProxiedBy: MWHPR18CA0035.namprd18.prod.outlook.com
 (2603:10b6:320:31::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a109) by MWHPR18CA0035.namprd18.prod.outlook.com (2603:10b6:320:31::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Mon, 19 Oct 2020 22:28:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ff1423-d1c2-4ebc-b14a-08d8747e5ad2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2663:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2663208F621DFF43A4D8A937BE1E0@BYAPR15MB2663.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MH+Cw998axhnLScAG4wWmCrX34zih1ASULFCVzusZD4YqFJDA+3qcsvZOJ0zwZyBxUunPEOzs0K0ZmV09V/lqF7LAa+/pgdaTTt2kgjmqLb5Yp1A8nXLCtAZIH+Uk7zzs1IwJjlmlTSJM1pMs8xchg8TKIt+YzAufXORnDeO+SHNdg3x8nBVzOdPGiJUCOip/XRKSkrBcd3erCxsj2FHuXl5JlKnjO3k9QWkJFzrq2IpeCzYaZmZHN5SGDmqw1zwjldEXnnwG+k8FSL4VENmIBaza8yJ+XppBSnwsKgnRhf5D4jCkQfK9I1n220jegt28HywTkjJoZOlroXoQExzTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(396003)(376002)(86362001)(66946007)(7696005)(52116002)(66476007)(66556008)(6506007)(33656002)(9686003)(54906003)(4326008)(2906002)(186003)(16526019)(83380400001)(53546011)(55016002)(5660300002)(478600001)(316002)(1076003)(8676002)(6666004)(7416002)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: llvMOaWIL/AxJQaqaMYwnnntWoE/UQNkYlXPcwz0IeNJK47SJnv4jglBPH1CDDe5MKDYu1Whb+mNk2Khja1RReXzY3pax33RI9rRmkBTU3/C4wxKoMLcGTX6w1VSDQi05sTD+oihCYsH8kH/qKgb1l9OpsojKXjCRYGYEXCpEpCvQfeBWs0LSSADRZ/dpfqogwL/QU9p/Kmm95KYveAwd+dvsCdxdm5E1SaySTT2EKJde7549AeMAOG6cWijrnZGd8g5fvg7XZk0hhpg3HHtfdmxX0v462YNYx93XUhmLxwHsrMB7GCr6R3AxAe+DgZ0+F/HkjzmZ1w0bSe7l5Ez4qXFLPW3JcKuB3lWZi/1r1TftSPdFsNcbtBhaPjLEdqQukDbxwpF+c9bg17sJ3B2pNABajwKrb/4QVaJAyJ6QzcinfnygPI5k8EQvOPMw4mRdujRjIcp+09iT5hlAWusAEqcR5HMY3CHJEPxjRemryZMmQ6lUt4E6wQB+c0n2nIJpLswfSUwyPprtIioad07hAL+hbvyarSVyyF5X5fs26bhYJbbdKbTbxV2qmbVOvfAJamfdPOIz6qUb4VROEKPp5RAsdJDf9M/iG6hGYsa7EeI60i5JsYx5Hlvgxl3TIV56rgqdKYaGatTmboHg+5LKhC5F9Q7MXvZhSHetL8hvQfhB3aA3vyfxbNGOG0bcL7M
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ff1423-d1c2-4ebc-b14a-08d8747e5ad2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 22:28:51.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88FauZnF9mvblymLoXH9YCJ0dTzjXCTRZ9nEaOUxqQHZmMf0CstLCl9dgBitqSxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2663
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_13:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010190150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 07:15:02PM +0200, Michal Koutny wrote:
> On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > The central try_charge() function charges recursively all the way up
> > to and including the root.
> Except for use_hiearchy=0 (which is the case here as Richard
> wrote). The reparenting is hence somewhat incompatible with
> new_parent.use_hiearchy=0 :-/
> 
> > We should clean this up one way or another: either charge the root or
> > don't, but do it consistently.
> I agree this'd be good to unify. One upside of excluding root memcg from
> charging is that users are spared from the charging overhead when memcg
> tree is not created.  (Actually, I thought that was the reason for this
> exception.)

Yeah, I'm completely on the same page. Moving a process to the root memory
cgroup is currently a good way to estimate the memory cgroup overhead.

How about the patch below, which consistently avoids charging the root
memory cgroup? It seems like it doesn't add too many checks.

Thanks!

--

From f50ea74d8f118b9121da3754acdde630ddc060a7 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Mon, 19 Oct 2020 14:37:35 -0700
Subject: [PATCH RFC] mm: memcontrol: do not charge the root memory cgroup

Currently the root memory cgroup is never charged directly, but
if an ancestor cgroup is charged, the charge is propagated up to the
root memory cgroup. The root memory cgroup doesn't show the charge
to a user, neither it does allow to set any limits/protections.
So the information about the current charge is completely useless.

Avoiding to charge the root memory cgroup allows to:
1) simplify the model and the code, so, hopefully, fewer bugs will
   be introduced in the future;
2) avoid unnecessary atomic operations, which are used to (un)charge
   corresponding root page counters.

In the default hierarchy case or if use_hiearchy == true, it's very
straightforward: when the page counters tree is traversed to the root,
the root page counter (the one with parent == NULL), should be
skipped. To avoid multiple identical checks over the page counters
code, for_each_nonroot_ancestor() macro is introduced.

To handle the use_hierarchy == false case without adding custom
checks, let's make page counters of all non-root memory cgroup
direct ascendants of the corresponding root memory cgroup's page
counters. In this case for_each_nonroot_ancestor() will work correctly
as well.

Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
However, it's not based on page counters (refer to mem_cgroup_usage()).

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c   | 21 ++++++++++++++++-----
 mm/page_counter.c | 21 ++++++++++++---------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..34cac7522e74 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5339,17 +5339,28 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		memcg->swappiness = mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable = parent->oom_kill_disable;
 	}
-	if (parent && parent->use_hierarchy) {
+	if (!parent) {
+		/* root memory cgroup */
+		page_counter_init(&memcg->memory, NULL);
+		page_counter_init(&memcg->swap, NULL);
+		page_counter_init(&memcg->kmem, NULL);
+		page_counter_init(&memcg->tcpmem, NULL);
+	} else if (parent->use_hierarchy) {
 		memcg->use_hierarchy = true;
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
-		page_counter_init(&memcg->memory, NULL);
-		page_counter_init(&memcg->swap, NULL);
-		page_counter_init(&memcg->kmem, NULL);
-		page_counter_init(&memcg->tcpmem, NULL);
+		/*
+		 * If use_hierarchy == false, consider all page counters direct
+		 * descendants of the corresponding root level counters.
+		 */
+		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
+		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
+		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
+		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
+
 		/*
 		 * Deeper hierachy with use_hierarchy == false doesn't make
 		 * much sense so let cgroup subsystem know about this
diff --git a/mm/page_counter.c b/mm/page_counter.c
index b24a60b28bb0..8901b184b9d5 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -13,6 +13,9 @@
 #include <linux/bug.h>
 #include <asm/page.h>
 
+#define for_each_nonroot_ancestor(c, counter) \
+	for ((c) = (counter); ((c) && ((c)->parent)); (c) = (c)->parent)
+
 static void propagate_protected_usage(struct page_counter *c,
 				      unsigned long usage)
 {
@@ -20,9 +23,6 @@ static void propagate_protected_usage(struct page_counter *c,
 	unsigned long low, min;
 	long delta;
 
-	if (!c->parent)
-		return;
-
 	min = READ_ONCE(c->min);
 	if (min || atomic_long_read(&c->min_usage)) {
 		protected = min(usage, min);
@@ -68,7 +68,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
 
-	for (c = counter; c; c = c->parent) {
+	for_each_nonroot_ancestor(c, counter) {
 		long new;
 
 		new = atomic_long_add_return(nr_pages, &c->usage);
@@ -97,7 +97,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 {
 	struct page_counter *c;
 
-	for (c = counter; c; c = c->parent) {
+	for_each_nonroot_ancestor(c, counter) {
 		long new;
 		/*
 		 * Charge speculatively to avoid an expensive CAS.  If
@@ -137,8 +137,11 @@ bool page_counter_try_charge(struct page_counter *counter,
 	return true;
 
 failed:
-	for (c = counter; c != *fail; c = c->parent)
+	for_each_nonroot_ancestor(c, counter) {
+		if (c == *fail)
+			break;
 		page_counter_cancel(c, nr_pages);
+	}
 
 	return false;
 }
@@ -152,7 +155,7 @@ void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
 
-	for (c = counter; c; c = c->parent)
+	for_each_nonroot_ancestor(c, counter)
 		page_counter_cancel(c, nr_pages);
 }
 
@@ -211,7 +214,7 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
 
 	WRITE_ONCE(counter->min, nr_pages);
 
-	for (c = counter; c; c = c->parent)
+	for_each_nonroot_ancestor(c, counter)
 		propagate_protected_usage(c, atomic_long_read(&c->usage));
 }
 
@@ -228,7 +231,7 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
 
 	WRITE_ONCE(counter->low, nr_pages);
 
-	for (c = counter; c; c = c->parent)
+	for_each_nonroot_ancestor(c, counter)
 		propagate_protected_usage(c, atomic_long_read(&c->usage));
 }
 
-- 
2.26.2

