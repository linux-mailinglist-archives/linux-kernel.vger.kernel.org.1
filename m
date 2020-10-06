Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976CC285440
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgJFWAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:00:17 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:42635 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgJFWAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:00:17 -0400
Received: by mail-oo1-f65.google.com with SMTP id l18so104194ooa.9;
        Tue, 06 Oct 2020 15:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z2hvVkSpnHINzNhjhUjzJuQ0tG2BYYHBLjAIAeoL0TQ=;
        b=M7zubysSj6BwvkJ5Zf7l+umy4xvZJdE9tdGWJCcqpe+wLYTMFVauubqiQRn58qzENo
         j70TpG+V4ikpugK/L/5k9O2ipJKMuFrb2KzIznpzmtLh6K9TKX5ZdQMBxjCJZq6eZdEE
         A8L2kFCiMA6ZeoQDNr3EJmgrLYnP9wbEepIcOc6Sm8ICsBxVQmG78TMhYwz9ft0t9FHU
         EF2hrJ2QYWZ9P6MBTfYz8mGG+eeFxdIaPcFlkAOIj+nWu5gGaQuJd0xcxIK5435XVmzx
         Q7ZTy9fejOoTOvevK3yAiLqX7z1Rhso8P7SRmPjpKbpIj6OFEuANTl+ykYGixDiU4fB4
         45Lw==
X-Gm-Message-State: AOAM53057ubVGYbkCxhLzebUhzOKsCLtJXNh/Pf/a6N0mhwvq8xDtjbm
        OvgkEcaN/RUh63sncS6IxQ==
X-Google-Smtp-Source: ABdhPJwftGpL2HYPjAt+Z1eQOcxnHz4QpTbvxtaOM3xgT1/4qgIW1HO6EhL66hoTavvtO3KwGn4Pyw==
X-Received: by 2002:a05:6820:22c:: with SMTP id j12mr104968oob.87.1602021616239;
        Tue, 06 Oct 2020 15:00:16 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o205sm119360oig.8.2020.10.06.15.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:00:15 -0700 (PDT)
Received: (nullmailer pid 2926434 invoked by uid 1000);
        Tue, 06 Oct 2020 22:00:14 -0000
Date:   Tue, 6 Oct 2020 17:00:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bogdan Togorean <bogdan.togorean@analog.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm: dt-bindings: adi: axi-hdmi-tx: Add DT bindings
 for axi-hdmi-tx
Message-ID: <20201006220014.GA2920793@bogus>
References: <20201005141226.180655-1-bogdan.togorean@analog.com>
 <20201005141226.180655-2-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005141226.180655-2-bogdan.togorean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:12:09PM +0300, Bogdan Togorean wrote:
> Add YAML device tree bindings for Analog Devices Inc. AXI HDMI TX
> IP core DRM driver.
> 
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> ---
>  .../bindings/gpu/adi,axi-hdmi-tx.yaml         | 70 +++++++++++++++++++

Not a GPU? Goes in .../bindings/display/

>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml b/Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml
> new file mode 100644
> index 000000000000..ab7e71d14d1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/adi,axi-hdmi-tx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI HDMI TX HDL core
> +
> +maintainers:
> +  - Bogdan Togorean <bogdan.togorean@analog.com>
> +
> +description: |
> +  The AXI HDMI HDL driver is the driver for the HDL graphics core which
> +  is used on various FPGA designs. It's mostly used to interface with
> +  the ADV7511 driver on some Zynq boards (e.g. ZC702 & ZedBoard).
> +
> +properties:
> +  compatible:
> +    const: adi,axi-hdmi-tx-1.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: phandle to AXIS DMA controller
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: video
> +
> +  clocks:
> +    maxItems: 1
> +    description: phandle to the pixel clock
> +
> +  adi,is-rgb:
> +    type: boolean
> +    description: control color space conversion
> +
> +  port:
> +    type: object
> +    description: |
> +      Port as described in Documentation/devicetree/bindings/graph.txt.
> +      Remote output connection to ADV7511 driver

The exact device it's connected to is outside the scope of this binding.

> +
> +required:
> +  - compatible
> +  - reg
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - port

additionalProperties: false

> +
> +examples:
> +  - |
> +    axi_hdmi_tx: axi_hdmi@70e00000 {
> +            compatible = "adi,axi-hdmi-tx-1.00.a";
> +            reg = <0x70e00000 0x10000>;
> +            dmas = <&hdmi_dma 0>;
> +            dma-names = "video";
> +            clocks = <&hdmi_clock>;
> +
> +            port {
> +                    axi_hdmi_out: endpoint {
> +                            remote-endpoint = <&zynq_hdmi_in>;
> +                    };
> +            };
> +    };
> +...
> -- 
> 2.28.0
> 
