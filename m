Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA251A1697
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgDGUNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:13:05 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:52342 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDGUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:13:05 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id F2C92804F2;
        Tue,  7 Apr 2020 22:12:59 +0200 (CEST)
Date:   Tue, 7 Apr 2020 22:12:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 1/3] dt-bindings: display: panel: Convert feiyang,
 fy07024di26a30d to DT schema
Message-ID: <20200407201258.GB28801@ravnborg.org>
References: <20200403142453.25307-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403142453.25307-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8
        a=gEfo2CItAAAA:8 a=e5mUnYsNAAAA:8 a=IP_fJxDYSyxqUQePLtIA:9
        a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

On Fri, Apr 03, 2020 at 07:54:51PM +0530, Jagan Teki wrote:
> Convert the feiyang,fy07024di26a30d panel bindings to DT schema.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Thanks, this and the two other patches are now pushed to drm-misc-next.

	Sam

> ---
> Changes for v3:
> - update the licence, used (GPL-2.0-only OR BSD-2-Clause) since
>   I'm the author for old binding
> - use panel-common.yaml
> - mark true for common properties 
> - use maxItems: 1 for reg
> - update example
> Changes for v2:
> - fix dt_binding_check 
> 
>  .../display/panel/feiyang,fy07024di26a30d.txt | 20 -------
>  .../panel/feiyang,fy07024di26a30d.yaml        | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> deleted file mode 100644
> index 82caa7b65ae8..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
> -
> -Required properties:
> -- compatible: must be "feiyang,fy07024di26a30d"
> -- reg: DSI virtual channel used by that screen
> -- avdd-supply: analog regulator dc1 switch
> -- dvdd-supply: 3v3 digital regulator
> -- reset-gpios: a GPIO phandle for the reset pin
> -
> -Optional properties:
> -- backlight: phandle for the backlight control.
> -
> -panel@0 {
> -	compatible = "feiyang,fy07024di26a30d";
> -	reg = <0>;
> -	avdd-supply = <&reg_dc1sw>;
> -	dvdd-supply = <&reg_dldo2>;
> -	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
> -	backlight = <&backlight>;
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
> new file mode 100644
> index 000000000000..95acf9e96f1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/feiyang,fy07024di26a30d.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
> +
> +maintainers:
> +  - Jagan Teki <jagan@amarulasolutions.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: feiyang,fy07024di26a30d
> +
> +  reg:
> +    description: DSI virtual channel used by that screen
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: analog regulator dc1 switch
> +
> +  dvdd-supply:
> +    description: 3v3 digital regulator
> +
> +  reset-gpios: true
> +
> +  backlight: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "feiyang,fy07024di26a30d";
> +            reg = <0>;
> +            avdd-supply = <&reg_dc1sw>;
> +            dvdd-supply = <&reg_dldo2>;
> +            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
> +            backlight = <&backlight>;
> +        };
> +    };
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
