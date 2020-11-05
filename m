Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB09D2A8118
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgKEOi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:38:58 -0500
Received: from foss.arm.com ([217.140.110.172]:34420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKEOi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:38:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB61414BF;
        Thu,  5 Nov 2020 06:38:57 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B68D3F719;
        Thu,  5 Nov 2020 06:38:55 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:38:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20201105143852.GJ82102@C02TD0UTHF1T.local>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com>
 <20201105134142.GA4856@sirena.org.uk>
 <20201105140322.GH82102@C02TD0UTHF1T.local>
 <20201105142949.GB4856@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105142949.GB4856@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 02:29:49PM +0000, Mark Brown wrote:
> On Thu, Nov 05, 2020 at 02:03:22PM +0000, Mark Rutland wrote:
> > On Thu, Nov 05, 2020 at 01:41:42PM +0000, Mark Brown wrote:
> 
> > > It isn't obvious to me why we don't fall through to trying the SMCCC
> > > TRNG here if for some reason the v8.5-RNG didn't give us something.
> > > Definitely an obscure possibility but still...
> 
> > I think it's better to assume that if we have a HW RNG and it's not
> > giving us entropy, it's not worthwhile trapping to the host, which might
> > encounter the exact same issue.
> 
> There's definitely a good argument for that, but OTOH it's possible the
> SMCCC implementation is doing something else (it'd be an interesting
> implementation decision but...).  That said I don't really mind, I think
> my comment was more that if we're doing this the code should be explicit
> about what the intent is since right now it isn't obvious.  Either a
> comment or having an explicit "what method are we choosing" thing.
> 
> > That said, I'm not sure it's great to plumb this under the
> > arch_get_random*() interfaces, e.g. given this measn that
> > add_interrupt_randomness() will end up trapping to the host all the time
> > when it calls arch_get_random_seed_long().
> 
> > Is there an existing interface for "slow" runtime entropy that we can
> > plumb this into instead?
> 
> Yeah, I was wondering about this myself - it seems like a better fit for
> hwrng rather than the arch interfaces but that's not used until
> userspace comes up, the arch stuff is all expected to be quick.  I
> suppose we could implement the SMCCC stuff for the early variants of the
> API you added so it gets used for bootstrapping purposes and then we
> rely on userspace keeping things topped up by fetching entropy through
> hwrng or otherwise but that feels confused so I have a hard time getting
> enthusiastic about it.

I'm perfectly happy for the early functions to call this, or for us to
add something new firmwware_get_random_*() functions that we can call
early (and potentially at runtime, but less often than
arch_get_random_*()).

I suspect the easy thing to do for now is plumb this into the existing
early arch functions and hwrng.

Thanks,
Mark.
