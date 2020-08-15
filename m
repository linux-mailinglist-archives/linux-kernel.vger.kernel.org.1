Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0141A2451FC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHOVe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:34:58 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:46900 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHOVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:34:56 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id DC50880533;
        Sat, 15 Aug 2020 10:39:18 +0200 (CEST)
Date:   Sat, 15 Aug 2020 10:39:17 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add Mantix MLAF057WE51-X panel bindings
Message-ID: <20200815083917.GA993113@ravnborg.org>
References: <cover.1597412076.git.agx@sigxcpu.org>
 <9345739df02b8b8630e7dccb61a80a7a7f692526.1597412076.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9345739df02b8b8630e7dccb61a80a7a7f692526.1597412076.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
        a=6yzhs6WGAAAA:8 a=e5mUnYsNAAAA:8 a=hVRzqGFF_kdORxQG3GsA:9
        a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=AjGcO6oz07-iQ99wixmX:22 a=j5F3_G_i7ziBYwdlbqZG:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Fri, Aug 14, 2020 at 03:36:22PM +0200, Guido G�nther wrote:
> The panel uses a Focaltech FT8006p, the touch part is handled by the
> already existing edt-ft5x06.
> 
> Signed-off-by: Guido G�nther <agx@sigxcpu.org>

A few trivialities.

> ---
>  .../display/panel/mantix,mlaf057we51-x.yaml   | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> new file mode 100644
> index 0000000000000..349f3380ac940
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/mantix,mlaf057we51-x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mantix MLAF057WE51-X 5.7" 720x1440 TFT LCD panel
> +
> +maintainers:
> +  - Guido G�nther <agx@sigxcpu.org>
> +
> +description: |
> +             Mantix MLAF057WE51 X is a 720x1440 TFT LCD panel
> +             connected using a MIPI-DSI video interface.
Indent text with two spaces only.
And I have learned that '|' is only needed to preserve formatting - so
it can be dropped.

> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mantix,mlaf057we51-x
This is a list - so needs an extra 2 spaces indent.
See https://lore.kernel.org/linux-devicetree/f1963eb9-283f-e903-2a3a-4f324d71d418@lucaceresoli.net/T/#m65900317fb948f6c40e8fb521f2201fba3c301a7
for examples where Rob fixes this.

> +
> +  port: true
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  avdd-supply:
> +    description: Positive analog power supply
> +
> +  avee-supply:
> +    description: Negative analog power supply
> +
> +  vddi-supply:
> +    description: 1.8V I/O voltage supply
> +
> +  reset-gpios:
> +    description: GPIO used for the reset pin
> +    maxItems: 1
Use reset-gpios: true as we already have it in panel-common.yaml

> +
> +  backlight:
> +    description: Backlight used by the panel
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
Use backlight from panel-common.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - avee-supply
> +  - vddi-supply
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
My personal preference is indent with 4 spaces in examples but there are
no rules so feel free to ignore.
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      panel@0 {
> +        compatible = "mantix,mlaf057we51-x";
> +        reg = <0>;
> +        avdd-supply = <&reg_avdd>;
> +        avee-supply = <&reg_avee>;
> +        vddi-supply = <&reg_1v8_p>;
> +        reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> +        backlight = <&backlight>;
> +      };
> +    };
I think we need an ampty line here.
> +...
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
