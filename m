Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D238302973
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbhAYR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731354AbhAYR5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:57:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 426B622583;
        Mon, 25 Jan 2021 17:56:33 +0000 (UTC)
Date:   Mon, 25 Jan 2021 17:56:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v4 1/3] arm64: Improve kernel address detection of
 __is_lm_address()
Message-ID: <20210125175630.GK25360@gaia>
References: <20210122155642.23187-1-vincenzo.frascino@arm.com>
 <20210122155642.23187-2-vincenzo.frascino@arm.com>
 <20210125130204.GA4565@C02TD0UTHF1T.local>
 <ddc0f9e2-f63e-9c34-f0a4-067d1c5d63b8@arm.com>
 <20210125145911.GG25360@gaia>
 <4bd1c01b-613c-787f-4363-c55a071f14ae@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd1c01b-613c-787f-4363-c55a071f14ae@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:09:57PM +0000, Vincenzo Frascino wrote:
> On 1/25/21 2:59 PM, Catalin Marinas wrote:
> > On Mon, Jan 25, 2021 at 02:36:34PM +0000, Vincenzo Frascino wrote:
> >> On 1/25/21 1:02 PM, Mark Rutland wrote:
> >>> On Fri, Jan 22, 2021 at 03:56:40PM +0000, Vincenzo Frascino wrote:
> >>>> Currently, the __is_lm_address() check just masks out the top 12 bits
> >>>> of the address, but if they are 0, it still yields a true result.
> >>>> This has as a side effect that virt_addr_valid() returns true even for
> >>>> invalid virtual addresses (e.g. 0x0).
> >>>>
> >>>> Improve the detection checking that it's actually a kernel address
> >>>> starting at PAGE_OFFSET.
> >>>>
> >>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Cc: Will Deacon <will@kernel.org>
> >>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >>>
> >>> Looking around, it seems that there are some existing uses of
> >>> virt_addr_valid() that expect it to reject addresses outside of the
> >>> TTBR1 range. For example, check_mem_type() in drivers/tee/optee/call.c.
> >>>
> >>> Given that, I think we need something that's easy to backport to stable.
> >>>
> >>
> >> I agree, I started looking at it this morning and I found cases even in the main
> >> allocators (slub and page_alloc) either then the one you mentioned.
> >>
> >>> This patch itself looks fine, but it's not going to backport very far,
> >>> so I suspect we might need to write a preparatory patch that adds an
> >>> explicit range check to virt_addr_valid() which can be trivially
> >>> backported.
> >>>
> >>
> >> I checked the old releases and I agree this is not back-portable as it stands.
> >> I propose therefore to add a preparatory patch with the check below:
> >>
> >> #define __is_ttrb1_address(addr)	((u64)(addr) >= PAGE_OFFSET && \
> >> 					(u64)(addr) < PAGE_END)
> >>
> >> If it works for you I am happy to take care of it and post a new version of my
> >> patches.
> > 
> > I'm not entirely sure we need a preparatory patch. IIUC (it needs
> > checking), virt_addr_valid() was fine until 5.4, broken by commit
> > 14c127c957c1 ("arm64: mm: Flip kernel VA space"). Will addressed the
> > flip case in 68dd8ef32162 ("arm64: memory: Fix virt_addr_valid() using
> > __is_lm_address()") but this broke the <PAGE_OFFSET case. So in 5.4 a
> > NULL address is considered valid.
> > 
> > Ard's commit f4693c2716b3 ("arm64: mm: extend linear region for 52-bit
> > VA configurations") changed the test to no longer rely on va_bits but
> > did not change the broken semantics.
> > 
> > If Ard's change plus the fix proposed in this test works on 5.4, I'd say
> > we just merge this patch with the corresponding Cc stable and Fixes tags
> > and tweak it slightly when doing the backports as it wouldn't apply
> > cleanly. IOW, I wouldn't add another check to virt_addr_valid() as we
> > did not need one prior to 5.4.
> 
> Thank you for the detailed analysis. I checked on 5.4 and it seems that Ard
> patch (not a clean backport) plus my proposed fix works correctly and solves the
> issue.

I didn't mean the backport of the whole commit f4693c2716b3 as it
probably has other dependencies, just the __is_lm_address() change in
that patch.

> Tomorrow I will post a new version of the series that includes what you are
> suggesting.

Please post the __is_lm_address() fix separately from the kasan patches.
I'll pick it up as a fix via the arm64 tree. The kasan change can go in
5.12 since it's not currently broken but I'll leave the decision with
Andrey.

-- 
Catalin
