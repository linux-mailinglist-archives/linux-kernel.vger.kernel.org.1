Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C122A8050
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgKEOD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:03:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgKEOD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:03:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED82614BF;
        Thu,  5 Nov 2020 06:03:27 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78F9C3F719;
        Thu,  5 Nov 2020 06:03:25 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:03:22 +0000
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
Message-ID: <20201105140322.GH82102@C02TD0UTHF1T.local>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com>
 <20201105134142.GA4856@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105134142.GA4856@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 01:41:42PM +0000, Mark Brown wrote:
> On Thu, Nov 05, 2020 at 12:56:55PM +0000, Andre Przywara wrote:
> 
> >  static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> >  {
> > +	struct arm_smccc_res res;
> >  	unsigned long val;
> > -	bool ok = arch_get_random_seed_long(&val);
> >  
> > -	*v = val;
> > -	return ok;
> > +	if (cpus_have_const_cap(ARM64_HAS_RNG)) {
> > +		if (arch_get_random_seed_long(&val)) {
> > +			*v = val;
> > +			return true;
> > +		}
> > +		return false;
> > +	}
> 
> It isn't obvious to me why we don't fall through to trying the SMCCC
> TRNG here if for some reason the v8.5-RNG didn't give us something.
> Definitely an obscure possibility but still...

I think it's better to assume that if we have a HW RNG and it's not
giving us entropy, it's not worthwhile trapping to the host, which might
encounter the exact same issue.

I'd rather we have one RNG source that we trust works, and use that
exclusively.

That said, I'm not sure it's great to plumb this under the
arch_get_random*() interfaces, e.g. given this measn that
add_interrupt_randomness() will end up trapping to the host all the time
when it calls arch_get_random_seed_long().

Is there an existing interface for "slow" runtime entropy that we can
plumb this into instead?

Thanks,
Mark.
