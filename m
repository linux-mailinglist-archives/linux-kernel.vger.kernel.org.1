Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07F926C583
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgIPRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIPQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45EC014D9D;
        Wed, 16 Sep 2020 06:14:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so10325239eja.2;
        Wed, 16 Sep 2020 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8c70bjdvGVrcsac+XpFC4DW7+UbOmn2FO+QEpKETtU=;
        b=Em6XgWp6dhDu4a2sVPZc1dCkrMGHLQvdRAi+t0cgxe6Z2wZ4BP+F/sVngK1Z+kkLis
         uDZT2tBXQlDep2WXS1WMr2OBzVgIravmSa/gd9+DJeWGuD3UOkJZyORqmQP4J/r90n4v
         6eHKLQdKoLYSbUpg/7FGjXbE/rwfe0Lu+ZEgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8c70bjdvGVrcsac+XpFC4DW7+UbOmn2FO+QEpKETtU=;
        b=OCrBy4njvaIemwLdftMBZepzDgfnCqZBCtjfrPAFXvbrKvRqbLfAHFMBfUQ7uKNaKF
         fJu7VLNmknEwfixQV5JK+OaT2IKIgnvU7wb9IPUYIcvzBuHbAOQqRoaJ5dF/W9W66pnv
         VxGetwQCrtZ6LKAIsG+TaV0in+UEFTUgDfLW5aag+EddHPS1R9y78es/A2HQSbkMb4xQ
         jIAkmu7raOhYwwuGuFaanMjE2lkmV/gF2wEKmdU3g+qLdrExjTjW2zeuLZ1emEIi7QD7
         WPeKjGL0ktwZvZjLzu1MJfU1S8gvOksfiuKY/2b97zoUTl+Ph99VbXCOt0lI+tQXO/Ia
         RX1Q==
X-Gm-Message-State: AOAM533yvlfXkQFykf2b+R7f7m8LwY2ksGN1drdj4rzJ0rhxhL5CTBrn
        DEGeL7uDVtUhZzdipw/VZteKGrm9JL2C1wg3V38=
X-Google-Smtp-Source: ABdhPJyEymYowEXN9Sqs2b7MV5IulS2sjphlMu8IRCGDHXmKJR9ZNsWTTJa6UtJWYJncIfBGvRQ86hfTja+eDRuW9Os=
X-Received: by 2002:a17:906:441:: with SMTP id e1mr2604781eja.396.1600262092781;
 Wed, 16 Sep 2020 06:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200916125554.195749-1-tmaimon77@gmail.com>
In-Reply-To: <20200916125554.195749-1-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Sep 2020 13:14:40 +0000
Message-ID: <CACPK8XcobhqHG1tQgjY2PH_Lvf3LLfzn7Ex=DVhBO58cUKv2jQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] arm: dts: add and modify device node in NPCM7xx
 device tree
To:     Tomer Maimon <tmaimon77@gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

On Wed, 16 Sep 2020 at 12:56, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> This patch set adds and modify device tree nodes in the NPCM7xx
> Baseboard Management Controller (BMC) device tree.

Thanks Tomer. I smoke tested these by booting on the npcm730 qemu
machine. Are you able to submit the gsj device tree (or get someone
who has worked on that to do so?) for inclusion too? Similarly for the
runbmc device tree.

We also lack a nuvoton configuration. We can submit one, or rely on
the multi_v7 for upstream testing. What would you prefer?

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

Does the STMMAC only appear in the 750 (and not the 730)? I was
wondering why it appeared in the 750 dtsi and not the common dtsi.

Cheers,

Joel

>
> The following device node modified:
>         - NPCM7xx timer.
>         - NPCM7xx clock constants parameters.
>
> NPCM7xx device tree tested on NPCM750 evaluation board.
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
> Tomer Maimon (3):
>   arm: dts: modify NPCM7xx device tree clock parameter
>   arm: dts: modify NPCM7xx device tree timer register size
>   arm: dts: add new device nodes to NPCM750 device tree
>
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 974 +++++++++++++++++-
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts     | 404 +++++++-
>  .../boot/dts/nuvoton-npcm750-pincfg-evb.dtsi  | 157 +++
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  24 +-
>  4 files changed, 1522 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi
>
> --
> 2.22.0
>
