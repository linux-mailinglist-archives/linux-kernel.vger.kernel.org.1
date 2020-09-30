Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E227F402
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgI3VPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:15:44 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1842 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3VPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:15:44 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f74f54c0001>; Wed, 30 Sep 2020 14:14:52 -0700
Received: from [10.2.53.117] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 21:15:40 +0000
Subject: Re: [PATCH 1/4] mm/gup_benchmark: Take the mmap lock around GUP
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <01417038-5456-2b93-2b63-d9ab5b93c95e@nvidia.com>
Date:   Wed, 30 Sep 2020 14:15:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601500492; bh=scoFmBRIh1vSjEY1A1wOQHt4NWbI6VNuVnBra8F4UHk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=CpgUG3WTW+cMM5KeanyfbpzjvkXw6NsgUjMmJsiuerxfFV00F6ldgesWm9qFE+X5j
         HX8hiEJmcHKZcnR3Jhy3YVVvYUUwQQ5s1FN+yr5Nh3hi30Ul0kBSyURlwn/mjCgWuC
         tIy1cDaplKaWv6dEQNoEtFDIK/1ujs5Ya7s8dt0RIy1GUDs9eozviRbiFK1uPUmHP3
         AumGgkSbDueR1etNXlVhydl63Rx9ltDUeWXrERAzZgYerJCrpGFEu1JQP186S/RtAB
         fJVHLEbOWyNfIM1aS2FWdccM9SGF3F9owvnLxYPBN2ne2GF57U/TauAwTEn/qnuGDY
         E63n0QBlO8JWQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 6:19 PM, Jann Horn wrote:
> To be safe against concurrent changes to the VMA tree, we must take the
> mmap lock around GUP operations (excluding the GUP-fast family of
> operations, which will take the mmap lock by themselves if necessary).
> 
> This code is only for testing, and it's only reachable by root through
> debugfs, so this doesn't really have any impact; however, if we want to add
> lockdep asserts into the GUP path, we need to have clean locking here.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This series should go on top of the coredump locking series (in
> particular "mm/gup: Take mmap_lock in get_dump_page()"), which is
> already in the mm tree.


Looks good. This also merges properly and still has the right semantics,
even after my gup_benchmark overhaul [1]. (Just have to change
mm/gup_benchmark.c to mm/gup_test.c).

The new needs_mmap_lock rule here still does the right thing, in other
words, after adding the new DUMP_USER_PAGES_TEST (a non-fast variant).

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

[1] https://lore.kernel.org/r/20200929212747.251804-1-jhubbard@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA


> 
>   mm/gup_benchmark.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index be690fa66a46..558595610650 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -71,6 +71,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>   	int nr;
>   	struct page **pages;
>   	int ret = 0;
> +	bool needs_mmap_lock =
> +		cmd != GUP_FAST_BENCHMARK && cmd != PIN_FAST_BENCHMARK;
> 
>   	if (gup->size > ULONG_MAX)
>   		return -EINVAL;
> @@ -80,6 +82,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>   	if (!pages)
>   		return -ENOMEM;
> 
> +	if (needs_mmap_lock && mmap_read_lock_killable(current->mm)) {
> +		ret = -EINTR;
> +		goto free_pages;
> +	}
> +
>   	i = 0;
>   	nr = gup->nr_pages_per_call;
>   	start_time = ktime_get();
> @@ -119,9 +126,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>   					    NULL);
>   			break;
>   		default:
> -			kvfree(pages);
>   			ret = -EINVAL;
> -			goto out;
> +			goto unlock;
>   		}
> 
>   		if (nr <= 0)
> @@ -149,8 +155,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>   	end_time = ktime_get();
>   	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
> 
> +unlock:
> +	if (needs_mmap_lock)
> +		mmap_read_unlock(current->mm);
> +free_pages:
>   	kvfree(pages);
> -out:
>   	return ret;
>   }
> 
> 
> base-commit: fb0155a09b0224a7147cb07a4ce6034c8d29667f
> prerequisite-patch-id: 08f97130a51898a5f6efddeeb5b42638577398c7
> prerequisite-patch-id: 577664d761cd23fe9031ffdb1d3c9ac313572c67
> prerequisite-patch-id: dc29a39716aa8689f80ba2767803d9df3709beaa
> prerequisite-patch-id: 42b1b546d33391ead2753621f541bcc408af1769
> prerequisite-patch-id: 2cbb839f57006f32e21f4229e099ae1bd782be24
> prerequisite-patch-id: 1b4daf01cf61654a5ec54b5c3f7c7508be7244ee
> prerequisite-patch-id: f46cc8c99f1909fe2a65fbc3cf1f6bc57489a086
> 

