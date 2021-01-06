Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD52EB9F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAFGUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:20:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:20:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1066F2j0187062;
        Wed, 6 Jan 2021 06:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BAx3FQhaT78LXzE5w5rZT4IIMZGFtdRI29ieC9bJQxI=;
 b=Q2JjUQzU+VmuLXiB1IM3f+fQPwb8ip1HWk1Xz9nDuyaVN9rIQdF4suj2Qhif7F6bjYrE
 XQh4arhBTAhWziz1Xo69k7mkunjdLR/FJY2sxzuekNF5trfR79pzNmDs1ynxwe5sgRKu
 wpqohtR5Gd4efqGEk6RWxIifNdkSu3ZiJQsZbZ4qMA5WXC3bHmYjoGNXQ6suCvayo4C4
 os1A/Dky1k+y9xe8f7LlFf1ugCVOl1nLt4iagkdIy5HhQSSK9bMyWC7DG4zZCHYR+r8E
 4ra8CJv10kLUTw90yfV1Qzs9O3bBtbbDxxE+3CrPnfjR/SJ7x/nMDqddhfZtgyrwBDc2 Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35w53b0e9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 06:19:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1066AnrU138369;
        Wed, 6 Jan 2021 06:19:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35v1f9j0mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 06:19:40 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1066JcAo002556;
        Wed, 6 Jan 2021 06:19:38 GMT
Received: from [172.20.10.12] (/1.129.209.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 22:19:37 -0800
Subject: Re: [PATCH] mm: memcg/slab: optimize objcg stock draining
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20210106042239.2860107-1-guro@fb.com>
From:   Imran Khan <imran.f.khan@oracle.com>
Message-ID: <92c34535-57de-39aa-7984-48faaa02c9e9@oracle.com>
Date:   Wed, 6 Jan 2021 17:19:33 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106042239.2860107-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/21 3:22 pm, Roman Gushchin wrote:
> Imran Khan reported a regression in hackbench results caused by the
> commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages"). The regression is noticeable in the case of
> a consequent allocation of several relatively large slab objects,
> e.g. skb's. As soon as the amount of stocked bytes exceeds PAGE_SIZE,
> drain_obj_stock() and __memcg_kmem_uncharge() are called, and it leads
> to a number of atomic operations in page_counter_uncharge().
> 
> The corresponding call graph is below (provided by Imran Khan):
>    |__alloc_skb
>    |    |
>    |    |__kmalloc_reserve.isra.61
>    |    |    |
>    |    |    |__kmalloc_node_track_caller
>    |    |    |    |
>    |    |    |    |slab_pre_alloc_hook.constprop.88
>    |    |    |     obj_cgroup_charge
>    |    |    |    |    |
>    |    |    |    |    |__memcg_kmem_charge
>    |    |    |    |    |    |
>    |    |    |    |    |    |page_counter_try_charge
>    |    |    |    |    |
>    |    |    |    |    |refill_obj_stock
>    |    |    |    |    |    |
>    |    |    |    |    |    |drain_obj_stock.isra.68
>    |    |    |    |    |    |    |
>    |    |    |    |    |    |    |__memcg_kmem_uncharge
>    |    |    |    |    |    |    |    |
>    |    |    |    |    |    |    |    |page_counter_uncharge
>    |    |    |    |    |    |    |    |    |
>    |    |    |    |    |    |    |    |    |page_counter_cancel
>    |    |    |    |
>    |    |    |    |
>    |    |    |    |__slab_alloc
>    |    |    |    |    |
>    |    |    |    |    |___slab_alloc
>    |    |    |    |    |
>    |    |    |    |slab_post_alloc_hook
> 
> Instead of directly uncharging the accounted kernel memory, it's
> possible to refill the generic page-sized per-cpu stock instead.
> It's a much faster operation, especially on a default hierarchy.
> As a bonus, __memcg_kmem_uncharge_page() will also get faster,
> so the freeing of page-sized kernel allocations (e.g. large kmallocs)
> will become faster.
> 
> A similar change has been done earlier for the socket memory by
> the commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for
> socket memory uncharging").
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Imran Khan <imran.f.khan@oracle.com>

Tested-by: Imran Khan <imran.f.khan@oracle.com>

> ---
>   mm/memcontrol.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0d74b80fa4de..8148c1df3aff 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3122,9 +3122,7 @@ void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
>   	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>   		page_counter_uncharge(&memcg->kmem, nr_pages);
>   
> -	page_counter_uncharge(&memcg->memory, nr_pages);
> -	if (do_memsw_account())
> -		page_counter_uncharge(&memcg->memsw, nr_pages);
> +	refill_stock(memcg, nr_pages);
>   }
>   
>   /**
> 
