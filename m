Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27D02F8640
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbhAOUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:06:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36386 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAOUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:06:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FK3pqs040051;
        Fri, 15 Jan 2021 20:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4+iqo9mstJm/PHD1CMGgzYJg604QoA69wE32Q+faFOA=;
 b=cEIampobplEClwEe2j4+iY6VFITXyI7EUYlL9Uoy/SrOGveHyN0oV+kxV7RhtMvA9ifB
 X8i/vugzZANc3MlygzvT3KYZgNF7hZmMWru93mGytMqw6Fa+nsNQRCyN2pRCt6zsJKtM
 KWC3XMsLITilgceKfmIukO69h26HbAc2NZxwmhzy0uSFMKjCFIq6mvDLBkBMmLRTghDv
 17QDz6ebf71VV1qJmPePgK8N2KTsnSTW4zlZdUjAu3PorOFrHIZZWwml/nFAWNPMhHMm
 8MBXekXPwmm16J2CNqbKnhza7HNrsip8/grAllHgYqHHOy+3DzcdyndYouxDR1voGmGA Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 360kg26maa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 20:05:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FK52aH169710;
        Fri, 15 Jan 2021 20:05:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 360keqce31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 20:05:34 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10FK5VJV004883;
        Fri, 15 Jan 2021 20:05:31 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jan 2021 12:05:30 -0800
Subject: Re: [RFC PATCH 2/3] hugetlb: convert page_huge_active() to
 HPageMigratable flag
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-3-mike.kravetz@oracle.com>
 <20210115091755.GB4092@linux>
 <d98039ef-8489-6d8c-a323-44e3f0d8acee@oracle.com>
Message-ID: <41ca9f90-63e3-f991-3f78-433f77250527@oracle.com>
Date:   Fri, 15 Jan 2021 12:05:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d98039ef-8489-6d8c-a323-44e3f0d8acee@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 9:43 AM, Mike Kravetz wrote:
> On 1/15/21 1:17 AM, Oscar Salvador wrote:
>> On Mon, Jan 11, 2021 at 01:01:51PM -0800, Mike Kravetz wrote:
>>> Use the new hugetlb page specific flag to replace the page_huge_active
>>> interfaces.  By it's name, page_huge_active implied that a huge page
>>> was on the active list.  However, that is not really what code checking
>>> the flag wanted to know.  It really wanted to determine if the huge
>>> page could be migrated.  This happens when the page is actually added
>>> the page cache and/or task page table.  This is the reasoning behind the
>>> name change.
>>>
>>> The VM_BUG_ON_PAGE() calls in the interfaces were not really necessary
>>> as in all case but one we KNOW the page is a hugetlb page.  Therefore,
>>> they are removed.  In one call to HPageMigratable() is it possible for
>>> the page to not be a hugetlb page due to a race.  However, the code
>>> making the call (scan_movable_pages) is inherently racy, and page state
>>> will be validated later in the migration process.
>>>
>>> Note:  Since HPageMigratable is used outside hugetlb.c, it can not be
>>> static.  Therefore, a new set of hugetlb page flag macros is added for
>>> non-static flag functions.
>>
>> Two things about this one:
>>
>> I am not sure about the name of this one.
>> It is true that page_huge_active() was only called by memory-hotplug and all
>> it wanted to know was whether the page was in-use and so if it made sense
>> to migrate it, so I see some value in the new PageMigratable flag.
>>
>> However, not all in-use hugetlb can be migrated, e.g: we might have constraints
>> when it comes to migrate certain sizes of hugetlb, right?
>> So setting HPageMigratable to all active hugetlb pages might be a bit misleading?
>> HPageActive maybe? (Sorry, don't have a replacement)
> 
> You concerns about the name change are correct.
> 
> The reason for the change came about from discussions about Muchun's series
> of fixes and the need for a new 'page is freed' status to fix a race.  In
> that discussion, Michal asked 'Why can't we simply set page_huge_active when
> the page is allocated and put on the active list?'.  That is mentioned above,
> but we really do not want to try and migrate pages after they are allocated
> and before they are in use.  That causes problems in the fault handling code.
> 
> Anyway, that is how the suggestion for Migration came about.
> 
> In that discussion David Hildenbrand noted that code in alloc_contig_range
> should migrate free hugetlb pages, but there is no support for that today.
> I plan to look at that if nobody else does.  When such code is added, the
> name 'Migratable' will become less applicable.
> 
> I'm not great at naming.  Perhaps 'In_Use' as a flag name might fit better.
> 

I went back and took a closer look.  Migration is the reason the existing
page_huge_active interfaces were introduced.  And, the only use of the
page_huge_active check is to determine if a page can be migrated.  So,
I think 'Migratable' may be the most suitable name.

To address the concern about not all hugetlb sizes are migratable, we can
just make a check before setting the flag.  This should even help in the
migration/offline paths as we will know sooner if the page can be
migrated or not.

We can address naming in the 'migrating free hugetlb pages' issue when
that code is written.
-- 
Mike Kravetz
