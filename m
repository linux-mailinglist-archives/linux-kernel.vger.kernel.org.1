Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E532AEE53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgKKJ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:59:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbgKKJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:59:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB9WZ63078832;
        Wed, 11 Nov 2020 04:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Wwf5jwDHkMd5SKtq1xrWEs5Z4PNyeSKCLqoHofFsgDk=;
 b=KdAUGemBn8sFV/r3PXXro2uwKvVewbogUUX+NnEJGTbShmUhkYyJ5nRedrDUAfH+O8bb
 6+eR79T17KRadqi0iX6V2jKsbUTCo+MQdEsmQDih8sOHZSOV5y1xm0KE8sWsZ4Cjv8Zq
 PsfXoTaj4kr9CIQzC2g67lvcbdlZPtq1/AZw5dLlLVrDRLOr7pefmOdWD//XeLCZ3xdB
 c8v3uSgc378rYiWKPRz2bpaBBgs1OsTZhnhKE5PdrPtmsjAYiMNVmLGtnwsR+XmiMNeb
 ulVzSaCVsuQK0GmaGLljYPRnWRtYEUbHRXBBxYvUEb69XW3MQB559SB3aBX777g247Tx Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34r6brkrnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 04:59:19 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AB9jgjC163750;
        Wed, 11 Nov 2020 04:59:18 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34r6brkrmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 04:59:18 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AB9vVrv006864;
        Wed, 11 Nov 2020 09:59:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 34p26pkecu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 09:59:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AB9xCv049021184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 09:59:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C2174C052;
        Wed, 11 Nov 2020 09:59:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A3454C044;
        Wed, 11 Nov 2020 09:59:11 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.10.167])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 11 Nov 2020 09:59:11 +0000 (GMT)
Date:   Wed, 11 Nov 2020 11:59:09 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages()
 with init_on_alloc=1 or __GFP_ZERO
Message-ID: <20201111095909.GC4755@linux.ibm.com>
References: <20201110193240.25401-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110193240.25401-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 08:32:40PM +0100, David Hildenbrand wrote:
> commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
> leaving the buddy via alloc_pages() and friends to be
> initialized/cleared/zeroed on allocation.
> 
> However, the same logic is currently not applied to
> alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
> with init_on_alloc=1 and init_on_free=0. Let's also properly clear
> pages on that allocation path and add support for __GFP_ZERO.
> 
> With this change, we will see double clearing of pages in some
> cases. One example are gigantic pages (either allocated via CMA, or
> allocated dynamically via alloc_contig_pages()) - which is the right
> thing to do (and to be optimized outside of the buddy in the callers) as
> discussed in:
>   https://lkml.kernel.org/r/20201019182853.7467-1-gpiccoli@canonical.com
> 
> This change implies that with init_on_alloc=1
> - All CMA allocations will be cleared
> - Gigantic pages allocated via alloc_contig_pages() will be cleared
> - virtio-mem memory to be unplugged will be cleared. While this is
>   suboptimal, it's similar to memory balloon drivers handling, where
>   all pages to be inflated will get cleared as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eed4f4075b3c..0361b119b74e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8453,6 +8453,19 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  	return 0;
>  }
>  
> +static void __alloc_contig_clear_range(unsigned long start_pfn,
> +				       unsigned long end_pfn)

Maybe clear_contig_range() ?

> +{
> +	unsigned long pfn;
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES) {
> +		cond_resched();
> +		kernel_init_free_pages(pfn_to_page(pfn),
> +				       min_t(unsigned long, end_pfn - pfn,
> +					     MAX_ORDER_NR_PAGES));
> +	}
> +}
> +
>  /**
>   * alloc_contig_range() -- tries to allocate given range of pages
>   * @start:	start PFN to allocate
> @@ -8461,7 +8474,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
>   *			in range must have the same migratetype and it must
>   *			be either of the two.
> - * @gfp_mask:	GFP mask to use during compaction
> + * @gfp_mask:	GFP mask to use during compaction. __GFP_ZERO clears allocated
> + *		pages.

"__GFP_ZERO is not passed to compaction but rather clears allocated pages"

>   *
>   * The PFN range does not have to be pageblock or MAX_ORDER_NR_PAGES
>   * aligned.  The PFN range must belong to a single zone.
> @@ -8488,7 +8502,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  		.mode = MIGRATE_SYNC,
>  		.ignore_skip_hint = true,
>  		.no_set_skip_hint = true,
> -		.gfp_mask = current_gfp_context(gfp_mask),
> +		.gfp_mask = current_gfp_context(gfp_mask & ~__GFP_ZERO),
>  		.alloc_contig = true,
>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
> @@ -8600,6 +8614,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	if (end != outer_end)
>  		free_contig_range(end, outer_end - end);
>  
> +	if (!want_init_on_free() && want_init_on_alloc(gfp_mask))
> +		__alloc_contig_clear_range(start, end);
> +
>  done:
>  	undo_isolate_page_range(pfn_max_align_down(start),
>  				pfn_max_align_up(end), migratetype);
> @@ -8653,7 +8670,8 @@ static bool zone_spans_last_pfn(const struct zone *zone,
>  /**
>   * alloc_contig_pages() -- tries to find and allocate contiguous range of pages
>   * @nr_pages:	Number of contiguous pages to allocate
> - * @gfp_mask:	GFP mask to limit search and used during compaction
> + * @gfp_mask:	GFP mask to limit search and used during compaction. __GFP_ZERO
> + *		clears allocated pages.
>   * @nid:	Target node
>   * @nodemask:	Mask for other possible nodes
>   *
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
