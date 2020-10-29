Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3429F032
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgJ2Pho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:37:44 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:33238 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgJ2Phn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:37:43 -0400
Received: by mail-oo1-f67.google.com with SMTP id u5so805859oot.0;
        Thu, 29 Oct 2020 08:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U8xolxlS5asomkB9UknbMIlesmKsBuSvzYQp6xmc6Bs=;
        b=EuuFC3CmFnnp39eKK/O98Q55/CWAiRaqhHVwM0qLARYil5cE9Nby36TyPiJAF6aTb3
         uhg17VtRkUVsO2+JR0w5cIC3bwXUrrJIQJ3FMe8XbhAerx/nQb+CKOYvCxSzPdUZWZBg
         j49mm1tgIhZjv1PW8YBxYcMjoKVvvhNNNizSXKDe09WHlImY62midL2V3Si0erOPKeGc
         0QD6SDEQ4uqpkmHsqYdeyZSVv3DqMLTqKjyk1ATdauAjXgtAdO++zgzhYuyfh/5lcG6B
         2EbTNoYwzRmhs5gkZH8cTLH8qTSSXdwLX8nRuoqt+Znnk3f0xCgKI2tuW1uHdw5cNnSv
         aU4w==
X-Gm-Message-State: AOAM532QwcbQKjLDcc0WSplaf3GuiEFKQkUOePLPFpNp5PkjDm3Tt82r
        5jP17T05Hd2/tlSoLkfMew==
X-Google-Smtp-Source: ABdhPJyE+848VL3OIBZZFQbqJdGtbbcdCkCxav93uU/i4lfp5PL5nrPg5vWK8EwxfeYi6ytTA7yIzw==
X-Received: by 2002:a4a:972c:: with SMTP id u41mr3758758ooi.10.1603985861665;
        Thu, 29 Oct 2020 08:37:41 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o8sm659452oog.47.2020.10.29.08.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:37:40 -0700 (PDT)
Received: (nullmailer pid 1917055 invoked by uid 1000);
        Thu, 29 Oct 2020 15:37:40 -0000
Date:   Thu, 29 Oct 2020 10:37:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH 3/3] dt-binding: hwmon: Add documentation for ltc2992
Message-ID: <20201029153740.GB1914153@bogus>
References: <20201029094911.79173-1-alexandru.tachici@analog.com>
 <20201029094911.79173-4-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029094911.79173-4-alexandru.tachici@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:49:11AM +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add documentation for ltc2992.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,ltc2992.yaml           | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> new file mode 100644
> index 000000000000..1b603026ed2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,ltc2992.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology 2992 Power Monitor
> +
> +maintainers:
> +  - Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +description: |
> +  Linear Technology 2992 Dual Wide Range Power Monitor
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2992.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2992
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply: true
> +
> +patternProperties:
> +  "^channel@([0-1])$":
> +    type: object
> +    description: |
> +      Represents the two supplies to be monitored.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. LTC2992 can monitor two supplies.
> +        items:
> +         minimum: 0
> +         maximum: 1
> +
> +      shunt-resistor-micro-ohms:
> +        description:
> +          The value of curent sense resistor in microohms.
> +  required:
> +    - reg
> +
> +  additionalProperties: false

Wrong indentation is the source of the errors.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c1 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ltc2992@6F {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                compatible = "adi,ltc2992";
> +                reg = <0x6F>;
> +
> +                channel@0 {
> +                        reg = <0x0>;
> +                        shunt-resistor-micro-ohms = <10000>;
> +                };
> +
> +                channel@1 {
> +                        reg = <0x1>;
> +                        shunt-resistor-micro-ohms = <10000>;
> +                };
> +        };
> +    };
> +...
> -- 
> 2.20.1
> 
