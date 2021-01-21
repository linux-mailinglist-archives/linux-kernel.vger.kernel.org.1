Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD302FE908
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbhAULkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbhAULjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:39:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3374020637
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611229141;
        bh=8Mrped0dqosEfHBS5NkF/32JfKc48YzZz11ccq0r9/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o4bQmM5EWoyBQDGPngnEWX3GCCk+7yMzZj3tM9stml5iM0nDO6isCm8eoILCOuLKq
         aeiyFgMlnq+iF6ioPa7g1sdRa/DdTO5smxBr02N7xiTbmHA4IRZnuZ7FmqLeZlKeer
         4ZRzKVu1q+IkLT9I0w2ZUiF1usVwXEAfvlEH9nB5IjFOQxIng4DY+17XI5eGCI91pB
         jtHgKSbfSzIqlAtvcXF9D/OGESrUe+Bj91Y/zXf7x0wCd2o1FpQTe9yTVuT2Qn9ryw
         B0L5lJagQ1lHqBpb4E4vFVLV0YkA9ftAdi0MGTZMpKvQSD3HyLZVuBdDlSIpCygXsZ
         AtuybR/XTGoug==
Received: by mail-oo1-f42.google.com with SMTP id y14so406970oom.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:39:01 -0800 (PST)
X-Gm-Message-State: AOAM531Tjtu1YJehgyr3E/7oVPeExGgnhDirbPVMSPrlbkPEIIKZo/Jh
        FPGrSzZw7z7obs2lr6DAm3nrJa14zairc5qcGD4=
X-Google-Smtp-Source: ABdhPJzOqMsrGPXVP1Jfm6P+8sPMW/UzyzkppZN9jSQuPFMKi2Q+z5HPdxIklLxttv9TSE5iIZNjyZ0hHgEoV56TlxA=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr9152302ooj.15.1611229140456;
 Thu, 21 Jan 2021 03:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com> <20210121112725.GA21750@willie-the-truck>
In-Reply-To: <20210121112725.GA21750@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 12:38:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0mp93afoWHnYiJ0B4uGQCG4q4W4A-O0+Cj8nCd6nL8dg@mail.gmail.com>
Message-ID: <CAK8P3a0mp93afoWHnYiJ0B4uGQCG4q4W4A-O0+Cj8nCd6nL8dg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple processors
To:     Will Deacon <will@kernel.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:32 PM Will Deacon <will@kernel.org> wrote:
> On Wed, Jan 20, 2021 at 02:27:13PM +0100, Mohamed Mediouni wrote:
> > Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious hardware quirk.
> >  /*
> >   * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
> >   * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> > @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
> >        * Memory region attributes
> >        */
> >       mov_q   x5, MAIR_EL1_SET
> > +#ifdef CONFIG_ARCH_APPLE
> > +     mrs     x0, MIDR_EL1
> > +     lsr     w0, w0, #24
> > +     mov_q   x1, MAIR_EL1_SET_APPLE
> > +     cmp     x0, #0x61                       // 0x61 = Implementer: Apple
> > +     csel    x5, x1, x5, eq
>
> Why does this need to be done so early? It would be a lot cleaner if we
> could detect this in a similar fashion to other errata and update the MAIR
> appropriately. If that's not possible because of early IO mappings (which
> ones?), then we could instead initialise to nGnRnE unconditionally, but
> relax it to nGnRE if we detect that we _don't_ have the erratum.

There is (at least) the custom SMP startup code that uses device
mappings. If that's the only thing that needs the modified MAIR
to be used early, I'd consider that one more reason against doing the
custom cpu_operations for now.

       Arnd
