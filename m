Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650512F3DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbhALVrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732102AbhALVrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:47:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3356023122;
        Tue, 12 Jan 2021 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610487981;
        bh=UQDaWvLBuUDRI2C+9laV/b1uo1RHw1RpRmTBFWgJcNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7ORlgNjfyzMEo5za2dbespNyEU4nMoCr33iibDSeVjm3ic4JiE6MkH9aJieisDFE
         oOBxGZYlvG9fmYrPGZ/6s63dmMqW8eQHWJ+RTVQlfC33HQgpcnpyPPyP5jXiNfeSDn
         qA4c0Qy1Np5sta1iJOg71HxvP5A3VoCCyvkSHlKEVaHU7oZkMbdj8RHSzavHU20sCu
         Ir3aT2YN4QvGWD69jJ8elyQaoHzfkpiHI9X35xU5ujS/aEhFcfbLyugVcezBzwajjJ
         ksHwjrNjRXXHyuY9uRFm8UY5R4bCodT99R0rdfwzU9X6mfImssgWV6Ey7ShvVQaAOQ
         3UZJcRW7T+8RA==
Date:   Tue, 12 Jan 2021 21:46:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
Message-ID: <20210112214615.GB10434@willie-the-truck>
References: <20210108171517.5290-1-will@kernel.org>
 <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
 <20210111133007.GA7642@willie-the-truck>
 <alpine.LSU.2.11.2101111254390.2227@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101111254390.2227@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:03:29PM -0800, Hugh Dickins wrote:
> On Mon, 11 Jan 2021, Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 11:34:08AM -0800, Linus Torvalds wrote:
> > > On Fri, Jan 8, 2021 at 9:15 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > The big difference in this version is that I have reworked it based on
> > > > Kirill's patch which he posted as a follow-up to the original. However,
> > > > I can't tell where we've landed on that -- Linus seemed to like it, but
> > > > Hugh was less enthusiastic.
> > > 
> > > Yeah, I like it, but I have to admit that it had a disturbingly high
> > > number of small details wrong for several versions. I hope you picked
> > > up the final version of the code.
> > 
> > I picked the version from here:
> > 
> >   https://lore.kernel.org/r/20201229132819.najtavneutnf7ajp@box
> > 
> > and actually, I just noticed that willy spotted a typo in a comment, so
> > I'll fix that locally as well as adding the above to a 'Link:' tag for
> > reference.
> > 
> > > At the same time, I do think that the "disturbingly high number of
> > > issues" was primarily exactly _because_ the old code was so
> > > incomprehensible, and I think the end result is much cleaner, so I
> > > still like it.
> 
> Just to report that I gave this v2 set a spin on a few (x86_64 and i386)
> machines, and found nothing objectionable this time around.

Thanks, Hugh.

> And the things that I'm unenthusiastic about are exactly those details
> that you and Kirill and Linus find unsatisfactory, but awkward to
> eliminate: expect no new insights from me!

Well, I'll keep you on CC for v3 -- just in case!

Will
