Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D12E2293
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgLWWuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgLWWuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:50:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19E3F224B2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 22:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608763772;
        bh=m1zWd25sVIMx88zsQb/owROtXvkRNF+hwhbGS+3/wO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sTCfu/8ffGAyn5nq3ol2HE9pMBcUetFaWQCUjmLTXSrHor9l3fxwQmeCZ+CQ/+eeG
         aKarM7K6bGAihrEfYRHTuJ/N+lhWDggwTaKkhf2U0qtneJMQi83xZll2nnfRKyBr6t
         +IESeapLBcjYYL05eA3yqi/f5hLxWYWhdINd0sgzyItnQa1yg/SXIuS4OunUzrihR1
         8bQ0yifzELxShTkysRcktmzQjMlAPJhIScopdbU3e449WaJnWoGpUKTUOcD/g8jePC
         8XWgePaascTxLhtwcZQu0t7uAbcwlWNY+Z11jursjI+7OqC9xKaemb/iWQXRxY5i3r
         TFtNKifqGskLQ==
Received: by mail-ed1-f53.google.com with SMTP id i24so643254edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:49:32 -0800 (PST)
X-Gm-Message-State: AOAM533M462BqvZH7F/cqT25UB2qiRkI1xDipLMEPl/qjeHZYHaFgkAR
        q6VRjn3s0Ml2YZumoKIhMmR1xdUOn8fJ82LHoQ==
X-Google-Smtp-Source: ABdhPJygcMTyc/b3pI/RXcZwMMTYpT6l0+CURLDRREupORahFKbx+vwVGFGZSz8lSskB3K6b2/PHUS2O9KVtUEf1IdM=
X-Received: by 2002:a50:e78b:: with SMTP id b11mr26355337edn.165.1608763770621;
 Wed, 23 Dec 2020 14:49:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608721968.git.wilken.gottwalt@posteo.net> <ef9657337a9a033bcbac2bc14805398b907835d6.1608721968.git.wilken.gottwalt@posteo.net>
In-Reply-To: <ef9657337a9a033bcbac2bc14805398b907835d6.1608721968.git.wilken.gottwalt@posteo.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 23 Dec 2020 15:49:19 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
Message-ID: <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 4:34 AM Wilken Gottwalt
<wilken.gottwalt@posteo.net> wrote:
>
> Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> compatible SoCs.

Please resend to DT list so that automated checks run and it's in my
queue (PW). You need to run 'make dt_binding_check' as there are
several issues.

> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v5:
>   - changed binding to earliest known supported SoC sun6i-a31
>   - dropped unnecessary entries
>
> Changes in v4:
>   - changed binding to sun8i-a33-hwpinlock
>   - added changes suggested by Maxime Ripard
>
> Changes in v3:
>   - changed symbols from sunxi to sun8i
>
> Changes in v2:
>   - fixed memory ranges
> ---
>  .../bindings/hwlock/sun6i-a31-hwspinlock.yaml | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
>
> diff --git a/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> new file mode 100644
> index 000000000000..481c5c995ad7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwlock/sun6i-hwspinlock.yaml#

This will fail checks. Wrong filename.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SUN6I hardware spinlock driver for Allwinner sun6i compatible SoCs
> +
> +maintainers:
> +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> +
> +description:
> +  The hardware unit provides semaphores between the ARM cores and the embedded
> +  companion core on the SoC.
> +
> +properties:
> +  compatible:
> +    const: allwinner,sun6i-a31-hwspinlock
> +
> +    reg:
> +      maxItems: 1
> +
> +    clocks:
> +      maxItems: 1
> +
> +    resets:
> +      maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hwspinlock@1c18000 {

hwlock@...

> +      compatible = "allwinner,sun6i-a31-hwspinlock";
> +      reg = <0x01c18000 0x1000>;
> +      clocks = <&ccu CLK_BUS_SPINLOCK>;
> +      resets = <&ccu RST_BUS_SPINLOCK>;

You need an include for these defines.

> +    };
> --
> 2.29.2
>
