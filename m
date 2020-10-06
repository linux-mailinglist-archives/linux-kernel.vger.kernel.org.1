Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFDE2854B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgJFWkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:40:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35901 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgJFWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:40:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so447341otw.3;
        Tue, 06 Oct 2020 15:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OadiA/el+2vt6yJfwpShon4bZ4FHD8Ssx0XuXvhq3A0=;
        b=tSZrt2RBpLcayz8xQ8D2pX2bSCNjaoX0QBHRjQxkpHduUmzJ0HfvpJrknCrdpV7k5x
         0f3KIgo1W7PubcQ336EqBxQ6BsGV1oz8vEAxdBiNF0ZixO3SbS9OT7ACL7UFO8YDMQHk
         eLhP/M/C033PbCkwWNTBHdTK2PSsBO+Et35N0RqQbxB5pWLo+EjKbjIcrd4sU7Gs/8yG
         vUQf5z1HfNE1nMUrTW5XndME5MR4j6WC2O2W85qyqPxWrwWrqrj2CbasJkb0ily7ELc0
         SxqBur/O1ApEqx8P6YL4dAgMFTUk02eeENgELWuQYm1fwcP+k+EcNSty7BLeecH9XpPR
         3GQA==
X-Gm-Message-State: AOAM532QuEMUuAQnrUXJbPpvzeWXQaDH9/tNHlccD8GgeeCQhPD9++qc
        YzSwVSSr77s3piZsp2Horg==
X-Google-Smtp-Source: ABdhPJwtnpeb6V8bOjRNwhtZ1T0muIYWEbwVo54wVwTVpTcW/JpgqRRvbRZ3Lrx5XSrZFpAaM8JrdQ==
X-Received: by 2002:a9d:27a1:: with SMTP id c30mr115324otb.214.1602024023600;
        Tue, 06 Oct 2020 15:40:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e7sm199652oia.9.2020.10.06.15.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:40:23 -0700 (PDT)
Received: (nullmailer pid 2989602 invoked by uid 1000);
        Tue, 06 Oct 2020 22:40:22 -0000
Date:   Tue, 6 Oct 2020 17:40:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
Message-ID: <20201006224022.GA2986208@bogus>
References: <20201006172341.16423-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006172341.16423-1-dmurphy@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:23:40PM -0500, Dan Murphy wrote:
> Add the binding for the TAS2764 Smart Amplifier.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tas2764.yaml    | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2764.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2764.yaml b/Documentation/devicetree/bindings/sound/tas2764.yaml
> new file mode 100644
> index 000000000000..d2c90c82b13f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2764.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/tas2764.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments TAS2764 Smart PA
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  The TAS2764 is a mono, digital input Class-D audio amplifier optimized for
> +  efficiently driving high peak power into small loudspeakers.
> +  Integrated speaker voltage and current sense provides for
> +  real time monitoring of loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2764
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +       I2C address of the device can be between 0x38 to 0x45.
> +
> +  reset-gpios:
> +    description: GPIO used to reset the device.

maxItems: 1

> +
> +  shutdown-gpios:
> +    description: GPIO used to control the state of the device.

maxItems: 1

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,imon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX current sense time slot.
> +
> +  ti,vmon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX voltage sense time slot.
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c0 {
> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     codec: codec@38 {
> +       compatible = "ti,tas2764";
> +       reg = <0x38>;
> +       #sound-dai-cells = <1>;
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <14>;
> +       reset-gpio = <&gpio1 15 0>;

This fails checks...

> +       shutdown-gpios = <&gpio1 15 0>;
> +       ti,imon-slot-no = <0>;
> +       ti,vmon-slot-no = <2>;
> +     };
> +   };
> +
> +...
> -- 
> 2.28.0.585.ge1cfff676549
> 
