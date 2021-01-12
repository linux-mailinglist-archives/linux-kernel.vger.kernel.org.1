Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC032F3112
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbhALNPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbhALNPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:15:35 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85582C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:14:55 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id y21so801655uag.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wsIAAaJmhz/Kgz7MWbqUdWEb95rr1AFp+qZxEap7h7M=;
        b=O69p2ecnXJaJLyc0kAIZxooLGMO+lDf9sqymqs+qWgc/YfXc/7tei+tAnu+PvYXW0J
         BEZwCTxK0P4y/JaurvI52+8ztEl/+GIrzY+A6fXPTnoA0hsaJlfcfpfbGFYONfMqAGJS
         EqJv6yIH0mD0pgdiZsTipHwrlNl/RJOfaLwwMdQlDDfIwgtLkc0wEYt4qC7h2438J/zY
         1hTm3/cP9pWOsd79M1ryqV1nlJINS8hNlrk/WLueqTUiNHbHgSR5nmabGxf1hs8+ERZi
         6vDDLIXFZKGCVnwkDMu9EQPBZ0ukqQ3AgulIjudEAGLPF2Slus7/2zR0Mj3lRfhn6gnq
         RPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wsIAAaJmhz/Kgz7MWbqUdWEb95rr1AFp+qZxEap7h7M=;
        b=kfc6MHSzY2kdvPrufdUBh/435j8QOwZh8gD8p+fo+WIRrxQ3KKD1uM2qnkvGG5gPVG
         knzMX6CZjveTLEE80iJ4fkcIx0Vb6Py4oxtpVb5en4PWpmbKzsFYMYACMdh85EBnBuAU
         V6mHS1k9Bnu6f9jWCYzIGw+qUrtcI3kQF6RkpsQnYpweSu7k1C1zepO5ADSfHXIiMG/W
         w1YvhIEH9KEi37ZC4JqQcgi9zqpHdDwRUSWFQfG2yrqTq5XQL3EytQp3wHhxEiCPIt9b
         eUveNo3PbDxC0J3Ls/KfngAYYjL+x+u8oTtzScSSYhMIObWje9HmDfG3AA43sVlJylc0
         JBDg==
X-Gm-Message-State: AOAM530ppjXNEYQG1H+EO1ff09mKb4HQZvBy3xWghtfcM+l/zm3geiPx
        2K36ZDUs8BHoYdU3dgefA/Sb6dGYSm88tBeMZCqgmg==
X-Google-Smtp-Source: ABdhPJwxPISSzqf3EW+/+hLpg/O5Ug7H7RCWxuCU3xGlx5Ix6IChIEDSkui97c+iJKJXTq7hvnNyBXXnjmzN/dgDmJI=
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr3470110uaa.104.1610457294428;
 Tue, 12 Jan 2021 05:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20201214180743.14584-1-zajec5@gmail.com> <20201214180743.14584-2-zajec5@gmail.com>
In-Reply-To: <20201214180743.14584-2-zajec5@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jan 2021 14:14:18 +0100
Message-ID: <CAPDyKFphRU+zhM5G7C-PU_tK_3R9mj5HUvY4SUDRvTmZec4b+Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: power: document Broadcom's PMB binding
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 at 19:08, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wr=
ote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Broadcom's PMB is power controller used for disabling and enabling SoC
> devices.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Apologize for the delay!

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  .../bindings/power/brcm,bcm-pmb.yaml          | 50 +++++++++++++++++++
>  include/dt-bindings/soc/bcm-pmb.h             | 11 ++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm-pmb.=
yaml
>  create mode 100644 include/dt-bindings/soc/bcm-pmb.h
>
> diff --git a/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml b/=
Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
> new file mode 100644
> index 000000000000..40b08d83c80b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/brcm,bcm-pmb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom PMB (Power Management Bus) controller
> +
> +description: This document describes Broadcom's PMB controller. It suppo=
rts
> +  powering various types of connected devices (e.g. PCIe, USB, SATA).
> +
> +maintainers:
> +  - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm4908-pmb
> +
> +  reg:
> +    description: register space of one or more buses
> +    maxItems: 1
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Flag to use for block working in big endian mode.
> +
> +  "#power-domain-cells":
> +    description: cell specifies device ID (see bcm-pmb.h)
> +    const: 1
> +
> +required:
> +  - reg
> +  - "#power-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/bcm-pmb.h>
> +
> +    pmb: power-controller@802800e0 {
> +        compatible =3D "brcm,bcm4908-pmb";
> +        reg =3D <0x802800e0 0x40>;
> +        #power-domain-cells =3D <1>;
> +    };
> +
> +    foo {
> +        power-domains =3D <&pmb BCM_PMB_PCIE0>;
> +    };
> diff --git a/include/dt-bindings/soc/bcm-pmb.h b/include/dt-bindings/soc/=
bcm-pmb.h
> new file mode 100644
> index 000000000000..744dc3af4d41
> --- /dev/null
> +++ b/include/dt-bindings/soc/bcm-pmb.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later OR MIT */
> +
> +#ifndef __DT_BINDINGS_SOC_BCM_PMB_H
> +#define __DT_BINDINGS_SOC_BCM_PMB_H
> +
> +#define BCM_PMB_PCIE0                          0x01
> +#define BCM_PMB_PCIE1                          0x02
> +#define BCM_PMB_PCIE2                          0x03
> +#define BCM_PMB_HOST_USB                       0x04
> +
> +#endif
> --
> 2.26.2
>
