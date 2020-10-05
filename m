Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1832835E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJEMlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJEMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:41:46 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A320FC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:41:45 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e62so4119262vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QE8OHLLcshoqgjao9rxTR2B1cn1gmKyp5nFcvuAzyYM=;
        b=w4lwZr5ahf5vTfr/Sla6b9a6dJJrqMnNnrGCPpE0A2wgptS0+tqhygVB/9v5pdY9tq
         EPJSfiiRWtTDaHXg5QxfgPtgsr6eVXsd5vY8SOM3X5IOjGHhZrbuIQXyyPKjaUX8dLa6
         UIoQYFdsNUiMnVM5DsdprGSSd3qR6RJ7OMFeNT+N43JBkBWzthRqYPGIRMA6MfnhUjDG
         0c+wWti7GTA7T4jaI9by9FdHpfMknlUb+dG2dUAfXt7RPnbPhVm6V1vOTEwrce449Fsz
         03LBUC4NbemiPguroR9bJNjOWUXBqcX7Nrb/AGC+7ptNcprwfJQqzkoBibsti/lCJmrA
         tZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QE8OHLLcshoqgjao9rxTR2B1cn1gmKyp5nFcvuAzyYM=;
        b=D4qKp0K2SovYWrmuVJ6A6wXCGqSYciP9zXHnkDxJTZpvrsVYNe0ZihFoH030Hpq8et
         Cp1QA8ATfCNMj1kKs/efMJHRYYWlyM8+vxXsC4eseNjwynXSoTvZr2snWz82bgAK27JQ
         9ZO7VvC+jJq+xwHhPfTD8J3dHnkgOyBJqizO9tKC0ysuKXEK7ZXSNBm7yXXYy1VWViyy
         wPemw2A8CrZSEv1xlhnKM1cgmpa54Ry5QTGzTBQSVoyN8mj2LQhWVuwvpVfiP7TbOJDW
         ya6YpE32i/GN6ztZcRxS5mB5X7Qov8hyTNUdeej/Up5zhUdp0/uaXLG1YDxvfZJZNQb8
         cs5Q==
X-Gm-Message-State: AOAM530A+8Hiy8iOqqgqkW7Lhd4ZSYDwcv087y2c5oUvaZSGSh9Okhbk
        lpgy8X1+ZCWLWNhDv2Bh2t8wXb6uIb8aV/GqtpCqIA==
X-Google-Smtp-Source: ABdhPJxW3PRcgihH+QhiZOdYzkdNBQPK1MQvkyo/5kU829snF+RDUnnYIRaeoeosnQLf5x/uy3/9W6WqD+wG+F7Wjt8=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr7259024vsp.34.1601901704719;
 Mon, 05 Oct 2020 05:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200930083120.11971-1-wenbin.mei@mediatek.com> <20200930083120.11971-2-wenbin.mei@mediatek.com>
In-Reply-To: <20200930083120.11971-2-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Oct 2020 14:41:08 +0200
Message-ID: <CAPDyKFrM9o7DjBstQXEnKcLsAt0uNh7xKTYEYrz=JTBM9TKgpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mmc: Convert mtk-sd to json-schema
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> new file mode 100644
> index 000000000000..7f89cbdc52a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mtk-sd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MTK MSDC Storage Host Controller Binding
> +
> +maintainers:
> +  - Chaotian Jing <chaotian.jing@mediatek.com>
> +  - Wenbin Mei <wenbin.mei@mediatek.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +        - mediatek,mt2701-mmc
> +        - mediatek,mt2712-mmc
> +        - mediatek,mt6779-mmc
> +        - mediatek,mt7620-mmc
> +        - mediatek,mt7622-mmc
> +        - mediatek,mt8135-mmc
> +        - mediatek,mt8173-mmc
> +        - mediatek,mt8183-mmc
> +        - mediatek,mt8516-mmc
> +      - items:
> +        - const: mediatek,mt7623-mmc
> +        - const: mediatek,mt2701-mmc
> +
> +  clocks:
> +    description:
> +      Should contain phandle for the clock feeding the MMC controller.
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - description: source clock (required).
> +      - description: HCLK which used for host (required).
> +      - description: independent source clock gate (required for MT2712).
> +      - description: bus clock used for internal register access (required for MT2712 MSDC0/3).
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - const: source
> +      - const: hclk
> +      - const: source_cg
> +      - const: bus_clk
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: state_uhs
> +
> +  pinctrl-0:
> +    description:
> +      should contain default/high speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    description:
> +      should contain uhs mode pin ctrl.
> +    maxItems: 1
> +
> +  vmmc-supply:
> +    description:
> +      power to the Core.
> +    maxItems: 1
> +
> +  vqmmc-supply:
> +    description:
> +      power to the IO.
> +    maxItems: 1

The vmmc and vqmmc are described in the mmc-controller.yaml, so
shouldn't be needed here.

> +
> +  assigned-clocks:
> +    description:
> +      PLL of the source clock.
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    description:
> +      parent of source clock, used for HS400 mode to get 400Mhz source clock.
> +    maxItems: 1
> +
> +  hs400-ds-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 DS delay setting.
> +    minimum: 0
> +    maximum: 0xffffffff
> +
> +  mediatek,hs200-cmd-int-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS200 command internal delay setting.
> +      This field has total 32 stages.
> +      The value is an integer from 0 to 31.
> +    minimum: 0
> +    maximum: 31
> +
> +  mediatek,hs400-cmd-int-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 command internal delay setting.
> +      This field has total 32 stages.
> +      The value is an integer from 0 to 31.
> +    minimum: 0
> +    maximum: 31
> +
> +  mediatek,hs400-cmd-resp-sel-rising:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      HS400 command response sample selection.
> +      If present, HS400 command responses are sampled on rising edges.
> +      If not present, HS400 command responses are sampled on falling edges.
> +
> +  mediatek,latch-ck:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some SoCs do not support enhance_rx, need set correct latch-ck to avoid
> +      data crc error caused by stop clock(fifo full) Valid range = [0:0x7].
> +      if not present, default value is 0.
> +      applied to compatible "mediatek,mt2701-mmc".
> +    minimum: 0
> +    maximum: 7
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: hrst
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names

According to the current bindings, the vmmc/vqmmc supplies and the
pinctrls are required as well. I assume you should add them here too!?

[...]

Kind regards
Uffe
