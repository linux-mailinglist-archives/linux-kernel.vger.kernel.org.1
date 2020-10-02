Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A867C280DD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgJBHDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:03:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:40138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBHDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:03:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601622214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4u/qRf9+kmqLyGtcPDIuQ13T83PRssmDQWjttbaB8g=;
        b=CtrW5dsO9U4JusMQ9BY4WwzEJiEyix+lp6gWqHhhJctMaDT6LSuhVp4HmtV0b16QTqP9GW
        Oz7jfYbV8zH/FZIjI9ufUe9OHvQmJYIMR7csydO3ZwwLXitYJTf/U3iMEqDrTslQjhmtJz
        df9/UaOsoF0qOKqhVQdDIIw5aS2rB4U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD644B1D0;
        Fri,  2 Oct 2020 07:03:34 +0000 (UTC)
Date:   Fri, 2 Oct 2020 09:03:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastiaan Meijer <meijersebastiaan@gmail.com>
Cc:     akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, riel@surriel.com,
        willy@infradead.org
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
Message-ID: <20201002070333.GA21871@dhcp22.suse.cz>
References: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
 <20201001123032.GC22560@dhcp22.suse.cz>
 <CANuy=CK-s=tEb57Kw+N8O2OGx1MXyUB=o-RDH-S=kYerb65dOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANuy=CK-s=tEb57Kw+N8O2OGx1MXyUB=o-RDH-S=kYerb65dOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-10-20 18:18:10, Sebastiaan Meijer wrote:
> (Apologies for messing up the mailing list thread, Gmail had fooled me into
> believing that it properly picked up the thread)
> 
> On Thu, 1 Oct 2020 at 14:30, Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 30-09-20 21:27:12, Sebastiaan Meijer wrote:
> > > > yes it shows the bottleneck but it is quite artificial. Read data is
> > > > usually processed and/or written back and that changes the picture a
> > > > lot.
> > > Apologies for reviving an ancient thread (and apologies in advance for my lack
> > > of knowledge on how mailing lists work), but I'd like to offer up another
> > > reason why merging this might be a good idea.
> > >
> > > From what I understand, zswap runs its compression on the same kswapd thread,
> > > limiting it to a single thread for compression. Given enough processing power,
> > > zswap can get great throughput using heavier compression algorithms like zstd,
> > > but this is currently greatly limited by the lack of threading.
> >
> > Isn't this a problem of the zswap implementation rather than general
> > kswapd reclaim? Why zswap doesn't do the same as normal swap out in a
> > context outside of the reclaim?
> 
> I wouldn't be able to tell you, the documentation on zswap is fairly limited
> from what I've found.

I would recommend you to talk to zswap maintainers. Describing your
problem and suggesting to offload the heavy lifting into a separate
context like the standard swap IO does. You are not the only one to hit
this problem
http://lkml.kernel.org/r/CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com.
Ccing Shakeel on such an email might help you to give more usecases.

> > My recollection of the particular patch is dimm but I do remember it
> > tried to add more kswapd threads which would just paper over the problem
> > you are seein rather than solve it.
> 
> Yeah, that's exactly what it does, just adding more kswap threads.

Which is far from trivial because it has its side effects on the over
system balanc. See my reply to the original request and the follow up
discussion. I am not saying this is impossible to achieve and tune
properly but it is certainly non trivial and it would require a really
strong justification.
-- 
Michal Hocko
SUSE Labs
