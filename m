Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75D82A1F0B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgKAP1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgKAP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:27:18 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9FC0617A6;
        Sun,  1 Nov 2020 07:27:17 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y17so10796775ilg.4;
        Sun, 01 Nov 2020 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sb+LSb8yKLdTuo/XIIeo90tsZCqN/YP0x/T/FxuDBAI=;
        b=UwR8SDbrSrYwV9KAxX280xwIhir4IekFmY1Jy0kT1/cM9oDYhC8NK7Dd5ohYWO+w5j
         FuIeOlbBOYTjMY9SSqDBNrlkPWk78ru0QVp97+hekk0OrBe7hlDHvwXh3kh8ZekCLKIf
         3cR6PBOXRUPZ7Tg+GynBO13LAQnzHm5S65HkpxMJ5laybeeSKGSOEnG3B/bfK+ARYX7g
         ETpJIrFVqzDsFNRd9We5ZK+35lxSEe0htDajTKttsTzIMM7Vp+UHxONTvo1hs633OFas
         rLn4RfdXzW1j//a7MtxZiJRFq72HbFnoivkr5c2NyG3jGMxpJ5a1FL2YLYjPIEEkDCz8
         vt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sb+LSb8yKLdTuo/XIIeo90tsZCqN/YP0x/T/FxuDBAI=;
        b=cMbkXbVoB39Dc06FyiZl1uTS8DuRPRtEFMaMVAfkmfHdRKXkirSDCIHY2QJuf0yLKo
         XXQhK62zGJK1JX6ZuqW2XKdRp79IP7Ri4RoJ/KPEtOdXmOvB3mjtxfVdGV8FruFoWfsn
         W1CYIyjETDpRA71KjqBkFvBhZg+qbRaH2ITsaHb+j5W29bpZOX499K4cTlCoMYYQcVAd
         e+6IpZk8Y0DzjJziHqjrM/Odw1m+Jf9vofhGPglVanUTZwbrEq5+fNNKGOQuPjw42WMH
         zy7qVFdIBtL1SCN0IfoHmuex+1jJkA6yfkq/jTHaP86SZnQIRGdTYjmXD8GhXrhjedd1
         xKQA==
X-Gm-Message-State: AOAM53277iXUbDoh7VFZjxWSPWNhrGp7p8r0cR1TXa7RaMTuQ6bt0YkP
        jAYFyAgqdUYszdTr+jdR3TQp8edssSrEEbF5s00=
X-Google-Smtp-Source: ABdhPJwEoz5zwAAz8pt9hCeMJDV9sIBKK1MQ5RDf7d6jvzgiKzk3xcC3XFBUC8hxC5HXm28oB8fAmqySvt/+MD/uLP4=
X-Received: by 2002:a92:5b46:: with SMTP id p67mr7738499ilb.150.1604244436992;
 Sun, 01 Nov 2020 07:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20200921102731.747736-1-peron.clem@gmail.com> <20200921135925.q7mde2cnt5jtzkb5@gilmour.lan>
 <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
 <59286578.E0qSRroNqr@kista> <20200928084308.eipnvlfqe3c5lfmg@gilmour.lan>
 <CAJiuCceHXr_5PvG-FW+hRNV7Q33hGrp8kLbO0EgfqqBxF7wbqQ@mail.gmail.com> <20200930101915.sultshdvxgu5u2rs@gilmour.lan>
In-Reply-To: <20200930101915.sultshdvxgu5u2rs@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 1 Nov 2020 16:27:05 +0100
Message-ID: <CAJiuCcdMbMQGoBG-SmgQ5=25v3AB+kh0H8ZdX7rFMHAXQ2A=QA@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
To:     Maxime Ripard <maxime@cerno.tech>, Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
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


On Wed, 30 Sep 2020 at 12:19, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 28, 2020 at 04:27:42PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Mon, 28 Sep 2020 at 10:43, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > On Mon, Sep 21, 2020 at 08:37:09PM +0200, Jernej =C5=A0krabec wrote:
> > > > Dne ponedeljek, 21. september 2020 ob 19:23:49 CEST je Cl=C3=A9ment=
 P=C3=A9ron
> > > > napisal(a):
> > > > > Hi Maxime,
> > > > >
> > > > > On Mon, 21 Sep 2020 at 15:59, Maxime Ripard <maxime@cerno.tech> w=
rote:
> > > > > >
> > > > > > On Mon, Sep 21, 2020 at 12:27:18PM +0200, Cl=C3=A9ment P=C3=A9r=
on wrote:
> > > > > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > > >
> > > > > > > Add a simple-soundcard to link audio between HDMI and I2S.
> > > > > > >
> > > > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++=
++++++++++
> > > > > > >  1 file changed, 33 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/a=
rch/arm64/
> > > > boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > > index 28c77d6872f6..a8853ee7885a 100644
> > > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > > @@ -67,6 +67,25 @@ de: display-engine {
> > > > > > >               status =3D "disabled";
> > > > > > >       };
> > > > > > >
> > > > > > > +     hdmi_sound: hdmi-sound {
> > > > > > > +             compatible =3D "simple-audio-card";
> > > > > > > +             simple-audio-card,format =3D "i2s";
> > > > > > > +             simple-audio-card,name =3D "sun50i-h6-hdmi";
> > > > > > > +             simple-audio-card,mclk-fs =3D <128>;
> > > > > > > +             simple-audio-card,frame-inversion;
> > > > > > > +             status =3D "disabled";
> > > > > > > +
> > > > > > > +             simple-audio-card,codec {
> > > > > > > +                     sound-dai =3D <&hdmi>;
> > > > > > > +             };
> > > > > > > +
> > > > > > > +             simple-audio-card,cpu {
> > > > > > > +                     sound-dai =3D <&i2s1>;
> > > > > > > +                     dai-tdm-slot-num =3D <2>;
> > > > > > > +                     dai-tdm-slot-width =3D <32>;
> > > > > >
> > > > > > It looks weird to have both some TDM setup here, and yet the fo=
rmat in
> > > > > > i2s?


I was looking at sound documentation regarding how I can properly
write the multi-lane I2S support.
And I think we made a wrong interpretation here.

TDM slot-num and slot-width are not referencing the format called PCM
or DSP_A / DSP_B.
But really the physical time division representation of a format.

For example Amlogic do the following representation for Multi-lane I2S:

dai-link-7 {
    sound-dai =3D <&tdmif_b>;
    dai-format =3D "i2s";
    dai-tdm-slot-tx-mask-0 =3D <1 1>;
    dai-tdm-slot-tx-mask-1 =3D <1 1>;
    dai-tdm-slot-tx-mask-2 =3D <1 1>;
    dai-tdm-slot-tx-mask-3 =3D <1 1>;
    mclk-fs =3D <256>;

    codec {
        sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_B>;
    };
};

So i think for 2 channels HDMI using the simple sound card with TDM
property is not a hack but the correct way to represent it.

Do you agree ?

If so, can I resend the simple sound card for HDMI audio ?

Thanks,
Clement

> > > > >
> > > > > Yes, I agree I will check if it's really needed.
> > > >
> > > > I think this was explained before.
> > >
> > > Possibly, but this should be in a comment or at least the commit log
> > >
> > > > Anyway, this is needed to force width to 32, no matter actual sampl=
e
> > > > width. That's a requirement of HDMI codec. I believe Marcus Cooper
> > > > have another codec which also needs fixed width.
> > > >
> > > > There is no similar property for I2S, so TDM one is used here.
> > >
> > > Except it's really dedicated to the TDM mode and doesn't really make
> > > much sense here.
> > >
> > > If we have special requirements like this on the codec setup, that
> > > sounds like a good justification for creating a custom codec instead =
of
> > > shoehorning it into simple-card
> >
> > When all the remarks are fixed would it be possible to merge the rest
> > of the series without the dts changes ?
> >
> > I will propose another series to introduce a dedicated codec for that.
>
> Yeah, sure
>
> Maxime
