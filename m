Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEA28C9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391056AbgJMIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:06:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbgJMIGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:06:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85A1CAD6B;
        Tue, 13 Oct 2020 08:05:59 +0000 (UTC)
Date:   Tue, 13 Oct 2020 10:05:57 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.10
Message-ID: <20201013080557.GF3302@suse.de>
References: <20201012172415.GA2962950@gmail.com>
 <CAHk-=wgf8ko=b-F74+Qc+EX6M36kHx5wEBCS8nJK1WSod9UO0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgf8ko=b-F74+Qc+EX6M36kHx5wEBCS8nJK1WSod9UO0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 03:07:45PM -0700, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 10:24 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Do not sync vmalloc/ioremap mappings on x86-64 kernels.
> >
> > Hopefully now without the bugs!
> 
> Let's hope so.
> 
> If this turns out to work this time, can we do a similar preallocation
> of the page directories on 32-bit? Because I think now x86-32 is the
> only remaining case of doing that arch_sync_kernel_mappings() thing.
> 
> Or is there some reason that won't work that I've lost sight of?

There were two reasons which made me decide to not pre-allocate on
x86-32:

	1) The sync-level is the same as the huge-page level (PMD) on
	   both paging modes, so with large ioremap mappings the
	   synchronization is always needed. The huge ioremap mapping
	   could possibly be disabled without much performance impact on
	   x86-32.

	2) The vmalloc area has a variable size and grows with less RAM
	   in the machine. And when the vmalloc area gets larger, more
	   pages are needed. Another factor is the configurable
	   vm-split. With a 1G/3G split on a machine with 128MB of RAM
	   there would be:

	   	VMalloc area size (hole ignored): 3072MB - 128MB = 2944MB
		PTE-pages needed (with PAE):      2944MB / 2MB/page = 1472 4k pages
		Memory needed:                    1472*4k = 5888kb

	   So on such machine the pre-allocation would need 5.75MB of
	   the 128MB RAM. Without PAE it is half of that. This is an
	   exotic configuration and I am not sure it matters much in
	   practice. It could also be worked around by setting limits
	   such as, for example, don't make the vmalloc area larger then
	   the avauilable memory in the system.

So pre-allocating has its implications. If we decide to pre-allocate on
x86-32 too, then we should be prepared for that fall-out of the higher
memory usage.

Regards,

	Joerg
