Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE292EA2E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbhAEBd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:33:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhAEBdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:33:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1051Q8kF065056;
        Tue, 5 Jan 2021 01:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0iX0hYqL8Jp+amfPcfQ+iuYkjd5pDTJ6H1dPNVW+Qbo=;
 b=sB4ROHGSWjjuMToEA3H9bFlMe651xq54ydaErpUN50OSoUBj2Km1q+ObjjeCywVfDCxf
 MZQ1j1x4ExjbIl/yxW2EHM42v/AztKv6pmFwcP8BX0nLKWk7vibvCDZAVg/peWB7ABTo
 /wggX/xsda9ui8zExetNNGrfx7l8ByrclWh8YIqCenjh7BUR2kop0GSK1Zqnn3bKnWiK
 BdYxjMD7Byl6OPt6MuUrbAvqNoin7NSWRZTd8kO3DD26CYo7PPpC0TMitMZbdvHLwLLx
 BUljbUyhAo29M8WW1HM6xr4qm7BEFsmyE8MHN74nMdkCUdjlOzVWrgmX/+OXvKINQRoU oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35tg8qxu2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 01:33:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1051SNnP115782;
        Tue, 5 Jan 2021 01:33:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35v1f81114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 01:33:00 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1051WtIq031261;
        Tue, 5 Jan 2021 01:32:57 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 17:32:55 -0800
Subject: Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e043e137-5ca7-d478-248c-9defcecc6ac7@oracle.com>
Date:   Mon, 4 Jan 2021 17:32:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210104065843.5658-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 10:58 PM, Muchun Song wrote:
> When dissolve_free_huge_page() races with __free_huge_page(), we can
> do a retry. Because the race window is small.

In general, I agree that the race window is small.  However, worst case
would be if the freeing of the page is put on a work queue.  Is it acceptable
to keep retrying in that case?  In addition, the 'Free some vmemmap' series
may slow the free_huge_page path even more.

In these worst case scenarios, I am not sure we want to just spin retrying.

-- 
Mike Kravetz

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 72608008f8b4..db00ae375d2a 100644
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
> @@ -1815,8 +1816,10 @@ int dissolve_free_huge_page(struct page *page)
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
> @@ -1857,7 +1860,10 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
>  		page = pfn_to_page(pfn);
> +retry:
>  		rc = dissolve_free_huge_page(page);
> +		if (rc == -EAGAIN)
> +			goto retry;
>  		if (rc)
>  			break;
>  	}
> 
