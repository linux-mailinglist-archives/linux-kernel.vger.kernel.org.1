Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205A02E9457
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbhADLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:51:31 -0500
Received: from foss.arm.com ([217.140.110.172]:60512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADLva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:51:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08B11FB;
        Mon,  4 Jan 2021 03:50:44 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17E3F3F70D;
        Mon,  4 Jan 2021 03:50:42 -0800 (PST)
Date:   Mon, 4 Jan 2021 11:49:54 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20210104114814.5e1fe218@slackpad.fritz.box>
In-Reply-To: <20201211162612.GF4929@sirena.org.uk>
References: <20201211160005.187336-1-andre.przywara@arm.com>
        <20201211160005.187336-5-andre.przywara@arm.com>
        <20201211162612.GF4929@sirena.org.uk>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 16:26:12 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 11, 2020 at 04:00:04PM +0000, Andre Przywara wrote:
> 
> >  static inline bool __must_check arch_get_random_seed_long(unsigned
> > long *v) {
> > +	struct arm_smccc_res res;
> > +
> > +	/*
> > +	 * We prefer the SMCCC call, since its semantics (return
> > actual
> > +	 * hardware backed entropy) is closer to the idea behind
> > this
> > +	 * function here than what even the RNDRSS register
> > provides
> > +	 * (the output of a pseudo RNG freshly seeded by a TRNG).
> > +	 */  
> 
> This logic...
> 
> > @@ -77,10 +117,20 @@ arch_get_random_seed_long_early(unsigned long
> > *v) {
> >  	WARN_ON(system_state != SYSTEM_BOOTING);
> >  
> > -	if (!__early_cpu_has_rndr())
> > -		return false;
> > +	if (__early_cpu_has_rndr())
> > +		return __arm64_rndr(v);
> > +
> > +	if (smccc_trng_available) {
> > +		struct arm_smccc_res res;
> >  
> > -	return __arm64_rndr(v);
> > +		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64,
> > &res);
> > +		if ((int)res.a0 >= 0) {
> > +			*v = res.a3;
> > +			return true;
> > +		}
> > +	}
> > +
> > +	return false;  
> 
> ...seems to also apply here but we prefer the RNDR instead of the
> SMCC. We probably want to either do the same thing or add a comment
> saying what's going on.

Argh, you are right, I missed to change this part as well.

Will send a fixed and rebased v5 ASAP.

Cheers,
Andre


