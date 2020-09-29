Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7527DC57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgI2WxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgI2WxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:53:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0S87uXkKSB7NmTMilPEy9DruRaasJPoFlfr0oUOWW2o=; b=QDrVr+ulZytJZEWhmEsh3fsECK
        pMppEFaHGkHc5E5WGoKjTNnKEbi5cC6zgA5bdLXE9MD4yvCTzW/sUyO0PyzE5Bd0LLG5Sa7u+eVc8
        uU7jE/LQ7VRgje0N9tq9mXxXDaBJseyOZQFkix4H/xp5jWEat5b+jhwgLOk5d0DIVN4po/Y8dOjFh
        ZLrEmfxpDa2yUyRPw16ieUhvIcQZT/iqUAe6ahNSFIh6/4/OBcbuHYH6iS/Yyec340m+LgEdKgTc1
        VN0sPMQUIAXKfyawdLV22ZBWO5pcKB6QzBanDv/TXtFCjFqAftVDYM73nq9tJhFrE5hoD1ii+7Aw3
        f9rQaHmA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNOUd-0004Y3-VX; Tue, 29 Sep 2020 22:53:08 +0000
Date:   Tue, 29 Sep 2020 23:53:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-ID: <20200929225307.GL20115@casper.infradead.org>
References: <20200926213919.26642-1-willy@infradead.org>
 <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
 <20200929011719.GD30994@casper.infradead.org>
 <20200928214656.be4a0f29961589c074e518fa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928214656.be4a0f29961589c074e518fa@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 09:46:56PM -0700, Andrew Morton wrote:
> On Tue, 29 Sep 2020 02:17:19 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Mon, Sep 28, 2020 at 06:03:07PM -0700, Andrew Morton wrote:
> > > On Sat, 26 Sep 2020 22:39:19 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > > 
> > > > Here is a very rare race which leaks memory:
> > > 
> > > Not worth a cc:stable?
> > 
> > Yes, it probably should have been.
> 
> Have you a feeling for how often this occurs?

I doubt it happens often.  I don't think I could construct a workload to
make it happen frequently.  Maybe more often with a virtualised workload
where a thread can be preempted between instructions.

> >  I just assume the stablebot will
> > pick up anything that has a Fixes: tag.
> 
> We asked them not to do that for mm/ patches.  Crazy stuff was getting
> backported.

That's a shame.  I'll try to remember to cc them explicitly in the future.

> > Although I'm now thinking of making that comment into kernel-doc and
> > turning it into advice to the caller rather than an internal note to
> > other mm developers.
> 
> hm.  But what action could the caller take?  The explanatory comment
> seems OK to me.

Use compound pages instead of non-compound pages.  Although Linus has
asked that people stop using __get_free_pages(), so maybe that will be
the direction we go in.

https://lore.kernel.org/lkml/CA+55aFwyxJ+TOpaJZnC5MPJ-25xbLAEu8iJP8zTYhmA3LXFF8Q@mail.gmail.com/
