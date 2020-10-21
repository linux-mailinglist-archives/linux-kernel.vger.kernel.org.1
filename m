Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236FF294CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440695AbgJUMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394624AbgJUMmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603284133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoOQdR018rTjybNT+FHJ7d/S35bDged0to5E6I4DaSM=;
        b=CBkIQdNHhSeuR1rN8La5hJCp9v8/Qj4y7R5Rdaot5XRgB7rodYAASjbRE8tPObAYsJD+45
        G4/zISrsBnjmWQ3dnKv2jPxBWnlmMm0/K82SaTerCGd6cu6Zdn+EIHdXnmJd8HqtkCs9e6
        DTZhdbPLyxg/YozlBe4f3U48u6iUBpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-FcYyZNL4OGKBsl0h9zlUUw-1; Wed, 21 Oct 2020 08:42:11 -0400
X-MC-Unique: FcYyZNL4OGKBsl0h9zlUUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33A36804024;
        Wed, 21 Oct 2020 12:42:10 +0000 (UTC)
Received: from [10.36.114.138] (ovpn-114-138.ams2.redhat.com [10.36.114.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A7F310013D0;
        Wed, 21 Oct 2020 12:42:04 +0000 (UTC)
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Privoznik <mprivozn@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <c1ea7548-622c-eda7-66f4-e4ae5b6ee8fc@redhat.com>
 <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
 <CAHS8izPEHZunoeXYS5ONfRoSRMpC7DQwtpjJ8g4nXiddTfNoaA@mail.gmail.com>
 <65a1946f-dbf9-5767-5b51-9c1b786051d1@redhat.com>
 <5f196069-8b98-0ad3-55e8-19af03d715cd@oracle.com>
 <c78634ee-0d6f-c98c-3c2a-8cb500c0ae47@oracle.com>
 <b24380ad-b87c-a3a1-d25e-ee30c10ed0d2@redhat.com>
 <312246f4-4e5f-1425-1bc2-1b356db0fbad@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0012e70b-3b48-df81-1dbd-29bd37e5b7e8@redhat.com>
Date:   Wed, 21 Oct 2020 14:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <312246f4-4e5f-1425-1bc2-1b356db0fbad@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.20 05:35, Mike Kravetz wrote:
> On 10/20/20 6:38 AM, David Hildenbrand wrote:
>>
>> I'm bisecting the warning right now. Looks like it was introduced in v5.7.
> 

So bisecting nailed it down to one of

353b2de42e84 mm/hugetlb.c: clean code by removing unnecessary initialization
a9b3f867404b hugetlb: support file_region coalescing again
08cf9faf7558 hugetlb_cgroup: support noreserve mappings
075a61d07a8e hugetlb_cgroup: add accounting for shared mappings
0db9d74ed884 hugetlb: disable region_add file_region coalescing
e9fe92ae0cd2 hugetlb_cgroup: add reservation accounting for private mappings
9808895e1a44 mm/hugetlb_cgroup: fix hugetlb_cgroup migration
1adc4d419aa2 hugetlb_cgroup: add interface for charge/uncharge hugetlb
reservations
cdc2fcfea79b hugetlb_cgroup: add hugetlb_cgroup reservation counter

So seems to be broken right from the beginning of
charge/uncharge/reservations. Not a surpise when looking at your fixes :)


> I found the following bugs in the cgroup reservation accounting.  The ones
> in region_del are pretty obvious as the number of pages to uncharge would
> always be zero.  The one on alloc_huge_page needs racing code to expose.
> 
> With these fixes, my testing is showing consistent/correct results for
> hugetlb reservation cgroup accounting.
> 
> It would be good if Mina (at least) would look these over.  Would also
> be interesting to know if these fixes address the bug seen with the qemu
> use case.

I strongly suspect it will. Compiling, will reply in half an our or so
with the result.

> 
> I'm still doing more testing and code inspection to look for other issues.

When sending, can you make sure to credit Michal P.? Thanks!

Reported-by: Michal Privoznik <mprivozn@redhat.com>

> 
> From 861bcd7d0443f18a5fed3c3ddc5f1c71e78c4ef4 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Tue, 20 Oct 2020 20:21:42 -0700
> Subject: [PATCH] hugetlb_cgroup: fix reservation accounting
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 67fc6383995b..c92366313780 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -685,17 +685,17 @@ static long region_del(struct resv_map *resv, long f, long t)
>  		}
>  
>  		if (f <= rg->from) {	/* Trim beginning of region */
> -			del += t - rg->from;
> -			rg->from = t;
> -
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
>  							    t - rg->from);
> -		} else {		/* Trim end of region */
> -			del += rg->to - f;
> -			rg->to = f;
>  
> +			del += t - rg->from;
> +			rg->from = t;
> +		} else {		/* Trim end of region */
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
>  							    rg->to - f);
> +
> +			del += rg->to - f;
> +			rg->to = f;

Those two look very correct to me.

You could keep computing "del" before the uncharge, similar to the /*
Remove entire region */ case.

>  		}
>  	}
>  
> @@ -2454,6 +2454,9 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  
>  		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
>  		hugetlb_acct_memory(h, -rsv_adjust);
> +		if (deferred_reserve)
> +			hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
> +					

That looks correct to me as well.

>  	}
>  	return page;
>  
> 

Thanks for debugging!

-- 
Thanks,

David / dhildenb

