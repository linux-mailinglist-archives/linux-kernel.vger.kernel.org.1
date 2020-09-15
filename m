Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CBB26B2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgIOWzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:55:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36754 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgIOP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:27:23 -0400
Received: by mail-io1-f68.google.com with SMTP id d190so4533880iof.3;
        Tue, 15 Sep 2020 08:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPYwHeQQ7IP3X54VVPhQeqc8s7HY2r7mj5Uv/WrGFAY=;
        b=oRnHO+Mib9baloxWE6jo2kgWWdJTnJatKHAshKFTpsT+M5rVHg9FpJWwT7DOv2h4V6
         kfA1ZLdiMx0G2iui6CK2rq4COgZ5N42PzcpDKIgiUev30CRdNHKkPLZ3bLjpDqZKqOIv
         oKX09IViIRaNoT0hHooJGrRrDHaNv6n0/N3wVI5gaWfpRCAFgo4CC28zHgjOxxgCAw/0
         FgQSl0+m/5/CyaEbAAZ1+c0xiYzEPRJj7QHamnVGhAqn59XHWKkN8Q0oYtlvL6Yv3irZ
         WTR4to70xwpXdskawUF1HjZ7wwCUxzeEUp2syOTY2QRoLcAa5nryDQoh557dwCwaq6QK
         qblw==
X-Gm-Message-State: AOAM531HS/g5AbhEe3/iNVCkxuam0MgPL8sLvsmxPaV0LKZIoyUMONG2
        NYd3PeeKrGLpgXuTM86BTg==
X-Google-Smtp-Source: ABdhPJxDjUOE6+zDP2a0Ae0W9UtEpGt1+7MYgRW/yuvD1nijynqc1rDIB9fdJf9BCdcuWC3RKcVucA==
X-Received: by 2002:a05:6602:22cf:: with SMTP id e15mr15463385ioe.114.1600183642802;
        Tue, 15 Sep 2020 08:27:22 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c85sm9033041ilg.10.2020.09.15.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:27:22 -0700 (PDT)
Received: (nullmailer pid 1978036 invoked by uid 1000);
        Tue, 15 Sep 2020 15:27:20 -0000
Date:   Tue, 15 Sep 2020 09:27:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
Message-ID: <20200915152720.GA1975674@bogus>
References: <20200907072708.26043-1-narmstrong@baylibre.com>
 <20200907072708.26043-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907072708.26043-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:27:07AM +0200, Neil Armstrong wrote:
> The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This D-PHY depends on a separate analog PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/phy/amlogic,axg-mipi-dphy.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
> new file mode 100644
> index 000000000000..f7ae1135288b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,axg-mipi-dphy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic AXG MIPI D-PHY
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,axg-mipi-dphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: analog
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - "#phy-cells"

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
