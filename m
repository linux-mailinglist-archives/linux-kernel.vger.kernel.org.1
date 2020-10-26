Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6342996D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793019AbgJZT3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771819AbgJZT3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:29:03 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C42821D42
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603740542;
        bh=wKLuiDvbV+H9f9Lf4+bBeVrz2CN0uM9OknzCnUeSXiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aa4n+Zd9KKttNz7z3Hgjrd0nb0/NZl5XwWUujz8lKPDFdZsNFNcQAai7TgSMI2rQs
         RGROAIUAN71t6EsIO66vtjq89tnkzL0nZbF11KZXQqi6ZwSQGHpDhbWms/EFqvViUK
         sQHmhQbpLGt6Tr3B0Wl2gcK2zasdPci31VHWZA7A=
Received: by mail-qk1-f181.google.com with SMTP id j129so5670492qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:29:02 -0700 (PDT)
X-Gm-Message-State: AOAM533FF3bj7/nUp4Pg3Zwa8FqG7mokMI+8IxQSKHVh9/cGPFIa8O5D
        G3h4ga7Qnibk7vCEexW6tH5hn3wlJQmykYRyYmo=
X-Google-Smtp-Source: ABdhPJxnbNtqMVedK+/vljrAMaqm/Td4F7tIaHM7EtyAyWHxO9Jiz0tHpvvDFNawO+JJ3wxO/umIpw06HyNO56M/4D0=
X-Received: by 2002:a05:620a:215d:: with SMTP id m29mr19431094qkm.138.1603740541104;
 Mon, 26 Oct 2020 12:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160342.3705327-1-arnd@kernel.org> <20201026160342.3705327-4-arnd@kernel.org>
 <20201026162314.GA42396@C02TD0UTHF1T.local> <CAFEAcA_sA+sAneWwi8ZtN1WmHhcHte0k_3_JcDybYWviW_18qg@mail.gmail.com>
 <20201026172737.GA25131@willie-the-truck>
In-Reply-To: <20201026172737.GA25131@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 20:28:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1mcNwCn-7fgujyQGrDAXR1ZJnEdPchAGUsegQtnSHabw@mail.gmail.com>
Message-ID: <CAK8P3a1mcNwCn-7fgujyQGrDAXR1ZJnEdPchAGUsegQtnSHabw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: traps: fix -Woverride-init warnings
To:     Will Deacon <will@kernel.org>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        James Morse <james.morse@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 6:27 PM Will Deacon <will@kernel.org> wrote:
> On Mon, Oct 26, 2020 at 05:13:30PM +0000, Peter Maydell wrote:
> > On Mon, 26 Oct 2020 at 16:23, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Mon, Oct 26, 2020 at 05:03:31PM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > There are many warnings in this file when we re-enable the
> > > > Woverride-init flag:
> > > >
> > > > arch/arm64/kernel/traps.c:704:26: warning: initialized field overwritten [-Woverride-init]
> > > >   704 |  [ESR_ELx_EC_UNKNOWN]  = "Unknown/Uncategorized",
> > > >       |                          ^~~~~~~~~~~~~~~~~~~~~~~
> > > > arch/arm64/kernel/traps.c:704:26: note: (near initialization for 'esr_class_str[0]')
> > > > arch/arm64/kernel/traps.c:705:22: warning: initialized field overwritten [-Woverride-init]
> > > >   705 |  [ESR_ELx_EC_WFx]  = "WFI/WFE",
> > > >       |                      ^~~~~~~~~
> > > >
> > > > This is harmless since they are only informational strings,
> > > > but it's easy to change the code to ignore missing initialization
> > > > and instead warn about possible duplicate initializers.
> > >
> > > This has come up before, and IMO the warning is more hindrance than
> > > helpful, given the prevalance of spurious warnings, and the (again IMO)
> > > the rework needed to avoid those making the code harder to reason about
> >
> > FWIW in QEMU we turn the clang version of this off with
> > -Wno-initializer-overrides because we agree that the code is
> > fine and the compiler is being unhelpful in this case. (There's
> > a reason gcc doesn't put it in -Wall.)
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91688 is a request
> > for something that would catch bugs without breaking ranged-array
> > initializer syntax usage, but the gcc devs don't seem to have
> > responded.
>
> Yes, I'm inclined to agree. The code is fine, and "fixing" it just leads to
> churn and the possible introduction of bugs.

Ok, shall we just disable it for all of arch/arm64/kernel then?
The other parts of the kernel that follow the same line of thinking
are drivers/gpu/drm/amd/ and drivers/ata, for which I already
just turn them off. The rest of the kernel is mostly clean for
the warning, or there are actual bugs that it finds.

       Arnd
