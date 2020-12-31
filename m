Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB222E8110
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLaPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 10:44:44 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:41818 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgLaPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 10:44:44 -0500
Received: by mail-oi1-f170.google.com with SMTP id 15so22171346oix.8;
        Thu, 31 Dec 2020 07:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cY0/B8d4jVkdNyYDuXSgudpiPHLVy6pOgXUesN4v88o=;
        b=A3bR1JaHNIax2FMzsbW7ZflcYJel2v43cbQWxGuhDXo6ETcZCEgL2YwTrq/+OgA6dZ
         aBpE+ps1RGC6xiQLM0romksIF5UYsH3fKkKvjXAMpkZbUsJPoVqxG96H/90vWYVi8VjI
         e/Xifts7/Jpyq0oIkCMr/avOjjUGrAD4u6OWMyfjMAe6qkMLTemShPZA+PB6awQ/r8Go
         b9h/7a7irA/vx4VTB4WO3hsEkDjzeFP1tCEATz760tgOBDnagdd73ezDNVLLXqvLhf4i
         oM66yCybGaN6ndkudTGc1gq92YrqcxFnCsSPo5ZO0EqD6P/tVZ2dck2QzjADmSsBo+Af
         Zt8g==
X-Gm-Message-State: AOAM533Ku0bdHynXrREbxxl03IEHOHt0OWMsqKD2wQlMHcatMY13Ei18
        RnmwZcQ2X2BnnoLZVmA5fQ==
X-Google-Smtp-Source: ABdhPJyfHYCwbjFtiLzrwArTkpQhp8K/FJcjLw0PXOJNAAPOP5x2y/0CZRhGzl6PudDcGsAn/mlESw==
X-Received: by 2002:aca:ab8c:: with SMTP id u134mr8517925oie.15.1609429442997;
        Thu, 31 Dec 2020 07:44:02 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g21sm11349439otj.77.2020.12.31.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 07:44:02 -0800 (PST)
Received: (nullmailer pid 1843013 invoked by uid 1000);
        Thu, 31 Dec 2020 15:44:00 -0000
Date:   Thu, 31 Dec 2020 08:44:00 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        drinkcat@chromium.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: regulator: document binding for
 MT6315 regulator
Message-ID: <20201231154400.GA1840028@robh.at.kernel.org>
References: <1608725624-30594-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1608725624-30594-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608725624-30594-2-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 08:13:42PM +0800, Hsin-Hsiung Wang wrote:
> Add device tree binding information for MT6315 regulator driver.
> Example bindings for MT6315 are added.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6315-regulator.yaml  | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
> new file mode 100644
> index 000000000000..15ce83a36174
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mtk,mt6315-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6315 Regulator
> +
> +maintainers:
> +  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> +
> +description: |
> +  The MT6315 is a power management IC (PMIC) configurable with SPMI.
> +  that contains 4 BUCKs output which can combine with each other
> +  by different efuse settings.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6315-regulator
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description: List of regulators and its properties
> +
> +    patternProperties:
> +      "^vbuck[1-4]$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^vbuck[1-4]$"
> +            description:
> +              should be "vbuck1", ..., "vbuck4"

The description just repeats what the schema defines. Drop it.

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic@6 {
> +      compatible = "mediatek,mt6315-regulator";
> +      reg = <0x6 0 0xb 1>;
> +
> +      regulators {
> +        vbuck1 {
> +          regulator-compatible = "vbuck1";
> +          regulator-min-microvolt = <300000>;
> +          regulator-max-microvolt = <1193750>;
> +          regulator-enable-ramp-delay = <256>;
> +          regulator-allowed-modes = <0 1 2 4>;
> +        };
> +
> +        vbuck3 {
> +          regulator-compatible = "vbuck3";
> +          regulator-min-microvolt = <300000>;
> +          regulator-max-microvolt = <1193750>;
> +          regulator-enable-ramp-delay = <256>;
> +          regulator-allowed-modes = <0 1 2 4>;
> +        };
> +      };
> +    };
> -- 
> 2.18.0
> 
