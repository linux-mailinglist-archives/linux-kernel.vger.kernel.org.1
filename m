Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD77C251343
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgHYHeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 03:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbgHYHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:34:23 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77766C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:34:23 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u131so3259517vsu.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9dUMlaBrYr0QPUU+/BwByH9mR1EJj9X/+BxAnd7n7g=;
        b=VWcVGZZn5sYlE6nfnxiL29D4ccEVLF9u8czOtdAqCykk2zBJn5knqKwUqCg5HMma+6
         KwV0WWoujrW5/0UCkoKguK5ad5NXefPHrFozEi+YSFAvGzmGkChZuU3MyPeT80sjrpIy
         YEUTdM5QAtkzP3hY3L/bA7jkrEuHdJESNH/TAeF1r7lj8DBPAbiNXYyLGQt+/Sau2zct
         ka/PnkTHIU6Qc3i40yokiEtlkD4hfZKP9ip1mwqEWjg9HpKua/EpKtsOmbhSVhyeGnWh
         SQKeG0iKCSNYH3b3qiJdvoap0Q4Ovz4+zYRiTVkyK6NDADdEtJ90QM6utPbWW52Lk2Ri
         4fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9dUMlaBrYr0QPUU+/BwByH9mR1EJj9X/+BxAnd7n7g=;
        b=rqg1tbsAcjicSFeme2fi/Ryzk7Cii4sTmX6WEAd0SQaqqtrHg3+UXaPwBtYCGMScSY
         bKWa48aodTv56CrNvc1d47oDNPNb4MGTdHgTw0QKphAXs8jP6FK6ymIuTZIoT9pLeWrD
         Z3lNZAI9ixGv+JPNiBCD0bzrhuyfYUEPRR3n51IdCU9ZSHf3igFcqUFX2lph+RZx21d7
         YnClTmZsWKXfPP9JIxgNMjDkwkBbZKhgd2xQGP3yYsKpTN3YD4JGi7FxRX/Npf5TkPqV
         uxkFBC9gpr2lX0I3YcW2EM545Te53CbkPfkkT6b68zNHaRSIi8SqksiZ2Gw45MMLg91C
         bSww==
X-Gm-Message-State: AOAM533kw15wRGuN++XTZs8Fh67jNBH1M++PN7T7nDOFsngmNeEU/pcz
        svd5sUay4GRNxKR8GDXFOTrlwZ1sHaWX78xZjSu3oA==
X-Google-Smtp-Source: ABdhPJyq3iaF9iHmf1FP2YZmUz8+m0tjz+LBxu2zhSgpmuNGB3x9iwVpZxb6Icf9nxJJqlL9tdZw9y4dFEqmdQmH7ik=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr5056875vsd.200.1598340862095;
 Tue, 25 Aug 2020 00:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200824151035.31093-1-lars.povlsen@microchip.com> <20200824151035.31093-2-lars.povlsen@microchip.com>
In-Reply-To: <20200824151035.31093-2-lars.povlsen@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 09:33:45 +0200
Message-ID: <CAPDyKFoBom1n4AHniiukPiE_szskHrhcmVXfMpKTvNo9Xw9v0w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 17:10, Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
> The Sparx5 SDHCI controller is based on the Designware controller IP.
>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> new file mode 100644
> index 0000000000000..55883290543b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Sparx5 Mobile Storage Host Controller Binding
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +# Everything else is described in the common file
> +properties:
> +  compatible:
> +    const: microchip,dw-sparx5-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Handle to "core" clock for the sdhci controller.
> +
> +  clock-names:
> +    items:
> +      - const: core
> +
> +  microchip,clock-delay:
> +    description: Delay clock to card to meet setup time requirements.
> +      Each step increase by 1.25ns.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 1
> +    maximum: 15
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/microchip,sparx5.h>
> +    sdhci0: mmc@600800000 {

Nitpick:

I think we should use solely "mmc[n]" here. So:

mmc0@600800000 {

Please update patch3/3 accordingly as well.

> +        compatible = "microchip,dw-sparx5-sdhci";
> +        reg = <0x00800000 0x1000>;
> +        pinctrl-0 = <&emmc_pins>;
> +        pinctrl-names = "default";
> +        clocks = <&clks CLK_ID_AUX1>;
> +        clock-names = "core";
> +        assigned-clocks = <&clks CLK_ID_AUX1>;
> +        assigned-clock-rates = <800000000>;
> +        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +        bus-width = <8>;
> +        microchip,clock-delay = <10>;
> +    };

Kind regards
Uffe
