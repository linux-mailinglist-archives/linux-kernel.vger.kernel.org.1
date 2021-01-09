Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A512F0348
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbhAITzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbhAITza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:55:30 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4FC061786;
        Sat,  9 Jan 2021 11:54:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x20so31220445lfe.12;
        Sat, 09 Jan 2021 11:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNvmJAWhKnx+Lp6lw/ACPlHC0ggaRodbLPnupnPJ/QM=;
        b=UDsKHUVYU4IhEm6irSLPJt4gOgVG84UC6JCDbmgDCtayXe94vIoIRNE6fcaBIejAGG
         ZAqffKLs4z6ZKLVmKpjbKO4B9UKmwD2uAsa7nr4NDqGrlENhiI/pGlmBDH8fubC8yKTa
         F2D7b4WaUYeIvvY771ai9+VjDFU0M1yBD3MVjW+MGam5G2OUs7CX7Tik9h0Edp3RIqFc
         9didFHcZpBXkIchiz/gm5lUESe6HAXodrUYONIUnV//fg2e8I8Hz/uXAcb1R4HGOZfQV
         cyKj/L9B8Tm7tHEtA+SSXBZj8Ole260s26XKyEM3K6MOm4+UkQmvizfzN6eP04QYZ18+
         aPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNvmJAWhKnx+Lp6lw/ACPlHC0ggaRodbLPnupnPJ/QM=;
        b=nUKXSmMZyqCjluYNBZ4CiwFTXYaJUb7M5LZM1UGF77mBByCuFPOR0BwAoW2F3DYQ/6
         eNDj4UZh0Jyq3765dFKRywJkJ3agOeuYx5uqxlJVaK6zHEG5vK+5+U4ZTqSi+fv5RzPw
         48UQ8x37QJLZA9nhcIuh5wq266znWHQBTyeMOXFlvk5ONCzCxoQWkv55EbrN32qP0UtH
         uf9WkOnVZf1OkMWgfqwP+ZKszCYBR4/5irAo7cHxY4EVNj+3GPoo9P4eULKlmXuvd3A/
         F8FAGcL+MArtkWPBQS5+VER9X/BAIkfTYHCtGXx02PcvvDCmoduBNbVuSprzLBbfBiKq
         ssDA==
X-Gm-Message-State: AOAM530ge2V48zUWFIYkdG25jLMDOx0RIGG54PThLf1uuuEyJF6h1RkW
        cjR6g6OLvylDBMW6rtezdJloNZ60hWcewwJ0NYA=
X-Google-Smtp-Source: ABdhPJxMuFYqABsH1N8e+qdc3YdYhatKlC2BjZf6ZcFY7c2md3GjAogfwEBs1F+9nGKVa2d2EpxiZMHu3APMmJtQVdw=
X-Received: by 2002:a2e:b556:: with SMTP id a22mr3926278ljn.264.1610222088657;
 Sat, 09 Jan 2021 11:54:48 -0800 (PST)
MIME-Version: 1.0
References: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com> <1610144511-19018-4-git-send-email-oliver.graute@gmail.com>
In-Reply-To: <1610144511-19018-4-git-send-email-oliver.graute@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 9 Jan 2021 16:54:37 -0300
Message-ID: <CAOMZO5CD2GBroqf+c4vLwDmDEhU3ScGt8b7pxC+YuZK_aKS3nQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>, parthitce@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Michael Walle <michael@walle.cc>,
        Robert Jones <rjones@gateworks.com>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 7:23 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 05906e2..5f74d78 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -240,6 +240,7 @@ properties:
>                - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
>                - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
>                - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
> +              - variscite,imx6ul-var-6ulcustomboard # i.MX UltraLite Carrier-board

You missed to add a "6" in the description: i.MX6 UltraLite Carrier-board
