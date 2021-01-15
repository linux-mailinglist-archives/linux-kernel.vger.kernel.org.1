Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898D82F82D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbhAORr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:47:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34418 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbhAORr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:47:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FHjC9Z016587;
        Fri, 15 Jan 2021 17:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SIXDqzr6jK0GrkDqRzVkNtY2qFgcoJUNx4ERzzoji/s=;
 b=JPZ5gulHdW45siXj/bDD+TZcFd77JOrZOx05Uey3wL6IcZb6mw/FJYnJoe9PZz859EGZ
 A9yNcRqUeufU1QZPPgdKJWI7QT/ujIBzKwI4ae4LKbjUK7WGHeTVWo0VKRzPeAjkiH/W
 FJJ0LKTwi7VCFrDGvJngZmkO1rxtWGxDLNIuYiW2svJ6gRIBlB7+8HalzYDtFwBgSxXB
 zy/IhnLKUQ0328zQcSRSo5ul2HKg9EQ/cu35veYY5w66xUfYqqbmLcld3Yp3XfBgIWYE
 0BwQ3SgHvuKa7OqOaMCydm0NeZ/rsc6fjaD/hofI6WWQOgraiDDwx2Xxe1Heqtu0R5ZV IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kd061h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 17:47:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FHk6hT157876;
        Fri, 15 Jan 2021 17:47:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360kebdu4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 17:47:07 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10FHl5t1009700;
        Fri, 15 Jan 2021 17:47:05 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jan 2021 09:47:05 -0800
Subject: Re: [RFC PATCH 3/3] hugetlb: convert PageHugeTemporary() to
 HPageTempSurplus
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-4-mike.kravetz@oracle.com>
 <20210115101629.GA5213@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6735bbc5-4eae-b541-d47d-23f7f98b00cf@oracle.com>
Date:   Fri, 15 Jan 2021 09:47:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210115101629.GA5213@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=897 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=906 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 2:16 AM, Oscar Salvador wrote:
> On Mon, Jan 11, 2021 at 01:01:52PM -0800, Mike Kravetz wrote:
>> Use new hugetlb specific flag HPageTempSurplus to replace the
>> PageHugeTemporary() interfaces.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 38 +++++++++-----------------------------
>>  1 file changed, 9 insertions(+), 29 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 34ce82f4823c..949e1f987319 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -58,6 +58,7 @@ static unsigned long hugetlb_cma_size __initdata;
>>  enum htlb_page_flags {
>>  	HPAGE_RestoreReserve = 0,
>>  	HPAGE_Migratable,
>> +	HPAGE_TempSurplus,
>>  };
>>  
>>  /*
>> @@ -99,6 +100,7 @@ void ClearHPage##flname(struct page *page)	\
>>  
>>  HPAGEFLAG(RestoreReserve)
>>  EXT_HPAGEFLAG(Migratable)
>> +HPAGEFLAG(TempSurplus)
> 
> Would HPAGE_Temporary/Temporary not be a better fit?

Yes it would.

> The point about current PageHugeTemporary is that these pages are temporary as
> they do not belong to the pool and will vanish once the last reference gets drop.
> We do not really care that much about the surplus part?
> 
> Besides, alloc_migrate_huge_page seems to not want to thread these pages as surplus.
> 

All correct, not sure why I was thinking 'surplus' when naming the flag.

> Also, I would add a comment either next to each flag or above
> the enum htlb_page_flags (probably the latter) with a brief explanation
> of each flag.

Will do.

-- 
Mike Kravetz

> Besides that, it looks fine to me.
> Here I do not see the same problem in
> stripping the PageHuge check in PageHugeTemporary, as I did in previous patch,
> because all callers of it make sure they operate on a hugetlb page.
> 
