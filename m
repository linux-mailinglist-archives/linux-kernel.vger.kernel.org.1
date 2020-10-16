Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031EC2905A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408002AbgJPNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:02:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:56490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407883AbgJPNCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:02:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602853329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGU+TiofL4Z7acFZTrz/FX0B5HKwXBlKH6gf2iGwsNU=;
        b=aPkBWMe/Mj0XautSxavMJ72BaVq/i6YfnnmycBdFQgPbeb5UoWZSsXjBJC7wuSazIkxpVz
        tHgtPiwkq+rtUgvRxXdAXXc1Jr6tdUlTM/aAuGRL4XPI1y1WIckpMsVhgIb0n1rLkVEUZa
        olrZr95ofMtI2Mq2RCWfGkZAjsnZiRk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCAB8B11D;
        Fri, 16 Oct 2020 13:02:08 +0000 (UTC)
Date:   Fri, 16 Oct 2020 15:02:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: avoid a unnecessary reschedule in
 shrink_slab()
Message-ID: <20201016130208.GI22589@dhcp22.suse.cz>
References: <20201016033952.1924-1-tian.xianting@h3c.com>
 <20201016120749.GG22589@dhcp22.suse.cz>
 <9a2b772b13f84bdd9517b17d8d72aa89@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2b772b13f84bdd9517b17d8d72aa89@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-10-20 12:48:23, Tianxianting wrote:
> Thanks, my understanding is,
> In shrink_slab(), do_shrink_slab() will do the real reclaim work, which will occupy current cpu and consume more cpu time, so we need to trigger a reschedule after reclaim.
> But if it jumps to 'out' label, that means we don't do the reclaim work at this time, it won't cause other thread getting starvation, so we don't need to call cond_resched() in this case.
> Is it right?

You are almost right. But consider situation when the lock is taken for
quite some time. do_shrink_slab cannot make any forward progress and
effectivelly busy loop. Unless the caller does cond_resched it might
cause soft lockups.

Anyway let me try to ask again. Why does would this be any problem that
deserves a fix?

> 
> -----Original Message-----
> From: Michal Hocko [mailto:mhocko@suse.com] 
> Sent: Friday, October 16, 2020 8:08 PM
> To: tianxianting (RD) <tian.xianting@h3c.com>
> Cc: akpm@linux-foundation.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mm: vmscan: avoid a unnecessary reschedule in shrink_slab()
> 
> On Fri 16-10-20 11:39:52, Xianting Tian wrote:
> > In shrink_slab(), it directly goes to 'out' label only when it can't 
> > get the lock of shrinker_rwsew. In this case, it doesn't do the real 
> > work of shrinking slab, so we don't need trigger a reschedule by 
> > cond_resched().
> 
> Your changelog doesn't explain why this is not needed or undesirable. Do you see any actual problem?
> 
> The point of this code is to provide a deterministic scheduling point regardless of the shrinker_rwsew.
> 
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> > ---
> >  mm/vmscan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c index 466fc3144..676e97b28 
> > 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -687,8 +687,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >  	}
> >  
> >  	up_read(&shrinker_rwsem);
> > -out:
> > +
> >  	cond_resched();
> > +out:
> >  	return freed;
> >  }
> >  
> > --
> > 2.17.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
