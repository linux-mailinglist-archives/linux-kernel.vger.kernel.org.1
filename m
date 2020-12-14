Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93EA2D997C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438676AbgLNOL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:11:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbgLNOLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:11:18 -0500
X-Gm-Message-State: AOAM531AuGeZUphIJ6bFlQ9IS5u4tKsKMYcl8RfxJkWZgQHedl3FRAn+
        rxlBsNsL1CBvfWm7AVkOFHf7U2uLTHh7jyydwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607955031;
        bh=Jzn8l38KRoOLsKkVvnCldWRNNSXncIPTkIkR6xkPitI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H6RJAYtoicuiA77SS89g7/7wgarP1h28KYBi4he/ZpAttxpAIEH+ISSwzXMIOB1nV
         ekLHRVocilZfHlK6f2arL5Pi9XBXnTJEZ7wvC3eb8VAt8UdJAEvI78CYUwCk4YS5RN
         on1OLWBXG2XygQ2ut3NnOJUjEAM4H7r7o87DFCJVXNcx4zWhSvZdS9lw0WQ0Yl7QSI
         rdgbwvcP9sOW2cqf8q9qNUDqB9ns+Xv3BKO93/cjYeoG5yM7nMwJ38wSWH4QqONntf
         NKnY/BGHLKLcORPIGVDD7QMtLYCwW/PNa4N2U7jGjrdGSYlw6BWJZ39G06TcgK0Zki
         Mh0jZIFQVziBw==
X-Google-Smtp-Source: ABdhPJw143/zC9fcc9wUHjIGVkwDKIZ/YUpCE4b6b1HB/jrN8MuTToZ3sZ8F/J1h8qV8oXUR5pUC/R/NxmzaWK1nUlk=
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr24906609edb.137.1607955030122;
 Mon, 14 Dec 2020 06:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20201214025946.25753-1-chris.ruehl@gtsys.com.hk> <20201214025946.25753-2-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201214025946.25753-2-chris.ruehl@gtsys.com.hk>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Dec 2020 08:10:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL0WF-VwnaqhgQyYP0A-2Xp_q==zAw9jS5eoD3P6PmF-A@mail.gmail.com>
Message-ID: <CAL_JsqL0WF-VwnaqhgQyYP0A-2Xp_q==zAw9jS5eoD3P6PmF-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] devicetree: phy: rockchip-emmc optional add vendor prefix
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 9:00 PM Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> Update the documentation and add the vendor prefix to the optional
> properties referred in vendor-prefixes.yaml.
>
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/phy/rockchip-emmc-phy.txt        | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> index 00aa2d349e55..3a55d8086868 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> @@ -13,14 +13,15 @@ Optional properties:
>                 access to it), it is strongly suggested.
>                 See ../clock/clock-bindings.txt for details.
>   - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
> - - drive-impedance-ohm: Specifies the drive impedance in Ohm.
> -                        Possible values are 33, 40, 50, 66 and 100.
> -                        If not set, the default value of 50 will be applied.
> - - enable-strobe-pulldown: Enable internal pull-down for the strobe line.
> -                           If not set, pull-down is not used.
> - - output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
> -                           If not set, the register defaults to 0x4.
> -                           Maximum value 0xf.
> + - rockchip,drive-impedance-ohm: Specifies the drive impedance in Ohm.
> +                                 Possible values are 33, 40, 50, 66 and 100.
> +                                 If not set, the default value of 50 will be
> +                                 applied.

You can't change this one, it's already an ABI. Only what just got
queued can be changed.

> + - rockchip,enable-strobe-pulldown: Enable internal pull-down for the strobe
> +                                    line.  If not set, pull-down is not used.
> + - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
> +                                    If not set, the register defaults to 0x4.
> +                                    Maximum value 0xf.
>
>  Example:
>
> @@ -37,7 +38,7 @@ grf: syscon@ff770000 {
>                 reg = <0xf780 0x20>;
>                 clocks = <&sdhci>;
>                 clock-names = "emmcclk";
> -               drive-impedance-ohm = <50>;
> +               rockchip,drive-impedance-ohm = <50>;
>                 #phy-cells = <0>;
>         };
>  };
> --
> 2.20.1
>
