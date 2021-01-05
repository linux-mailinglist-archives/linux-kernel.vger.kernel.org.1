Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BB2EA13F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAEADW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:03:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43142 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbhAEADW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:03:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104NtK3r034241;
        Tue, 5 Jan 2021 00:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yjmL1z8afkDj3V29IGaVoHqpiLI+uN3cU2BdAbj6NzY=;
 b=g2Kbr2cSfynMPGf7tn+ha097scMTAVgoJ8IV/db7NZgK3uJTaNLJ8UVWZiPq9upxapnf
 Yyu7EC/DV9ZrL5mUjyEsg8UK+MYsHjXcB8zy+5U8KnsNgO2kwweSCVBrh4aYJnrx5n8C
 vCpFClMjT+bEMes+Dwj5Y71XOidukj53EPs0zuYQua4/IYpx6X3QMSI3hwciJ7A4jMBG
 Q2W2rkNhOJQoItV7Kr3vaTVMFkkL8Dmt8ZDn3CHVekBGNu03iEHGPFX0EWokm3VgbjtD
 91LP0rIU2G/LM38a7lu0lf0iFuGDcSgS+VrXy4fg9TN+UleoZhLos7ySAm17cWjaeMpt gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35tebaprvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 00:02:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104NvCBx030340;
        Tue, 5 Jan 2021 00:00:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35v4ras3gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 00:00:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10500OAx015090;
        Tue, 5 Jan 2021 00:00:25 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 16:00:23 -0800
Subject: Re: [PATCH 3/6] mm: hugetlb: fix a race between freeing and
 dissolving the page
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b41d2f1d-da2c-07ae-6bd0-31022a3378ea@oracle.com>
Date:   Mon, 4 Jan 2021 16:00:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210104065843.5658-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 10:58 PM, Muchun Song wrote:
> There is a race condition between __free_huge_page()
> and dissolve_free_huge_page().
> 
> CPU0:                         CPU1:
> 
> // page_count(page) == 1
> put_page(page)
>   __free_huge_page(page)
>                               dissolve_free_huge_page(page)
>                                 spin_lock(&hugetlb_lock)
>                                 // PageHuge(page) && !page_count(page)
>                                 update_and_free_page(page)
>                                 // page is freed to the buddy
>                                 spin_unlock(&hugetlb_lock)
>     spin_lock(&hugetlb_lock)
>     clear_page_huge_active(page)
>     enqueue_huge_page(page)
>     // It is wrong, the page is already freed
>     spin_unlock(&hugetlb_lock)
> 
> The race windows is between put_page() and spin_lock() which
> is in the __free_huge_page().
> 
> We should make sure that the page is already on the free list
> when it is dissolved.
> 
> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f3bf1710b66..72608008f8b4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
>  static int num_fault_mutexes;
>  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>  
> +static inline bool PageHugeFreed(struct page *head)
> +{
> +	return page_private(head) == -1UL;

	return page_private(head + 4) == -1UL;

> +}
> +
> +static inline void SetPageHugeFreed(struct page *head)
> +{
> +	set_page_private(head + 4, -1UL);
> +}
> +
> +static inline void ClearPageHugeFreed(struct page *head)
> +{
> +	set_page_private(head + 4, 0);
> +}

It is unfortunate that we can not use some existing value like
page_huge_active() to determine if dissolve_free_huge_page() should
proceed with freeing the page to buddy.  If the existing check,

	if (!page_count(page)) {

was changed to

	if (!page_count(page) && !page_huge_active(page)) {

the race window would be shrunk.  However, the most straight forward
way to fully close the window is with the approach taken here.

> +
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>  
> @@ -1028,6 +1043,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  	list_move(&page->lru, &h->hugepage_freelists[nid]);
>  	h->free_huge_pages++;
>  	h->free_huge_pages_node[nid]++;
> +	SetPageHugeFreed(page);
>  }
>  
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> @@ -1044,6 +1060,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  
>  		list_move(&page->lru, &h->hugepage_activelist);
>  		set_page_refcounted(page);
> +		ClearPageHugeFreed(page);
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
>  		return page;
> @@ -1504,6 +1521,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	spin_lock(&hugetlb_lock);
>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
> +	ClearPageHugeFreed(page);
>  	spin_unlock(&hugetlb_lock);
>  }
>  
> @@ -1770,6 +1788,36 @@ int dissolve_free_huge_page(struct page *page)
>  		int nid = page_to_nid(head);
>  		if (h->free_huge_pages - h->resv_huge_pages == 0)
>  			goto out;
> +
> +		/*
> +		 * There is a race condition between __free_huge_page()
> +		 * and dissolve_free_huge_page().
> +		 *
> +		 * CPU0:                         CPU1:
> +		 *
> +		 * // page_count(page) == 1
> +		 * put_page(page)
> +		 *   __free_huge_page(page)
> +		 *                               dissolve_free_huge_page(page)
> +		 *                                 spin_lock(&hugetlb_lock)
> +		 *                                 // PageHuge(page) && !page_count(page)
> +		 *                                 update_and_free_page(page)
> +		 *                                 // page is freed to the buddy
> +		 *                                 spin_unlock(&hugetlb_lock)
> +		 *     spin_lock(&hugetlb_lock)
> +		 *     enqueue_huge_page(page)
> +		 *     // It is wrong, the page is already freed
> +		 *     spin_unlock(&hugetlb_lock)
> +		 *
> +		 * The race window is between put_page() and spin_lock() which
> +		 * is in the __free_huge_page().

IMO, the description of the race condition in the commit message is
sufficient.  It does not need to be here in the code.  The below comment
should be sufficient.

-- 
Mike Kravetz

> +		 *
> +		 * We should make sure that the page is already on the free list
> +		 * when it is dissolved.
> +		 */
> +		if (unlikely(!PageHugeFreed(head)))
> +			goto out;
> +
>  		/*
>  		 * Move PageHWPoison flag from head page to the raw error page,
>  		 * which makes any subpages rather than the error page reusable.
> 
