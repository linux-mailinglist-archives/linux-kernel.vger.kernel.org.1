Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0822E0E08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgLVR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgLVR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:59:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7FC0613D3;
        Tue, 22 Dec 2020 09:58:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m12so33994417lfo.7;
        Tue, 22 Dec 2020 09:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfXAXQ8kBE2vb/nUDtD4To0JchlXyJ1Qy383TUCdL5w=;
        b=bUt7/Ewoudd8Ppjf+R80lF3XO9mPK8pM3OhJPkyh7wcro70W1s2ps19o+kAMZu9Bo5
         IamxHUDH1WQg7+353HzRyVnc84N3pGo1MkoWpdqQq2S/gGSvvU+VBQDQ1ZWH6IS9yvJx
         uCPKZLZSOVX8lWdf3X4efSbHJb0LTFWLs69HHKjITTfrzqi/CSI38LH4wOt9kG8S9ldD
         oqfc84awKOYe35uJWz33WRhGOv7p/UHi4pqaho4F7vvfb899441quA9DJVWo+Zjt8uCT
         duCf3wDNI03Me+YoKe3sx4tBTiIH7N9py30uqYdRqCRgbknlP+0gaXWoUUgunOAx/lsp
         CRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfXAXQ8kBE2vb/nUDtD4To0JchlXyJ1Qy383TUCdL5w=;
        b=mGW4l+PVCnKf00cxvaYfXz9wZLi9G2HkDGuWBZnXhWw3PVeEKiWTm6lJ/blYYY12Ap
         sn4q5qMD5yibY4jTayRFWapiuKop7I+uoXKoPmmB/ER+P/mhh4dBp/N90Jt+BrJru4VG
         2BWCNjitydHIDXLx567Ms/WxoZOi/Y1FWcRdmkLqDzUJMu1/kij9557MrBbIMX7CrY2y
         6ayJ5WBx/YoEFc6KDM9QP+qAPQZujHImcizpiJoHTLshxqWQ7HGYpDVVceaZwjXI2RBK
         lOZLmMeF+6ArL8pQxH1S2U7mzUqPzGSh2GFfuPq4q1mji4v20RA0iduvdKc9V/8XOX4F
         xbPA==
X-Gm-Message-State: AOAM532e/E159kwNofEmlyrSDptMYDLKtLlMaYmG+31X0SodvkYrO43U
        tgbc+JHgJlLNanwCYb/hfJhWq/7bxLGRolzydAlAcibmSjs=
X-Google-Smtp-Source: ABdhPJxiMPW/bFl10CagAVMyf3CW3+lHjSBLbEcXhJeid36YohxQ09gShY8vDKRMIFXxt/2lq/4zLFC9vZRuRgXvJWw=
X-Received: by 2002:ac2:4431:: with SMTP id w17mr8772863lfl.223.1608659918710;
 Tue, 22 Dec 2020 09:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20201125161815.2361-1-lukma@denx.de> <20201125161815.2361-3-lukma@denx.de>
In-Reply-To: <20201125161815.2361-3-lukma@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Dec 2020 14:58:27 -0300
Message-ID: <CAOMZO5AkSZf3p7n1UdE9HXPcVciBATH1k5mZLCoNKZ6o2M8maQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx28: Add DTS description of imx28 based
 XEA board
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, Nov 25, 2020 at 1:19 PM Lukasz Majewski <lukma@denx.de> wrote:

> diff --git a/arch/arm/boot/dts/imx28-lwe.dtsi b/arch/arm/boot/dts/imx28-lwe.dtsi
> new file mode 100644
> index 000000000000..cb2eb4377d9c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-lwe.dtsi
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2020
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "imx28.dtsi"
> +
> +/ {
> +       compatible = "fsl,imx28";

You can drop this one.

> +
> +       aliases {
> +               spi2 = &ssp3;
> +       };
> +
> +       chosen {
> +               bootargs = "root=/dev/mmcblk0p2 rootfstype=ext4 ro rootwait console=ttyAMA0,115200 panic=1";

You could remove bootargs and let the bootloader pass it.

We usually don't pass bootargs in the i.MX dts files.

> +       };
> +
> +       memory {

memory@40000000

otherwise you will get dtc build warnings with W=1.

> +               reg = <0x40000000 0x08000000>;
> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;

No need for this 'regulators' container.

> +
> +               reg_3v3: regulator@0 {

reg_3v3: regulator-reg-3v3 {

> +                       compatible = "regulator-fixed";
> +                       reg = <0>;

Remove the reg = <0>

Same applies to other regulators.

> +               reg_usb_5v: regulator@1 {
> +                       compatible = "regulator-fixed";
> +                       reg = <1>;
> +                       regulator-name = "usb_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       enable-active-high;

Why passing 'enable-active-high' when this is not gpio controlled?

> +               };
> +
> +               reg_fec_3v3: regulator@2 {
> +                       compatible = "regulator-fixed";
> +                       reg = <2>;
> +                       regulator-name = "fec-phy";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       enable-active-high;

Same here.

> +&ssp3 {
> +       compatible = "fsl,imx28-spi";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&spi3_pins_a>;
> +       status = "okay";
> +
> +       flash0: s25fl256s0@0 {

Node names should be generic

flash@0
> +
> +/dts-v1/;
> +#include "imx28-lwe.dtsi"
> +
> +/ {
> +       model = "XEA";

compatible = "xea,imx20-lwe", "fsl,imx28";

You should add xea to the vendor prefix in a separate patch.

You also need to add thie board to
Documentation/devicetree/bindings/arm/fsl.yaml
