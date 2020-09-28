Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68327A7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgI1Gm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1Gm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:42:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B554C0613CE;
        Sun, 27 Sep 2020 23:42:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l17so39656edq.12;
        Sun, 27 Sep 2020 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUVhzoE1YhpTIQzZCdaXmbRNSb3545QE4RjdGCCy06k=;
        b=AAFsbuxpkDNDAqu/WeCL0tQy+8NBBoIN7gw/D4Kgcbdj8ZNBZCLyngCSXRt/clqmpv
         L93TgbLezkr09UAkhSdrndbmMaTjeDkxKBFy3kg8o9kb3hs/BMDJFsaptRlOVnL5U1/e
         B26Dvq0vEM2qRo/O+I4aqXEWbpeXF5KL9TXSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUVhzoE1YhpTIQzZCdaXmbRNSb3545QE4RjdGCCy06k=;
        b=l+JjXKO/7Pks+7XRyh1crd1JJ66tYnNtRgiDPcgcf/fZqipiE2b4O6gXlzFp7P1c00
         eSNLAuKoBhMdNeESOwae9BsOvFjLDqtF8Lt3byXLYFK6lsBMu/HWKBuU4MRUlh9st87p
         ophOsQ3KR1P1URw85d/sSJzuR82JIH0DTpBtoK0UB/BnlkaGWDMAKh8GcRuUSuMryLQa
         /ZGL5i94vMDWJLzSrA/f/OjByvF1MbHb9YX4LqeAxsWReUwA2IQfCq9PUvwwYHYt8VcL
         psOd+WIopIF2XG6ZxBTefa7Zfrahy/79jPwBm3kaOrop/rLlzcW3UKdWx/vUTkQe+nGl
         naKA==
X-Gm-Message-State: AOAM5319E7Udol83zLjloBkBMpTQn1bLgmaGHEnxFTVE/kY4G2HAkUnz
        ig7jIu0vcAoJzy/ePDDTLUJl06lfUT+AVh118q8=
X-Google-Smtp-Source: ABdhPJyFKeKAko6ux8E5BAU46tjSEAJKh9qX/fMsNyp+E0vMZiaExN5OEUXXkYnVrwK6wlW5pGYymSDZZfd/aJ7mWdo=
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr115062edt.233.1601275375032;
 Sun, 27 Sep 2020 23:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200923164730.176881-1-tmaimon77@gmail.com> <20200923164730.176881-6-tmaimon77@gmail.com>
In-Reply-To: <20200923164730.176881-6-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Sep 2020 06:42:42 +0000
Message-ID: <CACPK8Xc1s7Q6b-m3nCVh6mfukv6Pih331=vpnMTQDLO09mHVWQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] arm: dts: add new device nodes to NPCM750 device
 tree EVB
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 at 16:48, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add the following new device nodes to
> NPCM750 evolution board device tree:
>
>         - NPCM7xx Pin controller and GPIO
>         - NPCM7xx PWM and FAN.
>         - NPCM7xx EHCI USB.
>         - NPCM7xx KCS.
>         - NPCM Reset.
>         - NPCM Peripheral SPI.
>         - NPCM FIU SPI.
>         - NPCM HWRNG.
>         - NPCM I2C.
>         - STMicro STMMAC.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts     | 405 +++++++++++++++++-
>  .../boot/dts/nuvoton-npcm750-pincfg-evb.dtsi  | 157 +++++++
>  2 files changed, 546 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi
>
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> index 15f744f1beea..1623a18ac29b 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> @@ -4,36 +4,409 @@
>
>  /dts-v1/;
>  #include "nuvoton-npcm750.dtsi"
> +#include "dt-bindings/gpio/gpio.h"
> +#include "nuvoton-npcm750-pincfg-evb.dtsi"
>
>  / {
>         model = "Nuvoton npcm750 Development Board (Device Tree)";
>         compatible = "nuvoton,npcm750";
>
> +       aliases {
> +               ethernet2 = &gmac0;
> +               ethernet3 = &gmac1;
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +               serial2 = &serial2;
> +               serial3 = &serial3;
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
> +               i2c3 = &i2c3;
> +               i2c4 = &i2c4;
> +               i2c5 = &i2c5;
> +               i2c6 = &i2c6;
> +               i2c7 = &i2c7;
> +               i2c8 = &i2c8;
> +               i2c9 = &i2c9;
> +               i2c10 = &i2c10;
> +               i2c11 = &i2c11;
> +               i2c12 = &i2c12;
> +               i2c13 = &i2c13;
> +               i2c14 = &i2c14;
> +               i2c15 = &i2c15;
> +               spi0 = &spi0;
> +               spi1 = &spi1;
> +               fiu0 = &fiu0;
> +               fiu1 = &fiu3;
> +               fiu2 = &fiux;
> +       };
> +
>         chosen {
>                 stdout-path = &serial3;
>         };
>
>         memory {
> -               reg = <0 0x40000000>;
> +               device_type = "memory";
> +               reg = <0x0 0x20000000>;
>         };
> -};
>
> -&watchdog1 {
> -       status = "okay";
> -};
> +       ahb {
> +               gmac0: eth@f0802000 {
> +                       phy-mode = "rgmii-id";
> +                       status = "okay";
> +               };

While this will work it is less error prone to refer to the existing
node by it's phandle.

&gmac0 {
     phy-mode = "rgmii-id";
     status = "okay";
}


>
> -&serial0 {
> -       status = "okay";
> -};
> +               gmac1: eth@f0804000 {
> +                       phy-mode = "rgmii-id";
> +                       status = "okay";
> +               };

As with gmac0.

>
> -&serial1 {
> -       status = "okay";
> -};
> +               ehci1: usb@f0806000 {
> +                       status = "okay";
> +               };

As above:

&ehci1 {
   status = "okay";
}

>
> -&serial2 {
> -       status = "okay";
> -};
> +               fiu0: spi@fb000000 {

&fiu0 {
  status = "okay"
   spi-nor@1 {
...

And as I read down, the entire device tree needs to be fixed.

> +                       status = "okay";
> +                       spi-nor@0 {
> +                               compatible = "jedec,spi-nor";
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               spi-rx-bus-width = <2>;
> +                               reg = <0>;
> +                               spi-max-frequency = <5000000>;
> +                               partitions@80000000 {
> +                                       compatible = "fixed-partitions";
> +                                       #address-cells = <1>;
> +                                       #size-cells = <1>;
> +                                       bbuboot1@0 {
> +                                               label = "bb-uboot-1";
> +                                               reg = <0x0000000 0x80000>;
> +                                               read-only;
> +                                               };
> +                                       bbuboot2@80000 {
> +                                               label = "bb-uboot-2";
> +                                               reg = <0x0080000 0x80000>;
> +                                               read-only;
> +                                               };
> +                                       envparam@100000 {
> +                                               label = "env-param";
> +                                               reg = <0x0100000 0x40000>;
> +                                               read-only;
> +                                               };
> +                                       spare@140000 {
> +                                               label = "spare";
> +                                               reg = <0x0140000 0xC0000>;
> +                                               };
> +                                       kernel@200000 {
> +                                               label = "kernel";
> +                                               reg = <0x0200000 0x400000>;
> +                                               };
> +                                       rootfs@600000 {
> +                                               label = "rootfs";
> +                                               reg = <0x0600000 0x700000>;
> +                                               };
> +                                       spare1@D00000 {
> +                                               label = "spare1";
> +                                               reg = <0x0D00000 0x200000>;
> +                                               };
> +                                       spare2@0F00000 {
> +                                               label = "spare2";
> +                                               reg = <0x0F00000 0x200000>;
> +                                               };
> +                                       spare3@1100000 {
> +                                               label = "spare3";
> +                                               reg = <0x1100000 0x200000>;
> +                                               };
> +                                       spare4@1300000 {
> +                                               label = "spare4";
> +                                               reg = <0x1300000 0x0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               fiu3: spi@c0000000 {
> +                       pinctrl-0 = <&spi3_pins>, <&spi3quad_pins>;
> +                       status = "okay";
> +                       spi-nor@0 {
> +                               compatible = "jedec,spi-nor";
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               spi-rx-bus-width = <2>;
> +                               reg = <0>;
> +                               spi-max-frequency = <5000000>;
> +                               partitions@A0000000 {
> +                                       compatible = "fixed-partitions";
> +                                       #address-cells = <1>;
> +                                       #size-cells = <1>;
> +                                       system1@0 {
> +                                               label = "spi3-system1";
> +                                               reg = <0x0 0x0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               fiux: spi@fb001000 {
> +                       spix-mode;
> +               };
> +
> +               apb {
> +
> +                       watchdog1: watchdog@901C {
> +                               status = "okay";
> +                       };
> +
> +                       rng: rng@b000 {
> +                               status = "okay";
> +                       };
> +
> +                       serial0: serial@1000 {
> +                               status = "okay";
> +                       };
> +
> +                       serial1: serial@2000 {
> +                               status = "okay";
> +                       };
> +
> +                       serial2: serial@3000 {
> +                               status = "okay";
> +                       };
> +
> +                       serial3: serial@4000 {
> +                               status = "okay";
> +                       };
> +
> +                       adc: adc@c000 {
> +                               status = "okay";
> +                       };
> +
> +                       otp:otp@189000 {
> +                               status = "okay";
> +                       };
> +
> +                       lpc_kcs: lpc_kcs@7000 {
> +                               kcs1: kcs1@0 {
> +                                       status = "okay";
> +                               };
>
> -&serial3 {
> -       status = "okay";
> +                               kcs2: kcs2@0 {
> +                                       status = "okay";
> +                               };
> +
> +                               kcs3: kcs3@0 {
> +                                       status = "okay";
> +                               };
> +                       };
> +
> +                       /* lm75 on SVB */
> +                       i2c0: i2c@80000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                               lm75@48 {
> +                                       compatible = "lm75";
> +                                       reg = <0x48>;
> +                                       status = "okay";
> +                               };
> +                       };
> +
> +                       /* lm75 on EB */
> +                       i2c1: i2c@81000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                               lm75@48 {
> +                                       compatible = "lm75";
> +                                       reg = <0x48>;
> +                                       status = "okay";
> +                               };
> +                       };
> +
> +                       /* tmp100 on EB */
> +                       i2c2: i2c@82000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                               tmp100@48 {
> +                                       compatible = "tmp100";
> +                                       reg = <0x48>;
> +                                       status = "okay";
> +                               };
> +                       };
> +
> +                       i2c3: i2c@83000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       i2c5: i2c@85000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       /* tmp100 on SVB */
> +                       i2c6: i2c@86000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                               tmp100@48 {
> +                                       compatible = "tmp100";
> +                                       reg = <0x48>;
> +                                       status = "okay";
> +                               };
> +                       };
> +
> +                       i2c7: i2c@87000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       i2c8: i2c@88000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       i2c9: i2c@89000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       i2c10: i2c@8a000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       i2c11: i2c@8b000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       i2c14: i2c@8e000 {
> +                               clock-frequency = <100000>;
> +                               status = "okay";
> +                       };
> +
> +                       pwm_fan:pwm-fan-controller@103000 {
> +                               status = "okay";
> +                               fan@0 {
> +                                       reg = <0x00>;
> +                                       fan-tach-ch = /bits/ 8 <0x00 0x01>;
> +                                       cooling-levels = <127 255>;
> +                               };
> +                               fan@1 {
> +                                       reg = <0x01>;
> +                                       fan-tach-ch = /bits/ 8 <0x02 0x03>;
> +                                       cooling-levels = /bits/ 8 <127 255>;
> +                               };
> +                               fan@2 {
> +                                       reg = <0x02>;
> +                                       fan-tach-ch = /bits/ 8 <0x04 0x05>;
> +                                       cooling-levels = /bits/ 8 <127 255>;
> +                               };
> +                               fan@3 {
> +                                       reg = <0x03>;
> +                                       fan-tach-ch = /bits/ 8 <0x06 0x07>;
> +                                       cooling-levels = /bits/ 8 <127 255>;
> +                               };
> +                               fan@4 {
> +                                       reg = <0x04>;
> +                                       fan-tach-ch = /bits/ 8 <0x08 0x09>;
> +                                       cooling-levels = /bits/ 8 <127 255>;
> +                               };
> +                               fan@5 {
> +                                       reg = <0x05>;
> +                                       fan-tach-ch = /bits/ 8 <0x0A 0x0B>;
> +                                       cooling-levels = /bits/ 8 <127 255>;
> +                               };
> +                               fan@6 {
> +                                       reg = <0x06>;
> +                                       fan-tach-ch = /bits/ 8 <0x0C 0x0D>;
> +                                       cooling-levels = /bits/ 8 <127 255>;
> +                               };
> +                               fan@7 {
> +                                       reg = <0x07>;
> +                                       fan-tach-ch = /bits/ 8 <0x0E 0x0F>;
> +                                       cooling-levels = /bits/ 8 <127 255>;
> +                               };
> +                       };
> +
> +                       spi0: spi@200000 {
> +                               cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
> +                               status = "okay";
> +                               Flash@0 {
> +                                       compatible = "winbond,w25q128",
> +                                       "jedec,spi-nor";
> +                                       reg = <0x0>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <1>;
> +                                       spi-max-frequency = <5000000>;
> +                                       partition@0 {
> +                                               label = "spi0_spare1";
> +                                               reg = <0x0000000 0x800000>;
> +                                       };
> +                                       partition@1 {
> +                                               label = "spi0_spare2";
> +                                               reg = <0x800000 0x0>;
> +                                       };
> +                               };
> +                       };
> +
> +                       spi1: spi@201000 {
> +                               cs-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
> +                               status = "okay";
> +                               Flash@0 {
> +                                       compatible = "winbond,w25q128fw",
> +                                       "jedec,spi-nor";
> +                                       reg = <0x0>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <1>;
> +                                       spi-max-frequency = <5000000>;
> +                                       partition@0 {
> +                                               label = "spi1_spare1";
> +                                               reg = <0x0000000 0x800000>;
> +                                       };
> +                                       partition@1 {
> +                                               label = "spi1_spare2";
> +                                               reg = <0x800000 0x0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +
> +       pinctrl: pinctrl@f0800000 {

&pinctrl {

> +               pinctrl-names = "default";
> +               pinctrl-0 = <   &iox1_pins
> +                               &pin8_input
> +                               &pin9_output_high
> +                               &pin10_input
> +                               &pin11_output_high
> +                               &pin16_input
> +                               &pin24_output_high
> +                               &pin25_output_low
> +                               &pin32_output_high
> +                               &jtag2_pins
> +                               &pin61_output_high
> +                               &pin62_output_high
> +                               &pin63_output_high
> +                               &lpc_pins
> +                               &pin160_input
> +                               &pin162_input
> +                               &pin168_input
> +                               &pin169_input
> +                               &pin170_input
> +                               &pin187_output_high
> +                               &pin190_input
> +                               &pin191_output_high
> +                               &pin192_output_high
> +                               &pin197_output_low
> +                               &ddc_pins
> +                               &pin218_input
> +                               &pin219_output_low
> +                               &pin220_output_low
> +                               &pin221_output_high
> +                               &pin222_input
> +                               &pin223_output_low
> +                               &spix_pins
> +                               &pin228_output_low
> +                               &pin231_output_high
> +                               &pin255_input>;
> +       };
>  };
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi b/arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi
> new file mode 100644
> index 000000000000..edb4190826e6
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Nuvoton Technology tomer.maimon@nuvoton.com

Drop your email address; it's in the git history if someone needs to look it up.

> +
> +/ {
> +       pinctrl: pinctrl@f0800000 {
> +               pin8_input: pin8-input {
> +                       pins = "GPIO8/LKGPO1";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin9_output_high: pin9-output-high {
> +                       pins = "GPIO9/LKGPO2";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin10_input: pin10-input {
> +                       pins = "GPIO10/IOXHLD";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin11_output_high: pin11-output-high {
> +                       pins = "GPIO11/IOXHCK";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin16_input: pin16-input {
> +                       pins = "GPIO16/LKGPO0";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin24_output_high: pin24-output-high {
> +                       pins = "GPIO24/IOXHDO";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin25_output_low: pin25-output-low {
> +                       pins = "GPIO25/IOXHDI";
> +                       bias-disable;
> +                       output-low;
> +               };
> +               pin32_output_high: pin32-output-high {
> +                       pins = "GPIO32/nSPI0CS1";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin61_output_high: pin61-output-high {
> +                       pins = "GPO61/nDTR1_BOUT1/STRAP6";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin62_output_high: pin62-output-high {
> +                       pins = "GPO62/nRTST1/STRAP5";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin63_output_high: pin63-output-high {
> +                       pins = "GPO63/TXD1/STRAP4";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin160_input: pin160-input {
> +                       pins = "GPIO160/CLKOUT/RNGOSCOUT";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin162_input: pin162-input {
> +                       pins = "GPIO162/SERIRQ";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin168_input: pin168-input {
> +                       pins = "GPIO168/nCLKRUN/nESPIALERT";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin169_input: pin169-input {
> +                       pins = "GPIO169/nSCIPME";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin170_input: pin170-input {
> +                       pins = "GPIO170/nSMI";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin187_output_high: pin187-output-high {
> +                       pins = "GPIO187/nSPI3CS1";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin190_input: pin190-input {
> +                       pins = "GPIO190/nPRD_SMI";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin191_output_high: pin191-output-high {
> +                       pins = "GPIO191";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin192_output_high: pin192-output-high {
> +                       pins = "GPIO192";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin197_output_low: pin197-output-low {
> +                       pins = "GPIO197/SMB0DEN";
> +                       bias-disable;
> +                       output-low;
> +               };
> +               pin218_input: pin218-input {
> +                       pins = "GPIO218/nWDO1";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin219_output_low: pin219-output-low {
> +                       pins = "GPIO219/nWDO2";
> +                       bias-disable;
> +                       output-low;
> +               };
> +               pin220_output_low: pin220-output-low {
> +                       pins = "GPIO220/SMB12SCL";
> +                       bias-disable;
> +                       output-low;
> +               };
> +               pin221_output_high: pin221-output-high {
> +                       pins = "GPIO221/SMB12SDA";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin222_input: pin222-input {
> +                       pins = "GPIO222/SMB13SCL";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +               pin223_output_low: pin223-output-low {
> +                       pins = "GPIO223/SMB13SDA";
> +                       bias-disable;
> +                       output-low;
> +               };
> +               pin228_output_low: pin228-output-low {
> +                       pins = "GPIO228/nSPIXCS1";
> +                       bias-disable;
> +                       output-low;
> +               };
> +               pin231_output_high: pin231-output-high {
> +                       pins = "GPIO230/SPIXD3";
> +                       bias-disable;
> +                       output-high;
> +               };
> +               pin255_input: pin255-input {
> +                       pins = "GPI255/DACOSEL";
> +                       bias-disable;
> +                       input-enable;
> +               };
> +       };
> +};
> --
> 2.22.0
>
