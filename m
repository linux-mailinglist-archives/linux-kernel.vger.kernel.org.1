Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5411A1CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgDHHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 03:30:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35323 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgDHHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:30:14 -0400
Received: by mail-vs1-f65.google.com with SMTP id u11so4132638vsg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD0elTcRIMFole7OUjT/DPArTHrKmfnpdtzqT2CbEcI=;
        b=GNlgSOyiQVP/6vjJXE5Rs4MFQbMsECQtEYiSwZIozcKyRs9mM4wRwjT22otR46/bpO
         ugZ0Iyn1HrM55Y5B+2Z2FQuJBHYxKWKO8FWDVeOxDerfhaPBbEyyOJk3Y10aDHk0TjAW
         PLJA7f6mYqIA9YTyjPORzo870AqyXh6ywRbcQ/3f9Leq5QMxdDAgAIoeLt76D3gdwqJ9
         3MNqNWCByDkHGQ7MTsliT4ScHxUkOr+sD0/eP1A8bnbGa+gsLo4/1hFICx9OnlRnjcGc
         iqIBMnR9TSOEDIp0jJukL+HTyhqGnhOv0GFgZcf0UYNRRluNUWJ6WdujUSDa63WYSgCS
         /hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD0elTcRIMFole7OUjT/DPArTHrKmfnpdtzqT2CbEcI=;
        b=KzAwOOufiODyPGVmYXoFHVBrYs9YoImje69CuZ9vKO+VIaETpWXsiY6w2nF9RMKz9B
         mCyCjKQgCD6IOvbl610HoBENmHvcHTdZvsAGhW+wUkjjjFnLO4otCnCAxvZtPuLFzm26
         HzB6za06JY6ork8rYV3qInmsYOgviRTf+vHk50pcUpBLDiEsRAvLJ7XSWR+nyFsH7qKG
         fkhE1gW37T/OT43uqIUeXOvvHAB1xOtuwCqlGJD5NwkxZ+oNj+CE4TdvPL14gOH3wJxU
         9fVayBpqK/fR6MU3C+UOTkrbBQ3lpSbRoZrS/xM2PtPXcbOWG6izUefKW/1L2H9o98Bs
         Nw0g==
X-Gm-Message-State: AGi0PuZsjIFRgqAyQe3PiGeqA8o0zem1ZtqD8RDy7D8hNqOVd6BdNUPK
        sGkQ+P84WlbNX0cl1YQ0hgUzKcjofGs8HICdtU5xdQ==
X-Google-Smtp-Source: APiQypJT4BDwUnwGDmpI1r6J0epGgiyiPB5hfa/7yBBHYhqblfZim4j2sA6EX0KF68n7dcnpUQxer/An5Kt5MflCHmU=
X-Received: by 2002:a67:4242:: with SMTP id p63mr1661875vsa.159.1586331012758;
 Wed, 08 Apr 2020 00:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200407055116.16082-1-j-keerthy@ti.com> <20200407055116.16082-2-j-keerthy@ti.com>
In-Reply-To: <20200407055116.16082-2-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 8 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerOYfG4eifkWdecJ49cSx05pgDwc30L3zZuu0d9dVQN-AQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: thermal: k3: Add VTM bindings documentation
To:     Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, t-kristo@ti.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 11:21 AM Keerthy <j-keerthy@ti.com> wrote:
>
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 AM654 supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>
> Changes in v6:
>
>   * Reordered the properties to match the order of definition.
>
>  .../bindings/thermal/ti,am654-thermal.yaml    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> new file mode 100644
> index 000000000000..25b9209c2e5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ti,am654-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments AM654 VTM (DTS) binding
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am654-vtm
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    vtm: thermal@42050000 {
> +        compatible = "ti,am654-vtm";
> +        reg = <0x0 0x42050000 0x0 0x25c>;
> +        power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu0_thermal: mpu0_thermal {
> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&vtm0 0>;
> +
> +        trips {
> +                mpu0_crit: mpu0_crit {
> +                        temperature = <125000>; /* milliCelsius */
> +                        hysteresis = <2000>; /* milliCelsius */
> +                        type = "critical";
> +                };
> +        };
> +    };
> +...
> --
> 2.17.1
>
