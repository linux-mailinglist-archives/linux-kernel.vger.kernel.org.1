Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC62D1BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgLGVNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:13:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37843 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:13:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id o11so11213384ote.4;
        Mon, 07 Dec 2020 13:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9GzWk47iE/pkkA8VjjM3WdGe/Ch4l5wgwdzbUuZu4qg=;
        b=U99aihKTG3LCrD4QjWrO9rcTzDFaF0BxC7FOJBGMquvu/j85ENWaWbUB9R1ttRR95I
         FtDcIsv0daLzrGr4vDMU+9lJ7v9gvGf6v6zH33qzW4jN6smfsaSRXLOtTtE8/WyqcKfz
         j93NWJYM5x7Mt2qMVOFXZo/37xjV4RWH8jQhlAacl47QUKh7FhFzLqfjG3BhuwMACq0J
         j4yJwUUBmzpN9Lx8kE/F9a3/HqLq/VtJo7exw1CrETb0t/VbJWmZNBONT/WuFC6Ec2wA
         QgX726A+zpu+D4kvjxrhIx+GJnIcxkqvWTKqrHT61yDRiFbgldfGItblcoOMgm/9feUQ
         sEDw==
X-Gm-Message-State: AOAM5316gU1QyLlaKJ9pOu1JV1yvJcvcKRENrhKxzFPWZf9nXJg/m5sF
        +4D1s5ma4iZQHCFOJ5J7mw==
X-Google-Smtp-Source: ABdhPJx7wqla09dt3DsGgVgBoLRm0pdPR5DxxxKf38g12KRw58G9dkOAHccq9OtKWvuSSvg4UKsEOA==
X-Received: by 2002:a9d:4715:: with SMTP id a21mr14868375otf.220.1607375581404;
        Mon, 07 Dec 2020 13:13:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm3417238oii.45.2020.12.07.13.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:13:00 -0800 (PST)
Received: (nullmailer pid 833974 invoked by uid 1000);
        Mon, 07 Dec 2020 21:12:59 -0000
Date:   Mon, 7 Dec 2020 15:12:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>
Subject: Re: [PATCH 4/4] dt-bindings: hwmon: convert AD ADM1275 bindings to
 dt-schema
Message-ID: <20201207211259.GA832269@robh.at.kernel.org>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117220807.208747-4-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:08:07PM +0100, Krzysztof Kozlowski wrote:
> Convert the Analog Devices ADM1275 bindings to dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 58 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/adm1275.txt     | 25 --------
>  Documentation/hwmon/adm1275.rst               |  2 +-
>  3 files changed, 59 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> new file mode 100644
> index 000000000000..2cad28c499dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/adi,adm1275.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1075/ADM127x/ADM129x digital power monitors
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |
> +  The ADM1293 and ADM1294 are high accuracy integrated digital power monitors
> +  that offer digital current, voltage, and power monitoring using an on-chip,
> +  12-bit analog-to-digital converter (ADC), communicated through a PMBus
> +  compliant I2C interface.
> +
> +  Datasheets:
> +    https://www.analog.com/en/products/adm1294.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1075
> +      - adi,adm1272
> +      - adi,adm1275
> +      - adi,adm1276
> +      - adi,adm1278
> +      - adi,adm1293
> +      - adi,adm1294
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Shunt resistor value in micro-Ohm.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type if you have units. With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>
