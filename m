Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333FF27A79B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgI1GgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgI1GgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:36:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E8C0613CE;
        Sun, 27 Sep 2020 23:36:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so56169edt.4;
        Sun, 27 Sep 2020 23:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nKB/odECC+5oqZhSa7bIP3FBFtIvg26fikzOMA8o1U=;
        b=hBmKYDc/kEi7zflj1bZ9+9WwU93fZ3m2wYbDRdaX9IGB3F3ZfNlsCEdoppa3RM7VVc
         DEiyc52dDgzqn0d9p1kTWZFRM3KK/magW2NJSSRG/xIjZEZdrp/dcVvtX3G85ekpcoz/
         l9/pccUo9GrE/5t8nqSkxTuFjcNa6M+Us2rPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nKB/odECC+5oqZhSa7bIP3FBFtIvg26fikzOMA8o1U=;
        b=Spc98KGvEPjcyS7HgUqjfHYJQAUxyDsoxgW8uweOWEokCK7DRUnlJGg7rzpRGxm+8A
         sz5E58jR8427Oocevdp1u63ufyCuZelYb4Iy1sSbf8fa+Pbu8hLfIUKVeuras+ig+ArR
         8WLlpdX0C+gnuUKGp4OXT+sb+mCHCsqfbWxR3KYUg6Kyx4OpXySMLBA1fRq2l6J3iJdL
         qM1CC6dXkw9FcG+XU9N80wfdLrV5oRkB95Bzg19TWemCguNTsykJ1cRHLpY7IZZYXu0S
         FTsHoQV+UFjw5PF12r3uEsmbNf2zQrsoSeF5CL2p6+E4KZKKYOUaRODaQ7+UDNk1Z1wM
         TLMA==
X-Gm-Message-State: AOAM533dxb+76jxCD1ADlD/AmgBa1NgH6BtJrq3VtXiEbV3Ky0XCTYbs
        c3jxL//EvHcoLGxC5AN4SUmU8t7u+qsIoX0WwXg=
X-Google-Smtp-Source: ABdhPJyD4DRT+j+TjKP/dgAT8V8/M4iWxU6Zg+ZnI6IDRF/j+WOqGaSTMSlUw9s0o0su2LDEv+FCRh0AwzTCUuWdcxY=
X-Received: by 2002:aa7:d7ca:: with SMTP id e10mr94667eds.191.1601274968942;
 Sun, 27 Sep 2020 23:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200923164730.176881-1-tmaimon77@gmail.com> <20200923164730.176881-4-tmaimon77@gmail.com>
In-Reply-To: <20200923164730.176881-4-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Sep 2020 06:35:56 +0000
Message-ID: <CACPK8Xfe9Bh_botSMPx72TPnDt_Ar_s+o6QcE_THrb07v4N-2w@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] arm: dts: add pinctrl and GPIO node to NPCM7XX
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 at 16:48, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add pin controller and GPIO node to NPCM7XX device tree.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 565 ++++++++++++++++++
>  1 file changed, 565 insertions(+)
>
> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> index 72e364054e72..5df77a617e77 100644
> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> @@ -185,4 +185,569 @@
>                         };
>                 };
>         };
> +
> +       pinctrl: pinctrl@f0800000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "nuvoton,npcm750-pinctrl", "syscon", "simple-mfd";
> +               ranges = <0 0xf0010000 0x8000>;
> +               status = "okay";

Nodes are enabled by default, so there's no need to add status="okay"
here. It's no biggie, you can fix it up in a follow up patch.

Reviewed-by: Joel Stanley <joel@jms.id.au>
