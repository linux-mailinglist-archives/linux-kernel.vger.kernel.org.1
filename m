Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9C304F80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhA0DOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:14:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35120 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392771AbhAZT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:26:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJ4XHF107031;
        Tue, 26 Jan 2021 19:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CvzEtesgZWUXLz7Q4GitUrI1Qm5PX1Nk7OaWSJ1Ihko=;
 b=zR37OZKOpj5q3sw64uQzDhC+LaJqbNpQ52/cAciiveMKUzKGuJhfmfdUtoWeKmQWNhtS
 IxPisxTlY1jqI0XScvc9bapI7O2L4tuuKAiF6eHHaLgftjX5x+hn2U6rTi2xrWWI7ig5
 qJpyQqp4Wb4pygUSFRNoKsQkSt3QsHDwvYj0byc2gYanQrUBV4k2L/9DNBrb8s4J1pUy
 qPyRY2hYNiU3HCk0WSgHk/GHzf11p2BkgC39VRRbr1sim+P70QZU73U+4m43F27fLXHn
 N60s8Lmjpa5p7KtM+4xEQXmT4algR5OsnIkrYfGLhd2OTOM5vSaiau1ZhOSCYdgZ9h4d uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brkkmrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 19:25:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJ0ei2006985;
        Tue, 26 Jan 2021 19:25:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 368wpyb13v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 19:25:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10QJPSOw025020;
        Tue, 26 Jan 2021 19:25:28 GMT
Received: from [10.175.212.218] (/10.175.212.218) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Tue, 26 Jan 2021 11:24:29 -0800
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <0eb11869-2a5c-9724-7a48-2d252f8b4b37@oracle.com>
Date:   Tue, 26 Jan 2021 11:24:26 -0800 (PST)
From:   Joao Martins <joao.m.martins@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
In-Reply-To: <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/21 7:21 PM, Joao Martins wrote:
> On 1/26/21 6:08 PM, Mike Kravetz wrote:
>> On 1/25/21 12:57 PM, Joao Martins wrote:
>>> For a given hugepage backing a VA, there's a rather ineficient
>>> loop which is solely responsible for storing subpages in the passed
>>> pages/vmas array. For each subpage we check whether it's within
>>> range or size of @pages and keep incrementing @pfn_offset and a couple
>>> other variables per subpage iteration.
>>>
>>> Simplify this logic and minimize ops per iteration to just
>>> store the output page/vma. Instead of incrementing number of @refs
>>> iteratively, we do it through a precalculation of @refs and having
>>> only a tight loop for storing pinned subpages/vmas.
>>>
>>> pinning consequently improves considerably, bringing us close to
>>> {pin,get}_user_pages_fast:
>>>
>>>  - 16G with 1G huge page size
>>>  gup_test -f /mnt/huge/file -m 16384 -r 10 -L -S -n 512 -w
>>>
>>>  PIN_LONGTERM_BENCHMARK: ~11k us -> ~4400 us
>>>  PIN_FAST_BENCHMARK: ~3700 us
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
>>>  1 file changed, 28 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 016addc8e413..1f7a95bc7c87 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4789,6 +4789,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>>  	goto out;
>>>  }
>>>  
>>> +static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>>> +				 int refs, struct page **pages,
>>> +				 struct vm_area_struct **vmas)
>>> +{
>>> +	int nr;
>>> +
>>> +	for (nr = 0; nr < refs; nr++) {
>>> +		if (likely(pages))
>>> +			pages[nr] = page++;
>>> +		if (vmas)
>>> +			vmas[nr] = vma;
>>> +	}
>>> +}
>>> +
>>>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>  			 struct page **pages, struct vm_area_struct **vmas,
>>>  			 unsigned long *position, unsigned long *nr_pages,
>>> @@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>  			continue;
>>>  		}
>>>  
>>> -		refs = 0;
>>> +		refs = min3(pages_per_huge_page(h) - pfn_offset,
>>> +			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
>>>  
>>> -same_page:
>>> -		if (pages)
>>> -			pages[i] = mem_map_offset(page, pfn_offset);
>>> +		if (pages || vmas)
>>> +			record_subpages_vmas(mem_map_offset(page, pfn_offset),
>>
>> The assumption made here is that mem_map is contiguous for the range of
>> pages in the hugetlb page.  I do not believe you can make this assumption
>> for (gigantic) hugetlb pages which are > MAX_ORDER_NR_PAGES.  For example,
>>
> 
> That would mean get_user_pages_fast() and put_user_pages_fast() are broken for anything
> handling PUDs or above? See record_subpages() in gup_huge_pud() or even gup_huge_pgd().
> It's using the same page++.
> 

Err ... I meant pin_user_pages_fast(), sorry about that.

> This adjustment below probably is what you're trying to suggest.
> 
> Also, nth_page() is slightly more expensive and so the numbers above change from ~4.4k
> usecs to ~7.8k usecs.
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f7a95bc7c87..cf66f8c2f92a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4789,15 +4789,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         goto out;
>  }
> 
> -static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
> +static void record_subpages_vmas(struct page *page, unsigned long pfn_offset,
> +                                struct vm_area_struct *vma,
>                                  int refs, struct page **pages,
>                                  struct vm_area_struct **vmas)
>  {
> -       int nr;
> +       unsigned long nr;
> 
>         for (nr = 0; nr < refs; nr++) {
>                 if (likely(pages))
> -                       pages[nr] = page++;
> +                       pages[nr] = mem_map_offset(page, pfn_offset + nr);
>                 if (vmas)
>                         vmas[nr] = vma;
>         }
> @@ -4936,8 +4937,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct
> *vma,
>                             (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
> 
>                 if (pages || vmas)
> -                       record_subpages_vmas(mem_map_offset(page, pfn_offset),
> -                                            vma, refs,
> +                       record_subpages_vmas(page, pfn_offset, vma, refs,
>                                              likely(pages) ? pages + i : NULL,
>                                              vmas ? vmas + i : NULL);
> 
