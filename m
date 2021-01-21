Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3392B2FF745
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbhAUV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbhAUV3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:29:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0311623A53;
        Thu, 21 Jan 2021 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611264518;
        bh=Dd1W9bCeOuqQQTWgQKKjURvCvrcjupnyMPuQIYgLAi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kwi1tgKNlVNM/FF/m5oTJAgGIXLi5xbGLLa/ACf5QQj8ztMOuzklYEmWRnE/74HJ7
         LNn/REQ4/tO1id5izd309fpe+HOqBBdejgqiBZwtnTTUkIOlo/Zx45sGObLk4UjIMA
         C9Uaehs8Yi5cylTIwnpPo0NAw8mtqKDaCu6XaU1ncdu67byAoMPiirzfYToqSSckSX
         8Z9InGZgbG37RHpkegkpqkdJ9KJBmA4F7c/pjSYvwNQGj6hDYRGqkjrOzY1Ecx1TdA
         uAeDhL6GEtaaoZ1UeHruQQxxMgiQ5lX89wDAwD7OPR8IeM3EmGYB9rEznjWR96T1a/
         muxSRNkN6tNRQ==
Date:   Thu, 21 Jan 2021 21:28:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct
 vm_fault' as 'const'
Message-ID: <20210121212832.GA23234@willie-the-truck>
References: <20210120173612.20913-1-will@kernel.org>
 <20210120173612.20913-9-will@kernel.org>
 <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
 <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com>
 <20210121131101.GD22123@willie-the-truck>
 <CAKwvOdnmHH+sCqzdaAt_LYms_KULx5VpzmQZjSOy_Qyj0+hbgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnmHH+sCqzdaAt_LYms_KULx5VpzmQZjSOy_Qyj0+hbgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:24:36AM -0800, Nick Desaulniers wrote:
> On Thu, Jan 21, 2021 at 5:11 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Jan 20, 2021 at 11:02:06AM -0800, Linus Torvalds wrote:
> > > On Wed, Jan 20, 2021 at 10:27 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > Is there a difference between: [ const unnamed struct and individual const members ]
> > >
> > > Semantically? No.
> > >
> > > Syntactically the "group the const members together" is a lot cleaner,
> > > imho. Not just from a "just a single const" standpoint, but from a
> > > "code as documentation" standpoint.
> > >
> > > But I guess to avoid the clang issue, we could do the "mark individual
> > > fields" thing.
> >
> > I'd prefer to wait until the bug against LLVM has been resolved before we
> > try to work around anything. Although I couldn't find any other examples
> > like this in the kernel, requiring all of the member fields to be marked as
> > 'const' still feels pretty fragile to me; it's only a matter of time before
> > new non-const fields get added, at which point the temptation for developers
> > to remove 'const' from other fields when it gets in the way is pretty high.
> 
> What's to stop a new non-const field from getting added outside the
> const qualified anonymous struct?
> What's to stop someone from removing const from the anonymous struct?
> What's to stop a number of callers from manipulating the structure
> temporarily before restoring it when returning by casting away the
> const?
> 
> Code review.

Sure, but here we are cleaning up this stuff, so I think review only gets
you so far. To me:

	const struct {
		int	foo;
		long	bar;
	};

clearly says "don't modify fields of this struct", whereas:

	struct {
		const int	foo;
		const long	bar;
	};

says "don't modify foo or bar, but add whatever you like on the end" and
that's the slippery slope. So then we end up with the eye-sore of:

	const struct {
		const int	foo;
		const long	bar;
	};

and maybe that's the right answer, but I'm just saying we should wait for
clang to make up its mind first. It's not like this is a functional problem,
and there are enough GCC users around that we're not exactly in a hurry.

Will
