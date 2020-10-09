Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056702881F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbgJIGEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:04:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47686 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731739AbgJIGEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:04:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09962FLA113622;
        Fri, 9 Oct 2020 02:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KXPO49hXQxj1M9qPp+Zqeft7/at6K8bGnLzy4qtVbVc=;
 b=eJwHzd0DAwc4yJ/ZbGEFGV2rJ9UOdnz5tvURykT8q9GZRFZ/8D8DvQGUAZCnnORIyoo0
 +bN1EP0vjMytpvJjDmraXpfqZtS2V4sOxqFMq5dk40s6BTzPrnyxMup1HedVMt+cgA/r
 UTMJ5gkF6W+BFMkA2LI67cVnuWWICbnsMeNVwfFnEcR+nxsiAFhGDAPFARWyML9206Ho
 42+rpTQgFJ0G3VXafUlgqyW23MwoXGu2nvUq3j9Tunxaqta2O2uo5n2CIGC7KkZ7HkfU
 inU/5VbrNTWzkVVp8i06evFCmdXpax3Gqoom0ag8ZmQSpib9Svy0+SBqRhD7zHFmuRk4 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342j6k8710-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 02:04:33 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09962aBT115078;
        Fri, 9 Oct 2020 02:04:33 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342j6k86yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 02:04:33 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0995pfmx016636;
        Fri, 9 Oct 2020 06:04:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3429hrg5ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 06:04:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09964TWv33554728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 06:04:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50AD5AE045;
        Fri,  9 Oct 2020 06:04:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7E2FAE055;
        Fri,  9 Oct 2020 06:04:27 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.199.46.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 06:04:27 +0000 (GMT)
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, guro@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>
Subject: [PATCH FIX v0] mm: memcg/slab: Uncharge during kmem_cache_free_bulk()
Date:   Fri,  9 Oct 2020 11:34:23 +0530
Message-Id: <20201009060423.390479-1-bharata@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_02:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 suspectscore=3 phishscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Object cgroup charging is done for all the objects during
allocation, but during freeing, uncharging ends up happening
for only one object in the case of bulk allocation/freeing.

Fix this by having a separate call to uncharge all the
objects from kmem_cache_free_bulk() and by modifying
memcg_slab_free_hook() to take care of bulk uncharging.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 mm/slab.c |  2 +-
 mm/slab.h | 42 +++++++++++++++++++++++++++---------------
 mm/slub.c |  3 ++-
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index f658e86ec8cee..5c70600d8b1cc 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3440,7 +3440,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 		memset(objp, 0, cachep->object_size);
 	kmemleak_free_recursive(objp, cachep->flags);
 	objp = cache_free_debugcheck(cachep, objp, caller);
-	memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
+	memcg_slab_free_hook(cachep, &objp, 1);
 
 	/*
 	 * Skip calling cache_free_alien() when the platform is not numa.
diff --git a/mm/slab.h b/mm/slab.h
index 6cc323f1313af..6dd4b702888a7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -345,30 +345,42 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 	obj_cgroup_put(objcg);
 }
 
-static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
-					void *p)
+static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
+					void **p, int objects)
 {
+	struct kmem_cache *s;
 	struct obj_cgroup *objcg;
+	struct page *page;
 	unsigned int off;
+	int i;
 
 	if (!memcg_kmem_enabled())
 		return;
 
-	if (!page_has_obj_cgroups(page))
-		return;
+	for (i = 0; i < objects; i++) {
+		if (unlikely(!p[i]))
+			continue;
 
-	off = obj_to_index(s, page, p);
-	objcg = page_obj_cgroups(page)[off];
-	page_obj_cgroups(page)[off] = NULL;
+		page = virt_to_head_page(p[i]);
+		if (!page_has_obj_cgroups(page))
+			continue;
 
-	if (!objcg)
-		return;
+		if (!s_orig)
+			s = page->slab_cache;
+		else
+			s = s_orig;
 
-	obj_cgroup_uncharge(objcg, obj_full_size(s));
-	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
-			-obj_full_size(s));
+		off = obj_to_index(s, page, p[i]);
+		objcg = page_obj_cgroups(page)[off];
+		if (!objcg)
+			continue;
 
-	obj_cgroup_put(objcg);
+		page_obj_cgroups(page)[off] = NULL;
+		obj_cgroup_uncharge(objcg, obj_full_size(s));
+		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		obj_cgroup_put(objcg);
+	}
 }
 
 #else /* CONFIG_MEMCG_KMEM */
@@ -406,8 +418,8 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 {
 }
 
-static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
-					void *p)
+static inline void memcg_slab_free_hook(struct kmem_cache *s,
+					void **p, int objects)
 {
 }
 #endif /* CONFIG_MEMCG_KMEM */
diff --git a/mm/slub.c b/mm/slub.c
index 6d3574013b2f8..0cbe67f13946e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3091,7 +3091,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
 
-	memcg_slab_free_hook(s, page, head);
+	memcg_slab_free_hook(s, &head, 1);
 redo:
 	/*
 	 * Determine the currently cpus per cpu slab.
@@ -3253,6 +3253,7 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (WARN_ON(!size))
 		return;
 
+	memcg_slab_free_hook(s, p, size);
 	do {
 		struct detached_freelist df;
 
-- 
2.26.2

