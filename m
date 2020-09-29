Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0107827D069
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgI2OCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:02:37 -0400
Received: from foss.arm.com ([217.140.110.172]:45442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbgI2OCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:02:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C5AA31B;
        Tue, 29 Sep 2020 07:02:36 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921A33F6CF;
        Tue, 29 Sep 2020 07:02:29 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:02:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20200929140226.GB53442@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
 <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:25:11PM +0200, Alexander Potapenko wrote:
> Will,
> 
> > Given that the pool is relatively small (i.e. when compared with our virtual
> > address space), dedicating an area of virtual space sounds like it makes
> > the most sense here. How early do you need it to be available?
> 
> How do we assign struct pages to a fixed virtual space area (I'm
> currently experimenting with 0xffff7f0000000000-0xffff7f0000200000)?

You don't.

There should be a struct page for each of the /physical/ pages, and
these can be found:

* via the physical address, using phyts_to_page() or pfn_to_page()
* via the linear/direct map, using virt_to_page()
* via the vmalloc page tables using vmalloc_to_page()

If you need virt_to_page() to work, the address has to be part of the
linear/direct map.

If you need to find the struct page for something that's part of the
kernel image you can use virt_to_page(lm_alias(x)).

> Looks like filling page table entries (similarly to what's being done
> in arch/arm64/mm/kasan_init.c) is not enough.
> I thought maybe vmemmap_populate() would do the job, but it didn't
> (virt_to_pfn() still returns invalid PFNs).

As above, I think lm_alias() will solve the problem here. Please see
that and CONFIG_DEBUG_VIRTUAL.

Thanks,
Mark.
