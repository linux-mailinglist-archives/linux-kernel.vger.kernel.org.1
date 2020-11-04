Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB772A5F05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKDH6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDH6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:58:43 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD5E223FB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604476722;
        bh=TFz+TeHabmmJd9e/3K6CgPqA82j+TtGXEzFwY4bAQTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QWKmurpou2+qNLkk6z+Xf+QV81loy23x4f/VYHsSUVl/Zs09muXrarm767hwoD3ff
         sJaZ6rqcRkwEUAXjylQ56qN0Svc3k5EDKA2gFyxqnskdMADcKBhz8Cb9S5yqhep9L8
         lPO8GGCTOo0cNYSuo/sIiW9kSn9JqYezomeUb3dA=
Received: by mail-ed1-f52.google.com with SMTP id a15so12647341edy.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 23:58:42 -0800 (PST)
X-Gm-Message-State: AOAM531IFM7Pkgo1d0bSPYci6GkYjk77YYnOBE8HWBs3GS+olzXMPoEw
        0MQ48jMLbJHLj4+kT/wsvGyw0FANSw5msH2hgr4=
X-Google-Smtp-Source: ABdhPJxsmWC4B8wGB6ek80+A9z7BcpDGVGfkKUgMmX0J03RSAYcCzCJLoovVQ8v9S0uYtw+Qn3DsNckno8fo/cRZaTU=
X-Received: by 2002:a05:6402:cf:: with SMTP id i15mr26685370edu.246.1604476720904;
 Tue, 03 Nov 2020 23:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20201104030645.12931-1-alice.guo@nxp.com> <20201104030645.12931-2-alice.guo@nxp.com>
In-Reply-To: <20201104030645.12931-2-alice.guo@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Nov 2020 08:58:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd_sArJ5-Ka2btZNxn3aBGFioDGOmQKbqeVNgtpUZUw=A@mail.gmail.com>
Message-ID: <CAJKOXPd_sArJ5-Ka2btZNxn3aBGFioDGOmQKbqeVNgtpUZUw=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] LF-2571-1: dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
To:     Alice Guo <alice.guo@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 04:09, Alice Guo <alice.guo@nxp.com> wrote:
>
> Add DT Binding doc for the Unique ID of i.MX 8M series.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  .../bindings/soc/imx/imx8m-unique-id.yaml     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml b/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
> new file mode 100644
> index 000000000000..f1e45458cec7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/nxp/imx8m-unique-id.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Platforms Device Tree Bindings

This is not a title for these bindings. Please describe the bindings
for this device. Based on description, this might could go to
bindings/nvmem directory.

> +
> +properties:
> +  compatible:
> +    oneOf:

No need for oneOf.

> +      - items:
> +          - enum:
> +              - fsl,imx8mm-soc
> +              - fsl,imx8mn-soc
> +              - fsl,imx8mp-soc
> +              - fsl,imx8mq-soc
> +          - const: simple-bus
> +
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Reference to an nvmem node for the SOC Unique ID.

Misleading description - nvmem-cells do not contain a reference. Just
skip it, nvmem-cells should be obvious from the nvmem provider
bindings.

> +
> +  nvmem-cells-names:
> +    const: soc_unique_id

additionalProperties: false


Best regards,
Krzysztof
