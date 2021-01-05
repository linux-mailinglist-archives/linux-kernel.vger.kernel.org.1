Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92842EB615
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbhAEXXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:23:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45156 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbhAEXXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:23:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105NF6Ub112908;
        Tue, 5 Jan 2021 23:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=71w137zs8wrFhvzlyBDH7V4EcfuMXCx1LlC2WYxT9NM=;
 b=CJr+m79k1k0GN81A2Faw/cxUXWfIgH/oBQAujhytPLIe3zNG10RguPaoHo8nZzaOvNCY
 cqitroXxx8PE2EHXGRZDXp0SJ21Mk1QqhB1ozABRHV6nfxVZ3jgLaqF/+UNigZ0l+mC4
 1ygckntzt1H5YXDjJwNIjlT3gi8IsViwtuQHacGX7TV1xxziElzMrTKYPgQP8+DsoSSp
 vv7SBXluwpNRwaB1SLdrGKO/nXaJ7fy1lRAOtddrXaQSFvyZgLDz9XwASncp2f969Mck
 drb6rpBDL4kKU6BmvWBQ3H3vaQCrE9CS7lzr8n2u6lXmtXmHT7KyjlB+layd74fNZcGa rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35tgsku5h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 23:22:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105NEnpv085382;
        Tue, 5 Jan 2021 23:22:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35v1f96njr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 23:22:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 105NMDO7006811;
        Tue, 5 Jan 2021 23:22:14 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 15:22:13 -0800
Subject: Re: [External] Re: [PATCH 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-3-songmuchun@bytedance.com>
 <b41d2f1d-da2c-07ae-6bd0-31022a3378ea@oracle.com>
 <CAMZfGtV-zYoWrHZETd2soOGifRpbhQH=myzQc0NtjpgzC-Fygw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <19e24147-f3cd-c6d2-dd0a-57e6182d60d8@oracle.com>
Date:   Tue, 5 Jan 2021 15:22:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtV-zYoWrHZETd2soOGifRpbhQH=myzQc0NtjpgzC-Fygw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 6:55 PM, Muchun Song wrote:
> On Tue, Jan 5, 2021 at 8:02 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 1/3/21 10:58 PM, Muchun Song wrote:
>>> There is a race condition between __free_huge_page()
>>> and dissolve_free_huge_page().
>>>
>>> CPU0:                         CPU1:
>>>
>>> // page_count(page) == 1
>>> put_page(page)
>>>   __free_huge_page(page)
>>>                               dissolve_free_huge_page(page)
>>>                                 spin_lock(&hugetlb_lock)
>>>                                 // PageHuge(page) && !page_count(page)
>>>                                 update_and_free_page(page)
>>>                                 // page is freed to the buddy
>>>                                 spin_unlock(&hugetlb_lock)
>>>     spin_lock(&hugetlb_lock)
>>>     clear_page_huge_active(page)
>>>     enqueue_huge_page(page)
>>>     // It is wrong, the page is already freed
>>>     spin_unlock(&hugetlb_lock)
>>>
>>> The race windows is between put_page() and spin_lock() which
>>> is in the __free_huge_page().
>>>
>>> We should make sure that the page is already on the free list
>>> when it is dissolved.
>>>
>>> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 1f3bf1710b66..72608008f8b4 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
>>>  static int num_fault_mutexes;
>>>  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>>>
>>> +static inline bool PageHugeFreed(struct page *head)
>>> +{
>>> +     return page_private(head) == -1UL;
>>
>>         return page_private(head + 4) == -1UL;
>>
>>> +}
>>> +
>>> +static inline void SetPageHugeFreed(struct page *head)
>>> +{
>>> +     set_page_private(head + 4, -1UL);
>>> +}
>>> +
>>> +static inline void ClearPageHugeFreed(struct page *head)
>>> +{
>>> +     set_page_private(head + 4, 0);
>>> +}
>>
>> It is unfortunate that we can not use some existing value like
>> page_huge_active() to determine if dissolve_free_huge_page() should
>> proceed with freeing the page to buddy.  If the existing check,
>>
>>         if (!page_count(page)) {
>>
>> was changed to
>>
>>         if (!page_count(page) && !page_huge_active(page)) {
>>
>> the race window would be shrunk.  However, the most straight forward
>> way to fully close the window is with the approach taken here.
> 
> I also thought about this fix. But this is not enough. Because
> we just call put_page to free the HugeTLB page without
> setting activeness in some place (e.g. error handling
> routines).
> 
> If we use page_huge_active, we should set activeness
> before put_page. But we cannot guarantee this.

Just FYI,
I went back and explored the option of doing set_page_huge_active
when a page was put on the active list and clear_page_huge_active
when put on the free list.  This would be much like what you are
doing with PageHugeFreed.  Commit bcc54222309c which added page_huge_active
implied that this was possible.  Then I remembered a race fixed in
cb6acd01e2e4 that required delaying the call to set_page_huge_active
in hugetlb_no_page.  So, such a scheme would not work.

Also,
It seems we could use head[3].mapping for PageHugeFreed ?  Not much
of an advantage.  It does not add another tail page needed to store
page metadata.  And, this fits within the already defined
HUGETLB_CGROUP_MIN_ORDER.
-- 
Mike Kravetz
