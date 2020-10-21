Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB68E295147
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408974AbgJURCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390114AbgJURB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:01:59 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C282242F;
        Wed, 21 Oct 2020 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603299719;
        bh=IJgP+WkiF3CiHKbL4th8n+DlWtgkXJlshw3WQkre9Vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tuba3q90fK5U2WA7mvzxLgOqxbPw/EQZoiVM3r5oWZCEuU5rF7+NGJdnskc6nPf4P
         HBHRKlBTeJm40ahzN5JXhWl5uIbupAXdR6yLJ23bbQb6iU71gxNBxPSFLkmnNElDuX
         498wJme6ornfQfWRav8E0bI5Ldoo7TWtVy4SJh08=
Received: by mail-ed1-f49.google.com with SMTP id v19so3276863edx.9;
        Wed, 21 Oct 2020 10:01:58 -0700 (PDT)
X-Gm-Message-State: AOAM5314KgKBAo3KVcwpp+PQwBSWH6xbS01iwLcpPDkKo+J0Zlf0/sU+
        0kVVodts0lxvsSZEVoCMmc3PV5Sy5ZKboFg2Tw==
X-Google-Smtp-Source: ABdhPJxNYB5JrbgWoRZWM5b1UPk2c0NH+oFqgGIXB/umtBUJcVJOEuxHlHRZ5MwpQlcJDN+lPwb7BOCwm2vT1B8hJaw=
X-Received: by 2002:aa7:c3ca:: with SMTP id l10mr4071238edr.72.1603299717347;
 Wed, 21 Oct 2020 10:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201020174253.3757771-1-fparent@baylibre.com> <20201020174253.3757771-3-fparent@baylibre.com>
In-Reply-To: <20201020174253.3757771-3-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 22 Oct 2020 01:01:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9m-nqCe1HanPv5xa3mVLpyG6mC1pF1FRAFJdU1jqza_A@mail.gmail.com>
Message-ID: <CAAOTY_9m-nqCe1HanPv5xa3mVLpyG6mC1pF1FRAFJdU1jqza_A@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: display: mediatek: dsi: add
 documentation for MT8167 SoC
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add binding documentation for the MT8167 SoC. The SoC needs
> an additional clock compared to the already supported SoC: mipi26m.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt  | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> index f06f24d405a5..10ae6be7225e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -7,12 +7,13 @@ channel output.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-dsi"
> -- the supported chips are mt2701, mt7623, mt8173 and mt8183.
> +- the supported chips are mt2701, mt7623, mt8167, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
>    See Documentation/devicetree/bindings/clock/clock-bindings.txt for det=
ails.
> -- clock-names: must contain "engine", "digital", and "hs"
> +- clock-names: must contain "engine", "digital", "hs"
> +  Can optionnally also contain "mipi26m"

It seems that mipi26m is the clock of mipi-tx. In mt8173.dtsi [1],
mipi-tx's clock is 26m.

mipi_tx0: mipi-dphy@10215000 {
compatible =3D "mediatek,mt8173-mipi-tx";
reg =3D <0 0x10215000 0 0x1000>;
clocks =3D <&clk26m>;
clock-output-names =3D "mipi_tx0_pll";
#clock-cells =3D <0>;
#phy-cells =3D <0>;
status =3D "disabled";
};

If this is the clock of mipi-tx, it should be controlled by mipi-tx driver.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=3Dv5.9

Regards,
Chun-Kuang.

>  - phys: phandle link to the MIPI D-PHY controller.
>  - phy-names: must contain "dphy"
>  - port: Output port node with endpoint definitions as described in
> @@ -26,7 +27,7 @@ The MIPI TX configuration module controls the MIPI D-PH=
Y.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-mipi-tx"
> -- the supported chips are mt2701, 7623, mt8173 and mt8183.
> +- the supported chips are mt2701, 7623, mt8167, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - clocks: PLL reference clock
>  - clock-output-names: name of the output clock line to the DSI encoder
> --
> 2.28.0
>
