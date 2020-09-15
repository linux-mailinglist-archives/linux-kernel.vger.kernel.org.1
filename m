Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACC426B716
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgIPAQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:16:35 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35540 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgIOOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:23:18 -0400
Received: by mail-il1-f194.google.com with SMTP id y9so3185967ilq.2;
        Tue, 15 Sep 2020 07:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oibcEZaus/KsE9Tzx8ei6QcB5cjiNKskz7YSAoeajEU=;
        b=VUL0UUDL1tN2ZbWB7++YaOqMpVNu19aNMDXf2tcDFp63gnbNWnb41Ag+8+nLkYQ2O5
         GICDmqlLV+89s+oObukZSUd7HnIIAJv74xbMsr3jGi6KZDHQ08i5GCTQwqRjYvFysYcS
         orlnyHkr7KoJjfaCjTqV17AwcOB7YG1t9jqhJf/QHWT5dJgxMfHSgMxxMbqLwkCEV8My
         xi2kz7ZO0HaQ2QYfWMle8hycYJCm5BhrtIrCWzSdjd+85k+WScLQrzCVBUaQ9AgXDa+z
         gmJ+wvPVBav1gZ9/MOqAL9kusBfHqQCZyfNYmF5AbD9BCah3Q/3/XEuRKVy4wDKLht+n
         yWiA==
X-Gm-Message-State: AOAM531avnZsmncym+mrXHWCJVOsiOVa+/FtYA58MweHnz3Yi8AvMSB8
        l5QywPYxhPr3vu8tgcaOSw==
X-Google-Smtp-Source: ABdhPJzt8yV1vKiC8DPNIwCsSdd5HBuc1l0C2uul6JJjtgEd9/PutB30hWIdnJ86bLqeEaT6LV9bZA==
X-Received: by 2002:a92:9146:: with SMTP id t67mr16054340ild.297.1600179707146;
        Tue, 15 Sep 2020 07:21:47 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p17sm8912639ilj.81.2020.09.15.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:21:46 -0700 (PDT)
Received: (nullmailer pid 1873185 invoked by uid 1000);
        Tue, 15 Sep 2020 14:21:45 -0000
Date:   Tue, 15 Sep 2020 08:21:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for onboard USB hubs
Message-ID: <20200915142145.GA1861636@bogus>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:27:48AM -0700, Matthias Kaehlcke wrote:
> Onboard USB hubs need to be powered and may require initiaization of
> other resources (like GPIOs or clocks) to work properly. This adds
> a device tree binding for these hubs.

We already have bindings for these. 2 in fact as I2C controlled hubs are 
often described under the I2C bus.

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  .../bindings/usb/onboard_usb_hub.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> new file mode 100644
> index 000000000000..f82d8f459eed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> @@ -0,0 +1,70 @@
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
> +allOf:
> +  - $ref: /schemas/usb/onboard_usb_hub.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - onboard-usb-hub
> +      - realtek,rts5411
> +
> +  power-off-in-suspend:
> +    description:
> +      The hub should be powered off during system suspend. When the
> +      "wakeup-source" property is also provided the hub is only powered
> +      off during suspend when no wakeup capable descendants are connected.
> +    type: boolean
> +
> +  vdd-supply:
> +    description:
> +      phandle to the regulator that provides power to the hub.
> +
> +  wakeup-source:
> +    description:
> +      Wakeup capable USB devices connected to this hub can be used as
> +      wakeup source.
> +    type: boolean
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
> +        power-off-in-suspend;
> +        wakeup-source;

This is the hub device?

> +    };
> +
> +    &usb_1_dwc3 {
> +	dr_mode = "host";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub@1 {
> +		compatible = "usbbda,5411";
> +		reg = <1>;
> +		hub = <&usb_hub>;

Or this node is?

> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub@2 {
> +		compatible = "usbbda,411";
> +		reg = <2>;
> +		hub = <&usb_hub>;

Or this node is?

The hub node belongs here.

If you really have it connected to 2 upstream ports, then just do 
one node with 'reg = <1 2>;'.

Rob

> +	};
> +
> +...
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
