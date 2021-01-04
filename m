Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B053B2E9179
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbhADIL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:11:57 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51424 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbhADIL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:11:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UKeYYmw_1609747872;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UKeYYmw_1609747872)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 04 Jan 2021 16:11:13 +0800
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hui Su <sh_def@163.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <2c1083cb-53d6-1cd6-9e1b-14a501db6f9a@linux.alibaba.com>
Date:   Mon, 4 Jan 2021 16:11:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

ÔÚ 2021/1/4 ÏÂÎç1:03, Hugh Dickins Ð´µÀ:
> Boot a CONFIG_MEMCG=y kernel with "cgroup_disabled=memory" and you are
> met by a series of warnings from the VM_WARN_ON_ONCE_PAGE(!memcg, page)
> recently added to the inline mem_cgroup_page_lruvec().
> 
> An earlier attempt to place that warning, in mem_cgroup_lruvec(), had
> been careful to do so after weeding out the mem_cgroup_disabled() case;
> but was itself invalid because of the mem_cgroup_lruvec(NULL, pgdat) in
> clear_pgdat_congested() and age_active_anon().
> 
> Warning in mem_cgroup_page_lruvec() was once useful in detecting a KSM
> charge bug, so may be worth keeping: but skip if mem_cgroup_disabled().
> 
> Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  include/linux/memcontrol.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 5.11-rc2/include/linux/memcontrol.h	2020-12-27 20:39:36.751923135 -0800
> +++ linux/include/linux/memcontrol.h	2021-01-03 19:38:24.822978559 -0800
> @@ -665,7 +665,7 @@ static inline struct lruvec *mem_cgroup_
>  {
>  	struct mem_cgroup *memcg = page_memcg(page);
>  
> -	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> +	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
>  	return mem_cgroup_lruvec(memcg, pgdat);
>  }
>  
> 
