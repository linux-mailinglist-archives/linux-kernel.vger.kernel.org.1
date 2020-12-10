Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658BE2D5F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbgLJPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:18:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35045 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgLJPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:18:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so5183770otr.2;
        Thu, 10 Dec 2020 07:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O6n7jCHfQ+L1qVvvcr1LJS/+RzxlJbGuk5+PoiQLbfo=;
        b=IuAD9pvKoHs3sO05F4JiMMPPJPhSloAYpUcqFK7H9doMegUoutTOTd2dJj2B0VK6mu
         jEq8toVSi8Z+zsqVTXRxoj60OFpXh4jIc9T/4pru7D4EtmfWe8aiVaciree/BK//rXWk
         OphudTT7jD/UbROT464fetbcfOirciuSlXHCDa/ttPFYXJP8JSqL9wMJ1kRn5xFlIYpj
         m0MlpuWNWXxunjIH7pej8fBunbo4GFhwI4xDqtfNgHN8C9ygt7D8OhM6VJVBRcL27bXy
         6aDZ+hZzZpQsqe69RlbTj1wfKr3r6irCoEqgpzzWrSHHWy7nhMvd3ohKVnGGtNhVWX1b
         CEcw==
X-Gm-Message-State: AOAM531v0Re5/E8Bskn/pSURR57kHJzQzH493Z7kZQThv7fLKfWND83e
        2/5lkRvtVmHC+xLRevAZlQ==
X-Google-Smtp-Source: ABdhPJwyb/xhH+0OyUj6AU27XEtLESyKVPtbcYD43ujDXmX8TaRR9xvrY3dQrEtCnYQ9LCCYME9UJQ==
X-Received: by 2002:a9d:2287:: with SMTP id y7mr6025156ota.137.1607613464641;
        Thu, 10 Dec 2020 07:17:44 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t26sm469138otm.17.2020.12.10.07.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 07:17:43 -0800 (PST)
Received: (nullmailer pid 2522050 invoked by uid 1000);
        Thu, 10 Dec 2020 15:17:42 -0000
Date:   Thu, 10 Dec 2020 09:17:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] regulator: rt4831: Adds DT binding document for
 Richtek RT4831 DSV regulator
Message-ID: <20201210151742.GB2518014@robh.at.kernel.org>
References: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
 <1607442886-13046-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607442886-13046-3-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:54:45PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 DSV regulator.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v3
> - Add dual license tag in regulator binding document.
> - Left regulator dt-binding example only.
> ---
>  .../regulator/richtek,rt4831-regulator.yaml        | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
> new file mode 100644
> index 00000000..c6741f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt4831-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT4831 Display Bias Voltage Regulator
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  RT4831 is a multifunctional device that can provide power to the LCD display
> +  and LCD backlight.
> +
> +  For Display Bias Voltage DSVP and DSVN, the output range is about 4V to 6.5V.
> +  It is sufficient to meet the current LCD power requirement.
> +
> +  DSVLCM is a boost regulator in IC internal as DSVP and DSVN input power.
> +  Its voltage should be configured above 0.15V to 0.2V gap larger than the
> +  voltage needed for DSVP and DSVN. Too much voltage gap could improve the
> +  voltage drop from the heavy loading scenario. But it also make the power
> +  efficiency worse. It's a trade-off.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
> +
> +patternProperties:
> +  "^DSV(LCM|P|N)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    description:
> +      Properties for single Display Bias Voltage regulator.

Just put this into the MFD schema directly if you don't have any custom 
properties to add.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    regulators {
> +      DSVLCM {
> +        regulator-min-microvolt = <4000000>;
> +        regulator-max-microvolt = <7150000>;
> +        regulator-allow-bypass;
> +      };
> +      DSVP {
> +        regulator-name = "rt4831-dsvp";
> +        regulator-min-microvolt = <4000000>;
> +        regulator-max-microvolt = <6500000>;
> +        regulator-boot-on;
> +      };
> +      DSVN {
> +        regulator-name = "rt4831-dsvn";
> +        regulator-min-microvolt = <4000000>;
> +        regulator-max-microvolt = <6500000>;
> +        regulator-boot-on;
> +      };
> +    };
> -- 
> 2.7.4
> 
