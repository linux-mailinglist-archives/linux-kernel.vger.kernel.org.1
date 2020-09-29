Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE327CFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgI2NyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:54:15 -0400
Received: from foss.arm.com ([217.140.110.172]:45118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgI2NyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:54:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BCA931B;
        Tue, 29 Sep 2020 06:54:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 055C73F6CF;
        Tue, 29 Sep 2020 06:54:03 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:53:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20200929135355.GA53442@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
 <CAG_fn=WKaY9MVmbpkgoN4vaJYD_T_A3z2Lgqn+2o8-irmCKywg@mail.gmail.com>
 <CAG_fn=XV7JfJDK+t1X6bnV6gRoiogNXsHfww0jvcEtJ2WZpR7Q@mail.gmail.com>
 <20200921174357.GB3141@willie-the-truck>
 <CANpmjNNdGWoY_FcqUDUZ2vXy840H2+LGzN3WWrK8iERTKntSTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNdGWoY_FcqUDUZ2vXy840H2+LGzN3WWrK8iERTKntSTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:56:26AM +0200, Marco Elver wrote:
> On Mon, 21 Sep 2020 at 19:44, Will Deacon <will@kernel.org> wrote:
> [...]
> > > > > > For ARM64, we would like to solicit feedback on what the best option is
> > > > > > to obtain a constant address for __kfence_pool. One option is to declare
> > > > > > a memory range in the memory layout to be dedicated to KFENCE (like is
> > > > > > done for KASAN), however, it is unclear if this is the best available
> > > > > > option. We would like to avoid touching the memory layout.
> > > > >
> > > > > Sorry for the delay on this.
> > > >
> > > > NP, thanks for looking!
> > > >
> > > > > Given that the pool is relatively small (i.e. when compared with our virtual
> > > > > address space), dedicating an area of virtual space sounds like it makes
> > > > > the most sense here. How early do you need it to be available?
> > > >
> > > > Yes, having a dedicated address sounds good.
> > > > We're inserting kfence_init() into start_kernel() after timekeeping_init().
> > > > So way after mm_init(), if that matters.
> > >
> > > The question is though, how big should that dedicated area be?
> > > Right now KFENCE_NUM_OBJECTS can be up to 16383 (which makes the pool
> > > size 64MB), but this number actually comes from the limitation on
> > > static objects, so we might want to increase that number on arm64.
> >
> > What happens on x86 and why would we do something different?
> 
> On x86 we just do `char __kfence_pool[KFENCE_POOL_SIZE] ...;` to
> statically allocate the pool. On arm64 this doesn't seem to work
> because static memory doesn't have struct pages?

Are you using virt_to_page() directly on that statically-allocated
__kfence_pool? If so you'll need to use lm_alias() if so, as is done in
mm/kasan/init.c.

Anything statically allocated is part of the kernel image address range
rather than the linear/direct map, and doesn't have a valid virt addr,
but its linear map alias does.

If you enable CONFIG_DEBUG_VIRTUAL you should get warnings if missing
lm_alias() calls.

Thanks,
Mark.
