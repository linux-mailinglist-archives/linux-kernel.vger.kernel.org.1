Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2762FF2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389473AbhAUSCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388958AbhAURzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:55:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 414C621973;
        Thu, 21 Jan 2021 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251665;
        bh=UoorRMvSGUceggy9m7jQ580i3cz0aYpDS1TAbvR/rEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A08rRJRbcUEexudiHrvqmX6AgJwLL+HJOEIqjMdYrhGPSBMaRSmAp77HRfl/uEhJr
         GDgqkSHYixgVJ6aZ3/d1//Rqo7o8dspi6AgBkV92oCVtU8OZWeDquOIjJBQlyHr9Jv
         enuXyQFtAe1WvTAfA036bxCKVyOZtMOix7roLxWNR7rWsvWNXsmSt56F0bXEfuzusc
         QjCarXuyOSzhmmsrD1QJxh3oASray65OGKXi5FJGAHdHBjt5uDnPGZOED7AjUNYlps
         u58NTQShoDQr6IoCETUMwnJNU8EemE1sc/ErtHbnwHv4ZF969qqtAg1Ib3doLCmeSp
         wp85wTVhx/DZg==
Date:   Thu, 21 Jan 2021 17:54:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Message-ID: <20210121175419.GA22963@willie-the-truck>
References: <20210106103453.152275-1-andre.przywara@arm.com>
 <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
 <CAMj1kXHW4gPdWXc93eAYpHNU3H+Whg-n2mcEKX=Zro0nANhgSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHW4gPdWXc93eAYpHNU3H+Whg-n2mcEKX=Zro0nANhgSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:15:59PM +0100, Ard Biesheuvel wrote:
> On Wed, 20 Jan 2021 at 14:01, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, 6 Jan 2021 10:34:48 +0000, Andre Przywara wrote:
> > > a fix to v5, now *really* fixing the wrong priority of SMCCC vs. RNDR
> > > in arch_get_random_seed_long_early(). Apologies for messing this up
> > > in v5 and thanks to broonie for being on the watch!
> > >
> > > Will, Catalin: it would be much appreciated if you could consider taking
> > > patch 1/5. This contains the common definitions, and is a prerequisite
> > > for every other patch, although they are somewhat independent and likely
> > > will need to go through different subsystems.
> > >
> > > [...]
> >
> > Applied the first patch only to arm64 (for-next/rng), thanks!
> >
> > [1/5] firmware: smccc: Add SMCCC TRNG function call IDs
> >       https://git.kernel.org/arm64/c/67c6bb56b649
> >
> > What's the plan for the rest of the series, and I think the related
> > change over at [1]?
> >
> 
> Given that Ted seems to have lost interest in /dev/random patches, I
> was hoping [1] could be taken via the arm64 tree instead. Without this
> patch, I don't think we should expose the SMCCC RNG interface via
> arch_get_random_seed(), given how insanely often it will be called in
> that case.

Ok, let's give that a shot -- I'll additionally pick patches 2 and 4 out
of this series, and merge in the /dev/random change on its own branch in
case there are any late objections.

Will
