Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1924C207599
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404006AbgFXOV6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Jun 2020 10:21:58 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:59147 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388115AbgFXOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:21:57 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21603718-1500050 
        for multiple; Wed, 24 Jun 2020 15:21:54 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200624141604.GH6578@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk> <20200624121053.GD6578@ziepe.ca> <159300126338.4527.3968787379471939056@build.alporthouse.com> <20200624123910.GA3178169@ziepe.ca> <159300796224.4527.2014771396582759689@build.alporthouse.com> <20200624141604.GH6578@ziepe.ca>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with MAYFAIL
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <159300850942.4527.8335506003268197914@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Wed, 24 Jun 2020 15:21:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2020-06-24 15:16:04)
> On Wed, Jun 24, 2020 at 03:12:42PM +0100, Chris Wilson wrote:
> > Quoting Jason Gunthorpe (2020-06-24 13:39:10)
> > > On Wed, Jun 24, 2020 at 01:21:03PM +0100, Chris Wilson wrote:
> > > > Quoting Jason Gunthorpe (2020-06-24 13:10:53)
> > > > > On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> > > > > > When direct reclaim enters the shrinker and tries to reclaim pages, it
> > > > > > has to opportunitically unmap them [try_to_unmap_one]. For direct
> > > > > > reclaim, the calling context is unknown and may include attempts to
> > > > > > unmap one page of a dma object while attempting to allocate more pages
> > > > > > for that object. Pass the information along that we are inside an
> > > > > > opportunistic unmap that can allow that page to remain referenced and
> > > > > > mapped, and let the callback opt in to avoiding a recursive wait.
> > > > > 
> > > > > i915 should already not be holding locks shared with the notifiers
> > > > > across allocations that can trigger reclaim. This is already required
> > > > > to use notifiers correctly anyhow - why do we need something in the
> > > > > notifiers?
> > > > 
> > > > for (n = 0; n < num_pages; n++)
> > > >       pin_user_page()
> > > > 
> > > > may call try_to_unmap_page from the lru shrinker for [0, n-1].
> > > 
> > > Yes, of course you can't hold any locks that intersect with notifiers
> > > across pin_user_page()/get_user_page()
> > 
> > What lock though? It's just the page refcount, shrinker asks us to drop
> > it [via mmu], we reply we would like to keep using that page as freeing
> > it for the current allocation is "robbing Peter to pay Paul".
> 
> Maybe I'm unclear what this series is actually trying to fix? 
> 
> You said "avoiding a recursive wait" which sounds like some locking
> deadlock to me.

It's the shrinker being called while we are allocating for/on behalf of
the object. As we are actively using the object, we don't want to free
it -- the partial object allocation being the clearest, if the object
consists of 2 pages, trying to free page 0 in order to allocate page 1
has to fail (and the shrinker should find another candidate to reclaim,
or fail the allocation).
-Chris
