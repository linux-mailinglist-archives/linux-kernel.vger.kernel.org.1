Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69B928F376
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgJONj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:39:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgJONj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:39:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CFC013D5;
        Thu, 15 Oct 2020 06:39:57 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A683F719;
        Thu, 15 Oct 2020 06:39:51 -0700 (PDT)
Date:   Thu, 15 Oct 2020 14:39:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20201015133948.GB50416@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
 <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
 <20200929140226.GB53442@C02TD0UTHF1T.local>
 <CAG_fn=VOR-3LgmLY-T2Fy6K_VYFgCHK0Hv+Y-atrvrVZ4mQE=Q@mail.gmail.com>
 <20201001175716.GA89689@C02TD0UTHF1T.local>
 <CANpmjNMFrMZybOebFwJ1GRXpt8v39AN016UDgPZzE8J3zKh9RA@mail.gmail.com>
 <20201008104501.GB72325@C02TD0UTHF1T.local>
 <CANpmjNOg2OeWpXn57_ikqv4KR0xVEooCDECUyRijgr0tt4+Ncw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOg2OeWpXn57_ikqv4KR0xVEooCDECUyRijgr0tt4+Ncw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:12:37PM +0200, Marco Elver wrote:
> On Thu, 8 Oct 2020 at 12:45, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Oct 08, 2020 at 11:40:52AM +0200, Marco Elver wrote:
> > > On Thu, 1 Oct 2020 at 19:58, Mark Rutland <mark.rutland@arm.com> wrote:

> > > > > > If you need virt_to_page() to work, the address has to be part of the
> > > > > > linear/direct map.

> > > We're going with dynamically allocating the pool (for both x86 and
> > > arm64), 

[...]

> We've got most of this sorted now for v5 -- thank you!
> 
> The only thing we're wondering now, is if there are any corner cases
> with using memblock_alloc'd memory for the KFENCE pool? (We'd like to
> avoid page alloc's MAX_ORDER limit.) We have a version that passes
> tests on x86 and arm64, but checking just in case. :-)

AFAICT otherwise the only noticeable difference might be PageSlab(), if
that's clear for KFENCE allocated pages? A few helpers appear to check
that to determine how something was allocated (e.g. in the scatterlist
and hwpoison code), and I suspect that needs to behave the same.

Otherwise, I *think* using memblock_alloc should be fine on arm64; I'm
not entirely sure for x86 (but suspect it's similar). On arm64:

* All memory is given a struct page via memblocks_present() adding all
  memory memblocks. This includes memory allocated by memblock_alloc().

* All memory is mapped into the linear map via arm64's map_mem() adding
  all (non-nomap) memory memblocks. This includes memory allocated by
  memblock_alloc().

Thanks,
Mark.
