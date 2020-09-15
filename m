Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608C726A6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIOOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:04:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgIONyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:54:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82716ACF6;
        Tue, 15 Sep 2020 13:38:07 +0000 (UTC)
Date:   Tue, 15 Sep 2020 15:37:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     zangchunxin@bytedance.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] mm/vmscan: add a fatal signals check in drop_slab_node
Message-ID: <20200915133751.GC3736@dhcp22.suse.cz>
References: <20200915132741.84869-1-zangchunxin@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915132741.84869-1-zangchunxin@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-09-20 21:27:41, zangchunxin@bytedance.com wrote:
> From: Chunxin Zang <zangchunxin@bytedance.com>
> 
> On our server, there are about 10k memcg in one machine. They use memory
> very frequently. We have observed that drop_caches can take a
> considerable amount of time, and can't stop it.
> 
> There are two reasons:
> 1. There is somebody constantly generating more objects to reclaim
>    on drop_caches, result the 'freed' always bigger than 10.
> 2. The process has no chance to process signals.
> 
> We can get the following info through 'ps':
> 
>   root:~# ps -aux | grep drop
>   root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches
>   root 1771385 ... R    Aug16 21146421:17 echo 3 > /proc/sys/vm/drop_caches
> 
> Add a bail out on the fatal signals in the main loop so that the
> operation can be terminated by userspace.
> 
> Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> 	changelogs in v4:
> 	changelogs in v3: 
> 	1) Fix some descriptive problems pointed out by Michal Hocko.
> 		v2 named: mm/vmscan: fix infinite loop in drop_slab_node
> 
> 	changelogs in v2: 
> 	1) via check fatal signal break loop.
> 
>  mm/vmscan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b6d84326bdf2..6b2b5d420510 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -704,6 +704,9 @@ void drop_slab_node(int nid)
>  	do {
>  		struct mem_cgroup *memcg = NULL;
>  
> +		if (signal_pending(current))
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
