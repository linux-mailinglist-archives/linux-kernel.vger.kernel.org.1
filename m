Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1889D2C8196
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgK3KBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:01:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:60462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgK3KBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:01:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606730454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9QLAqcKegNHZ4enxhyxhkwws9hmf//rDueloPUrspE=;
        b=Qn7UPyCgUNImi1+ilkAUxok8xel0jXaNJWqPi7lVT1fidlp00do2xwiZ3xUt75SXL71fnH
        VJtyoGDZvZ8PlDU3nCk8pvfZjhZ/uXUe8NHLFTsZ/gBIabJ2VNr9j5+VCdSI4C/skirh9l
        wsfC/ewhUMXTtl8mj4Owsdvss+Yi/YM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3DD4ABD2;
        Mon, 30 Nov 2020 10:00:54 +0000 (UTC)
Date:   Mon, 30 Nov 2020 11:00:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Subject: Re: [PATCH 2/3] mm,thp,shm: limit gfp mask to no more than specified
Message-ID: <20201130100053.GD17338@dhcp22.suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
 <20201124194925.623931-3-riel@surriel.com>
 <20201126134034.GI31550@dhcp22.suse.cz>
 <920c627330f3c7d295ab58edd1b62f28fdbd14bc.camel@surriel.com>
 <20201127075214.GK31550@dhcp22.suse.cz>
 <1f089a155d7501fb156da34744d282ae1f3d02f7.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f089a155d7501fb156da34744d282ae1f3d02f7.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-11-20 14:03:39, Rik van Riel wrote:
> On Fri, 2020-11-27 at 08:52 +0100, Michal Hocko wrote:
> > On Thu 26-11-20 13:04:14, Rik van Riel wrote:
> > > 
> > > I would be more than happy to implement things differently,
> > > but I am not sure what alternative you are suggesting.
> > 
> > Simply do not alter gfp flags? Or warn in some cases of a serious
> > mismatch.
> > E.g. GFP_ZONEMASK mismatch because there are already GFP_KERNEL users
> > of
> > shmem.
> 
> Not altering the gfp flags is not really an option,
> because that would leads to attempting to allocate THPs
> with GFP_HIGHUSER, which is what is used to allocate
> regular tmpfs pages.

Right but that is a completely different reason to alter the mask and it
would be really great to know whether this is a theoretical concern or
those users simply do not ever use THPs. Btw. should they be using THPs
even if they opt themselves into GFP_KERNEL restriction?
 
> If the THP configuration in sysfs says we should
> not
> be doing compaction/reclaim from THP allocations, we
> should obey that configuration setting, and use a 
> gfp_flags that results in no compaction/reclaim being done.

Yes, I agree with that. The thing I disagree with is that you try to mix
how hard to try also from the shmem users which are not really THP aware
and they merely want to control how hard to try to order-0 pages. Or
more precisely whether to invoke OOM killer before doing their fallback.

So your patch adds a very subtle behavior that would be really hard to
maintain long term because the way how hart to compact is completely
detached from users who use the gfp mask.
-- 
Michal Hocko
SUSE Labs
