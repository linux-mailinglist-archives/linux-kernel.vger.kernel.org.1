Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB727D7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgI2URE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:17:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44202 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2URE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:17:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id a2so5714754otr.11;
        Tue, 29 Sep 2020 13:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GF1S+O6TcCTua7IiLpMCQUTQhVT/wWc1LlYe9jO62rw=;
        b=f9sW/e4uN7VQbHFuizFNwO6/w7ChbfERMyZkX/jZE1nkbyKXeF/KBSnpRmZode42tp
         2wbtSI67BJOrsV734RyUORGwV9YyK8K/Y2qQH2VolnKs+4Nc7vcOZy+7dkMvZzJZCyVz
         5f1pLhIlfFK2entKujV7Cejl56dNAfckxaWJX7H1WIq5MepvgUv4wHg9AD/j0kfz/djX
         NrqEeN0z7UicC+eqZYVkJvEWXoyrgRTpXCxXqQaUgHWnYxblWYJ0pQYMD8ka+X+PGueR
         daRl8Rq/fhRCNzkAtUmUuZffYYwGFGDd/8rUgjkt9ZsUrUaHqp5VevISbGvk3stq8Ffz
         6ggQ==
X-Gm-Message-State: AOAM530ToKXMJMZnhKwTS5+5atIWcf0tk8JXRXaOxxrkQdOLA5KrYbna
        DawxS7YUpzQstqy407Zq2A==
X-Google-Smtp-Source: ABdhPJwXlYj46ql9N4QV6q3UzHTUW9NrH00DqjEu+h2M9Wj4krankN8F/kzuSpSVFz5EUKv8RTJzmw==
X-Received: by 2002:a05:6830:1f13:: with SMTP id u19mr4168856otg.127.1601410623317;
        Tue, 29 Sep 2020 13:17:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s20sm3175800oot.15.2020.09.29.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:17:02 -0700 (PDT)
Received: (nullmailer pid 1092114 invoked by uid 1000);
        Tue, 29 Sep 2020 20:17:01 -0000
Date:   Tue, 29 Sep 2020 15:17:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20200929201701.GA1080459@bogus>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:13:54AM -0700, Matthias Kaehlcke wrote:
> Discrete onboard USB hubs (an example for such a hub is the Realtek
> RTS5411) need to be powered and may require initialization of other
> resources (like GPIOs or clocks) to work properly. This adds a device
> tree binding for these hubs.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - updated commit message
> - removed recursive reference to $self
> - adjusted 'compatible' definition to support multiple entries
> - changed USB controller phandle to be a node
> 
> Changes in v2:
> - removed 'wakeup-source' and 'power-off-in-suspend' properties
> - consistently use spaces for indentation in example
> 
>  .../bindings/usb/onboard_usb_hub.yaml         | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> new file mode 100644
> index 000000000000..c9783da3e75c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for onboard USB hubs
> +
> +maintainers:
> +  - Matthias Kaehlcke <mka@chromium.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - realtek,rts5411
> +      - const: onboard-usb-hub
> +
> +  vdd-supply:
> +    description:
> +      phandle to the regulator that provides power to the hub.
> +
> +required:
> +  - compatible
> +  - vdd-supply
> +
> +examples:
> +  - |
> +    usb_hub: usb-hub {
> +        compatible = "realtek,rts5411", "onboard-usb-hub";
> +        vdd-supply = <&pp3300_hub>;
> +    };

As I said in prior version, this separate node and 'hub' phandle is not 
going to work. You are doing this because you want a platform driver for 
"realtek,rts5411". That may be convenient for Linux, but doesn't reflect 
the h/w.

Rob
