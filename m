Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7952EC56D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbhAFVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:01:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45760 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbhAFVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:01:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106KwwFh091093;
        Wed, 6 Jan 2021 21:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gWBnq9ea48XyOLio70LmxAP9XgRXJrH6rK+qYLCgsnM=;
 b=jntD77/HwacS/xUIiU/mzjsaauHLUeqw8w6fFUqWL3pYDHOEo/nlXT4n6DyvYsnvqapW
 57giv/RGdqT2KA0x64x3kQlkLp2g20Cm8mWa1CN2dOEzMmdJo2tPhSx8tJZMsX55j+nH
 H+gGEpuxCHimV7Hv/uvq/KzmI+q9ifsZ9ZKJNcDF4qiZAbCI5UhpJKhJoLvLkW0J/E4Q
 /bk3//suiSsuzbQ7PIq+NXrAcU0ezOIwyqiaiCIF1+JU+q4ieOqXA38H9Vg3dOHRvgui
 9V87H+Xk4VAYVJYovQvS9OsXnqGflrhxz60QKYRYadQ2/VOqvWe93CmvNTyMoDNnsI2f Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35wepm9ukc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 21:00:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106KuQdq079426;
        Wed, 6 Jan 2021 20:58:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35w3qsje2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 20:58:35 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 106KwU25029412;
        Wed, 6 Jan 2021 20:58:31 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 12:58:30 -0800
Subject: Re: [PATCH v2 3/6] mm: hugetlb: fix a race between freeing and
 dissolving the page
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com>
 <20210106165632.GT13207@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a9c59b0e-9a9d-c568-5503-5df6fe8db908@oracle.com>
Date:   Wed, 6 Jan 2021 12:58:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210106165632.GT13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 8:56 AM, Michal Hocko wrote:
> On Wed 06-01-21 16:47:36, Muchun Song wrote:
>> There is a race condition between __free_huge_page()
>> and dissolve_free_huge_page().
>>
>> CPU0:                         CPU1:
>>
>> // page_count(page) == 1
>> put_page(page)
>>   __free_huge_page(page)
>>                               dissolve_free_huge_page(page)
>>                                 spin_lock(&hugetlb_lock)
>>                                 // PageHuge(page) && !page_count(page)
>>                                 update_and_free_page(page)
>>                                 // page is freed to the buddy
>>                                 spin_unlock(&hugetlb_lock)
>>     spin_lock(&hugetlb_lock)
>>     clear_page_huge_active(page)
>>     enqueue_huge_page(page)
>>     // It is wrong, the page is already freed
>>     spin_unlock(&hugetlb_lock)
>>
>> The race windows is between put_page() and spin_lock() which
>> is in the __free_huge_page().
> 
> The race window reall is between put_page and dissolve_free_huge_page.
> And the result is that the put_page path would clobber an unrelated page
> (either free or already reused page) which is quite serious.
> Fortunatelly pages are dissolved very rarely. I believe that user would
> require to be privileged to hit this by intention.
> 
>> We should make sure that the page is already on the free list
>> when it is dissolved.
> 
> Another option would be to check for PageHuge in __free_huge_page. Have
> you considered that rather than add yet another state? The scope of the
> spinlock would have to be extended. If that sounds more tricky then can
> we check the page->lru in the dissolve path? If the page is still
> PageHuge and reference count 0 then there shouldn't be many options
> where it can be queued, right?

The tricky part with expanding lock scope will be the potential call to
hugepage_subpool_put_pages as it may also try to acquire the hugetlb_lock.

I am not sure what you mean by 'check the page->lru'?  If we knew the page
was on the free list, then we could dissolve.  But, I do not think there
is an easy way to determine that from page->lru.  A hugetlb page is either
going to be on the active list or free list.

> 
>> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 4741d60f8955..8ff138c17129 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
>>  static int num_fault_mutexes;
>>  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>>  
>> +static inline bool PageHugeFreed(struct page *head)
>> +{
>> +	return (unsigned long)head[3].mapping == -1U;
>> +}
>> +
>> +static inline void SetPageHugeFreed(struct page *head)
>> +{
>> +	head[3].mapping = (void *)-1U;
>> +}
>> +
>> +static inline void ClearPageHugeFreed(struct page *head)
>> +{
>> +	head[3].mapping = NULL;
>> +}
>> +
>>  /* Forward declaration */
>>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>>  
>> @@ -1028,6 +1043,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>>  	list_move(&page->lru, &h->hugepage_freelists[nid]);
>>  	h->free_huge_pages++;
>>  	h->free_huge_pages_node[nid]++;
>> +	SetPageHugeFreed(page);
>>  }
>>  
>>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>> @@ -1044,6 +1060,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>>  
>>  		list_move(&page->lru, &h->hugepage_activelist);
>>  		set_page_refcounted(page);
>> +		ClearPageHugeFreed(page);
>>  		h->free_huge_pages--;
>>  		h->free_huge_pages_node[nid]--;
>>  		return page;
>> @@ -1291,6 +1308,17 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>>  						unsigned int order) { }
>>  #endif
>>  
>> +/*
>> + * Because we reuse the mapping field of some tail page structs, we should
>> + * reset those mapping to initial value before @head is freed to the buddy
>> + * allocator. The invalid value will be checked in the free_tail_pages_check().
>> + */

When I suggested using head[3].mapping for this state, I was not aware of
this requirement.  My suggestion was only following the convention used in
PageHugeTemporary.  I would not have made the suggestion if I had realized
this was required.  Sorry.
-- 
Mike Kravetz

>> +static inline void reset_tail_page_mapping(struct hstate *h, struct page *head)
>> +{
>> +	if (!hstate_is_gigantic(h))
>> +		head[3].mapping = TAIL_MAPPING;
>> +}
>> +
>>  static void update_and_free_page(struct hstate *h, struct page *page)
>>  {
>>  	int i;
>> @@ -1298,6 +1326,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>>  		return;
>>  
>> +	reset_tail_page_mapping(h, page);
>>  	h->nr_huge_pages--;
>>  	h->nr_huge_pages_node[page_to_nid(page)]--;
>>  	for (i = 0; i < pages_per_huge_page(h); i++) {
>> @@ -1504,6 +1533,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>>  	spin_lock(&hugetlb_lock);
>>  	h->nr_huge_pages++;
>>  	h->nr_huge_pages_node[nid]++;
>> +	ClearPageHugeFreed(page);
>>  	spin_unlock(&hugetlb_lock);
>>  }
>>  
>> @@ -1770,6 +1800,14 @@ int dissolve_free_huge_page(struct page *page)
>>  		int nid = page_to_nid(head);
>>  		if (h->free_huge_pages - h->resv_huge_pages == 0)
>>  			goto out;
>> +
>> +		/*
>> +		 * We should make sure that the page is already on the free list
>> +		 * when it is dissolved.
>> +		 */
>> +		if (unlikely(!PageHugeFreed(head)))
>> +			goto out;
>> +
>>  		/*
>>  		 * Move PageHWPoison flag from head page to the raw error page,
>>  		 * which makes any subpages rather than the error page reusable.
>> -- 
>> 2.11.0
> 
