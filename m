Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00C32C5676
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbgKZNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbgKZNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:50:44 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5BC0613D4;
        Thu, 26 Nov 2020 05:50:42 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id a19so1882424ilm.3;
        Thu, 26 Nov 2020 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqQilc1jh1TKfcIaK4ASDgXAN3ADRyeI/hovWDap4XY=;
        b=i1pyur2KLEtVWT0hwlDb1Jy03TxY5JJA8cDNxNvafMrTZeNEk+iREj5VFkQcM5BbXz
         M9AUgO0eAJQsgDdD7TyIWtGBjwkfcc9Vmw/UJ3+itUYgRCUuEC2qnIxY//08xsoObLQY
         jjkvboTHm3lJ+lRhZfBFNdS8i8iB4+JLOE4DtkT08h4DjYn+G0N5e8L4m35XQUkmaIww
         MVaFtorreo3GTX/dH8q5XOtloIyXYpFNZn4KxJa5NVibKJOikOa0V1t+S7rR+lxZD4p8
         R6AMJikTgz8+FCxF2xMA0QKtsRYqXJT046QtGK5+fU/5LIWSA43HF/V4VaXzj4Psx93q
         zy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqQilc1jh1TKfcIaK4ASDgXAN3ADRyeI/hovWDap4XY=;
        b=VC4NV0qMVFUZJiLySVrH9PVL2yuK4YR0Ef7ryd7YXnBzLCM7swead1Qlfu9SK5Zg3o
         PFuKqceALwxWU111kc+CEvml0Qt6yQd3bo5xzQoAG/AZmxCXZyiO7U2gTYU4XdDaVjTp
         crtcOceaiIGTXHPWtJq7wZ4JXd+D8eqCVwqJhjh+PvrXybFz8XA9z6FYQphJ4t9BpU9E
         Y1eZV3lG2CmM+msQmZmEe1nf87tfAbm13BZm+V6fhukcwXgOsyo2Z2uFF3VKJVb14PcL
         2J2Uv9jGlprKeQ29s6Gad2M2Iqx33M0Pqisb0SNvPG+qEyHgvP2CUlmkZ3/e+OXiio5A
         fKEQ==
X-Gm-Message-State: AOAM530aSrY6Eev4pGZeXDR8/Kt978XhbvV3l0Pip3hWpz1ahZhpIGTz
        mRcegNo7Jvs8mcDPlwtaG+d4KNQdNhj2UhDB3ZKaA/Nqc2Y=
X-Google-Smtp-Source: ABdhPJww7FJ891d4sOORcDC0vThOxtl7xmo1fWhyDlK1p0Pe8LzGZStl6WcJ+OAenlX4jDjyEy4AvUdSZ6+/xcFkOCA=
X-Received: by 2002:a05:6e02:926:: with SMTP id o6mr625455ilt.65.1606398641661;
 Thu, 26 Nov 2020 05:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20201118230414.121316-1-aford173@gmail.com>
In-Reply-To: <20201118230414.121316-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 26 Nov 2020 07:50:30 -0600
Message-ID: <CAHCN7xKDGrz=DAZ+ZLQRF6KkkYeT_J2XSc31HGb-1X0nYh1C2Q@mail.gmail.com>
Subject: Re: [PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
To:     devicetree <devicetree@vger.kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 5:04 PM Adam Ford <aford173@gmail.com> wrote:
>
> Add binding doc for fsl,spba-bus.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Rob,

Sorry to be a pest.  I have a series for the i.MX8M Nano that's
waiting on this.  Have you had time to review my latest attempt?

adam
> ---
> make dt_binding_check -j8 |grep spba
>   DTEX    Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dts
>   DTC     Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
>
> V5:  Rebase on 5.10-rc2 to be able to check yaml
>      Add Reg entry
>
> V4:  Remove an accidental makefile change
>      Move type:object under additional properties
>
> V3:  Rebase sample from aips-bus example
>      Split off from series adding i.MX8M Nano functions to reduce noise
>
> V2:  Attempted to update yaml from feedback
>
> diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> new file mode 100644
> index 000000000000..e9f77ecae3d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Shared Peripherals Bus Interface
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: |
> +  A simple bus enabling access to shared peripherals.
> +
> +  The "spba-bus" follows the "simple-bus" set of properties, as
> +  specified in the Devicetree Specification.  It is an extension of
> +  "simple-bus" because the SDMA controller uses this compatible flag to
> +  determine which peripherals are available to it and the range over which
> +  the SDMA can access.  There are no special clocks for the bus, because
> +  the SDMA controller itself has its interrupt, and clock assignments.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: fsl,spba-bus
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^bus(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    items:
> +      - const: fsl,spba-bus
> +      - const: simple-bus
> +
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - reg
> +  - ranges
> +
> +additionalProperties:
> +  type: object
> +
> +examples:
> +  - |
> +    bus@30000000 {
> +        compatible = "fsl,spba-bus", "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x30000000 0x100000>;
> +        ranges;
> +    };
> --
> 2.25.1
>
