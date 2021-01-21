Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7225E2FEB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbhAUNMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731495AbhAUNLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:11:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3DCA239FD;
        Thu, 21 Jan 2021 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611234667;
        bh=2y3nGlOhKVuLqnNjQEH4fvR9yoxLXv3W74n69qv+ztU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMGerGrEyeuqZjQcioHC6qJlSjxztZkPOzz9rPBbGMGM4CrCsv2OoPx+nqbx/5U6V
         qqnUASiYhMVlSFup3Xtd+GhMe9vouxtjgM5xEUoC6vloFLyuBsYJMqoV6HDsfK2Jwt
         s+Fn9tbQHe7o+zXPgNW3OjfJ3quFDKohpqwKv0OVYn2/OrqHoFw8VXYruoZLw0NJQs
         NnxmPBHMheaB9NLaz2p2IamJL7YC3LegARCqCn5DcSxRv6Ta0fLczedsj26scJmFLN
         hmuJp9osXG++3J9N+kDY72bLNkZ3z2e6KAhFY9IiGFany5cGQ8RQH4E7acxjU2EdIO
         Im3FHP1GKDehg==
Date:   Thu, 21 Jan 2021 13:11:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        luc.vanoostenryck@gmail.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
Message-ID: <20210121131101.GD22123@willie-the-truck>
References: <20210120173612.20913-1-will@kernel.org>
 <20210120173612.20913-9-will@kernel.org>
 <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
 <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:02:06AM -0800, Linus Torvalds wrote:
> On Wed, Jan 20, 2021 at 10:27 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Is there a difference between: [ const unnamed struct and individual const members ]
> 
> Semantically? No.
> 
> Syntactically the "group the const members together" is a lot cleaner,
> imho. Not just from a "just a single const" standpoint, but from a
> "code as documentation" standpoint.
> 
> But I guess to avoid the clang issue, we could do the "mark individual
> fields" thing.

I'd prefer to wait until the bug against LLVM has been resolved before we
try to work around anything. Although I couldn't find any other examples
like this in the kernel, requiring all of the member fields to be marked as
'const' still feels pretty fragile to me; it's only a matter of time before
new non-const fields get added, at which point the temptation for developers
to remove 'const' from other fields when it gets in the way is pretty high.

None of this is bullet-proof, of course, but if clang ends up emitting a
warning (even if it's gated behind an option) then I think we're in a good
place.

> (It turns out that sparse gets this wrong too, so it's not just clang).

Adding Luc, as hopefully that's fixable.

Will
