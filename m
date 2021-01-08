Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0F2EEA94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbhAHAxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:53:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38126 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbhAHAxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:53:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1080Z4aL182515;
        Fri, 8 Jan 2021 00:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6Yuo+VxFPfGQC4s1IrUj9sSA2Cqk6UuNoZ/DE8PBsk0=;
 b=MFg8yjJAUzj+cRrlFMTX5gU9LBOMwckVgF1b2Hg6EoPfOP8l/wPjsZrjeQ6pZhFCiaix
 Oy19dUGH9hVU+y3iwLzoMZk7/A1XQRio3OWomW7qgyRaS+Z8DcBzf4Hc2p98PU+KHPiR
 eUrKOIVBkg8+hUZUc4ucGkrjM69sRquYw2NQRrPgepcGWCRhibgqE0V13gc1cCO6Rvpu
 44mElzSUMw3YPSKlKS3Xln4tCyhK1vTew3VYOO5R+UhMTZC+zzFv6covmRoVBMt1mDVR
 jMScM4afemfqv/lNJklCJ4XanB7BaahToTYM+IwUabmnOwFo/WuZ3ofX5+Mw1tHboRDs gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35wcuxyeag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 00:52:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1080Ykhk157312;
        Fri, 8 Jan 2021 00:52:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35v4renp9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 00:52:24 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1080qLYK000383;
        Fri, 8 Jan 2021 00:52:21 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 00:52:21 +0000
Subject: Re: [PATCH v2 3/6] mm: hugetlb: fix a race between freeing and
 dissolving the page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com>
 <20210106165632.GT13207@dhcp22.suse.cz>
 <a9c59b0e-9a9d-c568-5503-5df6fe8db908@oracle.com>
 <20210107084038.GC13207@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <509ef752-cc2e-3edf-5871-87f971a7bc0f@oracle.com>
Date:   Thu, 7 Jan 2021 16:52:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210107084038.GC13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 12:40 AM, Michal Hocko wrote:
> On Wed 06-01-21 12:58:29, Mike Kravetz wrote:
>> On 1/6/21 8:56 AM, Michal Hocko wrote:
>>> On Wed 06-01-21 16:47:36, Muchun Song wrote:
>>>> There is a race condition between __free_huge_page()
>>>> and dissolve_free_huge_page().
>>>>
>>>> CPU0:                         CPU1:
>>>>
>>>> // page_count(page) == 1
>>>> put_page(page)
>>>>   __free_huge_page(page)
>>>>                               dissolve_free_huge_page(page)
>>>>                                 spin_lock(&hugetlb_lock)
>>>>                                 // PageHuge(page) && !page_count(page)
>>>>                                 update_and_free_page(page)
>>>>                                 // page is freed to the buddy
>>>>                                 spin_unlock(&hugetlb_lock)
>>>>     spin_lock(&hugetlb_lock)
>>>>     clear_page_huge_active(page)
>>>>     enqueue_huge_page(page)
>>>>     // It is wrong, the page is already freed
>>>>     spin_unlock(&hugetlb_lock)
>>>>
>>>> The race windows is between put_page() and spin_lock() which
>>>> is in the __free_huge_page().
>>>
>>> The race window reall is between put_page and dissolve_free_huge_page.
>>> And the result is that the put_page path would clobber an unrelated page
>>> (either free or already reused page) which is quite serious.
>>> Fortunatelly pages are dissolved very rarely. I believe that user would
>>> require to be privileged to hit this by intention.
>>>
>>>> We should make sure that the page is already on the free list
>>>> when it is dissolved.
>>>
>>> Another option would be to check for PageHuge in __free_huge_page. Have
>>> you considered that rather than add yet another state? The scope of the
>>> spinlock would have to be extended. If that sounds more tricky then can
>>> we check the page->lru in the dissolve path? If the page is still
>>> PageHuge and reference count 0 then there shouldn't be many options
>>> where it can be queued, right?
>>
>> The tricky part with expanding lock scope will be the potential call to
>> hugepage_subpool_put_pages as it may also try to acquire the hugetlb_lock.
> 
> Can we rearrange the code and move hugepage_subpool_put_pages after all
> this is done? Or is there any strong reason for the particular ordering?

The reservation code is so fragile, I always get nervous when making
any changes.  However, the straight forward patch below passes some
simple testing.  The only difference I can see is that global counts
are adjusted before sub-pool counts.  This should not be an issue as
global and sub-pool counts are adjusted independently (not under the
same lock).  Allocation code checks sub-pool counts before global
counts.  So, there is a SMALL potential that a racing allocation which
previously succeeded would now fail.  I do not think this is an issue
in practice.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3b38ea958e95..658593840212 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1395,6 +1395,11 @@ static void __free_huge_page(struct page *page)
 		(struct hugepage_subpool *)page_private(page);
 	bool restore_reserve;
 
+	spin_lock(&hugetlb_lock);
+	/* check for race with dissolve_free_huge_page/update_and_free_page */
+	if (!PageHuge(page))
+		return;
+
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
 
@@ -1403,26 +1408,6 @@ static void __free_huge_page(struct page *page)
 	restore_reserve = PagePrivate(page);
 	ClearPagePrivate(page);
 
-	/*
-	 * If PagePrivate() was set on page, page allocation consumed a
-	 * reservation.  If the page was associated with a subpool, there
-	 * would have been a page reserved in the subpool before allocation
-	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
-	 * reservtion, do not call hugepage_subpool_put_pages() as this will
-	 * remove the reserved page from the subpool.
-	 */
-	if (!restore_reserve) {
-		/*
-		 * A return code of zero implies that the subpool will be
-		 * under its minimum size if the reservation is not restored
-		 * after page is free.  Therefore, force restore_reserve
-		 * operation.
-		 */
-		if (hugepage_subpool_put_pages(spool, 1) == 0)
-			restore_reserve = true;
-	}
-
-	spin_lock(&hugetlb_lock);
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
@@ -1446,6 +1431,28 @@ static void __free_huge_page(struct page *page)
 		enqueue_huge_page(h, page);
 	}
 	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * If PagePrivate() was set on page, page allocation consumed a
+	 * reservation.  If the page was associated with a subpool, there
+	 * would have been a page reserved in the subpool before allocation
+	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
+	 * reservtion, do not call hugepage_subpool_put_pages() as this will
+	 * remove the reserved page from the subpool.
+	 */
+	if (!restore_reserve) {
+		/*
+		 * A return code of zero implies that the subpool will be
+		 * under its minimum size if the reservation is not restored
+		 * after page is free.  Therefore, we need to add 1 to the
+		 * global reserve count.
+		 */
+		if (hugepage_subpool_put_pages(spool, 1) == 0) {
+			spin_lock(&hugetlb_lock);
+			h->resv_huge_pages++;
+			spin_unlock(&hugetlb_lock);
+		}
+	}
 }
 
 /*
