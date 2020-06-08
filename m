Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122F91F13DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 09:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgFHHtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 03:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgFHHt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:49:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE673C08C5C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:49:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c12so9593997lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37K4gneCiuRGulLCKf4ynFvMW4e68flpa0GiDzEnHyg=;
        b=uLi1RmjhtH1FlDsw82tNk1UEqMah3505zWAqYW0iJnhsR3ofTEhFjqgg0bqVnddqZT
         wAxQu3f3tLu0IjoYRj/q5xCx5ttN12X/9cS1LPWtvPhLhxvS2znXsVPeT1APIbqa6lNe
         A4/si6/ECFxjTPLdooQi+BUYuS9FxroIrzWRnwuzUiDLj5axLDtmFK/fgmAKdII++gN0
         8H+slUd3WPMJbncGutqkddXFKaG9mJrXn4b9AcUYLERHHIRVN1uuOFicsU96UPRjItfA
         1eA5C+72CB02PbahRX0V2G87TOjsr01aUEtMLxh5bPLhc8KL2wa6RaC1xoAyU4lcJ6mb
         7heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37K4gneCiuRGulLCKf4ynFvMW4e68flpa0GiDzEnHyg=;
        b=WdRsKYrdgNkUzzqjHCxmfGAy97s/8m1Tqsh1Oqm3GSKBadxWt57qqsoQYCbmlSB/t2
         uY8J5688RpCljhlqhm0cGQPUdA6aME978RdOjJFqmtrHMw0UZtaS6PxTX/FnoNmzFE0z
         AmsazkfeCQm8kjJ8r1x37WPSX7CDL1zjq5rmjPw/po/E1ZSxMbNXOFmWehw33k3H98mR
         06B1M7IS5cBXNfC/WdPnFoTBxKY4TGGJLndDVYliNKGLaLbCsFZoJLZc0WrhtHOwjrg2
         +/mFRwTqWZFFor8wyeVtxfOmjNOSgvPhqM2fs2JB//CHwpMkK3OVHdvD1ioFB25S6JJf
         /nGA==
X-Gm-Message-State: AOAM533cTNKuiiZ3wSieBYo+esK1cjXE8IimfmhlOGluRP+E/aZqgVyM
        rvIMFUzUj2iNDoBdyI717I3e1QD/HWtKICZAyRPDLQ==
X-Google-Smtp-Source: ABdhPJwxrOl8NL4ByK/Pfp55vHI3T08O8KOMm+uol36pOuMBluSdlFqIghiVrQxdlv6OnTL4mJMgM/2GivNrvUhScRE=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr11864445lfn.21.1591602567899;
 Mon, 08 Jun 2020 00:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <1591085678-22764-1-git-send-email-neal.liu@mediatek.com>
 <CAMj1kXHjAdk5=-uSh_=S9j5cz42zr3h6t+YYGy+obevuQDp0fg@mail.gmail.com>
 <85dfc0142d3879d50c0ba18bcc71e199@misterjones.org> <1591169342.4878.9.camel@mtkswgap22>
 <fcbe37f6f9cbcde24f9c28bc504f1f0e@kernel.org> <20200603093416.GY1551@shell.armlinux.org.uk>
 <1591341543.19510.4.camel@mtkswgap22> <20200605080905.GF1551@shell.armlinux.org.uk>
 <1591347582.21704.9.camel@mtkswgap22>
In-Reply-To: <1591347582.21704.9.camel@mtkswgap22>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 8 Jun 2020 13:19:16 +0530
Message-ID: <CAFA6WYNqWmhiz=wvCTt1ubMtrhf+RtFSC2GiQQeteEbmrF1EnQ@mail.gmail.com>
Subject: Re: Security Random Number Generator support
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Julius Werner <jwerner@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Sean Wang <sean.wang@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?Q3J5c3RhbCBHdW8gKOmDreaZtik=?= <Crystal.Guo@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neal,

On Fri, 5 Jun 2020 at 14:40, Neal Liu <neal.liu@mediatek.com> wrote:
>
> On Fri, 2020-06-05 at 09:09 +0100, Russell King - ARM Linux admin wrote:
> > On Fri, Jun 05, 2020 at 03:19:03PM +0800, Neal Liu wrote:
> > > On Wed, 2020-06-03 at 17:34 +0800, Russell King - ARM Linux admin wrote:
> > > > This kind of thing is something that ARM have seems to shy away from
> > > > doing - it's a point I brought up many years ago when the whole
> > > > trustzone thing first appeared with its SMC call.  Those around the
> > > > conference table were not interested - ARM seemed to prefer every
> > > > vendor to do off and do their own thing with the SMC interface.
> > >
> > > Does that mean it make sense to model a sec-rng driver, and get each
> > > vendor's SMC function id by DT node?
> >
> > _If_ vendors have already gone off and decided to use different SMC
> > function IDs for this, while keeping the rest of the SMC interface
> > the same, then the choice has already been made.
> >
> > I know on 32-bit that some of the secure world implementations can't
> > be changed; they're burnt into the ROM. I believe on 64-bit that isn't
> > the case, which makes it easier to standardise.
> >
> > Do you have visibility of how this SMC is implemented in the secure
> > side?  Is it in ATF, and is it done as a vendor hack or is there an
> > element of generic implementation to it?  Has it been submitted
> > upstream to the main ATF repository?
> >
>
> Take MediaTek as an example, some SoCs are implemented in ATF, some of
> them are implemented in TEE.

In case your TEE implementation is derived from OP-TEE, then I will
suggest you to re-use OP-TEE based RNG driver [1]. With that, you just
need to implement an OP-TEE based pseudo trusted application (similar
to this [2]) specific to your platform and need to extend driver UUID
config table [3] with UUID of your platform specific pseudo TA. This
way you can avoid using hardcoded DT based SMC approach and rather use
auto RNG device detection provided by TEE bus.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/hw_random/optee-rng.c
[2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-synquacer/rng_pta.c
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/hw_random/optee-rng.c#n273

-Sumit

> We have no plan to make generic
> implementation in "secure world".
>
> Due to there must have different implementation in secure world for
> vendors, we plan to provide a generic SMC interface in secure rng kernel
> driver for more flexibility.
>
> Vendors can decide which "secure world" they want (HYP/ATF/TEE) by
> different smc/hvc and different SMC function IDs in DT node.
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
