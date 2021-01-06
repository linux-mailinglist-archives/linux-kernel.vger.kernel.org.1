Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6B2EBCAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbhAFKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFKt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:49:26 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DFC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:48:57 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id e15so1575834vsa.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65bthvYlj9KKIS5KK6JhxNYJMD8s4MDQLZpfgKqd4vM=;
        b=X7GGMa423pBbYfE4+HR39/XGdoDcfr3nbm8+IarZvID4Pf5pRICqedHoV1eEljrqvh
         1wjAGleOvGRLUtM2TA6SjwweF91aOSKSAHJQ+VWXnmcAOjDSGBetJbOtEXmvkzoISqnO
         gun7Yry+f4793b7Iq7Mmya8p7nFGc8lI/3GsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65bthvYlj9KKIS5KK6JhxNYJMD8s4MDQLZpfgKqd4vM=;
        b=bRQFJfGwXDY46SUDZ117fVA1UXr9Zg1gxs+Mz01DCQYtHf+xBEDAGWOxrhPxLYZtYe
         3Xm/vluCFA6Zp9BoPV/4YgX7u89so+KYLBT/QJXT7RGryrHANKmsRqp7ehyT7g4IeLjj
         WGC1SRmjqAvaI8JW+otHOTVIwexQWyoGqsoWuNmeFOpZRK6CAT//rMwWB3cI6Rmd43AZ
         SCiKtCtzN62kfyvhw6KSa7fcW8Iwt1a9gV2GXaJPZ4FOJ04Kcs5UDl6ZECDG2/KmOaXr
         g8cgny3R5zXkodaKlOag347pwsyvIWz+hLChereZlNPnzDPRjjyB0hd6ZaPLVJVcl7Jg
         Bepw==
X-Gm-Message-State: AOAM532W6fNIv7fH6YTCd3rXwK6YqznfQ7dQxI12XPLHB6zl5sV1KhMS
        F7qHjDuR6qxbVgD/FxKznhXJnl5R01nAs/xgSi7HTg==
X-Google-Smtp-Source: ABdhPJz9ON8BwWq+VaecVefOOUeLpjkYUuNp9NU/OAWS/f/jzOReQa42tBRohJ5XkaU0WXUWBPttXpWvspWnaIv70xQ=
X-Received: by 2002:a67:5c03:: with SMTP id q3mr2560878vsb.47.1609930136255;
 Wed, 06 Jan 2021 02:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20210106084626.2181286-1-hsinyi@chromium.org> <CANMq1KAoboK45uOhKMYZ-=TvBBQRZhEeij=ha6MqSKZiYx64eQ@mail.gmail.com>
In-Reply-To: <CANMq1KAoboK45uOhKMYZ-=TvBBQRZhEeij=ha6MqSKZiYx64eQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 6 Jan 2021 18:48:45 +0800
Message-ID: <CANMq1KDGUSGE5Vb3WQMhgECkBL_PTMHnS+8wTP6W0Uhhv9RJJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: config dsi node
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

On Wed, Jan 6, 2021 at 6:47 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Wed, Jan 6, 2021 at 4:46 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Config dsi node for mt8183 kukui. Set panel and ports.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index bf2ad1294dd30..4cfb3560e5d11 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -249,6 +249,36 @@ &cpu7 {
> >         proc-supply = <&mt6358_vproc11_reg>;
> >  };
> >
> > +&dsi0 {
> > +       status = "okay";
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +       panel: panel@0 {
> > +               compatible = "boe,tv101wum-nl6";
>
> We're going to have many panels in the kukui family, so I think I'd
> prefer it if you moved the compatible string to krane-sku0 dts: it
> makes it easier to figure out what's different with sku0.

I meant sku176 (since you are adding sku0 with a different panel
compatible later).

>
> Then maybe leave all the other properties in this file, as it seems
> like all MIPI panels use the exact same pin/supplies?
>
> (And add a comment here saying that the compatible needs to be set in
> board dts?)
>
> > +               reg = <0>;
> > +               enable-gpios = <&pio 45 0>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&panel_pins_default>;
> > +               avdd-supply = <&ppvarn_lcd>;
> > +               avee-supply = <&ppvarp_lcd>;
> > +               pp1800-supply = <&pp1800_lcd>;
> > +               status = "okay";
> > +               port {
> > +                       panel_in: endpoint {
> > +                               remote-endpoint = <&dsi_out>;
> > +                       };
> > +               };
> > +       };
> > +
> > +       ports {
> > +               port {
> > +                       dsi_out: endpoint {
> > +                               remote-endpoint = <&panel_in>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> >  &i2c0 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&i2c0_pins>;
> > @@ -547,6 +577,14 @@ pins_clk {
> >                 };
> >         };
> >
> > +       panel_pins_default: panel_pins_default {
> > +               panel_reset {
> > +                       pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
> > +                       output-low;
> > +                       bias-pull-up;
> > +               };
> > +       };
> > +
> >         pwm0_pin_default: pwm0_pin_default {
> >                 pins1 {
> >                         pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
> > --
> > 2.29.2.729.g45daf8777d-goog
> >
