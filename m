Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DDE2962F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897883AbgJVQoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:44:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45062 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897838AbgJVQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:44:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MGcjnu029838;
        Thu, 22 Oct 2020 16:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SPrO3yw9zpLsPknkEorGhq6tnr887sHRezfoKQoW/ko=;
 b=VfIA65xEKFglL95tIES9YoJW5ygBhit6mYdS/rQmgwgMeaC1XwLpn0FWDK48h6xY1Vv0
 /l1yz2kKOqGwULwDhszJcrSwKOr0FlXPbGP8k47vVIXlC+eFr8eAAGkMJ5nJtz5Lpsd2
 FpxMTeLwj1dARfi7jGPNHG41xq4fOWykV8ILCzVuF4r/W83SIEs7nbpPFsNzaooTedRv
 oJP8Hrx2bMPIvjK+f/+amHIdEquSnhxBtxLnVK30Z09EFoHlvQXHKgT+a/0fHS4o+ZQf
 TDxYhs+q+yyTv/GmUNufYlXN3yyC2MgodLgN49ob636gLVdEwEOSv04HDiwudoxlkE8V vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 349jrpy59p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 16:44:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MGdjZY067368;
        Thu, 22 Oct 2020 16:42:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 348ah11kch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 16:42:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09MGgDru003199;
        Thu, 22 Oct 2020 16:42:13 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 09:42:13 -0700
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
References: <20201016225254.3853109-1-guro@fb.com>
 <3f455d27-6d99-972f-b77f-b5b473b7614d@oracle.com>
 <20201022023352.GC300658@carbon.dhcp.thefacebook.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <91779b4c-378d-66ee-2df0-edb270dd4d04@oracle.com>
Date:   Thu, 22 Oct 2020 09:42:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201022023352.GC300658@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/20 7:33 PM, Roman Gushchin wrote:
> On Wed, Oct 21, 2020 at 05:15:53PM -0700, Mike Kravetz wrote:
>> On 10/16/20 3:52 PM, Roman Gushchin wrote:
>>> This small patchset makes cma_release() non-blocking and simplifies
>>> the code in hugetlbfs, where previously we had to temporarily drop
>>> hugetlb_lock around the cma_release() call.
>>>
>>> It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
>>> THP under a memory pressure requires a cma_release() call. If it's
>>> a blocking function, it complicates the already complicated code.
>>> Because there are at least two use cases like this (hugetlbfs is
>>> another example), I believe it's just better to make cma_release()
>>> non-blocking.
>>>
>>> It also makes it more consistent with other memory releasing functions
>>> in the kernel: most of them are non-blocking.
>>
>> Thanks for looking into this Roman.
> 
> Hi Mike,
> 
>>
>> I may be missing something, but why does cma_release have to be blocking
>> today?  Certainly, it takes the bitmap in cma_clear_bitmap and could
>> block.  However, I do not see why cma->lock has to be a mutex.  I may be
>> missing something, but I do not see any code protected by the mutex doing
>> anything that could sleep?
>>
>> Could we simply change that mutex to a spinlock?
> 
> I actually have suggested it few months ago, but the idea was
> opposed by Joonsoo: https://lkml.org/lkml/2020/4/3/12 .
> 
> The time of a bitmap operation is definitely not an issue in my context,
> but I can't speak for something like an embedded/rt case.
> 

I wonder if it may be time to look into replacing the cma area bitmap
with some other data structure?  Joonsoo was concerned about the time
required to traverse the bitmap for an 8GB area.  With new support for
allocating 1GB hugetlb pages from cma, I can imagine someone setting
up a cma area that is hundreds of GB if not TB in size.  It is going
take some time to traverse a bitmap describing such a huge area.

-- 
Mike Kravetz
