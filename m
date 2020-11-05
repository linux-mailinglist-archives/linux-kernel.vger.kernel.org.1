Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8392A8138
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgKEOph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:45:37 -0500
Received: from foss.arm.com ([217.140.110.172]:34554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731089AbgKEOph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:45:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7557D14BF;
        Thu,  5 Nov 2020 06:45:36 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A86743F718;
        Thu,  5 Nov 2020 06:45:33 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:45:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20201105144530.GK82102@C02TD0UTHF1T.local>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com>
 <20201105134142.GA4856@sirena.org.uk>
 <20201105140322.GH82102@C02TD0UTHF1T.local>
 <CAMj1kXEsaZAGT0jnPNyj_K1Q4W7E1+WP=tQf3bTPQi=KOCUv4g@mail.gmail.com>
 <20201105143023.GI82102@C02TD0UTHF1T.local>
 <CAMj1kXEoot13bFKywPRVf4BFhA5tSp+Nate=+Z+JsQdLW1oRrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEoot13bFKywPRVf4BFhA5tSp+Nate=+Z+JsQdLW1oRrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 03:34:01PM +0100, Ard Biesheuvel wrote:
> On Thu, 5 Nov 2020 at 15:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Nov 05, 2020 at 03:04:57PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 5 Nov 2020 at 15:03, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > > > That said, I'm not sure it's great to plumb this under the
> > > > arch_get_random*() interfaces, e.g. given this measn that
> > > > add_interrupt_randomness() will end up trapping to the host all the time
> > > > when it calls arch_get_random_seed_long().
> > >
> > > As it turns out, add_interrupt_randomness() isn't actually used on ARM.
> >
> > It's certainly called on arm64, per a warning I just hacked in:

[...]

> > ... and I couldn't immediately spot why 32-bit arm  would be different.
> 
> Hmm, I actually meant both arm64 and ARM.
> 
> Marc looked into this at my request a while ago, and I had a look
> myself as well at the time, and IIRC, we both concluded that we don't
> hit that code path. Darn.
> 
> In any case, the way add_interrupt_randomness() calls
> arch_get_random_seed_long() is absolutely insane, so we should try to
> fix that in any case.

I have no strong opinion there, and I'm happy with that getting cleaned
up.

Regardless, I do think it's reasonable for the common code to expect
that arch_get_random_*() to be roughly as expensive as "most other
instructions" (since even RNDR* is expensive the CPU might be able to do
useful speculative work in the mean time), whereas a trap to the host is
always liable to be expensive as no useful work can be done while the
host is handling it, so I think it makes sense to distinguish the two.

Thanks,
Mark.
