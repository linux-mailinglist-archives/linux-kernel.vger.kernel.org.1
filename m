Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3064C299277
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786022AbgJZQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1776159AbgJZQcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:32:03 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6AA22450
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603729922;
        bh=KqSdKY+izZYAso/LodvdUpM0mIjxLgpRtbZFyE7+WXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RZlzALNJWEUYU8IvvwoaazV9B/nMKRCCUUhD1ITIdv4xvCsetSwZfw7zX8ouKLt5y
         pAWFAcb7bF7koQDiL3dC5lO9qIYPj/yz8kAk7dqU7uYUMLPbuK2a4oBjSmoNEC07yt
         csqEO5yHuFb/58mDklrysgT9kZaTtcLijhmWAQro=
Received: by mail-qt1-f182.google.com with SMTP id r8so7131283qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:32:02 -0700 (PDT)
X-Gm-Message-State: AOAM532uHrnWLrBYxdXK+qMObWYHXEALUJ3E5A5GHO5fRLrzhvJQOrvz
        NIMWaA4Hshqkfne2sVr7TZfGGotn3VZTrUImCZ4=
X-Google-Smtp-Source: ABdhPJxIS+LNv9KoIukM1F6ZgtabuCwPY9owwG2ywnHfUkFx59vnJRY6LwwN3KdlS4WyW3EyZ9azbF+RfeAeiuwwNGs=
X-Received: by 2002:ac8:7955:: with SMTP id r21mr7181469qtt.204.1603729921595;
 Mon, 26 Oct 2020 09:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160342.3705327-1-arnd@kernel.org> <20201026160342.3705327-4-arnd@kernel.org>
 <20201026162314.GA42396@C02TD0UTHF1T.local>
In-Reply-To: <20201026162314.GA42396@C02TD0UTHF1T.local>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 17:31:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1zWTj=Q6T0mSBYnk4qVMQfua1ZZTyAvfiZXpufkb_Hbw@mail.gmail.com>
Message-ID: <CAK8P3a1zWTj=Q6T0mSBYnk4qVMQfua1ZZTyAvfiZXpufkb_Hbw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: traps: fix -Woverride-init warnings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        James Morse <james.morse@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 5:23 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Oct 26, 2020 at 05:03:31PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > There are many warnings in this file when we re-enable the
> > Woverride-init flag:
> >
> > arch/arm64/kernel/traps.c:704:26: warning: initialized field overwritten [-Woverride-init]
> >   704 |  [ESR_ELx_EC_UNKNOWN]  = "Unknown/Uncategorized",
> >       |                          ^~~~~~~~~~~~~~~~~~~~~~~
> > arch/arm64/kernel/traps.c:704:26: note: (near initialization for 'esr_class_str[0]')
> > arch/arm64/kernel/traps.c:705:22: warning: initialized field overwritten [-Woverride-init]
> >   705 |  [ESR_ELx_EC_WFx]  = "WFI/WFE",
> >       |                      ^~~~~~~~~
> >
> > This is harmless since they are only informational strings,
> > but it's easy to change the code to ignore missing initialization
> > and instead warn about possible duplicate initializers.
>
> This has come up before, and IMO the warning is more hindrance than
> helpful, given the prevalance of spurious warnings, and the (again IMO)
> the rework needed to avoid those making the code harder to reason about.
>
> We use this pattern all througout the kernel (e.g. in the syscall
> wrappers), so unless the plan is to avoid this everywhere, I don't think
> that we should alter individual cases.

I have patches for all instances, yes.

> I also don't think that the Fixes tag is appropriate given the code is correct.

I tend to add fixes tags even for false-positive warnings, as they
are helpful whenever someone tries to backport the warning
suppression patch to older kernels. That could easily be dropped
here of course.

> Could we instead convince the compiler folk to give us better tools to
> deal with this? For example, if we could annotate assignmments as
> overridable or being an override, it'd be possible to distinguish the
> benign cases from bad ones, without forcing us to have dynamic checks.

There are only a handful of instances that need this, and half of these
are in arch/arm64/. I have another patch that disables the warning
locally in arch/arm64/kernel/{perf_event,sys,sys32}.c and
arch/arm64/kvm/handle_exit.c, but this needs some extra
infrastructure to make it possible to disable it for both gcc
and clang (which use different warning flags for it), so I did not
include the patch in this series.

I had also considered disabling the two warning flags for the
entire arch/arm64/kernel/ directory, but that seemed wrong
after I noticed the cpu_errata.c warnings that are indeed suspicious
and could lead to bugs when additional changes are made to
that file.

     Arnd
