Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9701DB08F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgETKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 06:49:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:49:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C096AD4D;
        Wed, 20 May 2020 10:49:49 +0000 (UTC)
Subject: Re: [PATCH v3 01/19] mm: memcg: factor out memcg- and lruvec-level
 changes out of __mod_lruvec_state()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-2-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7a94d35e-c148-2471-6c6a-b213f220ed9b@suse.cz>
Date:   Wed, 20 May 2020 12:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-2-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> To convert memcg and lruvec slab counters to bytes there must be
> a way to change these counters without touching node counters.
> Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -713,30 +713,14 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
>  	return mem_cgroup_nodeinfo(parent, nid);
>  }
>  
> -/**
> - * __mod_lruvec_state - update lruvec memory statistics
> - * @lruvec: the lruvec
> - * @idx: the stat item
> - * @val: delta to add to the counter, can be negative
> - *
> - * The lruvec is the intersection of the NUMA node and a cgroup. This
> - * function updates the all three counters that are affected by a
> - * change of state at this level: per-node, per-cgroup, per-lruvec.
> - */
> -void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			int val)
> +void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> +			      int val)
>  {
>  	pg_data_t *pgdat = lruvec_pgdat(lruvec);

Looks like the pgdat can now be moved into the MEMCG_CHARGE_BATCH if().

