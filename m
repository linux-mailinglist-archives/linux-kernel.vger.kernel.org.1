Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B2329563D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894875AbgJVBy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:54:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2411804AbgJVBy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:54:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D637F6DA850343BA93E;
        Thu, 22 Oct 2020 09:54:56 +0800 (CST)
Received: from [127.0.0.1] (10.143.60.252) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 22 Oct 2020
 09:54:54 +0800
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
References: <20201016225254.3853109-1-guro@fb.com>
From:   "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Message-ID: <a94644b5-5867-0518-34e9-30fa6c510f81@hisilicon.com>
Date:   Thu, 22 Oct 2020 09:54:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20201016225254.3853109-1-guro@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.143.60.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/17 6:52, Roman Gushchin wrote:

> This small patchset makes cma_release() non-blocking and simplifies
> the code in hugetlbfs, where previously we had to temporarily drop
> hugetlb_lock around the cma_release() call.
>
> It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
> THP under a memory pressure requires a cma_release() call. If it's
> a blocking function, it complicates the already complicated code.
> Because there are at least two use cases like this (hugetlbfs is
> another example), I believe it's just better to make cma_release()
> non-blocking.
>
> It also makes it more consistent with other memory releasing functions
> in the kernel: most of them are non-blocking.
>
>
> Roman Gushchin (2):
>    mm: cma: make cma_release() non-blocking
>    mm: hugetlb: don't drop hugetlb_lock around cma_release() call
>
>   mm/cma.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
>   mm/hugetlb.c |  6 ------
>   2 files changed, 49 insertions(+), 8 deletions(-)
>
I don't think this patch is a good idea.It transfers part or even all of the time of
cma_release to cma_alloc, which is more concerned by performance indicators.
On Android phones, CPU resource competition is intense in many scenarios,
As a result, kernel threads and workers can be scheduled only after some ticks or more.
In this case, the performance of cma_alloc will deteriorate significantly,
which is not good news for many services on Android.


