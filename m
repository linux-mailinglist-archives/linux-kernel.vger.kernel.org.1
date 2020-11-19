Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718452B8F26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKSJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:38:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:56450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgKSJio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:38:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605778723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mqkr7WtOsPXe7Agi04uzzO7bVBcbEN8bGbm8NL0o4BY=;
        b=MGimUoL/EXI0gCRJnn+SvO9mgBJqu5D6uQq41Cl8ixTts8MToGxOHS3Pa73LD0F27ujEx1
        hiJFO3CzmZWCY7hAqA6h/Zx9m33/L9N5Xo1VnWmeDv7B1g66fts27rtk5p/CldraM0SFGz
        TMq4Z653Vzndpcc5/CJAVtKsj09Rv+c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AA0AAA4F;
        Thu, 19 Nov 2020 09:38:43 +0000 (UTC)
Date:   Thu, 19 Nov 2020 10:38:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/2] mm,thp,shm: limit gfp mask to no more than specified
Message-ID: <20201119093842.GC12284@dhcp22.suse.cz>
References: <20201105191508.1961686-1-riel@surriel.com>
 <20201105191508.1961686-3-riel@surriel.com>
 <20201112112242.GA12240@dhcp22.suse.cz>
 <05f80e300fd4907b99837b5973db8985b7312d3f.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f80e300fd4907b99837b5973db8985b7312d3f.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-11-20 22:40:40, Rik van Riel wrote:
> On Thu, 2020-11-12 at 12:22 +0100, Michal Hocko wrote:
> > [Cc Chris for i915 and Andray]
> > 
> > On Thu 05-11-20 14:15:08, Rik van Riel wrote:
> > > Matthew Wilcox pointed out that the i915 driver opportunistically
> > > allocates tmpfs memory, but will happily reclaim some of its
> > > pool if no memory is available.
> > 
> > It would be good to explicitly mention the requested gfp flags for
> > those
> > allocations. i915 uses __GFP_NORETRY | __GFP_NOWARN, or GFP_KERNEL.
> > Is
> > __shmem_rw really meant to not allocate from highmeme/movable zones?
> > Can
> > it be ever backed by THPs?
> 
> You are right, I need to copy the zone flags __GFP_DMA
> through
> __GFP_MOVABLE straight from the limiting gfp_mask
> into the gfp_mask used for THP allocations, and not use
> the default THP zone flags if the caller specifies something
> else.
> 
> I'll send out a new version that fixes that.

Can we make one step back here and actually check whether all this is
actually needed for those shmem users before adding more hacks here and
there?
-- 
Michal Hocko
SUSE Labs
