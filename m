Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F722A5093
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgKCT6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:58:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:54010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCT6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:58:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604433517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aW87E3yQfhjrReNvzduUoTGgZLBJOmiPHqndjMWgtW8=;
        b=akMqqMjRyUqjMp5cDlSancCsC/CWysNkT/3kl3pSSDXpUFZq+NxJvkBDSIrUn3gxrSB7SA
        Kg3iiCblqGQ8XqKsmutUxLwFLgrxymQnymg3+EUyXg5MzK03XXWEsZmq/w/RUQcWEFxtHX
        d2w8CcqF13yTWSaAzYIQRG8alkV64d4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 110B7AF84;
        Tue,  3 Nov 2020 19:58:37 +0000 (UTC)
Date:   Tue, 3 Nov 2020 20:58:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Increasing CMA Utilization with a GFP Flag
Message-ID: <20201103195836.GL21990@dhcp22.suse.cz>
References: <cover.1604282969.git.cgoldswo@codeaurora.org>
 <20201102144449.GM27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102144449.GM27442@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-11-20 14:44:49, Matthew Wilcox wrote:
> On Mon, Nov 02, 2020 at 06:39:20AM -0800, Chris Goldsworthy wrote:
> > The current approach to increasing CMA utilization introduced in
> > commit 16867664936e ("mm,page_alloc,cma: conditionally prefer cma
> > pageblocks for movable allocations") increases CMA utilization by
> > redirecting MIGRATE_MOVABLE allocations to a CMA region, when
> > greater than half of the free pages in a given zone are CMA pages.
> > The issue in this approach is that allocations with type
> > MIGRATE_MOVABLE can still succumb to pinning. To get around
> > this, one approach is to re-direct allocations to the CMA areas, that
> > are known not to be victims of pinning.
> > 
> > To this end, this series brings in __GFP_CMA, which we mark with
> > allocations that we know are safe to be redirected to a CMA area.
> 
> This feels backwards to me.  What you're essentially saying is "Some
> allocations marked with GFP_MOVABLE turn out not to be movable, so we're
> going to add another GFP_REALLY_MOVABLE flag" instead of tracking down
> which GFP_MOVABLE allocations aren't really movable.

Absolutely agreed. What is even worse the proposed approach doesn't
really add any new guarantee. Just look at how the new flag is used for
any anonymous page and that is a subject to a long term pinning as well.
So in the end a new and confusing gfp flag is proposed that doesn't
really help with the underlying problem.

Nacked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
