Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62052B1328
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKMATp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:19:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24782 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbgKMATo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:19:44 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AD0Hqs8029384;
        Thu, 12 Nov 2020 16:19:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Vfi7Naz11hUnoXv2S5qCY5q0d90lcnRgzoytUVltvW8=;
 b=BKEFVfrTN0VDG/zswy3Nw3G8YO3krgaAdtb5II6A3wVo1jDcWfE9NYFC+Rr2idzVhM4I
 MK5O5U3fJB4qdLAkUR9M0hdAaSppzYsWnVFA+/gjTT8NUtwY+I71jjNVSS35Jtrcno2x
 SAI7/fpfItepwy4NsfbaIFWqogrEVRSJ9tc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34rva9e745-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 16:19:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 16:19:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2AmJpbcRBsPoitWhzgqcJ5904ezgAgpE9AQgUJYGAJ7h3GG09ZHYIXBdHetrzgTq1zuPqBJJL+pGcZqQkFghx8xZBI5V13+DMv/8MLZy23Yu7ggCyN5mNCZfqAHBqrh8J28G2YXelyp9RGWAUOlvVvRuscAO/BvlqCVBtgWO6clrjT5461n1hxBCBtbnMqjfLOlBe+pz5aP0bkrxIRU+vR75DNHiiGOV3CG32smGA0oPkdCYekiBgkYbV77rIykfs/sIGzOYT6sOeV72AYUu/lE188PfzHBhGmZQHhjZXGEMN46ixHCRyBqg5ol7rzVWsWRajWu+OuMzihC8TVnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfi7Naz11hUnoXv2S5qCY5q0d90lcnRgzoytUVltvW8=;
 b=TENN04nSF/yP2jM633/R9Wd8fGYQP27cwXlpjikgyNtTKEDIjtU2WZC9gyc/uzqd4SMjdfjmIwV7AvVmFtgTAJ7z5lL6XC/10SFE7JFNfX87KeFifDg6Mm/5nhtAsGqCEMAsufWDC2AA70MWHIx1mvxfg2YPfQTFnXYF2tgjqbfbhz4JvKXFowx1h9Fu8pjc2R7kG7PvJT6jv6wm/38g1lfL3U5M5XUL+i01ooDdxKaVADM5JKa/pIuPNplWJZ89Vu+/SwnDlm4GkLIuvkLvRAQ8dr9Xw7cNAdyLB3DyRHwRagBbWqQLZl3q50EA8MKdNn4xpKkUv0RDrt3qasUkxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfi7Naz11hUnoXv2S5qCY5q0d90lcnRgzoytUVltvW8=;
 b=PIeX8kMp6gq3XEuuJiw46/AmPmFZsimct+DoKZjIdHxd7xmNKuTpppD+sKu2bYZlK+LPCKg6fWuNbLblt3d+zWpoPxKjfZ+7oZKRq3pGiFHXE+GsPxjjJABx1QW9m21TLe8ePTf6QkjEtiQtnLbnMSdLqS7r0LefqUE+cJI/ySQ=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3445.namprd15.prod.outlook.com (2603:10b6:a03:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Fri, 13 Nov
 2020 00:19:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 00:19:31 +0000
Date:   Thu, 12 Nov 2020 16:19:26 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-ID: <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
References: <20201110195753.530157-1-guro@fb.com>
 <20201110195753.530157-2-guro@fb.com>
 <20201112162303.GB873621@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112162303.GB873621@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:3cc3]
X-ClientProxiedBy: CO2PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:104:4::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3cc3) by CO2PR04CA0158.namprd04.prod.outlook.com (2603:10b6:104:4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 13 Nov 2020 00:19:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e873e66-7018-4555-0d9e-08d88769cab7
X-MS-TrafficTypeDiagnostic: BYAPR15MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3445A577882BD59F60B0E4C5BEE60@BYAPR15MB3445.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u93NN6t9faqihQ1ibtJtXl0EK2eaiG/bFwCCurEh5Sb8Gr6UosIaRc65m4zAf87bJAvfA002CtcEPgQ64cd/9gy4qq7G9V4Ag0fjU7eOwsRK2fRYqQ2r82u+4q2pFcmXef4ahzQtfbTHRWySRYnfvPOWsty5P2UHhHhmHAd3GSWjRICxlleJFgpFhJClm16z0iyflPMe+cRdfAsm8l7SIsnZ8wq9bcuogR5eOUytBTE8keh11RZGstACE5UUyuF8mf/RHxH8zSif3O4dar1oTXw2vx27k1f1AIsOj4/e/DjNIRZ/jgSE6SgfGD8TjOj2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(39860400002)(136003)(66476007)(316002)(5660300002)(54906003)(66556008)(9686003)(33656002)(83380400001)(66946007)(186003)(2906002)(6916009)(86362001)(7696005)(55016002)(16526019)(1076003)(52116002)(478600001)(4326008)(6666004)(8936002)(53546011)(6506007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PPIerQ2I9NeR84bLqLRuEMTJmlS4k2W8K0oSudtu5MhlNKnGz/Yyxi47qtpJIoP7DnoSHmHiyEuKtXceOOYpsInrzlLnzWCgOZrqpuKjvcudT8nVrjn/kkPBfQWmmI+a5En87vYKPAvhUaE9dQtkgQDHrdebD1KjkSFj7de8DYJrSoOuN4t8F8XB61QsPUqVuwq2Hs7Z2KGZiOuqX2K4PEL90vwZ8v8adbR/LZOw/iA1wKrnSDgGZom5gfMq7FLHIyL8P7+ZhnLadKGq9CjpO0XerVBMsXJN53lQkCP0s2GwBoWQ2oW8dnf00RSnjOjFzZJWN18r8c5MDGhXgtY0HCwe9dvn+LkGppEoP5FKQF0cfUu0+E26YEK+e8GF2dPD5RbTAPN8l822Fel5vOarc0QdYTIC0yETnqBJcq59DgHY3d4f3m49PRnZYDXoe7QcIpRc6y0YstRaAC2E01wwfVQKjouRlFtSB2nLhhzwI25wQhKtLsldA8lGz8abA/58f0SsOGwqGhmM3qn99jmopyJPzyzQV9IosdaBqCpqRibzseioLmwGKG5ApJNnm8z1ZnBCMcJhs9azxB3duM89+dZ6vAahOWAzFfOnMSUw3AKTQWEFKTEW6pHttCz4qULLaoM2swet8eTTwyAlikcnBrfsK9IpmI9vd4/4ogDMuD4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e873e66-7018-4555-0d9e-08d88769cab7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 00:19:31.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhZSkjoMUq0Q4YXxDBw5hzQzau5OOhP87pZ5yHCrM+rU01p7mfL1p9USOnoGyU2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3445
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_16:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=5
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:23:03AM -0500, Johannes Weiner wrote:
> On Tue, Nov 10, 2020 at 11:57:53AM -0800, Roman Gushchin wrote:
> > In general it's unknown in advance if a slab page will contain
> > accounted objects or not. In order to avoid memory waste, an
> > obj_cgroup vector is allocated dynamically when a need to account
> > of a new object arises. Such approach is memory efficient, but
> > requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> > because an allocation can race with a different allocation on another
> > cpu.
> > 
> > But in some common cases it's known for sure that a slab page will
> > contain accounted objects: if the page belongs to a slab cache with a
> > SLAB_ACCOUNT flag set. It includes such popular objects like
> > vm_area_struct, anon_vma, task_struct, etc.
> > 
> > In such cases we can pre-allocate the objcgs vector and simple assign
> > it to the page without any atomic operations, because at this early
> > stage the page is not visible to anyone else.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> That's a nice optimization!
> 
> Some comments inline:
> 
> > @@ -485,14 +485,20 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
> >   * set_page_objcgs - associate a page with a object cgroups vector
> >   * @page: a pointer to the page struct
> >   * @objcgs: a pointer to the object cgroups vector
> > + * @atomic: save the value atomically
> >   *
> >   * Atomically associates a page with a vector of object cgroups.
> >   */
> >  static inline bool set_page_objcgs(struct page *page,
> > -					struct obj_cgroup **objcgs)
> > +				   struct obj_cgroup **objcgs, bool atomic)
> 
> bool parameters make callsites pretty hard to understand - unless the
> function interface obviously has two modes (read vs write etc.), which
> isn't the case here.
> 
> > -	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs |
> > -			MEMCG_DATA_OBJCGS);
> > +	unsigned long memcg_data = (unsigned long) objcgs | MEMCG_DATA_OBJCGS;
> > +
> > +	if (atomic)
> > +		return !cmpxchg(&page->memcg_data, 0, memcg_data);
> > +
> > +	page->memcg_data = memcg_data;
> > +	return true;
> >  }
> >  #else
> >  static inline struct obj_cgroup **page_objcgs(struct page *page)
> > @@ -506,7 +512,7 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
> >  }
> >  
> >  static inline bool set_page_objcgs(struct page *page,
> > -					struct obj_cgroup **objcgs)
> > +				   struct obj_cgroup **objcgs, bool atomic)
> >  {
> >  	return true;
> >  }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 69a2893a6455..37bffd336235 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2874,7 +2874,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
> >  
> >  #ifdef CONFIG_MEMCG_KMEM
> >  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> > -				 gfp_t gfp)
> > +				 gfp_t gfp, bool atomic)
> >  {
> >  	unsigned int objects = objs_per_slab_page(s, page);
> >  	void *vec;
> > @@ -2884,7 +2884,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> >  	if (!vec)
> >  		return -ENOMEM;
> >  
> > -	if (!set_page_objcgs(page, vec))
> > +	if (!set_page_objcgs(page, vec, atomic))
> >  		kfree(vec);
> >  	else
> >  		kmemleak_not_leak(vec);
> 
> The life of page->memcg_data and this optimization could use a central
> comment somewhere, because it's hard to understand what's going on
> from the code alone. This function here seems like a good place?
> 
> I don't see a way to eliminate the bool on the allocation function,
> but maybe it could be more descriptive. Maybe bool slab_account?
> 
> set_page_objcgs() can be inlined at this point. It made some sense to
> abstract away the atomics with setter and matching getter, but with a
> non-atomic mode, inlining makes things clearer and allows for better
> in-place documentation in the sole callsite.

I agree, inlining makes sense here.

I'd prefer not to spill details about SLAB_ACCOUNT into memcg_alloc_page_obj_cgroups().
What's important there is only whether we have an exclusive access to the page or not.

How about the version below?

Thanks!

--

From 8b28d91475d54c552e503e66f169e1e00475c856 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 16 Sep 2020 15:43:48 -0700
Subject: [PATCH v2 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT

In general it's unknown in advance if a slab page will contain
accounted objects or not. In order to avoid memory waste, an
obj_cgroup vector is allocated dynamically when a need to account
of a new object arises. Such approach is memory efficient, but
requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
because an allocation can race with a different allocation on another
cpu.

But in some common cases it's known for sure that a slab page will
contain accounted objects: if the page belongs to a slab cache with a
SLAB_ACCOUNT flag set. It includes such popular objects like
vm_area_struct, anon_vma, task_struct, etc.

In such cases we can pre-allocate the objcgs vector and simple assign
it to the page without any atomic operations, because at this early
stage the page is not visible to anyone else.

v2: inline set_page_objcgs() and add some comments, by Johannes

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 19 -------------------
 mm/memcontrol.c            | 23 +++++++++++++++++++----
 mm/slab.c                  |  2 +-
 mm/slab.h                  | 14 ++++++++++----
 4 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20108e426f84..bfcdcb2d2976 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -481,19 +481,6 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
-/*
- * set_page_objcgs - associate a page with a object cgroups vector
- * @page: a pointer to the page struct
- * @objcgs: a pointer to the object cgroups vector
- *
- * Atomically associates a page with a vector of object cgroups.
- */
-static inline bool set_page_objcgs(struct page *page,
-					struct obj_cgroup **objcgs)
-{
-	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs |
-			MEMCG_DATA_OBJCGS);
-}
 #else
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
@@ -504,12 +491,6 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
 {
 	return NULL;
 }
-
-static inline bool set_page_objcgs(struct page *page,
-					struct obj_cgroup **objcgs)
-{
-	return true;
-}
 #endif
 
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69a2893a6455..6ca8c23d7816 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2874,9 +2874,10 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
-				 gfp_t gfp)
+				 gfp_t gfp, bool new_page)
 {
 	unsigned int objects = objs_per_slab_page(s, page);
+	unsigned long memcg_data;
 	void *vec;
 
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
@@ -2884,11 +2885,25 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 	if (!vec)
 		return -ENOMEM;
 
-	if (!set_page_objcgs(page, vec))
+	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
+	if (new_page) {
+		/*
+		 * If the slab page is brand new and nobody can yet access
+		 * it's memcg_data, no synchronization is required and
+		 * memcg_data can be simply assigned.
+		 */
+		page->memcg_data = memcg_data;
+	} else if (cmpxchg(&page->memcg_data, 0, memcg_data)) {
+		/*
+		 * If the slab page is already in use, somebody can allocate
+		 * and assign obj_cgroups in parallel. In this case the existing
+		 * objcg vector should be reused.
+		 */
 		kfree(vec);
-	else
-		kmemleak_not_leak(vec);
+		return 0;
+	}
 
+	kmemleak_not_leak(vec);
 	return 0;
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index c0ea4b1c7088..df0299e1d0b9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1380,7 +1380,7 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 		return NULL;
 	}
 
-	account_slab_page(page, cachep->gfporder, cachep);
+	account_slab_page(page, cachep->gfporder, cachep, flags);
 	__SetPageSlab(page);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
diff --git a/mm/slab.h b/mm/slab.h
index c73050654b8a..59aeb0d9f11b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -240,7 +240,7 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
-				 gfp_t gfp);
+				 gfp_t gfp, bool new_page);
 
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
@@ -307,7 +307,8 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 			page = virt_to_head_page(p[i]);
 
 			if (!page_objcgs(page) &&
-			    memcg_alloc_page_obj_cgroups(page, s, flags)) {
+			    memcg_alloc_page_obj_cgroups(page, s, flags,
+							 false)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
 			}
@@ -371,7 +372,8 @@ static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 }
 
 static inline int memcg_alloc_page_obj_cgroups(struct page *page,
-					       struct kmem_cache *s, gfp_t gfp)
+					       struct kmem_cache *s, gfp_t gfp,
+					       bool new_page)
 {
 	return 0;
 }
@@ -412,8 +414,12 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 }
 
 static __always_inline void account_slab_page(struct page *page, int order,
-					      struct kmem_cache *s)
+					      struct kmem_cache *s,
+					      gfp_t gfp)
 {
+	if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
+		memcg_alloc_page_obj_cgroups(page, s, gfp, true);
+
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
 }
-- 
2.26.2

