Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ECC2ECA23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 06:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbhAGF1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 00:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAGF1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 00:27:48 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D823C0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 21:27:08 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id 73so1881911uac.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 21:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DL77our55iztoQFTHcrzUPd8D74YCElR4PL+z7wu+tE=;
        b=OjyQY9vIgfuLF929d9DU5SnHiUtSpxLXxLvQtJZ2SZyiA7P3AmVHw+4xzcD07euXZH
         iAeFcVqv2ly3jq3fBIFqHUl7OII9uiJQT5O2ZhI4ERoovHY2bndHVBdfFkqKm9vvkX5R
         pFbb8V7es0KIqSQOUe0KRJlSA5gGBDBsrdyJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DL77our55iztoQFTHcrzUPd8D74YCElR4PL+z7wu+tE=;
        b=GREbgfJfWm6X1GR/zaV8u+FA9qb0mp5JWpQfH/utnvee55jGXRUpe0wotehOdEhBxA
         XnL66DPMN2N/bb+P63pWY1TKARRcyL8sCYH/4gXOhmgzsp/pHSrsKQsRzRAd97TTuILd
         ZGPaVNsiDQkr26g8+um32uNIvHQwWqcyFnFx584KyNKSUVbHGwoF1IsgX6y+bWp6fyaS
         3KrBbSJRU3TcKp10uaknNCV3+zAhFd5tWohYlJt6VAQ7a7VzfrVbtAFk/X+tYH7szsFl
         4+JDzK21vaX59u1F0Mjl1ywv1tqd3oiqWQPwcx7K7gn8ClaNreC1s/rPGjTgskD2Tb6+
         x43w==
X-Gm-Message-State: AOAM532bycG9Z0SI/ntlnpw5gjZSo8FYVabXSZ4aOrDXfac0jLS8OKEj
        pgtyRAhBkAc9fBSPzrksMD02kE0NOpof0yE4vvU5IRWNSrw=
X-Google-Smtp-Source: ABdhPJza3lS4l/BC3JjMmkmHf9Pi95rSoxNXaGQIp2kYtkNvVExUIZyYTCtGmm/WEDb6QKqPXjyKM8SQjMKPBVwMy3Q=
X-Received: by 2002:ab0:74d2:: with SMTP id f18mr6292889uaq.48.1609997226350;
 Wed, 06 Jan 2021 21:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20210107052206.2599844-1-hsinyi@chromium.org>
In-Reply-To: <20210107052206.2599844-1-hsinyi@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 7 Jan 2021 13:26:55 +0800
Message-ID: <CANMq1KCadbb+P9Lm7VD+Eq9UoY5ky9UEZjYOYBFSNj3qM4NKJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: mt8183: config dsi node
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 1:22 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Config dsi node for mt8183 kukui. Set panel and ports.
>
> Several kukui boards share the same panel property and only compatible
> is different. So compatible will be set in board dts for comparison
> convenience.

I like this, but maybe others have different opinions ,-)

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change:
> v2: move compatible to board dts
> ---
>  .../mediatek/mt8183-kukui-krane-sku176.dts    |  5 +++
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 37 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> index 47113e275cb52..721d16f9c3b4f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> @@ -16,3 +16,8 @@ / {
>         model = "MediaTek krane sku176 board";
>         compatible = "google,krane-sku176", "google,krane", "mediatek,mt8183";
>  };
> +
> +&panel {
> +        status = "okay";
> +        compatible = "boe,tv101wum-nl6";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index bf2ad1294dd30..d3d20e4773cf1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -249,6 +249,35 @@ &cpu7 {
>         proc-supply = <&mt6358_vproc11_reg>;
>  };
>
> +&dsi0 {
> +       status = "okay";
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       panel: panel@0 {
> +               // compatible will be set in board dts
> +               reg = <0>;
> +               enable-gpios = <&pio 45 0>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&panel_pins_default>;
> +               avdd-supply = <&ppvarn_lcd>;
> +               avee-supply = <&ppvarp_lcd>;
> +               pp1800-supply = <&pp1800_lcd>;
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&dsi_out>;
> +                       };
> +               };
> +       };
> +
> +       ports {
> +               port {
> +                       dsi_out: endpoint {
> +                               remote-endpoint = <&panel_in>;
> +                       };
> +               };
> +       };
> +};
> +
>  &i2c0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c0_pins>;
> @@ -547,6 +576,14 @@ pins_clk {
>                 };
>         };
>
> +       panel_pins_default: panel_pins_default {
> +               panel_reset {
> +                       pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
> +                       output-low;
> +                       bias-pull-up;
> +               };
> +       };
> +
>         pwm0_pin_default: pwm0_pin_default {
>                 pins1 {
>                         pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
> --
> 2.29.2.729.g45daf8777d-goog
>
