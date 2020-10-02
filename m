Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0719280F17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbgJBIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJBIkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:40:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B40CAE79;
        Fri,  2 Oct 2020 08:40:44 +0000 (UTC)
Date:   Fri, 2 Oct 2020 09:40:42 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Sebastiaan Meijer <meijersebastiaan@gmail.com>,
        akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, riel@surriel.com, willy@infradead.org
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
Message-ID: <20201002084042.GB3165@suse.de>
References: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
 <20201001123032.GC22560@dhcp22.suse.cz>
 <CANuy=CK-s=tEb57Kw+N8O2OGx1MXyUB=o-RDH-S=kYerb65dOw@mail.gmail.com>
 <20201002070333.GA21871@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201002070333.GA21871@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:03:33AM +0200, Michal Hocko wrote:
> > > My recollection of the particular patch is dimm but I do remember it
> > > tried to add more kswapd threads which would just paper over the problem
> > > you are seein rather than solve it.
> > 
> > Yeah, that's exactly what it does, just adding more kswap threads.
> 
> Which is far from trivial because it has its side effects on the over
> system balanc.

While I have not read the original patches, multiple kswapd threads will
smash into the LRU lock repeatedly. It's already the case that just plain
storms of page cache allocations hammer that lock on pagevec releases and
gets worse as memory sizes increase. Increasing LRU lock contention when
memory is low is going to have diminishing returns.

-- 
Mel Gorman
SUSE Labs
