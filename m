Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF31E4054
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgE0LnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:43:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgE0LnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:43:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45F3BB21C;
        Wed, 27 May 2020 11:43:20 +0000 (UTC)
Subject: Re: [PATCH v4 03/19] mm: memcg: convert vmstat slab counters to bytes
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-4-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a0a6c013-3a08-86f5-46a4-808a8c63a50a@suse.cz>
Date:   Wed, 27 May 2020 13:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526214227.989341-4-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 11:42 PM, Roman Gushchin wrote:
> In order to prepare for per-object slab memory accounting, convert
> NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat items to bytes.
> 
> To make it obvious, rename them to NR_SLAB_RECLAIMABLE_B and
> NR_SLAB_UNRECLAIMABLE_B (similar to NR_KERNEL_STACK_KB).
> 
> Internally global and per-node counters are stored in pages,
> however memcg and lruvec counters are stored in bytes.
> This scheme may look weird, but only for now. As soon as slab
> pages will be shared between multiple cgroups, global and
> node counters will reflect the total number of slab pages.
> However memcg and lruvec counters will be used for per-memcg
> slab memory tracking, which will take separate kernel objects
> in the account. Keeping global and node counters in pages helps
> to avoid additional overhead.
> 
> The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
> so it will fit into atomic_long_t we use for vmstats.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

You didn't add Acked-by: Johannes Weiner <hannes@cmpxchg.org>
( see 20200507204137.GC161043@cmpxchg.org )
(Noticed thanks to the great 'b4 am' and 'git range-diff' tools)

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

