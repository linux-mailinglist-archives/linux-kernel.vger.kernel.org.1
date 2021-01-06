Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0842EBBFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbhAFJ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:56:02 -0500
Received: from foss.arm.com ([217.140.110.172]:38140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbhAFJ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:56:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFD711FB;
        Wed,  6 Jan 2021 01:55:14 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044EE3F719;
        Wed,  6 Jan 2021 01:55:12 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:54:32 +0000
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
Subject: Re: [PATCH v5 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20210106095432.26e5b86d@slackpad.fritz.box>
In-Reply-To: <20210105170014.GG4487@sirena.org.uk>
References: <20210105163652.23646-1-andre.przywara@arm.com>
        <20210105163652.23646-5-andre.przywara@arm.com>
        <20210105170014.GG4487@sirena.org.uk>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 17:00:14 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Jan 05, 2021 at 04:36:51PM +0000, Andre Przywara wrote:
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
> 
> This still seems to be preferring RNDR over SMCCC for the early seed
> unless I'm misreading the diff?

Argh, my apologies for that blunder. I *did* change it, but must have
lost it when rebasing against my debug patches.
Will send a fixed version in a jiffy.

Cheers,
Andre.

