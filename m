Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9C281519
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbgJBO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:29:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:60722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBO3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:29:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601648974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ua3bCtpMycbDHDFeiy2dAsffKQu0yXXZ3KIokA2B8q4=;
        b=u0hhZ0PVogRAawGcVk2o7nQVX9xwDDm6JKBLkju3hRVK5Oe8UiB4ntqHBW4g5oAlVAUEw/
        ZmHZ2tjVJumo2W6hMZTVFOMOLcRuS139dmitcl6y5WWDX+dWYFu/sn7FObiAs9hCflftVb
        i/2SaDn8/1KRVgAuLStNulNTsDmsK4U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22063ABBD;
        Fri,  2 Oct 2020 14:29:34 +0000 (UTC)
Date:   Fri, 2 Oct 2020 16:29:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Sebastiaan Meijer <meijersebastiaan@gmail.com>,
        akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, willy@infradead.org
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
Message-ID: <20201002142933.GL4555@dhcp22.suse.cz>
References: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
 <20201001123032.GC22560@dhcp22.suse.cz>
 <CANuy=CK-s=tEb57Kw+N8O2OGx1MXyUB=o-RDH-S=kYerb65dOw@mail.gmail.com>
 <20201002070333.GA21871@dhcp22.suse.cz>
 <656725362af9bd757a281f0799a0bb9c9b2487bd.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656725362af9bd757a281f0799a0bb9c9b2487bd.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-10-20 09:53:05, Rik van Riel wrote:
> On Fri, 2020-10-02 at 09:03 +0200, Michal Hocko wrote:
> > On Thu 01-10-20 18:18:10, Sebastiaan Meijer wrote:
> > > (Apologies for messing up the mailing list thread, Gmail had fooled
> > > me into
> > > believing that it properly picked up the thread)
> > > 
> > > On Thu, 1 Oct 2020 at 14:30, Michal Hocko <mhocko@suse.com> wrote:
> > > > On Wed 30-09-20 21:27:12, Sebastiaan Meijer wrote:
> > > > > > yes it shows the bottleneck but it is quite artificial. Read
> > > > > > data is
> > > > > > usually processed and/or written back and that changes the
> > > > > > picture a
> > > > > > lot.
> > > > > Apologies for reviving an ancient thread (and apologies in
> > > > > advance for my lack
> > > > > of knowledge on how mailing lists work), but I'd like to offer
> > > > > up another
> > > > > reason why merging this might be a good idea.
> > > > > 
> > > > > From what I understand, zswap runs its compression on the same
> > > > > kswapd thread,
> > > > > limiting it to a single thread for compression. Given enough
> > > > > processing power,
> > > > > zswap can get great throughput using heavier compression
> > > > > algorithms like zstd,
> > > > > but this is currently greatly limited by the lack of threading.
> > > > 
> > > > Isn't this a problem of the zswap implementation rather than
> > > > general
> > > > kswapd reclaim? Why zswap doesn't do the same as normal swap out
> > > > in a
> > > > context outside of the reclaim?
> 
> On systems with lots of very fast IO devices, we have
> also seen kswapd take 100% CPU time without any zswap
> in use.

Do you have more details? Does the saturated kswapd lead to pre-mature
direct reclaim? What is the saturated number of reclaimed pages per unit
of time? Have you tried to play with this to see whether an additional
worker would help?

-- 
Michal Hocko
SUSE Labs
