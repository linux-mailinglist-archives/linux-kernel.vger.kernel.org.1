Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332E728915E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbgJISqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:46:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12690 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733050AbgJISq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:46:29 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099IeNkB018038;
        Fri, 9 Oct 2020 11:46:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=kaxKW0gVB8sBccIM0Vre7+2dVByNdinpsgWrBezwNPo=;
 b=XxMuHwVGMLZS2ZQTh1ehh59/RGTPzDYSLjjwN7t35BoLTdWUa/o6ugoWsywbyiQA4CxE
 ETx8fxZK34pcITEdU7jvEch61k89WNGxEWuX/XonzC9mkag6aqOnlLm5W9x1K6zwQISm
 bzfcz+V3ghPx+GVO+bgyQuWlhLJ4ERNIggQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3429h8n92q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Oct 2020 11:46:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 9 Oct 2020 11:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYdHCOLYsqRh0+yiDYG3Mfa9YL5n2nChCdce6BIAIqt2XuxgCeZrTyKuR6/TDlRJ1B987w+fzxWaRr5jdDs3tvl16vg2H4C8ZO8xYfbwb9oYnv+Lo+rmreT192NDTvWE0oAgrP5xrmlFrvqNBJhyOCjGArRRRiU1qKPpY8slUIwRxI3btC1DoEFv9qMLhGkgSkhijsEE91tA6NMNqk4O/T/ezCGdZxkG7jk94zpPOY4FJCN+zudBF9zWvIfdltumNRy+PVtyD5WghcDRSw43gPOWORKntDZ2YonC0rAK6MVOtq07JqFBvgig265cRjd4MbROi4jPwz0syz6NHsA9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaxKW0gVB8sBccIM0Vre7+2dVByNdinpsgWrBezwNPo=;
 b=nYrVT7yKb5YcqcZG1+EXGrxOWF6hDmAiek92D0M/EJzs3pVrQmuY0PSZDeBjcnfNUCtFSa1HBHaUbRUfW5WPTdMCbPQci7Z6YkhpD5xlijO6uwH0SaugfMPMm5CCCgFfZ/V6cis6lEo+/5RgFbE2OjrdrWu5DZkcH8ZUjGcZ2/0OusFiQPuNUZYXHqUjDEpSeF0gxzQTM622XiodcTyE2OWD76ne09JR1iwtxfTzUsUSK7+6R1OKceteFKQTO7exBpG5i08U9I7a2sFtvnvUF9RfWuhzdkd1PtVPsBkvaZTp3dNfwjDwMCqvscGUyak9hezj5BiztcgbqDQUfP53hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaxKW0gVB8sBccIM0Vre7+2dVByNdinpsgWrBezwNPo=;
 b=hZB+PYqNm5teZjgWkMh2/d2FBG9eWnpL0ABfNI8Eco+tJs1XYpMCkoTAuR8o57vbHIVYGoZ8AcNquaD5IvhFsUwxqzX5J2p7VDRnVHdNaIQVdBRjP87pD/+zf06GN0+Cf9K6rxjQn8l7vSuGnRBmW3WBmoYHaUSCOiPz1E+QUg4=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2869.namprd15.prod.outlook.com (2603:10b6:a03:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 9 Oct
 2020 18:45:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3455.023; Fri, 9 Oct 2020
 18:45:56 +0000
Date:   Fri, 9 Oct 2020 11:45:51 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <cl@linux.com>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH FIX v0] mm: memcg/slab: Uncharge during
 kmem_cache_free_bulk()
Message-ID: <20201009184551.GA3128977@carbon.dhcp.thefacebook.com>
References: <20201009060423.390479-1-bharata@linux.ibm.com>
In-Reply-To: <20201009060423.390479-1-bharata@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:b43d]
X-ClientProxiedBy: CO2PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:102:2::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b43d) by CO2PR05CA0066.namprd05.prod.outlook.com (2603:10b6:102:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.6 via Frontend Transport; Fri, 9 Oct 2020 18:45:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d318168a-9c14-48ff-035b-08d86c838e80
X-MS-TrafficTypeDiagnostic: BYAPR15MB2869:
X-Microsoft-Antispam-PRVS: <BYAPR15MB286966CAC394513701064001BE080@BYAPR15MB2869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFpg525PctMtwgrEAjxgBq+mhDzbPEN3xCJp0RaTQttktC7WDM9q+2R3xvwltPM5sCKK3lorfI+UKPc0ZytagRkJSm0oZnshnnz86EhVz0RoxqQ74rFjXWVL+3UXd+1ntJUkF2BnOHu5daDxPQMsOAStqvNOBFEolCOsZww3roiPOJu2YlrC3AzF/FHjipZaDy/8NpeIg3Zrc6pcBYnzDt3qH75BUzjSI0wooNuN5WNkvCTFRMfOHs+48KKw7tvF79SYAmyxg3WQsH9b0Sy8BXJejTiiQPZl57QIdxUuO6B0RvjGHfSd+Rt8bIM7z6lfzeTmuGXrZkZWusGPLDPt3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(7696005)(52116002)(478600001)(8936002)(83380400001)(5660300002)(316002)(2906002)(1076003)(6666004)(186003)(16526019)(6506007)(4326008)(33656002)(9686003)(66946007)(66476007)(66556008)(86362001)(8676002)(55016002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xMhVJooCXWVmS7zVn608x7aSuplw/dhcN7BdER74uBCi5Rgwy5UYIRR31OUbLKU6yvrdGOETfAxptI2j1KZaBOLjAaJEs++KzMTI6U2B+hjOE3z4fbBaMNkSKWkXWjWJL5vpw/FREfSFtongLJbGDaCSLTKgpj2bCpiil98nmHy4xgbCOUvwXKf2xsb00leXMglsn5ilMuUQwh6C0vVOata5FiC2WQk4z6psCOiCmxBg3xbtwZB0G7jS8vwQk1wtWpcBjyNdidCS0n+ZvdXbzY74PZPm7gEVTLxxD5hcWto5Q2iuhoyX1CRFezh6Y87cqXBiP4GJF9EIbTYs8Way8zLP+h3srhEz/AhAvYsggbqsB39+j8YDFP+XIjPplaFO3OuFli+cQKpLXFnC2znv570GM/jMEFhFr7HetlcX76piiUqx4Q6ZZFiHTRF+xIatq2gXX6BSmRMifLHcVF77q+0Guq+DApbhqIfvsc24jqoj6EK7C3PgqArV1nasq9acBak4V6oZ2FirbahwV/rbwXmcjQ5tdzhuZ3dvvBAB5+RhZF6/QDc5wD4xjqORoAdeQyIWR8+qx1KCmWhNfiDJLVBswdqJlaChZvHuKaRTSlALZptU3f8CHSLWzwbkxwVdzTqvo6ZzaCCCHqzmw7/4RrBDDrrjV7eeb+k7RBsGF9s=
X-MS-Exchange-CrossTenant-Network-Message-Id: d318168a-9c14-48ff-035b-08d86c838e80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 18:45:56.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRGH+CnkmOnwjmIMK6M2if4hFMvpaWL9vd4dRf4QyoSoLWJ9VIZF6j4PMy8sv+I5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2869
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_09:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=5
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010090134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:34:23AM +0530, Bharata B Rao wrote:

Hi Bharata,

> Object cgroup charging is done for all the objects during
> allocation, but during freeing, uncharging ends up happening
> for only one object in the case of bulk allocation/freeing.

Yes, it's definitely a problem. Thank you for catching it!

I'm curious, did you find it in the wild or by looking into the code?

> 
> Fix this by having a separate call to uncharge all the
> objects from kmem_cache_free_bulk() and by modifying
> memcg_slab_free_hook() to take care of bulk uncharging.
>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

Please, add:

Fixes: 964d4bd370d5 ("mm: memcg/slab: save obj_cgroup for non-root slab objects")
Cc: stable@vger.kernel.org

> ---
>  mm/slab.c |  2 +-
>  mm/slab.h | 42 +++++++++++++++++++++++++++---------------
>  mm/slub.c |  3 ++-
>  3 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index f658e86ec8cee..5c70600d8b1cc 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3440,7 +3440,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
>  		memset(objp, 0, cachep->object_size);
>  	kmemleak_free_recursive(objp, cachep->flags);
>  	objp = cache_free_debugcheck(cachep, objp, caller);
> -	memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
> +	memcg_slab_free_hook(cachep, &objp, 1);
>  
>  	/*
>  	 * Skip calling cache_free_alien() when the platform is not numa.
> diff --git a/mm/slab.h b/mm/slab.h
> index 6cc323f1313af..6dd4b702888a7 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -345,30 +345,42 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  	obj_cgroup_put(objcg);
>  }
>  
> -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> -					void *p)
> +static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
> +					void **p, int objects)
>  {
> +	struct kmem_cache *s;
>  	struct obj_cgroup *objcg;
> +	struct page *page;
>  	unsigned int off;
> +	int i;
>  
>  	if (!memcg_kmem_enabled())
>  		return;
>  
> -	if (!page_has_obj_cgroups(page))
> -		return;
> +	for (i = 0; i < objects; i++) {
> +		if (unlikely(!p[i]))
> +			continue;
>  
> -	off = obj_to_index(s, page, p);
> -	objcg = page_obj_cgroups(page)[off];
> -	page_obj_cgroups(page)[off] = NULL;
> +		page = virt_to_head_page(p[i]);
> +		if (!page_has_obj_cgroups(page))
> +			continue;
>  
> -	if (!objcg)
> -		return;
> +		if (!s_orig)
> +			s = page->slab_cache;
> +		else
> +			s = s_orig;
>  
> -	obj_cgroup_uncharge(objcg, obj_full_size(s));
> -	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> -			-obj_full_size(s));
> +		off = obj_to_index(s, page, p[i]);
> +		objcg = page_obj_cgroups(page)[off];
> +		if (!objcg)
> +			continue;
>  
> -	obj_cgroup_put(objcg);
> +		page_obj_cgroups(page)[off] = NULL;
> +		obj_cgroup_uncharge(objcg, obj_full_size(s));
> +		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> +				-obj_full_size(s));
> +		obj_cgroup_put(objcg);
> +	}
>  }
>  
>  #else /* CONFIG_MEMCG_KMEM */
> @@ -406,8 +418,8 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  {
>  }
>  
> -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> -					void *p)
> +static inline void memcg_slab_free_hook(struct kmem_cache *s,
> +					void **p, int objects)
>  {
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
> diff --git a/mm/slub.c b/mm/slub.c
> index 6d3574013b2f8..0cbe67f13946e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3091,7 +3091,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	struct kmem_cache_cpu *c;
>  	unsigned long tid;
>  
> -	memcg_slab_free_hook(s, page, head);
> +	memcg_slab_free_hook(s, &head, 1);

Hm, I wonder if it's better to teach do_slab_free() to handle the (cnt > 1) case correctly?

>  redo:
>  	/*
>  	 * Determine the currently cpus per cpu slab.
> @@ -3253,6 +3253,7 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  	if (WARN_ON(!size))
>  		return;
>  
> +	memcg_slab_free_hook(s, p, size);

Then you don't need this change.

Otherwise memcg_slab_free_hook() can be called twice for the same object. It's ok from
accounting correctness perspective, because the first call will zero out the objcg pointer,
but still much better to be avoided.

Thanks!
