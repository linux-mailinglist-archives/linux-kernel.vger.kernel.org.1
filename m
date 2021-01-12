Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60F92F2570
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbhALBVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:21:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37956 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbhALBVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:21:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C1H0uv101564;
        Tue, 12 Jan 2021 01:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lyZ0U9U2TqkiUJd7YSz9qBPdBQZnd1ZU9TozRTJ89lU=;
 b=aVRdIeh+y3SL/BbZ2MYWY51JlVQdBfIBTw1bc384uiouNnSrYN13cVEE3962bP5kwQFg
 Ht+G8D6UWr7iULQ8mk4faKCt48EoOr/DoiaWFlc56x1UHYR5+mx4gS1RdEyP516oTNeq
 Kro/Hbt2NDkce5OqnhLVTy1Ku7Bz+qo//rAuUEOHasqltBysTEwTll71cvl9JA3QPTmR
 8tZOBzF87mvjG0fPuVfO+dy/RTut6YlugIdanH8oKUbqkPq1sK5wE2NtrVudk2f5mlR6
 QLBHbG7yO4gWxmE/ksODZ739fCZeujb/0TAGtjLfY9EpnUOB1QSSrEQSsoaSwN1cOd4u Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 360kg1m0sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 01:20:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C1GSqw039250;
        Tue, 12 Jan 2021 01:20:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 360kf4jtr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 01:20:54 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10C1KqRI018722;
        Tue, 12 Jan 2021 01:20:52 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 17:20:52 -0800
Subject: Re: [PATCH v3 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        mhocko@suse.cz
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c61cdf1d-2feb-ecb3-393d-ca25175c73f4@oracle.com>
Date:   Mon, 11 Jan 2021 17:20:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210110124017.86750-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/21 4:40 AM, Muchun Song wrote:
> There is a race between dissolve_free_huge_page() and put_page(),
> and the race window is quite small. Theoretically, we should return
> -EBUSY when we encounter this race. In fact, we have a chance to
> successfully dissolve the page if we do a retry. Because the race
> window is quite small. If we seize this opportunity, it is an
> optimization for increasing the success rate of dissolving page.
> 
> If we free a HugeTLB page from a non-task context, it is deferred
> through a workqueue. In this case, we need to flush the work.
> 
> The dissolve_free_huge_page() can be called from memory hotplug,
> the caller aims to free the HugeTLB page to the buddy allocator
> so that the caller can unplug the page successfully.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

I am unsure about the need for this patch.  The code is OK, there are no
issues with the code.

As mentioned in the commit message, this is an optimization and could
potentially cause a memory offline operation to succeed instead of fail.
However, we are very unlikely to ever exercise this code.  Adding an
optimization that is unlikely to be exercised is certainly questionable.

Memory offline is the only code that could benefit from this optimization.
As someone with more memory offline user experience, what is your opinion
Michal?

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4a9011e12175..a176ceed55f1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>   * nothing for in-use hugepages and non-hugepages.
>   * This function returns values like below:
>   *
> - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> - *          (allocated or reserved.)
> - *       0: successfully dissolved free hugepages or the page is not a
> - *          hugepage (considered as already dissolved)
> + *  -EAGAIN: race with __free_huge_page() and can do a retry
> + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
> + *           (allocated or reserved.)
> + *       0:  successfully dissolved free hugepages or the page is not a
> + *           hugepage (considered as already dissolved)
>   */
>  int dissolve_free_huge_page(struct page *page)
>  {
> @@ -1793,8 +1794,10 @@ int dissolve_free_huge_page(struct page *page)
>  		 * We should make sure that the page is already on the free list
>  		 * when it is dissolved.
>  		 */
> -		if (unlikely(!PageHugeFreed(head)))
> +		if (unlikely(!PageHugeFreed(head))) {
> +			rc = -EAGAIN;
>  			goto out;
> +		}
>  
>  		/*
>  		 * Move PageHWPoison flag from head page to the raw error page,
> @@ -1813,6 +1816,14 @@ int dissolve_free_huge_page(struct page *page)
>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);
> +
> +	/*
> +	 * If the freeing of the HugeTLB page is put on a work queue, we should
> +	 * flush the work before retrying.
> +	 */
> +	if (unlikely(rc == -EAGAIN))
> +		flush_work(&free_hpage_work);
> +
>  	return rc;
>  }
>  
> @@ -1835,7 +1846,12 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
>  		page = pfn_to_page(pfn);
> +retry:
>  		rc = dissolve_free_huge_page(page);
> +		if (rc == -EAGAIN) {
> +			cpu_relax();
> +			goto retry;
> +		}
>  		if (rc)
>  			break;
>  	}
> 
