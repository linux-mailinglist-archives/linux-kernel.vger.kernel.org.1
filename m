Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C62F1737
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbhAKOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388298AbhAKOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:02:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E8692242A;
        Mon, 11 Jan 2021 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610373715;
        bh=50IG3zR+Q9oxcbVhieDnuu5FgxkxGAFNFUX/rpImuNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDweBAoGyGcdo8Q8Z8bdxt61JEm0SV2DUE6HLbw752d+V76R95FuTrxT9fQycKawv
         Wi8hxok+e6+KdKSNX97rOM1kbhPMaY1S8+8hXQz67FyHjM5uhruT5m6yMODANNDVdY
         AKRFj73QUdnxLxOgBZ6V+uuJpXq51aHVTlV69KrSG/Hpur51tjxpR0DGa8CSTTQJDZ
         6H4kumU/NWhGA0Ks0hbP3YN59eBuRIsWvFNH3kBqUWB01t6msUEQ+FXaO84528YDdI
         hs5Z8UtK23t0OmOfssqdRj8FOak+MOvmjbhHhBdK/irmCoJX7gF6TCdK8QiStch3Hq
         SEJ9+aHuxr5BQ==
Date:   Mon, 11 Jan 2021 14:01:49 +0000
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
Message-ID: <20210111140149.GB7642@willie-the-truck>
References: <20210108171517.5290-1-will@kernel.org>
 <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
 <CAHk-=wh=6=7qYKL0RLbzg4vKnT0v_c66n8RYS-CvmUxnO9MxPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=6=7qYKL0RLbzg4vKnT0v_c66n8RYS-CvmUxnO9MxPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:42:39AM -0800, Linus Torvalds wrote:
> On Fri, Jan 8, 2021 at 11:34 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Yeah, I think that's a side effect of "now the code really makes a lot
> > more sense". Your subsequent patches 2-3 certainly are much simpler
> > now
> 
> On that note - they could be simpler still if this was just done
> entirely unconditionally..
> 
> I'm taking your word for "it makes sense", but when you say
> 
>   On CPUs with hardware AF/DBM, initialising prefaulted PTEs as 'old'
>   improves vmscan behaviour and does not appear to introduce any overhead.
> 
> in the description for patch 3, it makes me wonder how noticeable the
> overhead is on the hardware that _does_ take a fault on old pte's..
> 
> IOW, it would be lovely to see numbers if you have any like that..

[Vinayak -- please chime in if I miss anything here, as you've posted these
 numbers before]

The initial posting in 2016 had some numbers based on a 3.18 kernel, which
didn't have support for hardware AF/DBM:

  https://lore.kernel.org/lkml/fdc23a2a-b42a-f0af-d403-41ea4e755084@codeaurora.org

  (note that "Kirill's-fix" in the last column was a quick hack and didn't
   make the faulting pte young)

So yes, for the cases we care about in Android (where the vmscan behaviour
seems to be the important thing), then this patch makes sense for
non-hardware AF/DBM CPUs too. In either case, we see ~80% reduction in
direct reclaim time according to mmtests [1] and double-digit percentage
reductions in app launch latency (some of this is mentioned in the link
above). The actual fault cost isn't especially relevant.

*However...*

For machines with lots of memory, the increased fault cost when hardware
AF/DBM is not available may well be measurable, and I suspect it would
hurt unixbench (which was the reason behind reverting this on x86 [2],
although I must admit that the diagnosis wasn't particularly satisfactory
[3]). We could run those numbers on arm64 but, due to the wide diversity of
micro-architectures we have to deal with, I would like to keep our options
open to detecting this dynamically anyway, just in case somebody builds a
CPU which struggles in this area.

Cheers,

Will

[1] https://github.com/gormanm/mmtests
[2] https://lore.kernel.org/lkml/20160613125248.GA30109@black.fi.intel.com/
[3] https://lore.kernel.org/lkml/20160616151049.GM6836@dhcp22.suse.cz/
