Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66F72D4BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbgLIUVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388201AbgLIUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:21:38 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205B9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 12:20:58 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id b9so4059482ejy.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aK0O6Cw1oeADRcE2fDIkx0Ub989jlKNAvqt9X/LiIpE=;
        b=wgbAK18+9b1vK3JJF81I/Nwg4DI8tjhX6atfMMbH8BQix9hS6qZbnian2u25s8isk5
         +WXu0Wuta9uxWc4RRnfqCNGrpEABKTAFbpX8Q31uxiO6QV7WyBuvZq8lJ9K5edstFVwh
         b0etdTgVT/PX9jX+1vCTzheRAC+qTqAbX1diA0FzmWWA8Byo2IviV0riMe0ojeZlaG+W
         wAeezKaYVTIftEyHbqIfSDbtJm4MzYMUiB9xT0mT5K9G2DponrIgjRZ0YuWWFI0A9HeI
         UvEWhcQ+pzgjsEBdROyZw88jZ3iMdzOV3xh32QqzySzSRHqQX9LUOpMKKy2jefUkTkDS
         S58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aK0O6Cw1oeADRcE2fDIkx0Ub989jlKNAvqt9X/LiIpE=;
        b=PJKtzhcYbkS95AYWuemhLE/lDumybGyTFyRLHQAERS6Xq8QnJ2ZXYJhESmrgR7+Kb7
         elSQgRlVkaDSaxv4p+LX0ifppq37AtsVQVMYftsVrDAehgT3qK53g7vpQIQKZo3RlL3Z
         laZdMX5wB6mt7Lm9jwavsogu4ZDKcfo7pzdX6rWyVOC4Rqk4QqeSvbvheSawlEe7nQ50
         /0fClWZGM7RIPzOOc7pXj4ic212lDf+419fBrzvaC8QykNktGzIPSqX8Lscp+e92Ob1F
         2D6no92zXcA5vbkTvvhRQVmBtFpSBmO1FCGqDjGwzDqHpyFHMz6ibUgxKdmNVpzKILVf
         A4Pw==
X-Gm-Message-State: AOAM533S+3kU0uVVnfXr2QO98/FZMvVvfQGIPPufcol88s6nciJY81Zb
        UWv6rwS9mASzgpspvnruFSYd5mU/Sc8iwVn2UzH2BA==
X-Google-Smtp-Source: ABdhPJxFXWxOGOdhpDOrfVLjnnzWmt/2E9U/6arUwQ4eTGf6ajZviI+L9zmeo+Ab8rs9gcK2GwhjI2yGPdUc0D7xUh0=
X-Received: by 2002:a17:906:1542:: with SMTP id c2mr3471397ejd.382.1607545256827;
 Wed, 09 Dec 2020 12:20:56 -0800 (PST)
MIME-Version: 1.0
References: <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com> <0d0eb6da6a11f76d10e532c157181985@kernel.org>
 <20201207163405.GD1526@gaia> <874kkx5thq.wl-maz@kernel.org>
 <20201208172143.GB13960@gaia> <7ff14490e253878d0735633b792e1ea9@kernel.org>
 <20201209124443.GB13566@gaia> <ef14a5158fc65c00f6c3c842cfa83b2c@kernel.org>
 <20201209152741.GC13566@gaia> <8c39b104-39c3-7cca-82b9-2e47d7cb9a9a@linaro.org>
 <20201209183920.GI13566@gaia> <6b9072fb-1232-e9fb-0b97-e69709980f99@linaro.org>
In-Reply-To: <6b9072fb-1232-e9fb-0b97-e69709980f99@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Wed, 9 Dec 2020 20:20:45 +0000
Message-ID: <CAFEAcA_K47jKSp46DFK-AKWv6MD1pkrEB6FNz=HNGdxmBDCSbw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Haibo Xu <haibo.xu@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 at 20:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/9/20 12:39 PM, Catalin Marinas wrote:
> >> I would have thought that the best way is to use TCO, so that we don't have to
> >> have dual mappings (and however many MB of extra page tables that might imply).
> >
> > The problem appears when the VMM wants to use MTE itself (e.g. linked
> > against an MTE-aware glibc), toggling TCO is no longer generic enough,
> > especially when it comes to device emulation.
>
> But we do know exactly when we're manipulating guest memory -- we have special
> routines for that.

Well, yes and no. It's not like every access to guest memory
is through a specific set of "load from guest"/"store from guest"
functions, and in some situations there's a "get a pointer to
guest RAM, keep using it over a long-ish sequence of QEMU code,
then be done with it" pattern. It's because it's not that trivial
to isolate when something is accessing guest RAM that I don't want
to just have it be mapped PROT_MTE into QEMU. I think we'd end
up spending a lot of time hunting down "whoops, turns out this
is accessing guest RAM and sometimes it trips over the tags in
a hard-to-debug way" bugs. I'd much rather the kernel just
provided us with an API for what we want, which is (1) the guest
RAM as just RAM with no tag checking and separately (2) some
mechanism yet-to-be-designed which lets us bulk copy a page's
worth of tags for migration.

thanks
-- PMM
