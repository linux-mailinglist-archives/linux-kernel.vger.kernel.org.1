Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE52C2FF170
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbhAURKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388393AbhAURKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:10:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA17F23A5A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611248963;
        bh=J9sLSBrU9hb4mIKGiZo00a1/NV2jBKZiWpKW1M26qj4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=StZ1hRPZlXlMl/uyJKraA4iaSYtiDV9HfiMy141VRYlyivPNw7ELfz/J+lv5Vhd9V
         WSo5/q0r2ga4bBvgpt1eNqQJwwcssTVrG4m/zQg9825UGIEzo8HR/OVwYvGDfJMQ8A
         6CRAEJ1kItoWtInpaGMVfDXQZ2nxRr5U5jl7mO2w0oHcAmFXr9jdZXFoRLA2ZnCQ9j
         KBpBxRes6gUIueWdLgaos4NxB+jjKQdyzSiNdeYeY4xHQWVD3wgZrDl9lMneQshYHb
         2KtVrhg8q4Ei6KDwbiaEWdZQ0Mf86hnY/EebL2GYPCnk2Pu41o9O2YQbCqhFBCH+W1
         XHHY51LXU7T1Q==
Received: by mail-ed1-f44.google.com with SMTP id h16so3360730edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:09:22 -0800 (PST)
X-Gm-Message-State: AOAM5301bWIAeGEZrhg1l28E4cnx6TR6+saZ3GTdAql+/78hksbu/Mw8
        JevaQ77UDnizzPanFOPwdq7QoKp5aBTaHyyf6Q==
X-Google-Smtp-Source: ABdhPJyJxp5MBbYxFzxkgYUIxAf0TzbC1KcTjT0BlKEd/RLbPE+2BdjNDA2uT4emWkBLvv2pQ5GRfs2aVnUqWSif1WQ=
X-Received: by 2002:a05:6402:1751:: with SMTP id v17mr75464edx.289.1611248961278;
 Thu, 21 Jan 2021 09:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com> <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
 <CAK8P3a3k7p3YK5DY3gTm0UaAgse41J7h_e-dN_NAjThPFE0tyw@mail.gmail.com> <d0eedc9e-2412-048a-9c7c-1e4a79aadb3b@marcan.st>
In-Reply-To: <d0eedc9e-2412-048a-9c7c-1e4a79aadb3b@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jan 2021 11:09:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKNcEd=WGYKcecwTSu=L_KY9HYiqJnsmRMFfo3geXLQbQ@mail.gmail.com>
Message-ID: <CAL_JsqKNcEd=WGYKcecwTSu=L_KY9HYiqJnsmRMFfo3geXLQbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
To:     "Hector Martin 'marcan'" <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 9:31 AM Hector Martin 'marcan' <marcan@marcan.st> wrote:
>
> On 21/01/2021 19.37, Arnd Bergmann wrote:
> > On Thu, Jan 21, 2021 at 10:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >>
> >> However weird it may seem, Apple is not in the file
> >> Documentation/devicetree/bindings/vendor-prefixes.yaml
> >
> > Since Apple are already using both the "AAPL" and the "apple"
> > prefix themselves, I have a bad feeling about reusing either of
> > them for defining the devicetree.org bindings that we add to
> > linux/Documentation/devicetree/bindings. The question is: if
> > not "apple", what else should we use here?
>
> This ties into the larger question of how we should handle devicetrees
> in general on these platforms.
>
> The two extremes are:
>
> 1) Have the bootloader outright convert ADT to FDT and make Linux
> support the entirety of Apple's devicetree structure, or
>
> 2) Maintain our own devicetrees and ignore Apple's entirely
>
> My feeling is that 1) is a non-starter, because Linux ARM device trees
> and Apple ARM device trees have seen independent evolution from the
> PowerPC era, and many details are completely different. Plus conversion
> is non-trivial, because the endianness is different and the format is
> too ambiguous to do programmatically without complex logic.

You are right it's a non-starter. Apple's DT even from PowerPC days
were weird and the hardware was much simpler then. Given we're still
maintaining that code I don't care to add what they've evolved on
their own over the last 15 years and support it for the next 20+ years
(given folks notice when we break 1998 era Macs).

> On the other hand, cranking out devicetrees by hand for every device
> variant that Apple puts out is a waste of time.
>
> Obviously at the bare minimum the bootloader will need to move some
> dynamic information from the ADT to the FDT, but that can be a very
> specific set of properties (memory layout, MAC addresses, etc).
>
> My current thinking is that we should write offline, automated tooling
> to parse, diff, and automatically convert portions of Apple devicetrees
> into Linux ones. Then we can more easily maintain our own, but still
> ultimately have humans decide what goes into the Linux device trees.

Seems reasonable.

> It's worth noting that AIUI Apple does not consider their devicetree
> layout to be stable, and it may change any time.

Yeah, also not something we want to support.

> On M1 devices, the
> devicetree is provided as part of the iBoot2 firmware bundle, which
> means it changes from one macOS version to the next (this is paired with
> the Darwin kernel itself, and they are upgraded as a unit). It includes
> placeholder values that iBoot2 then replaces with data from NOR before
> handing control over to the kernel. My goal for our long-term project
> [1] is to keep up with iBoot2 updates so that we do not have to instruct
> users to dig up old macOS versions.
>
> Quick TL;DR on how these things boot:
> - Boot ROM boots
> - iBoot1 (system firmware) in NOR flash which looks for a bootable OS in
> internal storage (only!) in the form of an APFS container+volume and
> then boots
> - iBoot2 (OS loader) which loads a bunch of firmware blobs and the
> devicetree off of storage, customizes it with system data from NOR, and
> then loads a wrapped mach-o file containing
> - A Darwin kernel, or in our case a Linux bootloader which then boots
> - A standard arm64 Linux blob
>
> The boot ROM is ROM. iBoot1 only ever rolls forward (downgrades
> impossible). iBoot2 downgrades are possible but Apple already proved
> they can break this willingly or not, at least in betas (macOS 11.2
> Beta2 iBoot1 cannot boot Beta1 iBoot2). The secureboot chain goes all
> the way up to the mach-o kernel load, that is the first point where we
> can change boot policy to load anything we want (with user consent).
>
> [1] https://asahilinux.org/
>
> --
> Hector Martin "marcan" (marcan@marcan.st)
> Public Key: https://mrcn.st/pub
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
