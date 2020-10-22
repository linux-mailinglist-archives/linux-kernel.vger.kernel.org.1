Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01642956F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895516AbgJVDr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:47:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2443108AbgJVDr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:47:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B21E86542CC63C75B47;
        Thu, 22 Oct 2020 11:47:52 +0800 (CST)
Received: from [127.0.0.1] (10.143.60.252) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 22 Oct 2020
 11:47:46 +0800
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
To:     Roman Gushchin <guro@fb.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
References: <20201016225254.3853109-1-guro@fb.com>
 <a94644b5-5867-0518-34e9-30fa6c510f81@hisilicon.com>
 <20201022024526.GD300658@carbon.dhcp.thefacebook.com>
From:   "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Message-ID: <c4f951c3-acef-a666-0e80-2aa820432ccc@hisilicon.com>
Date:   Thu, 22 Oct 2020 11:47:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20201022024526.GD300658@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.143.60.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/22 10:45, Roman Gushchin wrote:

> On Thu, Oct 22, 2020 at 09:54:53AM +0800, Xiaqing (A) wrote:
>>
>> On 2020/10/17 6:52, Roman Gushchin wrote:
>>
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
>>>
>>>
>>> Roman Gushchin (2):
>>>     mm: cma: make cma_release() non-blocking
>>>     mm: hugetlb: don't drop hugetlb_lock around cma_release() call
>>>
>>>    mm/cma.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
>>>    mm/hugetlb.c |  6 ------
>>>    2 files changed, 49 insertions(+), 8 deletions(-)
>>>
>> I don't think this patch is a good idea.It transfers part or even all of the time of
>> cma_release to cma_alloc, which is more concerned by performance indicators.
> I'm not quite sure: if cma_alloc() is racing with cma_release(), cma_alloc() will
> wait for the cma_lock mutex anyway. So we don't really transfer anything to cma_alloc().
>
>> On Android phones, CPU resource competition is intense in many scenarios,
>> As a result, kernel threads and workers can be scheduled only after some ticks or more.
>> In this case, the performance of cma_alloc will deteriorate significantly,
>> which is not good news for many services on Android.
> Ok, I agree, if the cpu is heavily loaded, it might affect the total execution time.
>
> If we aren't going into the mutex->spinlock conversion direction (as Mike suggested),
> we can address the performance concerns by introducing a cma_release_nowait() function,
> so that the default cma_release() would work in the old way.
> cma_release_nowait() can set an atomic flag on a cma area, which will cause following
> cma_alloc()'s to flush the release queue. In this case there will be no performance
> penalty unless somebody is using cma_release_nowait().
> Will it work for you?

That looks good to me.

Thanks!

>
> Thank you!
>
>


