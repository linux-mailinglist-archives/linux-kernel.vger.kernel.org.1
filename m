Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370BF28C670
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgJMAkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:40:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40820 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727403AbgJMAkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:39 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09D0ZTjd008483;
        Mon, 12 Oct 2020 17:40:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=Nuo4Yk+8lCPeFQxta5C1XUIXIfZI0yUbhdj3NMue/Cs=;
 b=aiNCcV3wSIiIw5mftXD7TMyPSiEfJv03HgtCMMocX2xJ5/ugoMQyJIq9f8WMxHLwSjya
 a40Pa4AR5fNYkE/5Lek3Mw/CmLVfdtG0s7jbKRcb1/04E8P0oMOtD1YB7BNAOGa4vXGY
 KzaRVhSu8HEOB4o8Tzf8B4bZvDfHIL4XxNs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 343veur4qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Oct 2020 17:40:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 12 Oct 2020 17:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjDUkvS4GvAbT31DQcd8ihMbTKhSmJbZSlraE5SEnyhETLRDd0DG2+U1CvOWy59XgO2uqeVk2RSXGpHaJmTLywKCLwbxF1hpBWR/+S7HL7VADprOnsfTGgcSLOtnevTf3JJ3WY03HMmm0pvr3Nk/A4bXADAl50iMUz6vbI3GPKQBCy10+iGpADwpXJ9YhDISwu736z5gLY36bCcKLig2chlQCFJ1o1STxJb6twBqXc5kBRcYaLCfHcM0Gqlrma+K5lpoFOkaxuAMzwNn0yz9gyW75XI30GHKlfwjF9TMMjpSmHNLL5ZmeR9TW5UjPA4TPCEoLsRPSolmuoYmOuJy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuo4Yk+8lCPeFQxta5C1XUIXIfZI0yUbhdj3NMue/Cs=;
 b=Wl69Q8K7ERNqTBh6svWIBJ+yrG3wDHgRBVe1qDhXfbXGtzmrHknXrNly+wh0bAmnG595nwoHp6Z1GpexCdKrNFpaqn+Ppkys9NsvgW7T3t656xYzHxZIn/kbM073x6GLGN3sz0+av3bTnrDZpigwKnq/7U6HjpwBJifN8MxqmRgV/G1Rht3vXi4P09l2zm9LfZt2hrL76iPJMdhprAIVnwasKjk1JUNN+i5lHV9oGy4mPVLt/l0dgUB/VZATXSeQgAgkhaTKBCG24Lpp/v266FO7DIkrj3WkxZFLXSirJtNsRUIy98c8OCoh9ijqu3I4LXIDTXsyUjeZ8p8oRXAl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuo4Yk+8lCPeFQxta5C1XUIXIfZI0yUbhdj3NMue/Cs=;
 b=hOkcLpP5Fl1sjB/wT0IBQomYbEKsJBb+hNDR/vKU/MRD7ph43SJw5XNT0xTV6dUf/lHMyrpxfjtMVRBwSPbGZGjKc7ILpywmCWnuY5PhdMyUqxHpQjbwAftRnJwph3QIjVBD4ss5UuWKt5wLv4zHLHczK7AArGS+D/pLWHmJYrs=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2758.namprd15.prod.outlook.com (2603:10b6:a03:14d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Tue, 13 Oct
 2020 00:40:12 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 00:40:12 +0000
Date:   Mon, 12 Oct 2020 17:40:07 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <cl@linux.com>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH FIX v0] mm: memcg/slab: Uncharge during
 kmem_cache_free_bulk()
Message-ID: <20201013004007.GB3687509@carbon.dhcp.thefacebook.com>
References: <20201009060423.390479-1-bharata@linux.ibm.com>
 <20201009184551.GA3128977@carbon.dhcp.thefacebook.com>
 <20201012033326.GJ185637@in.ibm.com>
In-Reply-To: <20201012033326.GJ185637@in.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:6ffe]
X-ClientProxiedBy: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6ffe) by MWHPR12CA0071.namprd12.prod.outlook.com (2603:10b6:300:103::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 13 Oct 2020 00:40:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4572b19-765b-4d9a-e1d7-08d86f108b7c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2758:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2758CC6D485BCAE9020E218FBE040@BYAPR15MB2758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OL+xgSRQCCerlKlqAey1AWALgRfL3dt/vUDm5BrmnQXxtbm+9dgtTbGy1PhvUo/bcZEM4Gwg6O4K4/3eO+TB78hLcIVcjOElPziwfAjtcSDzYlYyvWLrfRqx+eCBjEWSLfI2DcZdKm+Ha28vRkBju/sgPTGsftQ7yreNisKg5uDNJzAz9Bmxfgr/HXHH7qoBi0UYeu6OjF2D1jwpICWhuqxAJ9uZfmx4oQc6gfz2eoze3T3OH3uQkbhKky1PYf3U7dwx9FjL2MIaiDeFN1o4OVlUfHDX4dumml++/2WKZzlw5DWVKvEwemfArgfy+GRlnY+A2Zly0M/Mbiyxp40xng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(6666004)(52116002)(9686003)(86362001)(5660300002)(66476007)(7696005)(4326008)(6506007)(316002)(16526019)(478600001)(83380400001)(6916009)(2906002)(55016002)(33656002)(186003)(1076003)(66556008)(8676002)(8936002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZMHLEREdMeb5q4qfgii+y9kTaHp/uJR2UrakN8gR3RCN/77fyS9DopEiIu/GrAXp9biwcBYWV4/DNSpQYh0xlURE0aPp0q2LzdnilUR0fAtAMXSNdYs4WJ5mGZfpydqG1Vxgh6Ol19IAsfqrn82KF9eyvSIIVCCg0kPpXMrC/TsOq2zDPpmJyqbz5SCTClL0ldYNo4is9Vl6FTbY871qe5TOBnFmNXYSNrER1L5ThJGj8GFDendh51eQ1aZGy34toZWUQWJLbCE0cE7tHi0pcb1SeUqmhwrGkTu1f7pvqM5X2KOUz9KVGbh6OxjVjTAVclVY87kHI7uX8k6sgX6sEVV7g/d9NAW7VSnqUqeds9l1qBLx7WMtf5VqFxtoCoRrHHjUSPZsRNx5QSRB7wJdbViga8eLeHZTSTNIiCiSNWhp5GkFHYt7e6X3BD14NTtkBDH20Xak8vvSWx8buIhRDc9QvZmYASMAR+0LEdnHnuF/IdeMp9TsPSw52jXdBsrEZyg5ehWjV3yYn3yK2sb0rBRmHJWEsGF8vett8rKaMteKJklXHK0WQzaGFBsl54/7r80J7TKFbjhSE+qEmqXCE9VX8VP/WCBKSSuGaZsplj7RpDXSzJe6p38aGwY7UdNzaFqKF8MZJPOAHAvYAQebqJXTP+gnBQ/9pqpDd1ao6Z0=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4572b19-765b-4d9a-e1d7-08d86f108b7c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 00:40:12.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Do0HhUbecinDPcwg92223qN0LpKGNvJADfD3exYAK06sA1+vDGbOGjlqV0CRV4C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2758
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=5 clxscore=1015 impostorscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:03:26AM +0530, Bharata B Rao wrote:
> On Fri, Oct 09, 2020 at 11:45:51AM -0700, Roman Gushchin wrote:
> > On Fri, Oct 09, 2020 at 11:34:23AM +0530, Bharata B Rao wrote:
> > 
> > Hi Bharata,
> > 
> > > Object cgroup charging is done for all the objects during
> > > allocation, but during freeing, uncharging ends up happening
> > > for only one object in the case of bulk allocation/freeing.
> > 
> > Yes, it's definitely a problem. Thank you for catching it!
> > 
> > I'm curious, did you find it in the wild or by looking into the code?
> 
> Found by looking at the code.
> 
> > 
> > > 
> > > Fix this by having a separate call to uncharge all the
> > > objects from kmem_cache_free_bulk() and by modifying
> > > memcg_slab_free_hook() to take care of bulk uncharging.
> > >
> > > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > 
> > Please, add:
> > 
> > Fixes: 964d4bd370d5 ("mm: memcg/slab: save obj_cgroup for non-root slab objects")
> > Cc: stable@vger.kernel.org
> > 
> > > ---
> > >  mm/slab.c |  2 +-
> > >  mm/slab.h | 42 +++++++++++++++++++++++++++---------------
> > >  mm/slub.c |  3 ++-
> > >  3 files changed, 30 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/mm/slab.c b/mm/slab.c
> > > index f658e86ec8cee..5c70600d8b1cc 100644
> > > --- a/mm/slab.c
> > > +++ b/mm/slab.c
> > > @@ -3440,7 +3440,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
> > >  		memset(objp, 0, cachep->object_size);
> > >  	kmemleak_free_recursive(objp, cachep->flags);
> > >  	objp = cache_free_debugcheck(cachep, objp, caller);
> > > -	memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
> > > +	memcg_slab_free_hook(cachep, &objp, 1);
> > >  
> > >  	/*
> > >  	 * Skip calling cache_free_alien() when the platform is not numa.
> > > diff --git a/mm/slab.h b/mm/slab.h
> > > index 6cc323f1313af..6dd4b702888a7 100644
> > > --- a/mm/slab.h
> > > +++ b/mm/slab.h
> > > @@ -345,30 +345,42 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > >  	obj_cgroup_put(objcg);
> > >  }
> > >  
> > > -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> > > -					void *p)
> > > +static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
> > > +					void **p, int objects)
> > >  {
> > > +	struct kmem_cache *s;
> > >  	struct obj_cgroup *objcg;
> > > +	struct page *page;
> > >  	unsigned int off;
> > > +	int i;
> > >  
> > >  	if (!memcg_kmem_enabled())
> > >  		return;
> > >  
> > > -	if (!page_has_obj_cgroups(page))
> > > -		return;
> > > +	for (i = 0; i < objects; i++) {
> > > +		if (unlikely(!p[i]))
> > > +			continue;
> > >  
> > > -	off = obj_to_index(s, page, p);
> > > -	objcg = page_obj_cgroups(page)[off];
> > > -	page_obj_cgroups(page)[off] = NULL;
> > > +		page = virt_to_head_page(p[i]);
> > > +		if (!page_has_obj_cgroups(page))
> > > +			continue;
> > >  
> > > -	if (!objcg)
> > > -		return;
> > > +		if (!s_orig)
> > > +			s = page->slab_cache;
> > > +		else
> > > +			s = s_orig;
> > >  
> > > -	obj_cgroup_uncharge(objcg, obj_full_size(s));
> > > -	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> > > -			-obj_full_size(s));
> > > +		off = obj_to_index(s, page, p[i]);
> > > +		objcg = page_obj_cgroups(page)[off];
> > > +		if (!objcg)
> > > +			continue;
> > >  
> > > -	obj_cgroup_put(objcg);
> > > +		page_obj_cgroups(page)[off] = NULL;
> > > +		obj_cgroup_uncharge(objcg, obj_full_size(s));
> > > +		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> > > +				-obj_full_size(s));
> > > +		obj_cgroup_put(objcg);
> > > +	}
> > >  }
> > >  
> > >  #else /* CONFIG_MEMCG_KMEM */
> > > @@ -406,8 +418,8 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > >  {
> > >  }
> > >  
> > > -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> > > -					void *p)
> > > +static inline void memcg_slab_free_hook(struct kmem_cache *s,
> > > +					void **p, int objects)
> > >  {
> > >  }
> > >  #endif /* CONFIG_MEMCG_KMEM */
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 6d3574013b2f8..0cbe67f13946e 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -3091,7 +3091,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> > >  	struct kmem_cache_cpu *c;
> > >  	unsigned long tid;
> > >  
> > > -	memcg_slab_free_hook(s, page, head);
> > > +	memcg_slab_free_hook(s, &head, 1);
> > 
> > Hm, I wonder if it's better to teach do_slab_free() to handle the (cnt > 1) case correctly?
> 
> Possible, but we will have to walk the detached freelist there while
> here it is much easier to just walk the array of objects?
> 
> > 
> > >  redo:
> > >  	/*
> > >  	 * Determine the currently cpus per cpu slab.
> > > @@ -3253,6 +3253,7 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> > >  	if (WARN_ON(!size))
> > >  		return;
> > >  
> > > +	memcg_slab_free_hook(s, p, size);
> > 
> > Then you don't need this change.
> > 
> > Otherwise memcg_slab_free_hook() can be called twice for the same object. It's ok from
> > accounting correctness perspective, because the first call will zero out the objcg pointer,
> > but still much better to be avoided.
> 
> Yes, for that one object there will be one additional uncharge call,
> but as you note it is handled by the !objcg check.

Got it. Thanks for the explanation!

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
