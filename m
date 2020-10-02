Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13ECB281756
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbgJBQBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:01:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADCC0613D0;
        Fri,  2 Oct 2020 09:01:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so2048524iol.10;
        Fri, 02 Oct 2020 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djx2E1NwbIz4/NZf9pUZHpgnzpKYA44NN+Q6dr4EQBY=;
        b=VOR2gMTsMF6YapeksUWrfxuuAonuvm7dyeNpVx9In8aGbHotqpoTp2kPpH9tJMnKd0
         MwlDHqMPU/qxAiLIrntySAJ2F3QSZMHfjitSZ4qs8HhpyDW9pLJEuOlnaUu9Fbx1STLP
         L7jG2/EywJPwzl57SDzNq8n3Q8upBdCBHO8SE4Q95EzDzHnekbehmmjpvQiJ38c4w3d5
         I06XIghpFSFn+xXvsH4An6TPEpaG3HwOekq32V+DavFdKvEgCnmw8WVJPhSpTungpf42
         FQ4BKfASHwV4Xcmx78Keu9hYXx+x6ftUzKcm1sp3K1nj+8x81GN7oc4yOO0YG0fHc/cu
         fu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djx2E1NwbIz4/NZf9pUZHpgnzpKYA44NN+Q6dr4EQBY=;
        b=nmlPKetAxhto/ao46PNpt1a45QtGw1ndLP4dN44vHQn2lNwUinAJmaGjJySUEeldoo
         rSahQOMF6cpZ/HxSCbVcJPqgblwxjU/hQ3Cgfwv1GEcch5NQ76twxG2zluWN92Iy2W3S
         WGDlQamkg1ZcpGWqEAXOa2hMFY5L1ayOG9zA+7O6drW4GuJNaoUAQtGk4FvlRqLgSf+E
         UpDUNxTrPurUccaemEH0j6tczUdkHtBSqcfUXFWFMFQbuGAGYrGTMTH8szSYL30jG3bq
         +y29mZVyOFOuOQkBJNruKvZ3CAR/aYGq6snA1SfMTMjxjvb9VeGHZoQeiUVYLyEBEth7
         eNiQ==
X-Gm-Message-State: AOAM532/5xgas/6w+Mk8mlT1LXvouLrSP/OcQ++CEn2JnwCVEPuTsk+P
        QDOzBcG4+K3ETO5P3L/XqmWuVDDkWba/Z9tpA04=
X-Google-Smtp-Source: ABdhPJzr6hI4rDHBo9EOgqPBQNjU8Ul0TWnkEY/jKqZML69oSKgD/moghYTeu46CCisvwf7vmiU36Zt8SWWVPT/jWho=
X-Received: by 2002:a5d:8ace:: with SMTP id e14mr2463373iot.124.1601654492346;
 Fri, 02 Oct 2020 09:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-10-peron.clem@gmail.com>
 <CAGb2v64uAHUd=Ag2pQDqH=gjtPVso5dnKKdCn3ihyiVh8V8L=g@mail.gmail.com> <CAGb2v64U9b1Ayq-XNCHb3z6spsds6eDaz3C4EsV9xFOquHrB7w@mail.gmail.com>
In-Reply-To: <CAGb2v64U9b1Ayq-XNCHb3z6spsds6eDaz3C4EsV9xFOquHrB7w@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 2 Oct 2020 18:01:21 +0200
Message-ID: <CAJiuCcfThSqpobeZW7ugnmokc4Xy0n9o+5jvOfP9eqzvDbu_BQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/20] arm64: dts: allwinner: h6: Add DAI
 node and soundcard for HDMI
To:     Chen-Yu Tsai <wens@csie.org>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Mon, 28 Sep 2020 at 07:42, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Sep 28, 2020 at 1:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Mon, Sep 28, 2020 at 3:29 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gma=
il.com> wrote:
> > >
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > Add the I2S node used by the HDMI and a simple-soundcard to
> > > link audio between HDMI and I2S.
> > >
> > > Note that the HDMI codec requires an inverted frame clock and
> > > a fixed I2S width. As there is no such option for I2S we use
> > > TDM property of the simple-soundcard to do that.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++=
++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h6.dtsi
> > > index 28c77d6872f6..a8853ee7885a 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -67,6 +67,25 @@ de: display-engine {
> > >                 status =3D "disabled";
> > >         };
> > >
> > > +       hdmi_sound: hdmi-sound {
> > > +               compatible =3D "simple-audio-card";
> > > +               simple-audio-card,format =3D "i2s";
> > > +               simple-audio-card,name =3D "sun50i-h6-hdmi";
> > > +               simple-audio-card,mclk-fs =3D <128>;
> > > +               simple-audio-card,frame-inversion;
> > > +               status =3D "disabled";
> > > +
> > > +               simple-audio-card,codec {
> > > +                       sound-dai =3D <&hdmi>;
> > > +               };
> > > +
> > > +               simple-audio-card,cpu {
> > > +                       sound-dai =3D <&i2s1>;
> > > +                       dai-tdm-slot-num =3D <2>;
> >
> > Doesn't this end up limiting the number of audio channels HDMI can carr=
y?
> > AFAICT the TDM properties are all optional, so just leave it out.
> >
> > Same goes for the other two patches.
> >
> > > +                       dai-tdm-slot-width =3D <32>;
> > > +               };
> > > +       };
> > > +
> > >         osc24M: osc24M_clk {
> > >                 #clock-cells =3D <0>;
> > >                 compatible =3D "fixed-clock";
> > > @@ -609,6 +628,19 @@ mdio: mdio {
> > >                         };
> > >                 };
> > >
> > > +               i2s1: i2s@5091000 {
> > > +                       #sound-dai-cells =3D <0>;
> > > +                       compatible =3D "allwinner,sun50i-h6-i2s";
> > > +                       reg =3D <0x05091000 0x1000>;
> > > +                       interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIG=
H>;
> > > +                       clocks =3D <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S=
1>;
> > > +                       clock-names =3D "apb", "mod";
> > > +                       dmas =3D <&dma 4>, <&dma 4>;
> > > +                       resets =3D <&ccu RST_BUS_I2S1>;
> > > +                       dma-names =3D "rx", "tx";
>
> Sorry, missed this one.
>
> Given that usage for this interface is transmit only, and there is no
> RX DRQ number assigned to it, you should drop the RX DMA number and name.

Indeed if there is no DRQ number assigned we shouldn't have it in the
device-tree

but Samuel told me that the `make dtbs_check` reports:

i2s@1c22800: dma-names:0: 'rx' was expected
i2s@1c22800: dma-names: ['tx'] is too short
i2s@1c22800: dmas: [[28, 27]] is too short

Should I fix the YAML so?

Regards,
Clement

>
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > >                 spdif: spdif@5093000 {
> > >                         #sound-dai-cells =3D <0>;
> > >                         compatible =3D "allwinner,sun50i-h6-spdif";
> > > @@ -739,6 +771,7 @@ ohci3: usb@5311400 {
> > >                 };
> > >
> > >                 hdmi: hdmi@6000000 {
> > > +                       #sound-dai-cells =3D <0>;
> > >                         compatible =3D "allwinner,sun50i-h6-dw-hdmi";
> > >                         reg =3D <0x06000000 0x10000>;
> > >                         reg-io-width =3D <1>;
> >
> > The rest of the patch looks OK.
