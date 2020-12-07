Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DA2D1DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgLGWsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:48:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46028 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:48:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id f132so2868921oib.12;
        Mon, 07 Dec 2020 14:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0M8AV5f8oKzpVORQVLnD+CzneVSOa0nggX6FBEQvHak=;
        b=hmycxQuA78tZ9Vr8M17v3fpkS9DfNkDbPjzR3s2TNkeefr3vJ9DFMYs8e2l2Pe4XR3
         /EAnfd0dnnNY+GtRHVsOJUslimb1OdiBdg6FREnomqu28j2IIVq+VOzRKxxhF+2L+1sf
         pWekqsGK3TpTdDhIJaNO9KPd8fW+e/v8ujXPE3TeeNlXiKp4aSvvBQMkTRxliFynllfQ
         F2+2ytmqtUShRkrT+8m7u4ikvUjtdtTNNJTYrQcIINNVUKZDeci5NruO/UmNE0gJvliY
         nmxoJWDhLfTFYU50oZGFZaGmGRFgyLy9EbEN3Oyh3XQOMeYGMlOBzE0xM6WGuhEFzk7m
         oBEQ==
X-Gm-Message-State: AOAM530MQz5kgf04WWbwKWE2uaJSgmWuIjQwAb7AytSs20EI/NIBzhCI
        IAJl0y/1aIY/jQ7iuh28LA==
X-Google-Smtp-Source: ABdhPJzSi91QxN3R7XzrUK/0dXpeafD5EM57ynBOGctiHVV7avNW2TpfssDO34fTRuTPBN2KUDPnHQ==
X-Received: by 2002:aca:de85:: with SMTP id v127mr799245oig.36.1607381258314;
        Mon, 07 Dec 2020 14:47:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm3243022oif.42.2020.12.07.14.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:47:37 -0800 (PST)
Received: (nullmailer pid 985883 invoked by uid 1000);
        Mon, 07 Dec 2020 22:47:36 -0000
Date:   Mon, 7 Dec 2020 16:47:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY
 bindings
Message-ID: <20201207224736.GB978231@robh.at.kernel.org>
References: <20201123145157.300456-1-narmstrong@baylibre.com>
 <20201123145157.300456-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123145157.300456-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 03:51:56PM +0100, Neil Armstrong wrote:
> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This Analog D-PHY works with a separate Digital MIPI D-PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> new file mode 100644
> index 000000000000..28663552f05b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic G12A MIPI analog PHY
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |+
> +  The Everything-Else Power Domains node should be the child of a syscon
> +  node with the required property:
> +
> +  - compatible: Should be the following:
> +                "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
> +
> +  Refer to the the bindings described in
> +  Documentation/devicetree/bindings/mfd/syscon.yaml

This schema should be referenced from the parent schema and if you have 
child nodes, you shouldn't be using syscon.yaml.

> +
> +properties:
> +  compatible:
> +    const: amlogic,g12a-mipi-dphy-analog
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mpphy: phy {
> +          compatible = "amlogic,g12a-mipi-dphy-analog";
> +          #phy-cells = <0>;

Looks like a dedicated subset of registers, add 'reg' even if Linux 
doesn't use it (currently).

> +    };
> -- 
> 2.25.1
> 
