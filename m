Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A82A2526
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKBH0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgKBH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:26:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B106C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y0f6ILCwtq4G+l9+dzGcdDEE6zW8nF1rcA+SQ7hGP2Q=; b=YQsDUxSNrCxLMQfAwGNAx8h0Lz
        20Q6eFBq0hAyPnbv3ZshQgTuK1gvnKRVX/9BKvWhHOA4xxqCQOsH6TwtgnHv2qCIaJ4s56naO746z
        j15kmyIT2hVeA+t8BKYDVu36OqN5btYOJBh0Nz6S0+1MZt12GgAoOdwTLJmiGEZyKSQQOucpXxNXL
        2lvZx8QC7PxWI3ID9DJXVzhKPmMKUcrboFoB67/ieTfz05Y+JrXNW6SXpCLQgKm9CGp18YwneIvWI
        chHRncwkGJ0vynewQaS1y1ZjnnoH9f22fTMymFov4OzDvjl8PzQLpbsNJwDBU8Udz2hd7WLJRd5Ox
        njkGa95A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZUE2-0004Ct-O8; Mon, 02 Nov 2020 07:25:58 +0000
Date:   Mon, 2 Nov 2020 07:25:58 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
Message-ID: <20201102072558.GA12588@infradead.org>
References: <20201031093823.GA453843@infradead.org>
 <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 12:50:44PM -0700, Linus Torvalds wrote:
> So this is just a stylistic nit, and has no impact on this pull (which
> I've done). But looking at the patch, it triggers one of my "this is
> wrong" patterns.

Adding the author and maintainer of that code so that they can sort it
out.

> 
> In particular, this:
> 
>         u64 dma_start = 0;
>         ...
>         for (dma_start = ~0ULL; r->size; r++) {
> 
> is actually completely bogus in theory, and it's a horribly horribly
> bad pattern to have.
> 
> The thing that I hate about that parttern is "~0ULL", which is simply wrong.
> 
> The correct pattern for "all bits set" is ~0. NOTHING ELSE. No extra
> letters at the end.
> 
> Why? Because using an unsigned type is wrong, and will not extend the
> bits up to a potentially bigger size.
> 
> So adding that "ULL" is not just three extra characters to type, it
> actually _detracts_ from the code and makes it more fragile and
> potentially wrong.
> 
> It so happens, that yes, in the kernel, "ull" us 64-bit, and you get
> the right results. So the code _works_. But it's wrong, and it now
> requires that the types match exactly (ie it would not be broken if
> somebody ever were to say "I want to use use 128-bit dma addresses and
> u128").
> 
> Another example is using "~0ul", which would give different results on
> a 32-bit kernel and a 64-bit kernel. Again: DON'T DO THAT.
> 
> I repeat: the right thing to do for "all bits set" is just a plain ~0
> or -1. Either of those are fine (technically assumes a 2's complement
> machine, but let's just be honest: that's a perfectly fine assumption,
> and -1 might be preferred by some because it makes that sign extension
> behavior of the integer constant more obvious).
> 
> Don't try to do anything clever or anything else, because it's going
> to be strictly worse.
> 
> The old code that that patch removed was "technically correct", but
> just pointless, and actually shows the problem:
> 
>         for (dma_start = ~(dma_addr_t)0; r->size; r++) {
> 
> the above is indeed a correct way to say "I want all bits set in a
> dma_addr_t", but while correct, it is - once again - strictly inferior
> to just using "~0".
> 
> Why? Because "~0" works regardless of type. IOW, exactly *because*
> people used the wrong pattern for "all bits set", that patch was now
> (a) bigger than necessary and (b) much more ilkely to cause bugs (ie I
> could have imagined people changing just the type of the variable
> without changing the initialization).
> 
> So in that tiny three-line patch there were actually several examples
> of why "~0" is the right pattern to use for "all bits set". Because it
> JustWorks(tm) in ways other patterns do not.
> 
> And if you have a compiler that complains about assigning -1 or ~0 to
> an unsigned variable, get rid of that piece of garbage. You're almost
> certainly either using some warning flag that you shouldn't be using,
> or the compiler writer didn't know what they were doing.
> 
>             Linus
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
