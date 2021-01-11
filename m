Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F892F14D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbhAKNa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732941AbhAKNay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:30:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81C82221FF;
        Mon, 11 Jan 2021 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610371813;
        bh=9u2HWgUS7+SBF2cXUUEJwwSvQMwtFkX8ve6mtxwTAK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i33J0sYvklsC5LMvdOiZUD222Ye0+QMPyCyLIs77djWJf8gtM9OjQJD7ZUVdeco7C
         oLud5b0oRQ3ocbVbqoWB0rrbZhNnejHE0an6HIOIpJaMlBybFr2Wtq94iCJqXaEjJ5
         G5INIwpk5ke9G6Ww2eGWRmXHfhd5rkfD0odRytJRMcM82dPrMxSmcx0kc/0bcLPqsX
         XO2YRb4YZDg87YDFkl8lFlVP1DnbLMggGPL0gY9Bc4bj5ncNkDPQ25Q4v0bTHL5GWg
         Ue7LcULTBfONfDe4SFGPKNax/ecxXFN7zbtaZ4Tg6LStZiDjWagL3ONBsc1VCthFFC
         wZRs9Kj8n2aqQ==
Date:   Mon, 11 Jan 2021 13:30:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
Message-ID: <20210111133007.GA7642@willie-the-truck>
References: <20210108171517.5290-1-will@kernel.org>
 <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:34:08AM -0800, Linus Torvalds wrote:
> On Fri, Jan 8, 2021 at 9:15 AM Will Deacon <will@kernel.org> wrote:
> >
> > The big difference in this version is that I have reworked it based on
> > Kirill's patch which he posted as a follow-up to the original. However,
> > I can't tell where we've landed on that -- Linus seemed to like it, but
> > Hugh was less enthusiastic.
> 
> Yeah, I like it, but I have to admit that it had a disturbingly high
> number of small details wrong for several versions. I hope you picked
> up the final version of the code.

I picked the version from here:

  https://lore.kernel.org/r/20201229132819.najtavneutnf7ajp@box

and actually, I just noticed that willy spotted a typo in a comment, so
I'll fix that locally as well as adding the above to a 'Link:' tag for
reference.

> At the same time, I do think that the "disturbingly high number of
> issues" was primarily exactly _because_ the old code was so
> incomprehensible, and I think the end result is much cleaner, so I
> still like it.
> 
> >I think that my subsequent patches are an
> > awful lot cleaner after the rework
> 
> Yeah, I think that's a side effect of "now the code really makes a lot
> more sense". Your subsequent patches 2-3 certainly are much simpler
> now, although I'd be inclined to add an argument to "do_set_pte()"
> that has the "write" and "pretault" bits in it, instead of having to
> modify the 'vmf' structure.

I played with a few different ways of doing this, but I can't say I prefer
them over what I ended up posting. Having a bunch of 'bool' arguments makes
the callers hard to read and brings into question what exactly vmf->flags is
for. I also tried adding a separate 'address' parameter so that vmf->address
is always the real faulting address, but 'address' is the thing to use for
the pte (i.e. prefault is when 'address != vmf->address'). That wasn't too
bad, but it made the normal finish_fault() case look weird.

So I think I'll leave it as-is and see if anybody wants to change it later
on.

Will
