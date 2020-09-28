Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0407D27A706
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1FmZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 01:42:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47076 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgI1FmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:42:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id b22so9602478lfs.13;
        Sun, 27 Sep 2020 22:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=62VVtrR40xPsUderogAnod9rxvj1xY9G9jJZfGS80Yo=;
        b=ZBCRU0+7mxx5MpYw+evPJ1sUBAJtJyT49zS0OHcaDdGT2BfWm/muyrzPfZeHqjvivy
         p9lIYG/n7NdzLwq/DAXdqn0qeZavNDwJsfo+od7oyFxsrZFcoMrWMkfErdM50vSYde12
         Rz1mRJ+MlsMx0ZJqldn0W2J4xQR2n+A075Htz+pZ/WAuGvNK0+fp5KGlSngUwbMUx7Fs
         w9qvuy+gKwoPQsFilIQaYYsj4xecDzX2Hoz6x9rz+B4P7XiKFTqvz59xjerH6GywUaQ0
         i4U8D1TLVzv+MoDrs9qgD5AGtUzE8IH6WJ1hbeJWvsC17W/nMDPzG3AJI0yd+80vQhRi
         hxWQ==
X-Gm-Message-State: AOAM531N9ZQ+TLkBgYYzkx8P5hdQ7+856vVmFuX7z2fBlu/WThcdruPE
        crGf96YrmlG23dw2LqZX5lLONzR8Jprb2g==
X-Google-Smtp-Source: ABdhPJy08ACqDfnW6h0e/3ef69nBBtJqj9BTQ5YlbPwcOZ8f6+EcB/YhqXG5HKSSWU20+PUcWVEGhA==
X-Received: by 2002:ac2:5f77:: with SMTP id c23mr3651600lfc.568.1601271742726;
        Sun, 27 Sep 2020 22:42:22 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id k3sm2745115lfg.300.2020.09.27.22.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 22:42:22 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z17so9593602lfi.12;
        Sun, 27 Sep 2020 22:42:22 -0700 (PDT)
X-Received: by 2002:a19:c6c8:: with SMTP id w191mr2928439lff.348.1601271742080;
 Sun, 27 Sep 2020 22:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-10-peron.clem@gmail.com>
 <CAGb2v64uAHUd=Ag2pQDqH=gjtPVso5dnKKdCn3ihyiVh8V8L=g@mail.gmail.com>
In-Reply-To: <CAGb2v64uAHUd=Ag2pQDqH=gjtPVso5dnKKdCn3ihyiVh8V8L=g@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 13:42:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v64U9b1Ayq-XNCHb3z6spsds6eDaz3C4EsV9xFOquHrB7w@mail.gmail.com>
Message-ID: <CAGb2v64U9b1Ayq-XNCHb3z6spsds6eDaz3C4EsV9xFOquHrB7w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/20] arm64: dts: allwinner: h6: Add DAI
 node and soundcard for HDMI
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 1:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
> >
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > Add the I2S node used by the HDMI and a simple-soundcard to
> > link audio between HDMI and I2S.
> >
> > Note that the HDMI codec requires an inverted frame clock and
> > a fixed I2S width. As there is no such option for I2S we use
> > TDM property of the simple-soundcard to do that.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index 28c77d6872f6..a8853ee7885a 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -67,6 +67,25 @@ de: display-engine {
> >                 status = "disabled";
> >         };
> >
> > +       hdmi_sound: hdmi-sound {
> > +               compatible = "simple-audio-card";
> > +               simple-audio-card,format = "i2s";
> > +               simple-audio-card,name = "sun50i-h6-hdmi";
> > +               simple-audio-card,mclk-fs = <128>;
> > +               simple-audio-card,frame-inversion;
> > +               status = "disabled";
> > +
> > +               simple-audio-card,codec {
> > +                       sound-dai = <&hdmi>;
> > +               };
> > +
> > +               simple-audio-card,cpu {
> > +                       sound-dai = <&i2s1>;
> > +                       dai-tdm-slot-num = <2>;
>
> Doesn't this end up limiting the number of audio channels HDMI can carry?
> AFAICT the TDM properties are all optional, so just leave it out.
>
> Same goes for the other two patches.
>
> > +                       dai-tdm-slot-width = <32>;
> > +               };
> > +       };
> > +
> >         osc24M: osc24M_clk {
> >                 #clock-cells = <0>;
> >                 compatible = "fixed-clock";
> > @@ -609,6 +628,19 @@ mdio: mdio {
> >                         };
> >                 };
> >
> > +               i2s1: i2s@5091000 {
> > +                       #sound-dai-cells = <0>;
> > +                       compatible = "allwinner,sun50i-h6-i2s";
> > +                       reg = <0x05091000 0x1000>;
> > +                       interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
> > +                       clock-names = "apb", "mod";
> > +                       dmas = <&dma 4>, <&dma 4>;
> > +                       resets = <&ccu RST_BUS_I2S1>;
> > +                       dma-names = "rx", "tx";

Sorry, missed this one.

Given that usage for this interface is transmit only, and there is no
RX DRQ number assigned to it, you should drop the RX DMA number and name.

> > +                       status = "disabled";
> > +               };
> > +
> >                 spdif: spdif@5093000 {
> >                         #sound-dai-cells = <0>;
> >                         compatible = "allwinner,sun50i-h6-spdif";
> > @@ -739,6 +771,7 @@ ohci3: usb@5311400 {
> >                 };
> >
> >                 hdmi: hdmi@6000000 {
> > +                       #sound-dai-cells = <0>;
> >                         compatible = "allwinner,sun50i-h6-dw-hdmi";
> >                         reg = <0x06000000 0x10000>;
> >                         reg-io-width = <1>;
>
> The rest of the patch looks OK.
