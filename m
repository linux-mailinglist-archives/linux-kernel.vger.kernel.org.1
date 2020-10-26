Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F5729937C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787429AbgJZRNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:13:46 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40591 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787422AbgJZRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:13:45 -0400
Received: by mail-ej1-f68.google.com with SMTP id z5so14707881ejw.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q344x5M+j9q5rD8RKqBuwct2DyKHYIsxdy+T4ORm+ME=;
        b=Wo2wngeDQUUf+SWA2+JVIwlalaUpWDXoyLSIFVGR3ngAy3gkOC/SCTYJUbYAx+EwBi
         97HdTFqAxvvyBKl3E+stm6ut6gilueCELGyez/ILdlyd+O/GZi5r2yFAPaiKuNlSrV5C
         1fWZA4AblyKtsHRwThNydP/SsKGLuNobal8JZzr+EzNOsf38E7M8wDIo8dvkGtIUvTP6
         0cOelj5eBuYPC1GRPzpJt/M7bjU1tK3Mi7zrje0TIlQQZ40gWNkyBs+7sCtuDq6UOkrg
         KalQtWp2D9MZhIjyCgajC1qQipWyA6vmbPb7RhK+Ui11LhNYaFxcjZhK93HDH3FCdWzr
         Uctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q344x5M+j9q5rD8RKqBuwct2DyKHYIsxdy+T4ORm+ME=;
        b=PQ3RhD1mR8KEG330Kt6A9twfV0PRvE2/ruhmgcV03jEaAoOd4CYQS8gNzPh2gUkE1u
         Ilm/zrIG3HuCJDMOs6xb60mTI8bt6/LuhLgRCF3KYa0GOmd3Vy8v44UOkFcbKQulq+BI
         T8zUoGfwnhuRks2WttEP2gsSr/S+Ad0qpL+4JRYlLwq3GNbhyVk0EniBtG4eXlU+1G39
         U1fQDw0Edy7EoJT9ouCLo4k5QU6KthxeWblPgLR0efQtzDDMiMdpAhxZWoRV6mVoePF7
         JnyYDzb6RLdm9T3vwcojRo1JKRZvlPx94TpWvsM2xfhtmhhfYehT/tx/GvEH4Meur4b0
         ta1w==
X-Gm-Message-State: AOAM5312tRRG9NZGMzC9tl5HFPEgCUmkjGk+7jmoT+P3ixSbeik28AUN
        sfG5iRNIhncZkdyy5TQIxp0sGYxvlyOM6Jt+O9nvBQ==
X-Google-Smtp-Source: ABdhPJwM98Nn+r4/6Nr2VTfFw2AdZGGLTeRyz1PQS48uDuLyhfzldAbmnek6NaG2HnjSN6L+83fvxYrnK1BiMYA/bJA=
X-Received: by 2002:a17:906:1f42:: with SMTP id d2mr16301933ejk.407.1603732422400;
 Mon, 26 Oct 2020 10:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160342.3705327-1-arnd@kernel.org> <20201026160342.3705327-4-arnd@kernel.org>
 <20201026162314.GA42396@C02TD0UTHF1T.local>
In-Reply-To: <20201026162314.GA42396@C02TD0UTHF1T.local>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 26 Oct 2020 17:13:30 +0000
Message-ID: <CAFEAcA_sA+sAneWwi8ZtN1WmHhcHte0k_3_JcDybYWviW_18qg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: traps: fix -Woverride-init warnings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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

On Mon, 26 Oct 2020 at 16:23, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Arnd,
>
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
> the rework needed to avoid those making the code harder to reason about

FWIW in QEMU we turn the clang version of this off with
-Wno-initializer-overrides because we agree that the code is
fine and the compiler is being unhelpful in this case. (There's
a reason gcc doesn't put it in -Wall.)
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91688 is a request
for something that would catch bugs without breaking ranged-array
initializer syntax usage, but the gcc devs don't seem to have
responded.

thanks
-- PMM
