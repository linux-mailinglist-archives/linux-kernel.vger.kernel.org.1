Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8773428AC92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 05:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgJLDdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:33:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727453AbgJLDdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:33:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C3Wxl8122150;
        Sun, 11 Oct 2020 23:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=cTW9wQ+M9xFXDc4f4nVq3xTXiup+1FAxRU2jK/c10D4=;
 b=X26H+zevFNng2A0GvBSmMcjq94Zqm9dLVwDYXJtsdMNUedwTgSQvHPiotyDvobGrX0mw
 Ba/exrPLSqRPG0k15dIq7J3DkblXAYKExFWsR7tAT2NbzWYAYXgnMeqYy447bptOTZQK
 4gXi4fjzq3D9SMlxBPusadtYZ2m3ZZAzfxMbrC/cfehhvZKlTqMnkFMaKfwbEOi02GoS
 OIbZeOeq6YCvfBEr7LNwCFieyIJrU+qPKExh5WlMngjfpYB8y402kHcmEDT4VpE+B7k8
 I6IYdtqzijJB6OX8SKkbxXDBhfnI7FXTSkSCwUcV29K3/XNIy5M32zpfWk2MMhFz90l9 Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 344eb4hahh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Oct 2020 23:33:36 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09C3XZ4u123702;
        Sun, 11 Oct 2020 23:33:35 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 344eb4haga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Oct 2020 23:33:35 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09C3XXpP012764;
        Mon, 12 Oct 2020 03:33:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3434k7rsud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 03:33:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09C3XVLL28639642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 03:33:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0714C52054;
        Mon, 12 Oct 2020 03:33:31 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.68.118])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id AC65552050;
        Mon, 12 Oct 2020 03:33:29 +0000 (GMT)
Date:   Mon, 12 Oct 2020 09:03:26 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org
Subject: Re: [PATCH FIX v0] mm: memcg/slab: Uncharge during
 kmem_cache_free_bulk()
Message-ID: <20201012033326.GJ185637@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20201009060423.390479-1-bharata@linux.ibm.com>
 <20201009184551.GA3128977@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009184551.GA3128977@carbon.dhcp.thefacebook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_01:2020-10-09,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=5
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:45:51AM -0700, Roman Gushchin wrote:
> On Fri, Oct 09, 2020 at 11:34:23AM +0530, Bharata B Rao wrote:
> 
> Hi Bharata,
> 
> > Object cgroup charging is done for all the objects during
> > allocation, but during freeing, uncharging ends up happening
> > for only one object in the case of bulk allocation/freeing.
> 
> Yes, it's definitely a problem. Thank you for catching it!
> 
> I'm curious, did you find it in the wild or by looking into the code?

Found by looking at the code.

> 
> > 
> > Fix this by having a separate call to uncharge all the
> > objects from kmem_cache_free_bulk() and by modifying
> > memcg_slab_free_hook() to take care of bulk uncharging.
> >
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> 
> Please, add:
> 
> Fixes: 964d4bd370d5 ("mm: memcg/slab: save obj_cgroup for non-root slab objects")
> Cc: stable@vger.kernel.org
> 
> > ---
> >  mm/slab.c |  2 +-
> >  mm/slab.h | 42 +++++++++++++++++++++++++++---------------
> >  mm/slub.c |  3 ++-
> >  3 files changed, 30 insertions(+), 17 deletions(-)
> > 
> > diff --git a/mm/slab.c b/mm/slab.c
> > index f658e86ec8cee..5c70600d8b1cc 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3440,7 +3440,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
> >  		memset(objp, 0, cachep->object_size);
> >  	kmemleak_free_recursive(objp, cachep->flags);
> >  	objp = cache_free_debugcheck(cachep, objp, caller);
> > -	memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
> > +	memcg_slab_free_hook(cachep, &objp, 1);
> >  
> >  	/*
> >  	 * Skip calling cache_free_alien() when the platform is not numa.
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 6cc323f1313af..6dd4b702888a7 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -345,30 +345,42 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >  	obj_cgroup_put(objcg);
> >  }
> >  
> > -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> > -					void *p)
> > +static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
> > +					void **p, int objects)
> >  {
> > +	struct kmem_cache *s;
> >  	struct obj_cgroup *objcg;
> > +	struct page *page;
> >  	unsigned int off;
> > +	int i;
> >  
> >  	if (!memcg_kmem_enabled())
> >  		return;
> >  
> > -	if (!page_has_obj_cgroups(page))
> > -		return;
> > +	for (i = 0; i < objects; i++) {
> > +		if (unlikely(!p[i]))
> > +			continue;
> >  
> > -	off = obj_to_index(s, page, p);
> > -	objcg = page_obj_cgroups(page)[off];
> > -	page_obj_cgroups(page)[off] = NULL;
> > +		page = virt_to_head_page(p[i]);
> > +		if (!page_has_obj_cgroups(page))
> > +			continue;
> >  
> > -	if (!objcg)
> > -		return;
> > +		if (!s_orig)
> > +			s = page->slab_cache;
> > +		else
> > +			s = s_orig;
> >  
> > -	obj_cgroup_uncharge(objcg, obj_full_size(s));
> > -	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> > -			-obj_full_size(s));
> > +		off = obj_to_index(s, page, p[i]);
> > +		objcg = page_obj_cgroups(page)[off];
> > +		if (!objcg)
> > +			continue;
> >  
> > -	obj_cgroup_put(objcg);
> > +		page_obj_cgroups(page)[off] = NULL;
> > +		obj_cgroup_uncharge(objcg, obj_full_size(s));
> > +		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> > +				-obj_full_size(s));
> > +		obj_cgroup_put(objcg);
> > +	}
> >  }
> >  
> >  #else /* CONFIG_MEMCG_KMEM */
> > @@ -406,8 +418,8 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >  {
> >  }
> >  
> > -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> > -					void *p)
> > +static inline void memcg_slab_free_hook(struct kmem_cache *s,
> > +					void **p, int objects)
> >  {
> >  }
> >  #endif /* CONFIG_MEMCG_KMEM */
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 6d3574013b2f8..0cbe67f13946e 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3091,7 +3091,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> >  	struct kmem_cache_cpu *c;
> >  	unsigned long tid;
> >  
> > -	memcg_slab_free_hook(s, page, head);
> > +	memcg_slab_free_hook(s, &head, 1);
> 
> Hm, I wonder if it's better to teach do_slab_free() to handle the (cnt > 1) case correctly?

Possible, but we will have to walk the detached freelist there while
here it is much easier to just walk the array of objects?

> 
> >  redo:
> >  	/*
> >  	 * Determine the currently cpus per cpu slab.
> > @@ -3253,6 +3253,7 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> >  	if (WARN_ON(!size))
> >  		return;
> >  
> > +	memcg_slab_free_hook(s, p, size);
> 
> Then you don't need this change.
> 
> Otherwise memcg_slab_free_hook() can be called twice for the same object. It's ok from
> accounting correctness perspective, because the first call will zero out the objcg pointer,
> but still much better to be avoided.

Yes, for that one object there will be one additional uncharge call,
but as you note it is handled by the !objcg check.

Regards,
Bharata.
