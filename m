Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D417F268864
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgINJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:30:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgINJae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:30:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D281AE85;
        Mon, 14 Sep 2020 09:30:48 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:30:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     zangchunxin@bytedance.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
Message-ID: <20200914093032.GG16999@dhcp22.suse.cz>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909152047.27905-1-zangchunxin@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is misleading because this patch doesn't fix an infinite
loop, right? It just allows the userspace to interrupt the operation.

On Wed 09-09-20 23:20:47, zangchunxin@bytedance.com wrote:
> From: Chunxin Zang <zangchunxin@bytedance.com>
> 
> On our server, there are about 10k memcg in one machine. They use memory
> very frequently. When I tigger drop caches，the process will infinite loop
> in drop_slab_node.

Is this really an infinite loop, or it just takes a lot of time to
process all the metadata in that setup? If this is really an infinite
loop then we should look at it. My current understanding is that the
operation would finish at some time it just takes painfully long to get
there.

> There are two reasons:
> 1.We have too many memcgs, even though one object freed in one memcg, the
>   sum of object is bigger than 10.
> 
> 2.We spend a lot of time in traverse memcg once. So, the memcg who
>   traversed at the first have been freed many objects. Traverse memcg next
>   time, the freed count bigger than 10 again.
> 
> We can get the following info through 'ps':
> 
>   root:~# ps -aux | grep drop
>   root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches
>   root 1771385 ... R    Aug16 21146421:17 echo 3 > /proc/sys/vm/drop_caches
>   root 1986319 ... R    18:56 117:27 echo 3 > /proc/sys/vm/drop_caches
>   root 2002148 ... R    Aug24 5720:39 echo 3 > /proc/sys/vm/drop_caches
>   root 2564666 ... R    18:59 113:58 echo 3 > /proc/sys/vm/drop_caches
>   root 2639347 ... R    Sep03 2383:39 echo 3 > /proc/sys/vm/drop_caches
>   root 3904747 ... R    03:35 993:31 echo 3 > /proc/sys/vm/drop_caches
>   root 4016780 ... R    Aug21 7882:18 echo 3 > /proc/sys/vm/drop_caches
> 
> Use bpftrace follow 'freed' value in drop_slab_node:
> 
>   root:~# bpftrace -e 'kprobe:drop_slab_node+70 {@ret=hist(reg("bp")); }'
>   Attaching 1 probe...
>   ^B^C
> 
>   @ret:
>   [64, 128)        1 |                                                    |
>   [128, 256)      28 |                                                    |
>   [256, 512)     107 |@                                                   |
>   [512, 1K)      298 |@@@                                                 |
>   [1K, 2K)       613 |@@@@@@@                                             |
>   [2K, 4K)      4435 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>   [4K, 8K)       442 |@@@@@                                               |
>   [8K, 16K)      299 |@@@                                                 |
>   [16K, 32K)     100 |@                                                   |
>   [32K, 64K)     139 |@                                                   |
>   [64K, 128K)     56 |                                                    |
>   [128K, 256K)    26 |                                                    |
>   [256K, 512K)     2 |                                                    |
> 
> In the while loop, we can check whether the TASK_KILLABLE signal is set,
> if so, we should break the loop.

I would make it explicit that this is not fixing the above scenario. It
just helps to cancel to operation which is a good thing in general.
 
> Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

With updated changelog
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 	changelogs in v2: 
> 	1) Via check TASK_KILLABLE signal break loop.
> 
>  mm/vmscan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b6d84326bdf2..c3ed8b45d264 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -704,6 +704,9 @@ void drop_slab_node(int nid)
>  	do {
>  		struct mem_cgroup *memcg = NULL;
>  
> +		if (fatal_signal_pending(current))
> +			return;
> +
>  		freed = 0;
>  		memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  		do {
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
