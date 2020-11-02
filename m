Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD02A28F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgKBLT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:19:57 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3FEC0617A6;
        Mon,  2 Nov 2020 03:19:55 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id o11so3258984ioo.11;
        Mon, 02 Nov 2020 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jGIEcHWVxAn3fg0VUHHhYb4aY1F4L9zbPIcUYHsHdk=;
        b=rBX5rTWOyGpQ2QFTArzJXmF9gLj+2qHhpHtq5IccV7K+4i7zEXERiFzL57WJY+4iQX
         5w0fUre1grj24vaBMH4+zK7WtUSE8xQPv4kQQ4ei/rRCO4LldWrvf/9hKf42vlAGlXh1
         S6rGwf6r7WPzLzC69ZwHgXnKZcLHvQZ4G6qYWpkNYPNRzPt/Ydho3dPSUhMcYe66Yvos
         GRyLWQhkTcYclNim1YmzvP6WdrUg5vLj8RXCXeaDuKrMbcSbECG9iMPKJ8Y950kSDDeS
         4jzMIKZLYmwqonUIn4A+5TMDkyxlRfD/Kq7j7k7iNGtH7nQ9mJKXt4IuKLpdAzDGkIAk
         tNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jGIEcHWVxAn3fg0VUHHhYb4aY1F4L9zbPIcUYHsHdk=;
        b=a3On//kst+1WTSBntiJRg3Cap9qazcudokWEqkRjBM4Ajp3joQYAYYblo8pvesk8xj
         qMkKaxVEZGHFNGMUYRTKGiu8rMqMMTQV1HJzWul7CSSKIJ1aYaQDT1CYz4/HMUUu+w25
         g9AtjvXtzn0xkOd69O88xXkdVjef9R9z/jjAPCnz5b56xuzhYgmRbXERoTUx6l6HrOmo
         U8xex6HAZYrVIlS4Jewt4WjKwmwysbEW9+U6/k+Oyqw18nXyH3PYw0ujxYQF3cw+oey0
         DoExWSN94iwHg9klfZr3pLPoyBxihmVCtrCa3Nxse1iTxnepssHL0VNwnTlz17zWlNln
         BmqA==
X-Gm-Message-State: AOAM5334uIxvF8ryfkfvsyiyyqigtjrG7SsCwFy58eUY3Y/KoTWbka23
        lempcfsB0AQTjoVQRoJbJiIHgLBivGAl5J1GrcRhQyeXRxFLzg==
X-Google-Smtp-Source: ABdhPJx/Qx/ZXs30Y9m8IaogsMishx8Ib+4C2FwhUAGSo+27iaGj5JH/Ee9nIxebt9ovk2o2pSt6QQWjg3AgHAMVA3A=
X-Received: by 2002:a05:6602:164b:: with SMTP id y11mr3299604iow.36.1604315995103;
 Mon, 02 Nov 2020 03:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20200921102731.747736-1-peron.clem@gmail.com> <20200921135925.q7mde2cnt5jtzkb5@gilmour.lan>
 <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
 <59286578.E0qSRroNqr@kista> <20200928084308.eipnvlfqe3c5lfmg@gilmour.lan>
 <CAJiuCceHXr_5PvG-FW+hRNV7Q33hGrp8kLbO0EgfqqBxF7wbqQ@mail.gmail.com>
 <20200930101915.sultshdvxgu5u2rs@gilmour.lan> <CAJiuCcdMbMQGoBG-SmgQ5=25v3AB+kh0H8ZdX7rFMHAXQ2A=QA@mail.gmail.com>
 <20201102102117.hp6v5nnkhzp3bful@gilmour.lan>
In-Reply-To: <20201102102117.hp6v5nnkhzp3bful@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 2 Nov 2020 12:19:44 +0100
Message-ID: <CAJiuCceXBBWLCg6pgH389m8itauHkfcvVoe-EgnZxnQx3xrzMg@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
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

Hi Maxime,

On Mon, 2 Nov 2020 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Nov 01, 2020 at 04:27:05PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Wed, 30 Sep 2020 at 12:19, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 04:27:42PM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > On Mon, 28 Sep 2020 at 10:43, Maxime Ripard <maxime@cerno.tech> wro=
te:
> > > > >
> > > > > On Mon, Sep 21, 2020 at 08:37:09PM +0200, Jernej =C5=A0krabec wro=
te:
> > > > > > Dne ponedeljek, 21. september 2020 ob 19:23:49 CEST je Cl=C3=A9=
ment P=C3=A9ron
> > > > > > napisal(a):
> > > > > > > Hi Maxime,
> > > > > > >
> > > > > > > On Mon, 21 Sep 2020 at 15:59, Maxime Ripard <maxime@cerno.tec=
h> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 21, 2020 at 12:27:18PM +0200, Cl=C3=A9ment P=C3=
=A9ron wrote:
> > > > > > > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > > > > >
> > > > > > > > > Add a simple-soundcard to link audio between HDMI and I2S=
.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > > > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.=
com>
> > > > > > > > > ---
> > > > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++=
++++++++++++++
> > > > > > > > >  1 file changed, 33 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi=
 b/arch/arm64/
> > > > > > boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > > > > index 28c77d6872f6..a8853ee7885a 100644
> > > > > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > > > > @@ -67,6 +67,25 @@ de: display-engine {
> > > > > > > > >               status =3D "disabled";
> > > > > > > > >       };
> > > > > > > > >
> > > > > > > > > +     hdmi_sound: hdmi-sound {
> > > > > > > > > +             compatible =3D "simple-audio-card";
> > > > > > > > > +             simple-audio-card,format =3D "i2s";
> > > > > > > > > +             simple-audio-card,name =3D "sun50i-h6-hdmi"=
;
> > > > > > > > > +             simple-audio-card,mclk-fs =3D <128>;
> > > > > > > > > +             simple-audio-card,frame-inversion;
> > > > > > > > > +             status =3D "disabled";
> > > > > > > > > +
> > > > > > > > > +             simple-audio-card,codec {
> > > > > > > > > +                     sound-dai =3D <&hdmi>;
> > > > > > > > > +             };
> > > > > > > > > +
> > > > > > > > > +             simple-audio-card,cpu {
> > > > > > > > > +                     sound-dai =3D <&i2s1>;
> > > > > > > > > +                     dai-tdm-slot-num =3D <2>;
> > > > > > > > > +                     dai-tdm-slot-width =3D <32>;
> > > > > > > >
> > > > > > > > It looks weird to have both some TDM setup here, and yet th=
e format in
> > > > > > > > i2s?
> >
> >
> > I was looking at sound documentation regarding how I can properly
> > write the multi-lane I2S support.
> > And I think we made a wrong interpretation here.
> >
> > TDM slot-num and slot-width are not referencing the format called PCM
> > or DSP_A / DSP_B.
> > But really the physical time division representation of a format.
> >
> > For example Amlogic do the following representation for Multi-lane I2S:
> >
> > dai-link-7 {
> >     sound-dai =3D <&tdmif_b>;
> >     dai-format =3D "i2s";
> >     dai-tdm-slot-tx-mask-0 =3D <1 1>;
> >     dai-tdm-slot-tx-mask-1 =3D <1 1>;
> >     dai-tdm-slot-tx-mask-2 =3D <1 1>;
> >     dai-tdm-slot-tx-mask-3 =3D <1 1>;
> >     mclk-fs =3D <256>;
> >
> >     codec {
> >         sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_B>;
> >     };
> > };
> >
> > So i think for 2 channels HDMI using the simple sound card with TDM
> > property is not a hack but the correct way to represent it.
> >
> > Do you agree ?
> >
> > If so, can I resend the simple sound card for HDMI audio ?
>
> I mean, it's not less weird :)
>
> And like I said before we still have the option to write a card driver
> ourselves that doesn't take anything from the DT beside the phandle of
> the i2s controller and the HDMI controller.
>
> If it's a fixed configuration, I'm not sure why we bother trying to make
> it dynamic in the DT.

Ok I see what you mean here, as the link is hardcoded in the SoC it's
a better representation to hardcode it in the sound card driver than
having it dynamically represented in each board device-tree.

Sounds correct for me,
Thanks :)

>
> Maxime
