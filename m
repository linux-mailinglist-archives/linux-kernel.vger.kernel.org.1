Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7252943EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409480AbgJTUde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731214AbgJTUde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:33:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A927ACDB;
        Tue, 20 Oct 2020 20:33:33 +0000 (UTC)
Date:   Tue, 20 Oct 2020 21:33:31 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: don't wake kswapd prematurely when watermark
 boosting is disabled
Message-ID: <20201020203331.GB32041@suse.de>
References: <20201020175833.397286-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201020175833.397286-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 01:58:33PM -0400, Johannes Weiner wrote:
> On 2-node NUMA hosts we see bursts of kswapd reclaim and subsequent
> pressure spikes and stalls from cache refaults while there is plenty
> of free memory in the system.
> 
> Usually, kswapd is woken up when all eligible nodes in an allocation
> are full. But the code related to watermark boosting can wake kswapd
> on one full node while the other one is mostly empty. This may be
> justified to fight fragmentation, but is currently unconditionally
> done whether watermark boosting is occurring or not.
> 
> In our case, many of our workloads' throughput scales with available
> memory, and pure utilization is a more tangible concern than trends
> around longer-term fragmentation. As a result we generally disable
> watermark boosting.
> 
> Wake kswapd only woken when watermark boosting is requested.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

This makes sense to the extent that I would support adding

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")

With or without that;

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
