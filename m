Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E832EC587
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAFVJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:09:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53376 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbhAFVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:09:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106L4miC100728;
        Wed, 6 Jan 2021 21:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=W6W0gJfOIiS/xI8E4K2OEUfCxl6zQ9m2UdSjovBPjRc=;
 b=hChs4iZNT6WJlzEukQaa10Jor2WBU+1DGrqP/MK15J5eTgiJlkspQhPH+iq31emYCQlq
 7Ct+UgCdbAl52xXQ8EiXZCWlJ1tmITUZkiNfsOXOPj+pkP7k5IjtT36M8tXGoLWxalDJ
 H9nfxM984yiFIZ3kl3RqTgjtaPFv5U/E1CiB5BRXSjCiDsAJ0d9hEyepyHssvftLj8l9
 Uz3wJxYNLjhlvq12O71J0RK3TX2qMjdt3T8M3j86hZLdIWNm6gqzETJt5SBRyuw0IS/0
 6Gusq9Odpmc2rPwCsN1dSd+ymlwGd795oWluC1an8HoungdSY47OFrUZtpq296gH5sAf LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 35wcuxt8ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 21:07:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106L5Pjt023332;
        Wed, 6 Jan 2021 21:07:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35w3g1k52p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 21:07:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 106L7fJg011347;
        Wed, 6 Jan 2021 21:07:41 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 13:07:41 -0800
Subject: Re: [PATCH v2 2/6] mm: hugetlbfs: fix cannot migrate the fallocated
 HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-3-songmuchun@bytedance.com>
 <20210106163513.GS13207@dhcp22.suse.cz>
 <7e69a55c-d501-6b42-8225-a677f09fb829@oracle.com>
 <20210106200242.GY13207@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b9dcdeb8-6994-55f9-1780-794e17589129@oracle.com>
Date:   Wed, 6 Jan 2021 13:07:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210106200242.GY13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 12:02 PM, Michal Hocko wrote:
> On Wed 06-01-21 11:30:25, Mike Kravetz wrote:
>> On 1/6/21 8:35 AM, Michal Hocko wrote:
>>> On Wed 06-01-21 16:47:35, Muchun Song wrote:
>>>> Because we only can isolate a active page via isolate_huge_page()
>>>> and hugetlbfs_fallocate() forget to mark it as active, we cannot
>>>> isolate and migrate those pages.
>>>
>>> I've little bit hard time to understand this initially and had to dive
>>> into the code to make sense of it. I would consider the following
>>> wording easier to grasp. Feel free to reuse if you like.
>>> "
>>> If a new hugetlb page is allocated during fallocate it will not be
>>> marked as active (set_page_huge_active) which will result in a later
>>> isolate_huge_page failure when the page migration code would like to
>>> move that page. Such a failure would be unexpected and wrong.
>>> "
>>>
>>> Now to the fix. I believe that this patch shows that the
>>> set_page_huge_active is just too subtle. Is there any reason why we
>>> cannot make all freshly allocated huge pages active by default?
>>
>> I looked into that yesterday.  The primary issue is in page fault code,
>> hugetlb_no_page is an example.  If page_huge_active is set, then it can
>> be isolated for migration.  So, migration could race with the page fault
>> and the page could be migrated before being added to the page table of
>> the faulting task.  This was an issue when hugetlb_no_page set_page_huge_active
>> right after allocating and clearing the huge page.  Commit cb6acd01e2e4
>> moved the set_page_huge_active after adding the page to the page table
>> to address this issue.
> 
> Thanks for the clarification. I was not aware of this subtlety. The
> existing comment is not helping much TBH. I am still digesting the
> suggested race. The page is new and exclusive and not visible via page
> tables yet, so the only source of the migration would be pfn based
> (hotplug, poisoning), right?

That is correct.


> Btw. s@set_page_huge_active@set_page_huge_migrateable@ would help
> readability IMHO. With a comment explaining that this _has_ to be called
> after the page is fully initialized.

Agree, I will add that as a future enhancement.

-- 
Mike Kravetz
