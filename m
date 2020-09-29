Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119C027D21A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgI2PF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:05:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgI2PF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:05:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566D91063;
        Tue, 29 Sep 2020 08:05:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE43B3F6CF;
        Tue, 29 Sep 2020 08:05:51 -0700 (PDT)
Date:   Tue, 29 Sep 2020 16:05:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
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
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
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
Message-ID: <20200929150549.GE53442@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-2-elver@google.com>
 <20200929142411.GC53442@C02TD0UTHF1T.local>
 <CANpmjNNQGrpq+fBh4OypP9aK+-548vbCbKYiWQnSHESM0SLVzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNQGrpq+fBh4OypP9aK+-548vbCbKYiWQnSHESM0SLVzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:51:29PM +0200, Marco Elver wrote:
> On Tue, 29 Sep 2020 at 16:24, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
> >
> > From other sub-threads it sounds like these addresses are not part of
> > the linear/direct map. Having kmalloc return addresses outside of the
> > linear map is going to break anything that relies on virt<->phys
> > conversions, and is liable to make DMA corrupt memory. There were
> > problems of that sort with VMAP_STACK, and this is why kvmalloc() is
> > separate from kmalloc().
> >
> > Have you tested with CONFIG_DEBUG_VIRTUAL? I'd expect that to scream.
> >
> > I strongly suspect this isn't going to be safe unless you always use an
> > in-place carevout from the linear map (which could be the linear alias
> > of a static carevout).
> 
> That's an excellent point, thank you! Indeed, on arm64, a version with
> naive static-pool screams with CONFIG_DEBUG_VIRTUAL.
> 
> We'll try to put together an arm64 version using a carveout as you suggest.

Great, thanks!

Just to be clear, the concerns for DMA and virt<->phys conversions also
apply to x86 (the x86 virt<->phys conversion behaviour is more forgiving
in the common case, but still has cases that can go wrong).

Other than the code to initialize the page tables for the careveout, I
think the carevout code can be geenric.

Thanks,
Mark.
