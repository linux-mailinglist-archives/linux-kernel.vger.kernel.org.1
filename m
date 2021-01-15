Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239D62F82C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbhAORoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:44:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59562 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbhAORoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:44:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FHe2m3190194;
        Fri, 15 Jan 2021 17:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ml/fErxJ4JuHhBzsQjxTSI597dwX+lHlDTScxN9HNMQ=;
 b=yll1db4fZQ/x09N8mKtXDKLqkU4hSGBXqDBhBSS5+K8uqVaVQz5NOGx+GU+/EUtu1JGV
 c62jijtDzNkBFsNHCva3TDYjJr8bum3GW6iQfjJ42wfD6YXppRDT7Y/1uSQaJgH9Byau
 p9aW704tVBqnN71LpZK9QaK2VoAqyz+cvbAWRiCs26fXNBUOO2flNv/Qcb79Nur8gW96
 S2qLaLXPfHEix2ucGL+lqxq4+vHH6rGoxPANHAqs0/1YdrA92s0zJXj/mO09cHYn33my
 7dYZj8BVFiQjKR8vtQo2iNsFJ83z1PQRyDgRn/cEFiI4/aW8TEoD9Wl6JtksZspihQIf kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 360kd06104-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 17:43:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FHfEfc155294;
        Fri, 15 Jan 2021 17:43:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360keq62ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 17:43:42 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10FHhcC7014078;
        Fri, 15 Jan 2021 17:43:38 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jan 2021 09:43:38 -0800
Subject: Re: [RFC PATCH 2/3] hugetlb: convert page_huge_active() to
 HPageMigratable flag
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d98039ef-8489-6d8c-a323-44e3f0d8acee@oracle.com>
Date:   Fri, 15 Jan 2021 09:43:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210115091755.GB4092@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 1:17 AM, Oscar Salvador wrote:
> On Mon, Jan 11, 2021 at 01:01:51PM -0800, Mike Kravetz wrote:
>> Use the new hugetlb page specific flag to replace the page_huge_active
>> interfaces.  By it's name, page_huge_active implied that a huge page
>> was on the active list.  However, that is not really what code checking
>> the flag wanted to know.  It really wanted to determine if the huge
>> page could be migrated.  This happens when the page is actually added
>> the page cache and/or task page table.  This is the reasoning behind the
>> name change.
>>
>> The VM_BUG_ON_PAGE() calls in the interfaces were not really necessary
>> as in all case but one we KNOW the page is a hugetlb page.  Therefore,
>> they are removed.  In one call to HPageMigratable() is it possible for
>> the page to not be a hugetlb page due to a race.  However, the code
>> making the call (scan_movable_pages) is inherently racy, and page state
>> will be validated later in the migration process.
>>
>> Note:  Since HPageMigratable is used outside hugetlb.c, it can not be
>> static.  Therefore, a new set of hugetlb page flag macros is added for
>> non-static flag functions.
> 
> Two things about this one:
> 
> I am not sure about the name of this one.
> It is true that page_huge_active() was only called by memory-hotplug and all
> it wanted to know was whether the page was in-use and so if it made sense
> to migrate it, so I see some value in the new PageMigratable flag.
> 
> However, not all in-use hugetlb can be migrated, e.g: we might have constraints
> when it comes to migrate certain sizes of hugetlb, right?
> So setting HPageMigratable to all active hugetlb pages might be a bit misleading?
> HPageActive maybe? (Sorry, don't have a replacement)

You concerns about the name change are correct.

The reason for the change came about from discussions about Muchun's series
of fixes and the need for a new 'page is freed' status to fix a race.  In
that discussion, Michal asked 'Why can't we simply set page_huge_active when
the page is allocated and put on the active list?'.  That is mentioned above,
but we really do not want to try and migrate pages after they are allocated
and before they are in use.  That causes problems in the fault handling code.

Anyway, that is how the suggestion for Migration came about.

In that discussion David Hildenbrand noted that code in alloc_contig_range
should migrate free hugetlb pages, but there is no support for that today.
I plan to look at that if nobody else does.  When such code is added, the
name 'Migratable' will become less applicable.

I'm not great at naming.  Perhaps 'In_Use' as a flag name might fit better.

> The other thing is that you are right that scan_movable_pages is racy, but
> page_huge_active() was checking if the page had the Head flag set before
> retrieving page[1].
> 
> Before the page_huge_active() in scan_movable_pages() we have the
> if (!PageHuge(page)) check, but could it be that between that check and
> the page_huge_active(), the page gets dissolved, and so we are checking
> a wrong page[1]? Am I making sense? 

Yes, you are making sense.

The reason I decided to drop the check is because it does not eliminate the
race.  Even with that check in page_huge_active, the page could be dissolved
between that check and check of page[1].  There really is no way to eliminate
the race without holding a reference to the page (or hugetlb_lock).  That
check in page_huge_active just shortens the race window.

-- 
Mike Kravetz
