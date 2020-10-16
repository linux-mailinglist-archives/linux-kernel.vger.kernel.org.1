Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BA290B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391856AbgJPSbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:31:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33916 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391792AbgJPSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:31:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id d28so3330407ote.1;
        Fri, 16 Oct 2020 11:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuUhaBtQzn2aKGSZBCnzQsa0o962xBd7gbgs2TYe4IQ=;
        b=lMmBRpFMe6GTVvEf4t0/T2RZRFok7k9cmeMAkuZ/vUpBjur4Okz0o+vWah0/qcX0Yp
         Ee1fyt/rOWX11u02wnVESw9tcCGcVrcnK5zaqrSjnCxqfAMd49UjawNog9Q24wAOGCdC
         y9/IfYaEXy56GIRrh0I9V1xuxz5RnCYGzP7w/taMOdtJaVtsOHox/+AZmdBXSdlHGmY2
         2JBPznHV7NIgZR6nyD8XaZRBmlsA1WglCoYUXL1u6k1QQaMt8vRCBeWNzN1KfXnI32WX
         p45JqrvO4orjL7uiJ6Jy0lff360xzcHh/9JYGNOpPPOETNzNWU3nvhpEocu13phqpb5J
         Wf2w==
X-Gm-Message-State: AOAM533WIJ4c1PHLtX/7e71oudbEcQTIrRUwl1q89muA2985HiE3CsGO
        MaRGXPJ46/Cwx5I2G4lkSg==
X-Google-Smtp-Source: ABdhPJw15xqo4Bai5DrhVcdHZ8a0hOghsFJb8yUvxFs7Ci4yNzIuChIrty4MVz7JQ+t77vl3CYrpQA==
X-Received: by 2002:a05:6830:1282:: with SMTP id z2mr3487048otp.301.1602873069519;
        Fri, 16 Oct 2020 11:31:09 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a10sm1205110otl.5.2020.10.16.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:31:08 -0700 (PDT)
Received: (nullmailer pid 1694882 invoked by uid 1000);
        Fri, 16 Oct 2020 18:31:07 -0000
Date:   Fri, 16 Oct 2020 13:31:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shihlun Lin <shihlun.lin@advantech.com.tw>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Campion Kang <campion.kang@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: Re: [PATCH 2/2] dt-bindings: mfd: ahc1ec0.yaml: Add Advantech
 Embedded Controll - AHC1EC0
Message-ID: <20201016183107.GA1609800@bogus>
References: <20201014082941.25385-1-shihlun.lin@advantech.com.tw>
 <20201014082941.25385-2-shihlun.lin@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014082941.25385-2-shihlun.lin@advantech.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:29:41PM +0800, Shihlun Lin wrote:
> Add DT binding schema for Advantech embedded controller AHC1EC0.

Where's the driver?

> 
> Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
> ---
>  .../devicetree/bindings/mfd/ahc1ec0.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml b/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
> new file mode 100644
> index 000000000000..2a3581d2ecab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +# All the top-level keys are standard json-schema keywords except for
> +# 'maintainers' and 'select'

Drop this. 

> +
> +
> +$id: http://devicetree.org/schemas/mfd/ahc1ec0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Advantech Embedded Controller (AHC1EC0)
> +
> +maintainers:
> +  - Shihlun Lin <shihlun.lin@advantech.com.tw>
> +  - Campion Kang <campion.kang@advantech.com.tw>
> +
> +description: |
> +  AHC1EC0 is one of the embedded controllers used by Advantech to provide several
> +  functions such as watchdog, hwmon, brightness, etc. Advantech related applications
> +  can control the whole system via these functions.
> +
> +  # In this case, a 'false' schema will never match.

Drop

> +
> +properties:
> +  compatible:
> +    const: advantech,ahc1ec0
> +
> +  advantech,sub-dev-nb:
> +    description:
> +      The number of sub-devices specified in the platform.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1

Isn't this just the length of the next property?

> +
> +  advantech,sub-dev:
> +    description:
> +      A list of the sub-devices supported in the platform. Defines for the
> +      appropriate values can found in dt-bindings/mfd/ahc1ec0.h.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    minItems: 1
> +    maxItems: 6

This is kind of odd. Aren't you going to need DT info for each of the 
sub-dev. GPIO is a provider, backlight connection, LED properties, etc.

> +
> +  advantech,hwmon-profile:
> +    description:
> +      The number of sub-devices specified in the platform. Defines for the
> +      hwmon profiles can found in dt-bindings/mfd/ahc1ec0.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - advantech,sub-dev-nb
> +  - advantech,sub-dev
> +
> +if:
> +  properties:
> +    advantech,sub-dev:
> +      contains:
> +        const: AHC1EC0_SUBDEV_HWMON

defines don't work here.

> +then:
> +  required:
> +    - advantech,hwmon-profile
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/mfd/ahc1ec0.h>
> +    ahc1ec0 {
> +        compatible = "advantech,ahc1ec0";
> +
> +        advantech,sub-dev-nb = <2>;
> +        advantech,sub-dev = <AHC1EC0_SUBDEV_HWMON
> +                             AHC1EC0_SUBDEV_WDT>;
> +
> +        advantech,hwmon-profile = <AHC1EC0_HWMON_PRO_UNO2271G>;
> +    };
> -- 
> 2.17.1
> 
