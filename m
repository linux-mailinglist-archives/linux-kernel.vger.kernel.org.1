Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3942CA9CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392044AbgLARfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388186AbgLARf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:35:29 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DCD62222E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606844087;
        bh=obR+gLukVOK9LenxoCUDYCV+puzsLe1AQixYneEFagQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q9Lj/ahohD/SF6T5/kn6+YaW1dqpOZ0GqSUvB2P9mGlTGor/XOx2WZAwdgTTvr//D
         WAyLYPZV8iMZ2VbziIY2C/v6ENvMhICd3Hhvpx47wUL7dC9LDPST1veer8rZNFLbvz
         cHACQ4+VrEfAhweKvbyjhlYBZEazCtGLKRtQMsCs=
Received: by mail-ej1-f44.google.com with SMTP id f23so5790794ejt.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:34:47 -0800 (PST)
X-Gm-Message-State: AOAM532kQhbuF8HcVkliCnuRtm415cO69HDCkmhhjTCbrXRKDE9Sxp/r
        t9Cm+QoROV+Kp9BwQW5yh2fvdwYoR4CJFrZcGw==
X-Google-Smtp-Source: ABdhPJz3Vy73m3b5E89+1NTNMuTwYZ94x3LtlPZa8Tcrxkqtnc0Sy94wvTzMrBBVGJ8BdUDEn+lDNuy/sClXteAHr2M=
X-Received: by 2002:a17:906:a418:: with SMTP id l24mr4039461ejz.360.1606844085258;
 Tue, 01 Dec 2020 09:34:45 -0800 (PST)
MIME-Version: 1.0
References: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
 <1606746513-30909-6-git-send-email-kevin3.tang@gmail.com> <CAL_JsqKZKZtOaduTEuu2dgD9sFf5YDvcSkQfBVA9Ssn4n_mDsg@mail.gmail.com>
 <CAFPSGXYwHyF7xEpc-OiVtpSOKiorRO=jGGftKArK-NeGDGMvdw@mail.gmail.com>
In-Reply-To: <CAFPSGXYwHyF7xEpc-OiVtpSOKiorRO=jGGftKArK-NeGDGMvdw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 1 Dec 2020 10:34:33 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKaRu3+333zzO+e5fpY4QTjNOx2gQ3rkuYyEN8dxj4tuQ@mail.gmail.com>
Message-ID: <CAL_JsqKaRu3+333zzO+e5fpY4QTjNOx2gQ3rkuYyEN8dxj4tuQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:56 AM Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> Hi Rob,
>
> Rob Herring <robh+dt@kernel.org> =E4=BA=8E2020=E5=B9=B412=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:31=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Mon, Nov 30, 2020 at 7:29 AM Kevin Tang <kevin3.tang@gmail.com> wrote=
:
>> >
>> > From: Kevin Tang <kevin.tang@unisoc.com>
>> >
>> > Adds MIPI DSI Master and MIPI DSI-PHY (D-PHY)
>> > support for Unisoc's display subsystem.
>> >
>> > Cc: Orson Zhai <orsonzhai@gmail.com>
>> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
>> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
>> > ---
>> >  .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 107 ++++++++++++=
+++++++++
>> >  .../display/sprd/sprd,sharkl3-dsi-phy.yaml         |  84 ++++++++++++=
++++
>> >  2 files changed, 191 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/display/sprd/spr=
d,sharkl3-dsi-host.yaml
>> >  create mode 100644 Documentation/devicetree/bindings/display/sprd/spr=
d,sharkl3-dsi-phy.yaml
>> >
>> > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,shark=
l3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,shar=
kl3-dsi-host.yaml
>> > new file mode 100644
>> > index 0000000..fe0e89d
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-=
host.yaml
>> > @@ -0,0 +1,107 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host=
.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Unisoc MIPI DSI Controller
>> > +
>> > +maintainers:
>> > +  - Kevin Tang <kevin.tang@unisoc.com>
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: sprd,sharkl3-dsi-host
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +    description:
>> > +      Physical base address and length of the registers set for the d=
evice.
>> > +
>> > +  interrupts:
>> > +    maxItems: 2
>> > +    description:
>> > +      Should contain DSI interrupt.
>> > +
>> > +  clocks:
>> > +    minItems: 1
>> > +
>> > +  clock-names:
>> > +    items:
>> > +      - const: clk_src_96m
>> > +
>> > +  power-domains:
>> > +    maxItems: 1
>> > +    description: A phandle to DSIM power domain node
>> > +
>> > +  ports:
>> > +    type: object
>> > +
>> > +    properties:
>> > +      "#address-cells":
>> > +        const: 1
>> > +
>> > +      "#size-cells":
>> > +        const: 0
>> > +
>> > +      port@0:
>> > +        type: object
>> > +        description:
>> > +          A port node with endpoint definitions as defined in
>> > +          Documentation/devicetree/bindings/media/video-interfaces.tx=
t.
>> > +          That port should be the input endpoint, usually coming from
>> > +          the associated DPU.
>> > +      port@1:
>> > +        type: object
>> > +        description:
>> > +          A port node with endpoint definitions as defined in
>> > +          Documentation/devicetree/bindings/media/video-interfaces.tx=
t.
>> > +          That port should be the output endpoint, usually output to
>> > +          the associated DPHY.
>> > +
>> > +    required:
>> > +      - "#address-cells"
>> > +      - "#size-cells"
>> > +      - port@0
>> > +      - port@1
>> > +
>> > +    additionalProperties: false
>> > +
>> > +required:
>> > +  - compatible
>> > +  - reg
>> > +  - interrupts
>> > +  - clocks
>> > +  - clock-names
>> > +  - ports
>> > +
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> > +    #include <dt-bindings/clock/sprd,sc9860-clk.h>
>> > +    dsi: dsi@63100000 {
>> > +        compatible =3D "sprd,sharkl3-dsi-host";
>> > +        reg =3D <0x63100000 0x1000>;
>> > +        interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
>> > +          <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> > +        clock-names =3D "clk_src_96m";
>> > +        clocks =3D <&pll CLK_TWPLL_96M>;
>> > +        ports {
>> > +            #address-cells =3D <1>;
>> > +            #size-cells =3D <0>;
>> > +            port@0 {
>> > +                reg =3D <0>;
>> > +                dsi_in: endpoint {
>> > +                    remote-endpoint =3D <&dpu_out>;
>> > +                };
>> > +            };
>> > +            port@1 {
>> > +                reg =3D <1>;
>> > +                dsi_out: endpoint {
>> > +                    remote-endpoint =3D <&dphy_in>;
>> > +                };
>> > +            };
>> > +        };
>> > +    };
>> > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,shark=
l3-dsi-phy.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,shark=
l3-dsi-phy.yaml
>> > new file mode 100644
>> > index 0000000..b4715d5
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-=
phy.yaml
>> > @@ -0,0 +1,84 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-phy.=
yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Unisoc MIPI DSI-PHY (D-PHY)
>> > +
>> > +maintainers:
>> > +  - Kevin Tang <kevin.tang@unisoc.com>
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: sprd,sharkl3-dsi-phy
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +    description:
>> > +      Must be the dsi controller base address.
>> > +
>> > +  ports:
>> > +    type: object
>> > +
>> > +    properties:
>> > +      "#address-cells":
>> > +        const: 1
>> > +
>> > +      "#size-cells":
>> > +        const: 0
>> > +
>> > +      port@0:
>> > +        type: object
>> > +        description:
>> > +          A port node with endpoint definitions as defined in
>> > +          Documentation/devicetree/bindings/media/video-interfaces.tx=
t.
>> > +          That port should be the output endpoint, usually output to
>> > +          the associated panel.
>> > +      port@1:
>>
>> For PHYs, we use the PHY binding, not the graph binding. Please follow
>> what practically every other DSI PHY does.
>
> It seems that the dphy driver does not need to exist alone, so i remove d=
phy and dsi graph binding, merge the dphy driver into the dsi driver.

Maybe not now, but what about in the future? PHYs tend to change with
every process node and digital blocks like the DSI controller may not.

If the DPHY is a separate h/w block then it should be a separate node
in the DT. Whether you have 1 driver or 2 is independent of the DT
binding. Drivers and DT nodes don't have to be 1:1. It's just
convenient when they are.

Rob
