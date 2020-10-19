Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC566292194
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 06:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgJSEI5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Oct 2020 00:08:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33508 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJSEI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 00:08:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id l2so12468460lfk.0;
        Sun, 18 Oct 2020 21:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Opolm4cc3xkSXr8hVN2RdLWSRKL0yVq0IDyWQr6WV0k=;
        b=GscUleyt2spXZDRGHkaKkYE81fdHOzks5R3Y23V8FiQ9zf+dhOeMKiqxuLVwLRIN/0
         WQUp2mGmTwJt0BQkPQQnMfsR8pMHc3Xmn2avQrOUF1Xk4U44d0pl0WxYP/wKJCio14Ti
         /IMUT+pJMBhjAx/R6NTBgDCa2j+g2S1Ei3p5O7dmNehW+KAewTZ4XINTsnuik42HKqk4
         dBakYBuUd/XxefqnK1qiqcwU4fQnKZIGLtT79lCTxrBHkRRuScH8AMxZNrBhkoALackI
         YRBJ4pBrR4j9+KvWbo3ilhhppLb/L4AxwENBhGkYwPhhFFIH4MNEYT0Z/dEMdkji0Ysk
         4RVQ==
X-Gm-Message-State: AOAM531NM1n4WRFNGI0So0rtUy4pkVnyY93Rihs6fbHHCm3GWg0p4Twc
        KyQeW70W6r5QeMRv+6PcrKWhyEoXkYo4zg==
X-Google-Smtp-Source: ABdhPJwEz6OkcPzlD7CycirQ8yIGV47azS5wBWf65LJMv7qx0sSRDaBJqnWt4C9IPEdxjpqf9s0Rwg==
X-Received: by 2002:a05:6512:3b1:: with SMTP id v17mr4821004lfp.262.1603080533975;
        Sun, 18 Oct 2020 21:08:53 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m132sm3082487lfa.34.2020.10.18.21.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 21:08:53 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a28so5579022ljn.3;
        Sun, 18 Oct 2020 21:08:53 -0700 (PDT)
X-Received: by 2002:a2e:8116:: with SMTP id d22mr5301246ljg.331.1603080532846;
 Sun, 18 Oct 2020 21:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201018172409.1754775-1-peron.clem@gmail.com> <CAJiuCce+VHusdYPv7QutYvCcCByz=nRcBotPNL6E=jA4U4=YoA@mail.gmail.com>
In-Reply-To: <CAJiuCce+VHusdYPv7QutYvCcCByz=nRcBotPNL6E=jA4U4=YoA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 19 Oct 2020 12:08:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v65szCZyu+Gm0igGmyRGZRwvTr+0O-QYAMyTk8n_V7Ne-Q@mail.gmail.com>
Message-ID: <CAGb2v65szCZyu+Gm0igGmyRGZRwvTr+0O-QYAMyTk8n_V7Ne-Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: beelink-gs1: Enable both RGMII
 RX/TX delay
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 1:57 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> Hi,
>
> On Sun, 18 Oct 2020 at 19:24, Clément Péron <peron.clem@gmail.com> wrote:
> >
> > Before the commit:
> > net: phy: realtek: fix rtl8211e rx/tx delay config
> bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
>
> With the hash for reference it's better :)
> Clement
>
> >
> > The software overwrite for RX/TX delays of the RTL8211e were not
> > working properly and the Beelink GS1 had both RX/TX delay of RGMII
> > interface set using pull-up on the TXDLY and RXDLY pins.
> >
> > Now that these delays are working properly they overwrite the HW
> > config and set this to 'rgmii' meaning no delay on both RX/TX.
> > This makes the ethernet of this board not working anymore.
> >
> > Set the phy-mode to 'rgmii-id' meaning RGMII with RX/TX delays
> > in the device-tree to keep the correct configuration.
> >
> > Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 board")
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

For reference, the driver fix for dwmac enabling the other RGMII modes

    f1239d8aa84d ("net: stmmac: dwmac-sun8i: Allow all RGMII modes")

was merged in v5.5 and was backported to relevant stable kernels.

> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > index a364cb4e5b3f..6ab53860e447 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > @@ -99,7 +99,7 @@ &ehci0 {
> >  &emac {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&ext_rgmii_pins>;
> > -       phy-mode = "rgmii";
> > +       phy-mode = "rgmii-id";
> >         phy-handle = <&ext_rgmii_phy>;
> >         phy-supply = <&reg_aldo2>;
> >         status = "okay";
> > --
> > 2.25.1
> >
