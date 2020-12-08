Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC12D373D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgLHX4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:56:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730364AbgLHX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:56:00 -0500
Date:   Tue, 8 Dec 2020 15:55:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607471719;
        bh=XYsYf5906N+mg1XwuCiho6GHsJNm2dGoMhfW56SAY8I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqapjCiUDt5ExNEpAupAg/ZpeOom3Aiu7KhulRwdafuvSQLKj7jGFe021y5kDSJbE
         eD56i7mcQqPLrFOOogLc85rv0+qh/tK3UIFH7S5CpShj6662STqFqVaiJBZy3ZgsQs
         c4npFfZMdBuvUDyDvGVUCHPl09N8HKv0nZFC+tvAckYBGUPXR+7MrE7dc//B+f11hh
         Jskw6sHp2Wr8QVY9IkC8I/kHs+mTWB8yf1rjYPBqQJKGqYN5bxkeR3kTA1AWs7z1wl
         /U3oklwBMSR6/x2H9f8vheTeBvL9kQ1UHWIx0y1r6Znmlx9zs7n1UAnCKs80zD570U
         Ns9oNGcDgMIwA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X9ASZV4ZBBPxCpU/@google.com>
References: <20201205042626.1113600-1-daeho43@gmail.com>
 <X86RJdLhOVRm28Eu@gmail.com>
 <CACOAw_yp0LU-vcT2+NTF3ipibF6GvqfaQ4V=957CDPQLbes92Q@mail.gmail.com>
 <X88ZC4f2hZxAU3C0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X88ZC4f2hZxAU3C0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, Eric Biggers wrote:
> On Tue, Dec 08, 2020 at 08:51:45AM +0900, Daeho Jeong wrote:
> > > I am trying to review this but it is very hard, as the f2fs compression code is
> > > very hard to understand.
> > >
> > > It looks like a 'struct decompress_io_ctx' represents the work to decompress a
> > > particular cluster.  Since the compressed data of the cluster can be read using
> > > multiple bios, there is a reference count of how many pages are remaining to be
> > > read before all the cluster's pages have been read and decompression can start.
> > >
> > > What I don't understand is why that reference counting needs to work differently
> > > depending on whether verity is enabled or not.  Shouldn't it be exactly the
> > > same?
> > >
> > > There also seems to be some confusion about the scope of STEP_VERITY.  Before
> > > f2fs compression was added, it was a per-bio thing.  But now in a compressed
> > > file, it's really a per-cluster thing, since all decompressed pages in a
> > > compressed cluster are verified (or not verified) at once.
> > >
> > > Wouldn't it make a lot more sense to, when a cluster needs both compression and
> > > verity, *not* set STEP_VERITY on the bios, but rather set a similar flag in the
> > > decompress_io_ctx?
> > >
> > 
> > Eric,
> > 
> > Decompression and verity can be executed in different thread contexts
> > in different timing, so we need separate counts for each.
> > 
> > We already use STEP_VERITY for non-compression case, so I think using
> > this flag in here looks more making sense.
> > 
> > Thanks,
> 
> That didn't really answer my questions.
> 
> I gave up trying to review this patch as the compression post-read handling is
> just way too weird and hard to understand.  I wrote a patch to clean it all up
> instead, please take a look:
> https://lkml.kernel.org/r/20201208060328.2237091-1-ebiggers@kernel.org

Eric,
I also tried to review your patch, but it's quite hard to follow quickly and
requires stress tests for a while. Given upcoming merge window and urgency of
the bug, let me apply Daeho's fix first. By any chance, may I ask revisiting
your clean-up on top of the fix in the next cycle?

Thanks,

> 
> - Eric
