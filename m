Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7008C2D272F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgLHJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:09:58 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41130 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728562AbgLHJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:09:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHyyIaT_1607418552;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHyyIaT_1607418552)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 17:09:13 +0800
Subject: Re: [PATCH 10/11] mm: make lruvec_lru_size() static
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-11-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <10396c35-9e42-b3a0-0183-490e10e6ad0c@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 17:09:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-11-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/12/8 上午6:09, Yu Zhao 写道:
> All other references to the function were removed after
> commit b910718a948a ("mm: vmscan: detect file thrashing at the reclaim root")
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/mmzone.h | 2 --
>  mm/vmscan.c            | 3 ++-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b593316bff3d..2fc54e269eaf 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -872,8 +872,6 @@ static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
>  #endif
>  }
>  
> -extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
> -
>  #ifdef CONFIG_HAVE_MEMORYLESS_NODES
>  int local_memory_node(int node_id);
>  #else
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 95e581c9d9af..fd0c2313bee4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -310,7 +310,8 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>   * @lru: lru to use
>   * @zone_idx: zones to consider (use MAX_NR_ZONES for the whole LRU list)
>   */
> -unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
> +static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
> +				     int zone_idx)
>  {
>  	unsigned long size = 0;
>  	int zid;
> 
