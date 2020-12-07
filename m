Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F72D1DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgLGWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:45:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33962 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLGWpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:45:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id h19so14166106otr.1;
        Mon, 07 Dec 2020 14:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZJn2pgTt1kUD8to1t5Dt8cuRrsBFqiHtGixw10QU3M=;
        b=GofZVaGUwuzPQCSYH6tJCo6UbFtbgveswLD+SQHuL7Y9vN8glklesztNGxiQpMp3GB
         hTys7Lcg2VHDiB7RdNQywhM71nooC94mcThm0di105zS6crNR9nSDoR0Mb62QFyUMoaB
         1A7Vz3zewzt0GJhIXieadpuZsDQQ9eUIGjqj/TM10xYi2SOW4cyQNJYkxyrKpSGw9EA6
         ofhE1gSUZcA7nLgcA8yiNCir5Wl1gQadVlfJ0YsY7vG0IyvqpcMBqh5/VXbZDf8M16K8
         CPaVWyKI5d/Hf2EcKWt2f3VTKu0khLBiVOOZ5D/TK6TSm9+xyY4lF8tqZ4MMaAdOzjOF
         y7GA==
X-Gm-Message-State: AOAM532eSkXMOWTmHL9z8muZAm6d7KIhGZxShJ+hVqgpuzGCapEVCrgE
        hasRsfm3eMLJ/MOeFXRRCQ==
X-Google-Smtp-Source: ABdhPJzRshPJNj+/0MGBhONump6skmEbNXhtOQcFjYdv8QT/xYUy2jDOLoIYu8rYALbDzGcCowO47g==
X-Received: by 2002:a9d:1d64:: with SMTP id m91mr5592660otm.290.1607381088018;
        Mon, 07 Dec 2020 14:44:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm1041039otp.36.2020.12.07.14.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:44:47 -0800 (PST)
Received: (nullmailer pid 981516 invoked by uid 1000);
        Mon, 07 Dec 2020 22:44:46 -0000
Date:   Mon, 7 Dec 2020 16:44:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY
 bindings
Message-ID: <20201207224446.GA978231@robh.at.kernel.org>
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

Everything-Else Power Domains node??

> +  node with the required property:
> +
> +  - compatible: Should be the following:
> +                "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
> +
> +  Refer to the the bindings described in
> +  Documentation/devicetree/bindings/mfd/syscon.yaml
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
> +    };
> -- 
> 2.25.1
> 
