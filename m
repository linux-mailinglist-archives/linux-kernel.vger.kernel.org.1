Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E7126B2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgIOWw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:52:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32802 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgIOPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:41:29 -0400
Received: by mail-io1-f65.google.com with SMTP id r25so4630851ioj.0;
        Tue, 15 Sep 2020 08:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9td3CHrhD2ePyY61tWqpgj5SUv0on2Qa1ge62urpHGs=;
        b=GhKTuU0M9iSE3sJ7dv5HT4SbWce3pUpIvdEjxMtGAkHIfjnwWSLhgsMb4MSnHPVZF8
         D96IM3zYgs2MjCFSIamBOuUmRr2F5cT2KzEMNlpoG3ybcOZ2v2IXGUxTmP2shbjAApYY
         NH4TgpNNypIA9XtXRg3JYic41Kz55EFkEvCSgnm9Wzvjk7NMxCUcKc4lFFL8SovXR+kj
         HTgTwd0KFjONaCswVE33Q84DpWmMoIBzkgROgQmFerhRPmJp3ptAlCQwqif71eBB7TOM
         plrow+ZWDq7H7yB4FBf+a+TNKlihmSnxVydN2gco1S8RsmVIeObTLJ74TOhk5r6zOsJl
         mmjQ==
X-Gm-Message-State: AOAM5317EAQAezjS8JmGr0ZLWO8y1R8nYwMM1JaCrLIDtpXiMDzgNIov
        zowZSinQV826Oo+hbvb5CQ==
X-Google-Smtp-Source: ABdhPJwNFt8xtG/jVr9dFKGqM4jI/u+N27xrn10aCxWh4fQsBFtbNUAm75Pkj7j/t6t5kOZ/mWI69Q==
X-Received: by 2002:a6b:c997:: with SMTP id z145mr15671026iof.136.1600184480497;
        Tue, 15 Sep 2020 08:41:20 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s2sm9369515ili.49.2020.09.15.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:41:19 -0700 (PDT)
Received: (nullmailer pid 1999129 invoked by uid 1000);
        Tue, 15 Sep 2020 15:41:19 -0000
Date:   Tue, 15 Sep 2020 09:41:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: display: add Amlogic MIPI DSI Host
 Controller bindings
Message-ID: <20200915154118.GA1988840@bogus>
References: <20200907081825.1654-1-narmstrong@baylibre.com>
 <20200907081825.1654-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907081825.1654-3-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 10:18:21AM +0200, Neil Armstrong wrote:
> The Amlogic AXg SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a), with a custom
> glue managing the IP resets, clock and data input similar to the DW-HDMI Glue on other
> Amlogic SoCs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../display/amlogic,meson-dw-mipi-dsi.yaml    | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..6177f45ea1a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/amlogic,meson-dw-mipi-dsi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic specific extensions to the Synopsys Designware MIPI DSI Host Controller
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The Amlogic Meson Synopsys Designware Integration is composed of
> +  - A Synopsys DesignWare MIPI DSI Host Controller IP
> +  - A TOP control block controlling the Clocks & Resets of the IP
> +
> +allOf:
> +  - $ref: dsi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-axg-dw-mipi-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: pclk
> +      - const: px_clk
> +      - const: meas_clk
> +
> +  resets:
> +    minItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: top
> +
> +  phys:
> +    minItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      port@0:
> +        type: object
> +        description: Input node to receive pixel data.
> +      port@1:
> +        type: object
> +        description: DSI output node to panel.
> +
> +    required:
> +      - port@0
> +      - port@1
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
> +  - ports
> +
> +additionalProperties: false

Presumably you may have panel/bridge child nodes, so this needs to be 
'unevaluatedProperties: false'.

Rob
