Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B505D2B9AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgKSSk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgKSSk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:40:28 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:40:28 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id a19so484457ilm.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvBOcBzyg+eaLhpr35x3ip38QjdZlKmVc5mM+8taPHE=;
        b=C6mhW7KCNFK2+hF2yTFbwgR4Hb2BSiSkENk1iQgAHCifiyZwkapsVC6SULC6UZ5/5Q
         MuxYOBRSLZ2fOcfQyIMgYaJXGn+LgYjGrkIaQNPr6qyDRYr4ITWlcE0SLbBGZbhJXwwS
         hWzTlYMWnMHUTXTprJASQTlPO6Pf0h6kpIYdVbDvAqCepDAl3g2S5TVAIoPWPB6wQcLw
         QhD3yYh6J0USuXo7o3gIYzhPHFpc22mK0CNSwTGssQ405lzyGfS31oq5WZxKiTjJoc70
         02FuPV42opH7PSClyZSKhr+0bPC71r0TnddDkAKLNpk0xZvUhGR0PGCH13Q7WQBC6aJU
         AHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvBOcBzyg+eaLhpr35x3ip38QjdZlKmVc5mM+8taPHE=;
        b=CKwqd2epTKy+VG4f6lm9ZL0NNDRFEmNU3vKgM5abPDK0HaRiwEKBgOIib/rWOT8yGx
         5UO8uVhEoIXZ33S7JHNKts3sjvYQNMqep4C8ViqLB96ZNZ5cbuIbTVsU6i5JDU6ovTr5
         pRqYCUM4LIQIMp0a2aZw8L9//yJgNnE8PN7PBmo4LQ+Y5g/ggiecrDavAcuKB/S5gdiw
         F03YPY1xpuhOQp9QHgOHto5DN9tEHzbt5hQwRBOGxXCWDh+oig8Hw6TgvKiJMGQOYFLI
         pzU2RBbN2cwYIBKUEjBsbCl5BwYTV+W0q/nBECZINCGGg7FzYG44WCmD7GZvOFXoA6p5
         WyGg==
X-Gm-Message-State: AOAM530CYEdhw/0qU+qkLS/5GZcBWQpnVvypVJp+CC1B90ZsExELdMqk
        68OyeWp6Omxz2GrTX43ucpvjvNIss1twJGKm1rziZw==
X-Google-Smtp-Source: ABdhPJyxBFnoi5YnxmRXEWi3RyOT8zK9WD++uul35NAXdT0Y4CBYSq0+BgknePDAlzmhd8jRWTJRg0Pw5651ggprPVM=
X-Received: by 2002:a05:6e02:1348:: with SMTP id k8mr20739743ilr.154.1605811227390;
 Thu, 19 Nov 2020 10:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20201119080002.100342-1-tmaimon77@gmail.com>
In-Reply-To: <20201119080002.100342-1-tmaimon77@gmail.com>
From:   Benjamin Fair <benjaminfair@google.com>
Date:   Thu, 19 Nov 2020 10:39:48 -0800
Message-ID: <CADKL2t45q907QGpq9rqjnGgMx=43Gz4RRGbyRLZUozYD0kt-DQ@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: add Nuvoton NPCM730 device tree
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        olof@lixom.net, arm@kernel.org, soc@kernel.org,
        avifishman70@gmail.com, Rob Herring <robh+dt@kernel.org>,
        mark.rutland@arm.com, Nancy Yuen <yuenn@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 00:00, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton NPCM730 SoC device tree.
>
> The Nuvoton NPCN730 SoC is a part of the
> Nuvoton NPCM7xx SoCs family.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Reviewed-by: Benjamin Fair <benjaminfair@google.com>

>
> ---
>  arch/arm/boot/dts/nuvoton-npcm730.dtsi | 44 ++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm730.dtsi
>
> diff --git a/arch/arm/boot/dts/nuvoton-npcm730.dtsi b/arch/arm/boot/dts/nuvoton-npcm730.dtsi
> new file mode 100644
> index 000000000000..86ec12ec2b50
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm730.dtsi
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2020 Nuvoton Technology
> +
> +#include "nuvoton-common-npcm7xx.dtsi"
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&gic>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               enable-method = "nuvoton,npcm750-smp";
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <0>;
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <1>;
> +                       next-level-cache = <&l2>;
> +               };
> +       };
> +
> +       soc {
> +               timer@3fe600 {
> +                       compatible = "arm,cortex-a9-twd-timer";
> +                       reg = <0x3fe600 0x20>;
> +                       interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +                                                 IRQ_TYPE_LEVEL_HIGH)>;
> +                       clocks = <&clk NPCM7XX_CLK_AHB>;
> +               };
> +       };
> +};
> --
> 2.22.0
>
