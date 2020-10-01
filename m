Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3711C28064D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbgJASLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:11:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgJASLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:11:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A6BD1042;
        Thu,  1 Oct 2020 11:11:29 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218163F6CF;
        Thu,  1 Oct 2020 11:11:21 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:11:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20201001181119.GB89689@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-2-elver@google.com>
 <20200929142411.GC53442@C02TD0UTHF1T.local>
 <CAG_fn=UOJARteeqT_+1ORPEP9SB5HR3B3W8830rA9kjZLoN+Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UOJARteeqT_+1ORPEP9SB5HR3B3W8830rA9kjZLoN+Ww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 05:51:58PM +0200, Alexander Potapenko wrote:
> On Tue, Sep 29, 2020 at 4:24 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Sep 21, 2020 at 03:26:02PM +0200, Marco Elver wrote:
> > > From: Alexander Potapenko <glider@google.com>
> > >
> > > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > > low-overhead sampling-based memory safety error detector of heap
> > > use-after-free, invalid-free, and out-of-bounds access errors.
> > >
> > > KFENCE is designed to be enabled in production kernels, and has near
> > > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > > for precision. The main motivation behind KFENCE's design, is that with
> > > enough total uptime KFENCE will detect bugs in code paths not typically
> > > exercised by non-production test workloads. One way to quickly achieve a
> > > large enough total uptime is when the tool is deployed across a large
> > > fleet of machines.
> > >
> > > KFENCE objects each reside on a dedicated page, at either the left or
> > > right page boundaries. The pages to the left and right of the object
> > > page are "guard pages", whose attributes are changed to a protected
> > > state, and cause page faults on any attempted access to them. Such page
> > > faults are then intercepted by KFENCE, which handles the fault
> > > gracefully by reporting a memory access error. To detect out-of-bounds
> > > writes to memory within the object's page itself, KFENCE also uses
> > > pattern-based redzones. The following figure illustrates the page
> > > layout:
> > >
> > >   ---+-----------+-----------+-----------+-----------+-----------+---
> > >      | xxxxxxxxx | O :       | xxxxxxxxx |       : O | xxxxxxxxx |
> > >      | xxxxxxxxx | B :       | xxxxxxxxx |       : B | xxxxxxxxx |
> > >      | x GUARD x | J : RED-  | x GUARD x | RED-  : J | x GUARD x |
> > >      | xxxxxxxxx | E :  ZONE | xxxxxxxxx |  ZONE : E | xxxxxxxxx |
> > >      | xxxxxxxxx | C :       | xxxxxxxxx |       : C | xxxxxxxxx |
> > >      | xxxxxxxxx | T :       | xxxxxxxxx |       : T | xxxxxxxxx |
> > >   ---+-----------+-----------+-----------+-----------+-----------+---
> > >
> > > Guarded allocations are set up based on a sample interval (can be set
> > > via kfence.sample_interval). After expiration of the sample interval, a
> > > guarded allocation from the KFENCE object pool is returned to the main
> > > allocator (SLAB or SLUB). At this point, the timer is reset, and the
> > > next allocation is set up after the expiration of the interval.
> >
> > From other sub-threads it sounds like these addresses are not part of
> > the linear/direct map.
> For x86 these addresses belong to .bss, i.e. "kernel text mapping"
> section, isn't that the linear map?

No; the "linear map" is the "direct mapping" on x86, and the "image" or
"kernel text mapping" is a distinct VA region. The image mapping aliases
(i.e. uses the same physical pages as) a portion of the linear map, and
every page in the linear map has a struct page.

Fon the x86_64 ivirtual memory layout, see:

https://www.kernel.org/doc/html/latest/x86/x86_64/mm.html

Originally, the kernel image lived in the linear map, but it was split
out into a distinct VA range (among other things) to permit KASLR.  When
that split was made, the x86 virt_to_*() helpers were updated to detect
when they were passed a kernel image address, and automatically fix that
up as-if they'd been handed the linear map alias of that address.

For going one-way from virt->{phys,page} that works ok, but it doesn't
survive the round-trip, and introduces redundant work into each
virt_to_*() call.

As it was largely arch code that was using image addresses, we didn't
bother with the fixup on arm64, as we preferred the stronger warning. At
the time I was also under the impression that on x86 they wanted to get
rid of the automatic fixup, but that doesn't seem to have happened.

Thanks,
Mark.
