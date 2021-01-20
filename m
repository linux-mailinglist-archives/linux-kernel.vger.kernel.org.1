Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F072FDBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbhATU6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:58:35 -0500
Received: from foss.arm.com ([217.140.110.172]:34950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732997AbhATNrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:47:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42EB2101E;
        Wed, 20 Jan 2021 05:46:13 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0493F66E;
        Wed, 20 Jan 2021 05:46:11 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:45:24 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
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
Message-ID: <20210120134524.0c47139a@slackpad.fritz.box>
In-Reply-To: <d2423ab6e44855846a8f61f327932784@kernel.org>
References: <20210106103453.152275-1-andre.przywara@arm.com>
        <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
        <d2423ab6e44855846a8f61f327932784@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 13:26:26 +0000
Marc Zyngier <maz@kernel.org> wrote:

Hi,

> On 2021-01-20 13:01, Will Deacon wrote:
> > On Wed, 6 Jan 2021 10:34:48 +0000, Andre Przywara wrote:  
> >> a fix to v5, now *really* fixing the wrong priority of SMCCC vs.
> >> RNDR in arch_get_random_seed_long_early(). Apologies for messing
> >> this up in v5 and thanks to broonie for being on the watch!
> >> 
> >> Will, Catalin: it would be much appreciated if you could consider 
> >> taking
> >> patch 1/5. This contains the common definitions, and is a
> >> prerequisite for every other patch, although they are somewhat
> >> independent and likely
> >> will need to go through different subsystems.
> >> 
> >> [...]  
> > 
> > Applied the first patch only to arm64 (for-next/rng), thanks!
> > 
> > [1/5] firmware: smccc: Add SMCCC TRNG function call IDs
> >       https://git.kernel.org/arm64/c/67c6bb56b649  
> 
> I can't see how the rest of the patches can go via any other tree
> if all the definitions are in the first one.
> 
> Andre, can you explain what your plan is?

Well, I don't really have a great solution for that, other than hoping
that 1/5 makes it into Linus' master at some point.

I see that it's a stretch, but pulling 1/5 into 5.11 now would
prepare the stage for the others to go via any tree, into 5.12-rc1?

Or you could maybe take both 1/5 and 5/5 into your kvm-arm tree, and
would hope that a git rebase later would sort this out for you?

But I think you are much more experienced in those kind of issues, so
happy to hear about any other solutions.

Thanks,
Andre
