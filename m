Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61E28160E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbgJBPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:06:58 -0400
Received: from foss.arm.com ([217.140.110.172]:38574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387939AbgJBPG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:06:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B12B41396;
        Fri,  2 Oct 2020 08:06:56 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.49.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F5C3F73B;
        Fri,  2 Oct 2020 08:06:50 -0700 (PDT)
Date:   Fri, 2 Oct 2020 16:06:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20201002150643.GA5601@C02TD0UTHF1T.local>
References: <20200929133814.2834621-1-elver@google.com>
 <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
 <CAG48ez1MQks2na23g_q4=ADrjMYjRjiw+9k_Wp9hwGovFzZ01A@mail.gmail.com>
 <CACT4Y+a3hLF1ph1fw7xVz1bQDNKL8W0s6pXe7aKm9wTNrJH3=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a3hLF1ph1fw7xVz1bQDNKL8W0s6pXe7aKm9wTNrJH3=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 04:22:59PM +0200, Dmitry Vyukov wrote:
> On Fri, Oct 2, 2020 at 9:54 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Fri, Oct 2, 2020 at 8:33 AM Jann Horn <jannh@google.com> wrote:
> > > On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> > > > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > > > low-overhead sampling-based memory safety error detector of heap
> > > > use-after-free, invalid-free, and out-of-bounds access errors.
> > > >
> > > > KFENCE is designed to be enabled in production kernels, and has near
> > > > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > > > for precision. The main motivation behind KFENCE's design, is that with
> > > > enough total uptime KFENCE will detect bugs in code paths not typically
> > > > exercised by non-production test workloads. One way to quickly achieve a
> > > > large enough total uptime is when the tool is deployed across a large
> > > > fleet of machines.
> > [...]
> > > > +/*
> > > > + * The pool of pages used for guard pages and objects. If supported, allocated
> > > > + * statically, so that is_kfence_address() avoids a pointer load, and simply
> > > > + * compares against a constant address. Assume that if KFENCE is compiled into
> > > > + * the kernel, it is usually enabled, and the space is to be allocated one way
> > > > + * or another.
> > > > + */

> KFENCE needs the range to be covered by struct page's and that's what
> creates problems for arm64. But I would assume most other users don't
> need that.

I've said this in a few other sub-threads, but the issue being
attributed to arm64 is a red herring, and indicates a more fundamental
issue that also applies to x86, which will introduce a regression for
existing correctly-written code. I don't think that's acceptable for a
feature expected to be deployed in production kernels, especially given
that the failures are going to be non-deterministic and hard to debug.

The code in question is mostly going to be in drivers, and it's very
likely you may not hit it in local testing.

If it is critical to avoid a pointer load here, then we need to either:

* Build some infrastructure for patching constants. The x86 static_call
  work is vaguely the right shape for this. Then we can place the KFENCE
  region anywhere (e.g. within the linear/direct map), and potentially
  dynamically allocate it.

* Go audit usage of {page,phys}_to_virt() to find any va->{page,pa}->va
  round-trips, and go modify that code to do something else which avoids
  a round-trip. When I last looked at this it didn't seem viable in
  general since in many cases the physcial address was the only piece of
  information which was retained.

I'd be really curious to see how using an immediate compares to loading
an __ro_after_init pointer value.

Thanks,
Mark.
