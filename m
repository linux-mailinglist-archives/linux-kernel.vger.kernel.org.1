Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8C2FD1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbhATNYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:24:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbhATNQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:16:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F0A823371
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611148571;
        bh=87O7GrSH7aFNMKentPe/tHn88Y8PdtjVrGHyPMN/1Ks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nx/USp8x+a4VErW3+FrTdkcMiu71DTeVUy0+HRIQr3KRZoZ56eS19LkKj+BRzQB9B
         mgkkI4AxBYx6QWaTf45JAgLtrFUast2bjTzRk65ih2vbik7/0FNEhJhtnYGjZt6HQT
         da/O5wPcLe9wTkXtuCSaz93E50Vj3eET5tEdytU1F1rvjroXl5UNyfD3d09f6Nj6Zw
         BryR9RL/SCwVum6VXmBSd+F+UVcVIH6sjDfsng73Ng8BVteGwUjY2wlM3UuFgRs9VT
         0+v5uQwK8tdFhNFIIOBubt/WtYtb2uAS6j+9mc5sv8HNb5GQJ4OyAlN8S+smC5mdD8
         q+Gft8kAVVRZw==
Received: by mail-oi1-f179.google.com with SMTP id w124so24986812oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:16:11 -0800 (PST)
X-Gm-Message-State: AOAM531D2ODYriC9ZWJCYesoDk5FVs9LLW2M9JlO+iJ1t6IGzGqLnuxd
        yNtozNa3Is83JUrttdq0VgE+EKc1X1CXTqI/+uM=
X-Google-Smtp-Source: ABdhPJw8vZjz+ynYzeabDu0W9Mkp4ZmuPTi9i1w7KwilsqfguTeO6X1CqhyKq14F6BMDgjhUR8h2OGXCiTzK2zKrLAg=
X-Received: by 2002:aca:210f:: with SMTP id 15mr2800820oiz.174.1611148570568;
 Wed, 20 Jan 2021 05:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20210106103453.152275-1-andre.przywara@arm.com> <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
In-Reply-To: <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 Jan 2021 14:15:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHW4gPdWXc93eAYpHNU3H+Whg-n2mcEKX=Zro0nANhgSg@mail.gmail.com>
Message-ID: <CAMj1kXHW4gPdWXc93eAYpHNU3H+Whg-n2mcEKX=Zro0nANhgSg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] ARM: arm64: Add SMCCC TRNG entropy service
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 at 14:01, Will Deacon <will@kernel.org> wrote:
>
> On Wed, 6 Jan 2021 10:34:48 +0000, Andre Przywara wrote:
> > a fix to v5, now *really* fixing the wrong priority of SMCCC vs. RNDR
> > in arch_get_random_seed_long_early(). Apologies for messing this up
> > in v5 and thanks to broonie for being on the watch!
> >
> > Will, Catalin: it would be much appreciated if you could consider taking
> > patch 1/5. This contains the common definitions, and is a prerequisite
> > for every other patch, although they are somewhat independent and likely
> > will need to go through different subsystems.
> >
> > [...]
>
> Applied the first patch only to arm64 (for-next/rng), thanks!
>
> [1/5] firmware: smccc: Add SMCCC TRNG function call IDs
>       https://git.kernel.org/arm64/c/67c6bb56b649
>
> What's the plan for the rest of the series, and I think the related
> change over at [1]?
>

Given that Ted seems to have lost interest in /dev/random patches, I
was hoping [1] could be taken via the arm64 tree instead. Without this
patch, I don't think we should expose the SMCCC RNG interface via
arch_get_random_seed(), given how insanely often it will be called in
that case.

Note that the KVM patch implements the opposite end of this interface,
and is not affected by [1] at all, so that can be taken at any time.
