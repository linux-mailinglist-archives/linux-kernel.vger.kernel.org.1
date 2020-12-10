Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DF62D5122
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgLJDIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:08:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgLJDH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:07:56 -0500
X-Gm-Message-State: AOAM530KYdUeetAxKWP0YDQgCkxq6ooNEHg+GN3mZuzBgqoA3amm/Ilk
        a9r7SHlWHWmPOASNkX/m1uWchtcd6Zxhx9CnWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607569632;
        bh=Ij9Zk/sFw/WVF3WIL7Awpv4vVlyqAocQrIlQUfk4EAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mRGdRf7AkW5/S3/2Xi22QAXd+Bjl7ZSR49AkoK96PrfRW5t8qzjkJFb7fY9xfKRCx
         Aqu9uXWF4D2wQ1m+7eJgRtYZKe5k5m6iUEZr/1Eo20oURDQE7M5cbjkFkXTzb9FKpB
         kA4UPru0N88k3tc3UnDFqw/OqaxEYPy14C90ZB3DiI3isg71Y+Bc7LInUidzUc7jeQ
         jFEc+P6d8sAf6CxoSevVhfl6iJjH+qxYuR2B/UZBduEYBTAMsFpclIVisVXY3eQb3X
         K4V3wcjr4zI+SX4XMd9NkPehFR27gL5zmA2KcgKjKG/tk6f+tyzu28xwwfzNQ0cnvR
         Q0pSs0Hf0WLRw==
X-Google-Smtp-Source: ABdhPJwEtsuU+F78ug25YRx5NKd5Abr/WII+jJ4HNESUFqg/3e6qw3rnVpO4bkSIn2pbjdbajOHhLUzB3jTHEwV50Sw=
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr4762536edb.137.1607569630778;
 Wed, 09 Dec 2020 19:07:10 -0800 (PST)
MIME-Version: 1.0
References: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAAAJUqiRO33GQqGIHffCVyG/AQAAAAA=@ministro.hu>
In-Reply-To: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAAAJUqiRO33GQqGIHffCVyG/AQAAAAA=@ministro.hu>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Dec 2020 21:06:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ5gXcVnqRxFWt0UadGTFA=QjquQhs3UtyVC=9Jb2-xdg@mail.gmail.com>
Message-ID: <CAL_JsqJ5gXcVnqRxFWt0UadGTFA=QjquQhs3UtyVC=9Jb2-xdg@mail.gmail.com>
Subject: Re: [PATCH] Staging: silabs si4455 serial driver
To:     Info <info@ministro.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 5:17 AM Info <info@ministro.hu> wrote:
>
> This is a serial port driver for
> Silicon Labs Si4455 Sub-GHz transciver.
>
> Signed-off-by: J=C3=B3zsef Horv=C3=A1th <info@ministro.hu>
> ---
>  .../bindings/staging/serial/silabs,si4455.txt |   39 +

Looks straightforward enough to not be in staging. Plus
bindings/staging/serial is not a directory I want.

DT bindings are in DT schema format now. See
Documentation/devicetree/writing-schema.rst.

>  drivers/staging/Kconfig                       |    2 +
>  drivers/staging/Makefile                      |    1 +
>  drivers/staging/si4455/Kconfig                |    8 +
>  drivers/staging/si4455/Makefile               |    2 +
>  drivers/staging/si4455/TODO                   |    3 +
>  drivers/staging/si4455/si4455.c               | 1465 +++++++++++++++++
>  drivers/staging/si4455/si4455_api.h           |   56 +
>  8 files changed, 1576 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
>  create mode 100644 drivers/staging/si4455/Kconfig
>  create mode 100644 drivers/staging/si4455/Makefile
>  create mode 100644 drivers/staging/si4455/TODO
>  create mode 100644 drivers/staging/si4455/si4455.c
>  create mode 100644 drivers/staging/si4455/si4455_api.h
>
> diff --git
> a/Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
> b/Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
> new file mode 100644
> index 000000000000..abd659b7b952
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
> @@ -0,0 +1,39 @@
> +* Silicon Labs Si4455 EASY-TO-USE, LOW-CURRENT OOK/(G)FSK SUB-GHZ
> TRANSCEIVER
> +
> +Required properties:
> +- compatible: Should be one of the following:
> +  - "silabs,si4455" for Silicon Labs Si4455-B1A or Si4455-C2A (driver
> automatically detects the part info),

Either do this or...

> +  - "silabs,si4455b1a" for Silicon Labs Si4455-B1A,
> +  - "silabs,si4455c2a" for Silicon Labs Si4455-C2A,

this. Not both. I assume there's an id register or something you can
read to determine which one. That's fine, but consider if there's any
power sequencing differences that you'd need to handle before you can
read that register.

> +- reg: SPI chip select number.
> +- interrupts: Specifies the interrupt source of the parent interrupt
> +  controller. The format of the interrupt specifier depends on the
> +  parent interrupt controller.
> +- clocks: phandle to the IC source clock (only external clock source
> supported).
> +- spi-max-frequency: maximum clock frequency on SPI port
> +- shdn-gpios: gpio pin for SDN

shutdown-gpios is the semi-standard name.

> +
> +Example:
> +
> +/ {
> +       clocks {
> +                si4455_1_2_osc: si4455_1_2_osc {
> +                        compatible =3D "fixed-clock";
> +                        #clock-cells =3D <0>;
> +                        clock-frequency  =3D <30000000>;
> +                };
> +       };

Don't need to show this for the example.

> +};
> +
> +&spi0 {
> +       si4455: si4455@0 {
> +               compatible =3D "silabs,si4455";
> +               reg =3D <0>;
> +               clocks =3D <&si4455_1_2_osc>;
> +               interrupt-parent =3D <&gpio>;
> +               interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +                shdn-gpios =3D <&gpio 26 1>;
> +                status =3D "okay";

Don't show status in examples.

> +                spi-max-frequency =3D <3000000>;
> +       };
> +};
