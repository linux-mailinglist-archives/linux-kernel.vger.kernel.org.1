Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9073026FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbhAYPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbhAYPdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:33:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DC8423B70;
        Mon, 25 Jan 2021 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611588682;
        bh=qjqOOxZHKUNkJrWJLLIv5ELWV/kMvv5CYzw1+xODwS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAIjljpRC9HZtZNqGk1TAWWiZm0+mJJBd9Cqz1brf/HrRlTH3LnsgjuoyIlO0NH2K
         tAL2IGsS6H92+0RRFMP59nK7k6ZzMd8lCdCYrRMdFLAE+9tOUopdi9P9kTQY3fw16M
         l0pQ9luW5RcK21IceGedE4jzyKw6624rhQaJq7uqe4miZ1PFToGe0PaYqCXjoJamwW
         F3j+zMU4FJM796dn28MGcq81vHzqF3a0zEN/T3eAeHDdYB9FRdtsQAjrh7YzysuA9n
         APsvKnhcdqxxG6d/q9lPg8myw7RX5B3BJKCik7ZRG4meBfCABC9vc/wqRlIrbl3nbv
         qH+4ravqCopLA==
Date:   Mon, 25 Jan 2021 17:31:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/setup: consolidate early memory reservations
Message-ID: <20210125153114.GH6332@kernel.org>
References: <20210115083255.12744-1-rppt@kernel.org>
 <20210115083255.12744-2-rppt@kernel.org>
 <20210125145041.GD23070@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125145041.GD23070@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 03:50:41PM +0100, Borislav Petkov wrote:
> On Fri, Jan 15, 2021 at 10:32:54AM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The early reservations of memory areas used by the firmware, bootloader,
> > kernel text and data are spread over setup_arch(). Moreover, some of them
> > happen *after* memblock allocations, e.g trim_platform_memory_ranges() and
> > trim_low_memory_range() are called after reserve_real_mode() that allocates
> > memory.
> > 
> > We did not observe corruption of these memory regions because memblock
> 
> Make that "We" impersonal, passive voice pls.

Ok.
 
> > always allocates memory either from the end of memory (in top-down mode) or
> > above the kernel image (in bottom-up mode). However, the bottom up mode is
> > going to be updated to span the entire memory [1] to avoid limitations
> > caused by KASLR.
> > 
> > Consolidate early memory reservations in a dedicated function to improve
> > robustness against future changes. Having the early reservations in one
> > place also makes it clearer what memory must be reserved before we allow
> > memblock allocations.
> 
> Would it make sense to have a check with a WARN or so to catch early
> reservations which get added after memblock allocations have been
> allowed? To catch people who don't pay attention...

This would make sense but it's tricky. From memblock perspective,
allocations are always allowed and it is the user responsibility to ensure
all the early reservations are done before allocating memory.

So adding such a WARN would require a new memblock API and it's adoption by
all architectures, which is way beyond the scope of this series :)

-- 
Sincerely yours,
Mike.
