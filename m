Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BBA285E58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgJGLlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGLlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:41:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A72C061755;
        Wed,  7 Oct 2020 04:41:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so1975774ilh.3;
        Wed, 07 Oct 2020 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N17VnEsIu34Gcj2d92AACCPEjaWw1N9Hkf92JAEgEGA=;
        b=ibADa4c8zVbJ1vvahEOvd4VRx65VbYoBfkSfKuyVM/p90Nvkf4BstfrPncVCec4iSP
         aLPjZYqG216hpe9L4hi07Q7o0F+X6Ay/6qFBNyQBG/TzpdJeIQPLMp195OVEN1y9PDM5
         IAw+u+ZrPdUvCwZ2qZnyf6SnlbMU/A29lWG70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N17VnEsIu34Gcj2d92AACCPEjaWw1N9Hkf92JAEgEGA=;
        b=HMubA+jPadV0bPqmRbvbFfh0IRs7xE3CZ1dVqIFKZrxkfZhdbTY097+kiPHakCYqsT
         o1QIex1PakqLHnIO9YmiAbWMPvEz8L8WbQiXGd2NrhQqqegi9Ihoc0ioX6vrRhVi434J
         L31wivSAPtwLhpI6Jf8besPxrRLJDHfGuXvflTUMhgR1HdQQlIvUJjUoiTct6L4eDGcK
         Gcp2krtOSZYS2eKnkm8xLzI0TeA436p5CrPhQhIrl7I5INExMCFzco6siV7VV5GfuGH3
         1SejYg61NZ2WCHiHnw2Kqv9EJU4XjhqFJ/2HD7gUdIBGGECyOEMGK6d661qqxJoow3BB
         0OTw==
X-Gm-Message-State: AOAM531+CKzf/5+ruwl5CeP1ANEKPgN7xdqTd/HGIBaIv5ZtMw52vdI7
        NPWCdbSIpTApgZ8f2ACGZOpbhnaDz+oPGcrqi/c=
X-Google-Smtp-Source: ABdhPJz/r+ehlkOPdveObjrNrhT5nYGNLW4liBrZy4oEKvHxdCFDeWOtreukGOby4kV2yT+CQWXcCXIWhuxEs+X12ao=
X-Received: by 2002:a05:6e02:66b:: with SMTP id l11mr2352022ilt.14.1602070891264;
 Wed, 07 Oct 2020 04:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200929131807.15378-1-tmaimon77@gmail.com>
In-Reply-To: <20200929131807.15378-1-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 7 Oct 2020 11:41:19 +0000
Message-ID: <CACPK8Xch0KJW80-ehYxaY=p-OYtx2KWUkMAn8oE_FiqAA-y5yg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] arm: dts: add and modify device node in NPCM7xx
 device tree
To:     Tomer Maimon <tmaimon77@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, arm <arm@kernel.org>,
        SoC Team <soc@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arm/SoC maintainers,

On Tue, 29 Sep 2020 at 13:18, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> This patch set adds and modify device tree nodes in the NPCM7xx
> Baseboard Management Controller (BMC) device tree.

This series has been reviewed by myself and we would like to see it
merged for 5.10.

Tomer isn't set up to send pull requests himself at this stage, so I
can send you a pull request (and perhaps continue doing so in the
future, as the "BMC maintainer"). Alternatively if you could merge
this series directly that would be appreciated.

Let me know what you would prefer.

Cheers,

Joel

>
> The following device node add:
>         - NPCM7xx Pin controller and GPIO
>         - NPCM7xx PWM and FAN.
>         - NPCM7xx EHCI USB.
>         - NPCM7xx KCS.
>         - NPCM Reset.
>         - NPCM Peripheral SPI.
>         - NPCM FIU SPI.
>         - NPCM HWRNG.
>         - NPCM I2C.
>         - STMicro STMMAC.
>
> The following device node modified:
>         - NPCM7xx timer.
>         - NPCM7xx clock constants parameters.
>
> NPCM7xx device tree tested on NPCM750 evaluation board.
>
> Changes since version 7:
> Address comments from Joel Stanely: https://www.spinics.net/lists/devicetree/msg380191.html
>
> Changes since version 6:
> Split commits.
>
> Changes since version 5:
> Address comments from Joel Stanely: https://lkml.org/lkml/2020/9/16/994
>
> Changes since version 4:
>  - Tested patches in Linux kernel 5.9.
>
> Changes since version 3:
>  - Tested patches in Linux kernel 5.6.
>
> Changes since version 2:
>  - Remove unnecessary output-enable flags.
>
> Changes since version 1:
>  - Add NPCM reset device node.
>  - Add reset parameters to NPCM driver device nodes.
>
>
> Tomer Maimon (5):
>   arm: dts: modify NPCM7xx device tree clock parameter
>   arm: dts: modify NPCM7xx device tree timer register size
>   arm: dts: add pinctrl and GPIO node to NPCM7XX device tree
>   arm: dts: add new device nodes to NPCM7XX device tree
>   arm: dts: add new device nodes to NPCM750 device tree EVB
>
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 967 +++++++++++++++++-
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts     | 367 ++++++-
>  .../boot/dts/nuvoton-npcm750-pincfg-evb.dtsi  | 157 +++
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  24 +-
>  4 files changed, 1495 insertions(+), 20 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi
>
> --
> 2.22.0
>
