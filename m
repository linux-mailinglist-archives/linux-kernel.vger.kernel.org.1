Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38349302920
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbhAYRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:40:18 -0500
Received: from foss.arm.com ([217.140.110.172]:53414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbhAYRj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:39:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB78E1063;
        Mon, 25 Jan 2021 09:38:34 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.45.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 021DC3F68F;
        Mon, 25 Jan 2021 09:38:31 -0800 (PST)
Date:   Mon, 25 Jan 2021 17:38:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Message-ID: <20210125173829.GB4565@C02TD0UTHF1T.local>
References: <20210122155642.23187-1-vincenzo.frascino@arm.com>
 <20210122155642.23187-2-vincenzo.frascino@arm.com>
 <20210125130204.GA4565@C02TD0UTHF1T.local>
 <ddc0f9e2-f63e-9c34-f0a4-067d1c5d63b8@arm.com>
 <20210125145911.GG25360@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125145911.GG25360@gaia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:59:12PM +0000, Catalin Marinas wrote:
> On Mon, Jan 25, 2021 at 02:36:34PM +0000, Vincenzo Frascino wrote:
> > On 1/25/21 1:02 PM, Mark Rutland wrote:
> > > On Fri, Jan 22, 2021 at 03:56:40PM +0000, Vincenzo Frascino wrote:
> > > This patch itself looks fine, but it's not going to backport very far,
> > > so I suspect we might need to write a preparatory patch that adds an
> > > explicit range check to virt_addr_valid() which can be trivially
> > > backported.
> > 
> > I checked the old releases and I agree this is not back-portable as it stands.
> > I propose therefore to add a preparatory patch with the check below:
> > 
> > #define __is_ttrb1_address(addr)	((u64)(addr) >= PAGE_OFFSET && \
> > 
> > If it works for you I am happy to take care of it and post a new version of my
> > patches.
> 
> I'm not entirely sure we need a preparatory patch. IIUC (it needs
> checking), virt_addr_valid() was fine until 5.4, broken by commit
> 14c127c957c1 ("arm64: mm: Flip kernel VA space").

Ah, so it was; thanks for digging into the history!

> Will addressed the
> flip case in 68dd8ef32162 ("arm64: memory: Fix virt_addr_valid() using
> __is_lm_address()") but this broke the <PAGE_OFFSET case. So in 5.4 a
> NULL address is considered valid.
> 
> Ard's commit f4693c2716b3 ("arm64: mm: extend linear region for 52-bit
> VA configurations") changed the test to no longer rely on va_bits but
> did not change the broken semantics.
> 
> If Ard's change plus the fix proposed in this test works on 5.4, I'd say
> we just merge this patch with the corresponding Cc stable and Fixes tags
> and tweak it slightly when doing the backports as it wouldn't apply
> cleanly. IOW, I wouldn't add another check to virt_addr_valid() as we
> did not need one prior to 5.4.

That makes sense to me; sorry for the noise!

Thanks,
Mark.
