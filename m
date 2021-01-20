Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B512FDBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbhATU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388405AbhATNtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:49:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C39DB23340;
        Wed, 20 Jan 2021 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611150550;
        bh=OQBSvzfYcwZS8/3ldKkX9veJ3pP4BOkdeXMVtbXLWHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXEB0doB0IG+whfzmKW+EqOYgTcjTpnzkM01FZLhyTA+fT2l/nEFEnI+2RCKZhCOq
         SNGCYfJt8iiec8OKZFmXshdk4ePw4zjx/L6ODtNYykOvULwgQTUyejhsnsofWDcE45
         dzErkqrPL9QmGSPhg/ysbAaOzNBQBcQrDsMftrKb+QZOVUQHEk9okilPFmVsDvAX8s
         cueYkL/tI1ZL4Di+y+JMl4IxxjgrjbMuM8xbOW1O3jynCRbmJM0jGxSB+PQ385EIzW
         oyUG/qBpV3UxONqwbYeE3a39365R1gAWZ1jyaszsuYeJE7JCQkJvCHkCzGq8yP0mxc
         wEGvXTQx/lBFg==
Date:   Wed, 20 Jan 2021 13:49:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kvmarm@lists.cs.columbia.edu,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Message-ID: <20210120134904.GA20315@willie-the-truck>
References: <20210106103453.152275-1-andre.przywara@arm.com>
 <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
 <d2423ab6e44855846a8f61f327932784@kernel.org>
 <20210120134524.0c47139a@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120134524.0c47139a@slackpad.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 01:45:24PM +0000, Andre Przywara wrote:
> On Wed, 20 Jan 2021 13:26:26 +0000
> Marc Zyngier <maz@kernel.org> wrote:
> 
> Hi,
> 
> > On 2021-01-20 13:01, Will Deacon wrote:
> > > On Wed, 6 Jan 2021 10:34:48 +0000, Andre Przywara wrote:  
> > >> a fix to v5, now *really* fixing the wrong priority of SMCCC vs.
> > >> RNDR in arch_get_random_seed_long_early(). Apologies for messing
> > >> this up in v5 and thanks to broonie for being on the watch!
> > >> 
> > >> Will, Catalin: it would be much appreciated if you could consider 
> > >> taking
> > >> patch 1/5. This contains the common definitions, and is a
> > >> prerequisite for every other patch, although they are somewhat
> > >> independent and likely
> > >> will need to go through different subsystems.
> > >> 
> > >> [...]  
> > > 
> > > Applied the first patch only to arm64 (for-next/rng), thanks!
> > > 
> > > [1/5] firmware: smccc: Add SMCCC TRNG function call IDs
> > >       https://git.kernel.org/arm64/c/67c6bb56b649  
> > 
> > I can't see how the rest of the patches can go via any other tree
> > if all the definitions are in the first one.
> > 
> > Andre, can you explain what your plan is?
> 
> Well, I don't really have a great solution for that, other than hoping
> that 1/5 makes it into Linus' master at some point.
> 
> I see that it's a stretch, but pulling 1/5 into 5.11 now would
> prepare the stage for the others to go via any tree, into 5.12-rc1?
> 
> Or you could maybe take both 1/5 and 5/5 into your kvm-arm tree, and
> would hope that a git rebase later would sort this out for you?
> 
> But I think you are much more experienced in those kind of issues, so
> happy to hear about any other solutions.

for-next/rng is a stable branch, so anybody who wants the first patch can
just pull it (without anything I queue on top).

Will
