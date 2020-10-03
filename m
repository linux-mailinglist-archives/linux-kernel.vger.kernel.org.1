Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB760282326
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 11:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgJCJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJCJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 05:32:27 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803EC0613D0;
        Sat,  3 Oct 2020 02:32:26 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f15so3461821ilj.2;
        Sat, 03 Oct 2020 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4WQdhvBY7Cu+BKjdKPqvJ/Sk6eBScmJA1Il/OJIwbPY=;
        b=rDgBrnRUVr0DmKj+rS3jI7rJF4bvwpd9IFiBZWo/PewjFMH9pC0KVJPsqhs9JpH3ok
         232gvsoNInvADJblNqWm8QHatzpimcvt3MY7GJbQlJr3nDPzukg9bSmbtYfmakKrjdEc
         UCD1BWfPhzLa7s4kz9hHJ3YLSZZuZHI/qZ5RFEW/XPbv608NrQc6DyvXlc0G7bp5ycOf
         1DPg4IKIpPBbrTUY6jywxcWSAzHLd+CfYTmoEOBWTbOwz49gpIqNmO9Sw3uPWF2Exrbu
         g2m0o7oXwUi4GZBpT0r1d9xqIs7WJI896pLleRDSyqrQiFZVjIALR08QxGHvXUOBGw8J
         DFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4WQdhvBY7Cu+BKjdKPqvJ/Sk6eBScmJA1Il/OJIwbPY=;
        b=X6PK5kPDjuqkRJp7YOYLxkshZfvOFHwcjdBRKUQ2VelV91+Wnd5VdyPxPVDG+hzJdG
         zFnuFkxMk7PqM0ZBWkcZ8Nl8n/h2j3Do4B2x85c1clxlbzG+kBE7yHby2x4nxoEm6skW
         s/sq3JKP3ccKB5Imlbmeor9sXyBoloLKJ3KmoAjbFrEFnrJ+8Hrd92JxoxuEzbtLtsLh
         EvkwL4HADWARj8xFWBr7GccX6yqNm6xooQFnfY4eByX42y/Te2OgsV8+wU7tDDUC+VfV
         xgWo2GZghFa5plt4xVKkTKbMwjSPo0tuRV+96l45IoUB07oeHwllZxmTVWwwu7WbjdD9
         i5rQ==
X-Gm-Message-State: AOAM531ua002u1IryL6Wqxs9y+ZZoU3hyg52BXWxhHqvvCbCwIwvSnz0
        d5hoI22BxAjKPVtaDupOqlp+6KlnzDJgaKsl15E=
X-Google-Smtp-Source: ABdhPJwznevI08Npwv/RTZ1m5OlGQQK2mF55vXywQ3Oe368RprFs3Wb7KZq9VD5M6dksP3D8DwkZVXut+VNuWVOmC7s=
X-Received: by 2002:a05:6e02:804:: with SMTP id u4mr4609563ilm.35.1601717546019;
 Sat, 03 Oct 2020 02:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-10-peron.clem@gmail.com>
 <CAGb2v64uAHUd=Ag2pQDqH=gjtPVso5dnKKdCn3ihyiVh8V8L=g@mail.gmail.com>
 <CAGb2v64U9b1Ayq-XNCHb3z6spsds6eDaz3C4EsV9xFOquHrB7w@mail.gmail.com>
 <CAJiuCcfThSqpobeZW7ugnmokc4Xy0n9o+5jvOfP9eqzvDbu_BQ@mail.gmail.com> <20201002162434.3jeksuelrig6yyo5@gilmour.lan>
In-Reply-To: <20201002162434.3jeksuelrig6yyo5@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 3 Oct 2020 11:32:14 +0200
Message-ID: <CAJiuCccfJP4VTrpVN0ez900zWZSUbP703Hx2qa-NKdGrXwiFyQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/20] arm64: dts: allwinner: h6: Add DAI
 node and soundcard for HDMI
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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

Hi,

On Fri, 2 Oct 2020 at 18:24, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, Oct 02, 2020 at 06:01:21PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Chen-Yu,
> >
> > On Mon, 28 Sep 2020 at 07:42, Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 1:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > >
> > > > On Mon, Sep 28, 2020 at 3:29 AM Cl=C3=A9ment P=C3=A9ron <peron.clem=
@gmail.com> wrote:
> > > > >
> > > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > >
> > > > > Add the I2S node used by the HDMI and a simple-soundcard to
> > > > > link audio between HDMI and I2S.
> > > > >
> > > > > Note that the HDMI codec requires an inverted frame clock and
> > > > > a fixed I2S width. As there is no such option for I2S we use
> > > > > TDM property of the simple-soundcard to do that.
> > > > >
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++=
++++++
> > > > >  1 file changed, 33 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/=
arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > index 28c77d6872f6..a8853ee7885a 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > @@ -67,6 +67,25 @@ de: display-engine {
> > > > >                 status =3D "disabled";
> > > > >         };
> > > > >
> > > > > +       hdmi_sound: hdmi-sound {
> > > > > +               compatible =3D "simple-audio-card";
> > > > > +               simple-audio-card,format =3D "i2s";
> > > > > +               simple-audio-card,name =3D "sun50i-h6-hdmi";
> > > > > +               simple-audio-card,mclk-fs =3D <128>;
> > > > > +               simple-audio-card,frame-inversion;
> > > > > +               status =3D "disabled";
> > > > > +
> > > > > +               simple-audio-card,codec {
> > > > > +                       sound-dai =3D <&hdmi>;
> > > > > +               };
> > > > > +
> > > > > +               simple-audio-card,cpu {
> > > > > +                       sound-dai =3D <&i2s1>;
> > > > > +                       dai-tdm-slot-num =3D <2>;
> > > >
> > > > Doesn't this end up limiting the number of audio channels HDMI can =
carry?
> > > > AFAICT the TDM properties are all optional, so just leave it out.
> > > >
> > > > Same goes for the other two patches.
> > > >
> > > > > +                       dai-tdm-slot-width =3D <32>;
> > > > > +               };
> > > > > +       };
> > > > > +
> > > > >         osc24M: osc24M_clk {
> > > > >                 #clock-cells =3D <0>;
> > > > >                 compatible =3D "fixed-clock";
> > > > > @@ -609,6 +628,19 @@ mdio: mdio {
> > > > >                         };
> > > > >                 };
> > > > >
> > > > > +               i2s1: i2s@5091000 {
> > > > > +                       #sound-dai-cells =3D <0>;
> > > > > +                       compatible =3D "allwinner,sun50i-h6-i2s";
> > > > > +                       reg =3D <0x05091000 0x1000>;
> > > > > +                       interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL=
_HIGH>;
> > > > > +                       clocks =3D <&ccu CLK_BUS_I2S1>, <&ccu CLK=
_I2S1>;
> > > > > +                       clock-names =3D "apb", "mod";
> > > > > +                       dmas =3D <&dma 4>, <&dma 4>;
> > > > > +                       resets =3D <&ccu RST_BUS_I2S1>;
> > > > > +                       dma-names =3D "rx", "tx";
> > >
> > > Sorry, missed this one.
> > >
> > > Given that usage for this interface is transmt only, and there is no
> > > RX DRQ number assigned to it, you should drop the RX DMA number and n=
ame.
> >
> > Indeed if there is no DRQ number assigned we shouldn't have it in the
> > device-tree

After reviewing the H6 User Manual it seems to be assigned :
page 269 3.10.3.3 DRQ TYPE
port 4 =3D> I2S/PCM1-RX /  I2S/PCM1-TX
Same for A64
But indeed it's not mapped for H5.

I will fix the yaml for H3/H5 but not for A64/H6.

Regards,
Clement


> >
> > but Samuel told me that the `make dtbs_check` reports:
> >
> > i2s@1c22800: dma-names:0: 'rx' was expected
> > i2s@1c22800: dma-names: ['tx'] is too short
> > i2s@1c22800: dmas: [[28, 27]] is too short
> >
> > Should I fix the YAML so?
>
> Yep :)
>
> Maxime
