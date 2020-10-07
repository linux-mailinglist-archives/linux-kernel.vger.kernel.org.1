Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DEE2869A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgJGU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJGU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:57:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422DC061755;
        Wed,  7 Oct 2020 13:57:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so3545872ota.8;
        Wed, 07 Oct 2020 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+PgDkY01r+SPnq9V1UBxtImvIZ+pUBtI19wyV25iY7U=;
        b=ThvuIbr0CMZR0dT8iUzKHjStgv9nz1WNJP5fSKGNEJY/201n+RdT9yrPcuzoZJPIsi
         kS4PrL9gs8INyZACDFD9AEenxp93n7GO3vK7jruujXKhiIwq508kxuFJeIy2mB6yhTuW
         6s1Yw/lZ1N2qcSvhuJ0Xn8tY+LxOg3Rt4EVJA4BbddD7CU2OuMJsLijYA8eVnlZ4+iyH
         zp2OjjK/bGLdykxCCMqLJdcHpjgwrRsiqvFoMYADWd3E1WAl9fN2X+tR3zsEzkySmz0X
         OnD9+yDxjT3RhT+hTJ20LlcWXVGQBNHyZQq/e8wniNDHt5Y+UZhPj9N5EkRDeQTw6o3z
         pI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+PgDkY01r+SPnq9V1UBxtImvIZ+pUBtI19wyV25iY7U=;
        b=JMiLLPv+87dMZy3p+573rh9K4MDQuJIPHp4/dUeAAtpqqn9Zbv9oCVAQqW1CAE/QPp
         G+QATvamdm4hv1kkvMza37p2yRxPYjZKNa9LSjll8jtJh4zaqRY1F9kjNyM8cmk1+t34
         Z80z9ZpSkZAhc2O8pc177f59gzk7lDNhVdAechW2VIvYcEGdx9FHRNJM8DfyRY/NzGS7
         7RI+FpVlfKX/fk/+oRYqsv0v2I5+vF3oqddt/5RjjLMj5k5b/yX1/dSPjIMfx6lzIdgO
         Gh6K1GmxSa4JbnkNC3J+viYxGe2krOmIXPrhfm+IE+k6di8M3RKKvqgkUxumqGz0iTTz
         Vwsg==
X-Gm-Message-State: AOAM53360SvHh6mFcfoKC/uYDmzS6pVjnmTFne5GAJjAmxcq2iU/JxSb
        XZFaR+P/9IswNyZInWbD6a4hYtUQaDCTWjrMKS8=
X-Google-Smtp-Source: ABdhPJxgP4pU9mnZ9sU5+E8aH+0IQMPjuMDOxIs4XgZ/mYhmQeCtbrQMCUI8zn5ZAOPEnRHwPtiDhBHyFB0sMbUURYE=
X-Received: by 2002:a05:6830:1f4d:: with SMTP id u13mr2870769oth.184.1602104235068;
 Wed, 07 Oct 2020 13:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200921092951.945382-1-enric.balletbo@collabora.com> <20201007151159.GA221754@bogus>
In-Reply-To: <20201007151159.GA221754@bogus>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 7 Oct 2020 22:57:02 +0200
Message-ID: <CAFqH_531fkh_gZbOMuzhsRj-72NeWsPyxWoFQh9bAF3CZwTfNw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Caesar Wang <wxt@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Missatge de Rob Herring <robh@kernel.org> del dia dc., 7 d=E2=80=99oct. 202=
0 a
les 17:12:
>
> On Mon, Sep 21, 2020 at 11:29:51AM +0200, Enric Balletbo i Serra wrote:
> > Convert the soc/rockchip/power_domain.txt binding document to json-sche=
ma
> > and move to the power bindings directory.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> > Changes in v3:
> > - Fixed tab errors found by bot
> >
> > Changes in v2:
> > - Fixed a warning that says that 'syscon' should not be used alone.
> > - Use patternProperties to define a new level for power-domains.
> > - Add const values for power-domain-cells, address-cells, etc.
> >
> >  .../power/rockchip,power-controller.yaml      | 207 ++++++++++++++++++
> >  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
> >  2 files changed, 207 insertions(+), 136 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/power/rockchip,po=
wer-controller.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/powe=
r_domain.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/rockchip,power-con=
troller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-contr=
oller.yaml
> > new file mode 100644
> > index 000000000000..b23ea37e2a08
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller=
.yaml
> > @@ -0,0 +1,207 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Power Domains
> > +
> > +maintainers:
> > +  - Caesar Wang <wxt@rock-chips.com>
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +description: |
> > +  Rockchip processors include support for multiple power domains which=
 can be
> > +  powered up/down by software based on different application scenes to=
 save power.
> > +
> > +  Power domains contained within power-controller node are generic pow=
er domain
> > +  providers documented in Documentation/devicetree/bindings/power/powe=
r-domain.yaml.
> > +
> > +  IP cores belonging to a power domain should contain a 'power-domains=
'
> > +  property that is a phandle for the power domain node representing th=
e domain.
> > +
> > +properties:
> > +  $nodename:
> > +    const: power-controller
> > +
> > +  compatible:
> > +    enum:
> > +      - rockchip,px30-power-controller
> > +      - rockchip,rk3036-power-controller
> > +      - rockchip,rk3066-power-controller
> > +      - rockchip,rk3128-power-controller
> > +      - rockchip,rk3188-power-controller
> > +      - rockchip,rk3228-power-controller
> > +      - rockchip,rk3288-power-controller
> > +      - rockchip,rk3328-power-controller
> > +      - rockchip,rk3366-power-controller
> > +      - rockchip,rk3368-power-controller
> > +      - rockchip,rk3399-power-controller
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^power-domain@[0-9]+$":
>
> unit-addresses are hex.
>
> > +    type: object
> > +    description: |
> > +      Represents the power domains within the power controller node as=
 documented
> > +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> > +
> > +    properties:
> > +
> > +      '#power-domain-cells':
> > +        description:
> > +            Must be 0 for nodes representing a single PM domain and 1 =
for nodes
> > +            providing multiple PM domains.
> > +
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +      reg:
> > +        description: |
> > +          Power domain index. Valid values are defined in:
> > +          "include/dt-bindings/power/px30-power.h" - for PX30 type pow=
er domain.
> > +          "include/dt-bindings/power/rk3036-power.h" - for RK3036 type=
 power domain.
> > +          "include/dt-bindings/power/rk3066-power.h" - for RK3066 type=
 power domain.
> > +          "include/dt-bindings/power/rk3128-power.h" - for RK3128 type=
 power domain.
> > +          "include/dt-bindings/power/rk3188-power.h" - for RK3188 type=
 power domain.
> > +          "include/dt-bindings/power/rk3228-power.h" - for RK3228 type=
 power domain.
> > +          "include/dt-bindings/power/rk3288-power.h" - for RK3288 type=
 power domain.
> > +          "include/dt-bindings/power/rk3328-power.h" - for RK3328 type=
 power domain.
> > +          "include/dt-bindings/power/rk3366-power.h" - for RK3366 type=
 power domain.
> > +          "include/dt-bindings/power/rk3368-power.h" - for RK3368 type=
 power domain.
> > +          "include/dt-bindings/power/rk3399-power.h" - for RK3399 type=
 power domain.
> > +        maxItems: 1
>
> Range of values?
>
> > +
> > +      clocks:
> > +        description: |
> > +          A number of phandles to clocks that need to be enabled while=
 power domain
> > +          switches state.
>
> Can you at least put a range of how many clocks?
>
> > +
> > +      pm_qos:
> > +        description: |
> > +          A number of phandles to qos blocks which need to be saved an=
d restored
> > +          while power domain switches state.
>
> And here.
>
> > +
> > +    required:
> > +      - reg
>
>        additionalProperties: false
>
> Which in turn means the nested power domains will throw an error, so you
> can do:
>
>        patternProperties:
>          "^power-domain@[0-9a-f]+$":
>            $ref: '#/patternProperties/^power-domain@[0-9a-f]+$'
>

When I tried this I got the following error:

rockchip,power-controller.yaml:
patternProperties:^power-domain@[0-9a-f]+$:patternProperties:^power-domain@=
[0-9a-f]+$:$ref:
'#/patternProperties/^power-domain@[0-9a-f]+$' is not a
'uri-reference'

Not sure if is my environment or I am still doing something silly, can
you confirm that this works for you? It doesn't seem to be any binding
doing this actually.

Thanks,
  Enric

> > +
> > +required:
> > +  - compatible
> > +  - '#power-domain-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rk3399-cru.h>
> > +    #include <dt-bindings/power/rk3399-power.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        qos_hdcp: qos@ffa90000 {
> > +            compatible =3D "rockchip,rk3399-qos","syscon";
>
> space                                             ^
>
> > +            reg =3D <0x0 0xffa90000 0x0 0x20>;
> > +        };
> > +
> > +        qos_iep: qos@ffa98000 {
> > +            compatible =3D "rk3399-qos","syscon";
> > +            reg =3D <0x0 0xffa98000 0x0 0x20>;
> > +        };
> > +
> > +        qos_rga_r: qos@ffab0000 {
> > +            compatible =3D "rk3399-qos","syscon";
> > +            reg =3D <0x0 0xffab0000 0x0 0x20>;
> > +        };
> > +
> > +        qos_rga_w: qos@ffab0080 {
> > +            compatible =3D "rk3399-qos","syscon";
> > +            reg =3D <0x0 0xffab0080 0x0 0x20>;
> > +        };
> > +
> > +        qos_video_m0: qos@ffab8000 {
> > +            compatible =3D "rk3399-qos","syscon";
> > +            reg =3D <0x0 0xffab8000 0x0 0x20>;
> > +        };
> > +
> > +        qos_video_m1_r: qos@ffac0000 {
> > +            compatible =3D "rk3399-qos","syscon";
> > +            reg =3D <0x0 0xffac0000 0x0 0x20>;
> > +        };
> > +
> > +        qos_video_m1_w: qos@ffac0080 {
> > +            compatible =3D "rk3399-qos","syscon";
> > +            reg =3D <0x0 0xffac0080 0x0 0x20>;
> > +        };
> > +
> > +        power-management@ff310000 {
> > +            compatible =3D "rockchip,rk3399-pmu", "syscon", "simple-mf=
d";
> > +            reg =3D <0x0 0xff310000 0x0 0x1000>;
> > +
> > +            power-controller {
> > +                compatible =3D "rockchip,rk3399-power-controller";
> > +                #power-domain-cells =3D <1>;
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                /* These power domains are grouped by VD_CENTER */
> > +                power-domain@RK3399_PD_IEP {
> > +                    reg =3D <RK3399_PD_IEP>;
> > +                    clocks =3D <&cru ACLK_IEP>,
> > +                             <&cru HCLK_IEP>;
> > +                    pm_qos =3D <&qos_iep>;
> > +                    #power-domain-cells =3D <0>;
> > +                };
> > +                power-domain@RK3399_PD_RGA {
> > +                    reg =3D <RK3399_PD_RGA>;
> > +                    clocks =3D <&cru ACLK_RGA>,
> > +                             <&cru HCLK_RGA>;
> > +                    pm_qos =3D <&qos_rga_r>,
> > +                             <&qos_rga_w>;
> > +                    #power-domain-cells =3D <0>;
> > +                };
> > +                power-domain@RK3399_PD_VCODEC {
> > +                    reg =3D <RK3399_PD_VCODEC>;
> > +                    clocks =3D <&cru ACLK_VCODEC>,
> > +                             <&cru HCLK_VCODEC>;
> > +                    pm_qos =3D <&qos_video_m0>;
> > +                    #power-domain-cells =3D <0>;
> > +                };
> > +                power-domain@RK3399_PD_VDU {
> > +                    reg =3D <RK3399_PD_VDU>;
> > +                    clocks =3D <&cru ACLK_VDU>,
> > +                             <&cru HCLK_VDU>;
> > +                    pm_qos =3D <&qos_video_m1_r>,
> > +                             <&qos_video_m1_w>;
> > +                    #power-domain-cells =3D <0>;
> > +                };
> > +                power-domain@RK3399_PD_VIO {
> > +                    reg =3D <RK3399_PD_VIO>;
> > +                    #power-domain-cells =3D <1>;
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <0>;
> > +
> > +                    power-domain@RK3399_PD_HDCP {
> > +                        reg =3D <RK3399_PD_HDCP>;
> > +                        clocks =3D <&cru ACLK_HDCP>,
> > +                                 <&cru HCLK_HDCP>,
> > +                                 <&cru PCLK_HDCP>;
> > +                        pm_qos =3D <&qos_hdcp>;
> > +                        #power-domain-cells =3D <0>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
