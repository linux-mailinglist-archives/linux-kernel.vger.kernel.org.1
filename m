Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A52EB55F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbhAEWaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:30:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35390 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAEWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:30:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105MPmPG022645;
        Tue, 5 Jan 2021 22:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wXVdrBUbSRT99XPEF5wQND4MuLbgCVx8TLN5Nwz7Y7s=;
 b=opeT4ikT4Jz/FnPretW7uujdJlohEpnNNTAZUp6w7gRUn3rIFTFKV4JP6y75bageQAyT
 79LJ3+dIgkPFAnadAJPozYu8v5eO/7x5xk8zbx8geajt3ofSBOlnLKftpKCq9JdnNlZb
 +cTXjzeJjvHTvg7vixMj2jSWf9wNHjVPInbnc162J4h4kwIdQIGhdvciuLBFDwUNrnW+
 uxV2/paXqTVy6nRBusel/oMojQ4ySjgviO/LAcw8dKkAmMrckyjJeC1YgovO1+8qj6Mm
 XxM+zcJElJoxS9CZTtMsMHIcane268YFRFUiiq50QepdPKceqkQdl/FvHUGykwkSSkh8 Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35tgsku1h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 22:29:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105MTGgd168756;
        Tue, 5 Jan 2021 22:29:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35v1f95jnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 22:29:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 105MR9Yq017456;
        Tue, 5 Jan 2021 22:27:09 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 14:27:09 -0800
Subject: Re: [External] Re: [PATCH 2/6] hugetlbfs: fix cannot migrate the
 fallocated HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-2-songmuchun@bytedance.com>
 <09be227a-4e16-1960-c8e9-609c35a80ef5@oracle.com>
 <CAMZfGtXApP2k5AWK5ff5TWh+nkY1bHKbMimj4faFC8u6bUzMCQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <24d35764-46b9-4234-3266-91232ac9103b@oracle.com>
Date:   Tue, 5 Jan 2021 14:27:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXApP2k5AWK5ff5TWh+nkY1bHKbMimj4faFC8u6bUzMCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 6:44 PM, Muchun Song wrote:
> On Tue, Jan 5, 2021 at 6:40 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 1/3/21 10:58 PM, Muchun Song wrote:
>>> Because we only can isolate a active page via isolate_huge_page()
>>> and hugetlbfs_fallocate() forget to mark it as active, we cannot
>>> isolate and migrate those pages.
>>>
>>> Fixes: 70c3547e36f5 (hugetlbfs: add hugetlbfs_fallocate())
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  fs/hugetlbfs/inode.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> Good catch.  This is indeed an issue.
>>
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index b5c109703daa..2aceb085d202 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -737,10 +737,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>>>
>>>               /*
>>>                * unlock_page because locked by add_to_page_cache()
>>> -              * page_put due to reference from alloc_huge_page()
>>> +              * put_page() (which is in the putback_active_hugepage())
>>> +              * due to reference from alloc_huge_page()
>>
>> Thanks for fixing the comment.
>>
>>>                */
>>>               unlock_page(page);
>>> -             put_page(page);
>>> +             putback_active_hugepage(page);
>>
>> I'm curious why you used putback_active_hugepage() here instead of simply
>> calling set_page_huge_active() before the put_page()?
>>
>> When the page was allocated, it was placed on the active list (alloc_huge_page).
>> Therefore, the hugetlb_lock locking and list movement should not be necessary.
> 
> I agree with you. Because set_page_huge_active is not exported (static
> function). Only exporting set_page_huge_active seems strange (leaving
> clear_page_huge_active not export). This is just my opinion. What's
> yours, Mike?

I'm thinking that we should export (make external) set_page_huge_active.
We can leave clear_page_huge_active as static and just add something to
the commit log noting that there are no external users.

My primary reason for doing this is to eliminate the extra and unnecessary
per-page lock/unlock cycle.  I believe there are some applications that
use fallocate to pre-allocate very large hugetlbfs files.  They may notice
the extra overhead.
-- 
Mike Kravetz
