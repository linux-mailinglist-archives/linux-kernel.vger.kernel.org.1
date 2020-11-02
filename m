Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C822A2796
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgKBJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:58:23 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA71C0617A6;
        Mon,  2 Nov 2020 01:58:22 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id k14so1456679lfg.7;
        Mon, 02 Nov 2020 01:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BvrmoJb7ZkWa+BOQwxev+65F8hk83DHzBw1V994tkYM=;
        b=ofyUMHRiWvXa7BEXoEkJyfgCkMoTLJ8vCUGwusVqOWsKqZnMpT8WYiQpejSkLkvGAK
         fXcvTnmKRtjt48RMw4cLHhpaeCjxMQucwVT6216pILAB6gHiLAME6ZWJvNH0tZ3xiEv7
         7eUYkCCIjYrDnlq06JndGrbMG/W97W7C9khE4vmOOZp7s8CtKfW6aLqMaWFMYAlbnH1Z
         fZbrSLpGHxxtlMc/Ca2dANr1TaU0j9rx4vsnDXwKFzP4MctNulH6Ko6kG7/xhceftuGu
         udy7LAZcri0YUPLEhBxTkd7NlnQBfcDQS480HiMSnUu/yctakCIi+6Y/7AMNYsXRiMS3
         gKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BvrmoJb7ZkWa+BOQwxev+65F8hk83DHzBw1V994tkYM=;
        b=KB4FFs2I4JGGzPpivDqrtfp645Nu4tuNcmIo2QZEOuQP3KbfvtFudPmg4Xix7FH56r
         kF1zyo1T1I3c8xJLHmPrEbfJ+Vap8S7ki9lxNuHPL2RO5AMOn+L3TlyySO3cZ6z6JOtd
         IYIwg918B9TWtBF76Tz5vVKBI0RGS5YtxlEnS0jleQVkwmMpajSZyC/z/vzD+I+lkIxo
         OS7NukAhV1suWdMuCaz3Xt0p9POHgR/6m/HNktC7Z6Q6f0Yx/YaDfpbV8lXErSrr4/44
         wAvU89QM6ZqMlj1J3EBMMtJNOel9h6IOZulwOKXtISSn39x1jCxGgvBX6Y71nCACJ3aC
         A2Mg==
X-Gm-Message-State: AOAM532vAX+/okl4QUxzYBQqzIZsiZBmvhlEfq9USlAwVkY05JZw1Tls
        pfLyKycdsIIBlElXdMZ69Rtzudm8VSbUkvrZwpE=
X-Google-Smtp-Source: ABdhPJxSTdSDTbirE5f8bLhpU1+zkfDsroP55+4C196jVsD9y5lgAJZsbZpQUbEpU8GcOMZIrmvlAJDrYiFHklp7U6s=
X-Received: by 2002:ac2:58d2:: with SMTP id u18mr5201636lfo.496.1604311101225;
 Mon, 02 Nov 2020 01:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20201102094851.85301-1-mtwget@gmail.com> <20201102094851.85301-2-mtwget@gmail.com>
 <CAHRgzyNFxkNgV7J9oAY7j5ur5mKnmO1645KxVrYyfDVJrKKqkw@mail.gmail.com>
In-Reply-To: <CAHRgzyNFxkNgV7J9oAY7j5ur5mKnmO1645KxVrYyfDVJrKKqkw@mail.gmail.com>
From:   Yu-Tung Chang <mtwget@gmail.com>
Date:   Mon, 2 Nov 2020 17:58:08 +0800
Message-ID: <CAHRgzyM9xieKcCqN0M+i6ZHht7NV9koFV8F-ipPy+tR5fSCqzw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch, The content of this patch is wrong.


Yu-Tung Chang <mtwget@gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Please ignore this patch, The content of this patch is wrong.
>
> Yu-Tung Chang <mtwget@gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:49=E5=86=99=E9=81=93=EF=BC=9A
>>
>> The ZeroPi is another fun board developed
>> by FriendlyELEC for makers,
>> hobbyists and fans.
>>
>> ZeroPi key features
>> - Allwinner H3, Quad-core Cortex-A7@1.2GHz
>> - 256MB/512MB DDR3 RAM
>> - microsd slot
>> - 10/100/1000Mbps Ethernet
>> - Debug Serial Port
>> - DC 5V/2A power-supply
>>
>> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>> Link: https://lore.kernel.org/r/20201026073536.13617-2-mtwget@gmail.com
>> ---
>>  .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
>>  arch/arm/boot/dts/Makefile                    |  1 +
>>  arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 85 +++++++++++++++++++
>>  3 files changed, 91 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Document=
ation/devicetree/bindings/arm/sunxi.yaml
>> index afa00268c7db..0f23133672a3 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
>> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> @@ -251,6 +251,11 @@ properties:
>>            - const: friendlyarm,nanopi-neo-plus2
>>            - const: allwinner,sun50i-h5
>>
>> +      - description: FriendlyARM ZeroPi
>> +        items:
>> +          - const: friendlyarm,zeropi
>> +          - const: allwinner,sun8i-h3
>> +
>>        - description: Gemei G9 Tablet
>>          items:
>>            - const: gemei,g9
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index ce66ffd5a1bb..4f0adfead547 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1201,6 +1201,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>>         sun8i-h3-orangepi-plus2e.dtb \
>>         sun8i-h3-orangepi-zero-plus2.dtb \
>>         sun8i-h3-rervision-dvk.dtb \
>> +       sun8i-h3-zeropi.dtb \
>>         sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
>>         sun8i-r16-bananapi-m2m.dtb \
>>         sun8i-r16-nintendo-nes-classic.dtb \
>> diff --git a/arch/arm/boot/dts/sun8i-h3-zeropi.dts b/arch/arm/boot/dts/s=
un8i-h3-zeropi.dts
>> new file mode 100644
>> index 000000000000..7d3e7323b661
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
>> @@ -0,0 +1,85 @@
>> +/*
>> + * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of t=
he
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include "sun8i-h3-nanopi.dtsi"
>> +
>> +/ {
>> +       model =3D "FriendlyARM ZeroPi";
>> +       compatible =3D "friendlyarm,zeropi", "allwinner,sun8i-h3";
>> +
>> +       aliases {
>> +               ethernet0 =3D &emac;
>> +       };
>> +
>> +       reg_gmac_3v3: gmac-3v3 {
>> +               compatible =3D "regulator-fixed";
>> +               regulator-name =3D "gmac-3v3";
>> +               regulator-min-microvolt =3D <3300000>;
>> +               regulator-max-microvolt =3D <3300000>;
>> +               startup-delay-us =3D <100000>;
>> +               enable-active-high;
>> +               gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
>> +       };
>> +};
>> +
>> +&external_mdio {
>> +       ext_rgmii_phy: ethernet-phy@7 {
>> +               compatible =3D "ethernet-phy-ieee802.3-c22";
>> +               reg =3D <7>;
>> +       };
>> +};
>> +
>> +&emac {
>> +       pinctrl-names =3D "default";
>> +       pinctrl-0 =3D <&emac_rgmii_pins>;
>> +       phy-supply =3D <&reg_gmac_3v3>;
>> +       phy-handle =3D <&ext_rgmii_phy>;
>> +       phy-mode =3D "rgmii-id";
>> +
>> +       allwinner,leds-active-low;
>> +       status =3D "okay";
>> +};
>> +
>> +&usb_otg {
>> +       status =3D "okay";
>> +       dr_mode =3D "host";
>> +};
>> --
>> 2.29.0
>>
