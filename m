Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8559F27AFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1O15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1O15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:27:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48166C061755;
        Mon, 28 Sep 2020 07:27:55 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c5so1408470ilk.11;
        Mon, 28 Sep 2020 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=swpXeTWHWCNF6KXrz68zf9yRkpoPYhiTjW+lMQcubDQ=;
        b=BOKMig27yWnniwJh3B4l/zCp7mHNUCUubmP8fwzAFvtftEdZrq/J5g9GHUBm8+rBuS
         7amT5mIVNrvgC4h1nJVlIySswEDjj9KrXY7EYQiVaVvuH7TBrJ6dfBuiWOfpA6V2IDOx
         x9LC2kOWZB0ps5+Cyr6Xg+yjE8OMl6kIbLSj/ATKUBG5HsSlyCEdJfEQK70juLfljq5j
         1dQF4HWNgPah2G3fS8Xd50ag91nSTfdiRRC+sj1wUizOwipypUqx7Pk3IoeV7D/SwCNf
         U3/X/j+AwtDaXBvH5eeOcRi5yscC+RRR6tBZQYohGmJfwYktf4JYiFAbARckHIswggK1
         P8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=swpXeTWHWCNF6KXrz68zf9yRkpoPYhiTjW+lMQcubDQ=;
        b=XqnHFZ3uvkcqowE7uKd/Z6+T170wtVrpGSdFX4jLiDeMon/384P64F+o26q+WMX3mG
         zBxSY/8MCXt+OG7IMR39RG1yEolquHzTon4/isKYodh2+tcH9TVYbsmVrRuSFPvfzJrX
         vNyTE6tTznyN40PEdH+sfZnOB8KCFn5+q+MANj6Dz7vk3LXzlP8EFYTdsyuHbbA7piKy
         FiqdDm3fs5IYXZ5OJxbFeFhYeeloxUwf4YzqflfW005vS3+wEgjEV+tJawB8mlodJc+C
         LI4THRlkghdSJ/53RbPaYHfA+zxquNuewqgep5m/rKcPmD5ekIYMWdFRhLu1t/hzNB23
         f7mw==
X-Gm-Message-State: AOAM533VwD6duyU0YYOT5B1DEXgxAZbw99VKTjdcs9aWHXlwfwfzCY6i
        W9n/TIXiPuG8KH8MrTam/dWrrl7UUmDi+q4JC48=
X-Google-Smtp-Source: ABdhPJzOveX0je2bblXhCXBXIiaCyUUc4S3JAXPSmt4lEfMi8iabOV8HZOiVHqjpmvDzsFtEhoueN56owxsQKZojPH0=
X-Received: by 2002:a92:d68b:: with SMTP id p11mr1294955iln.59.1601303274202;
 Mon, 28 Sep 2020 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200921102731.747736-1-peron.clem@gmail.com> <20200921135925.q7mde2cnt5jtzkb5@gilmour.lan>
 <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
 <59286578.E0qSRroNqr@kista> <20200928084308.eipnvlfqe3c5lfmg@gilmour.lan>
In-Reply-To: <20200928084308.eipnvlfqe3c5lfmg@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 28 Sep 2020 16:27:42 +0200
Message-ID: <CAJiuCceHXr_5PvG-FW+hRNV7Q33hGrp8kLbO0EgfqqBxF7wbqQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
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

On Mon, 28 Sep 2020 at 10:43, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 21, 2020 at 08:37:09PM +0200, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 21. september 2020 ob 19:23:49 CEST je Cl=C3=A9ment P=
=C3=A9ron
> > napisal(a):
> > > Hi Maxime,
> > >
> > > On Mon, 21 Sep 2020 at 15:59, Maxime Ripard <maxime@cerno.tech> wrote=
:
> > > >
> > > > On Mon, Sep 21, 2020 at 12:27:18PM +0200, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > >
> > > > > Add a simple-soundcard to link audio between HDMI and I2S.
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
arm64/
> > boot/dts/allwinner/sun50i-h6.dtsi
> > > > > index 28c77d6872f6..a8853ee7885a 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > @@ -67,6 +67,25 @@ de: display-engine {
> > > > >               status =3D "disabled";
> > > > >       };
> > > > >
> > > > > +     hdmi_sound: hdmi-sound {
> > > > > +             compatible =3D "simple-audio-card";
> > > > > +             simple-audio-card,format =3D "i2s";
> > > > > +             simple-audio-card,name =3D "sun50i-h6-hdmi";
> > > > > +             simple-audio-card,mclk-fs =3D <128>;
> > > > > +             simple-audio-card,frame-inversion;
> > > > > +             status =3D "disabled";
> > > > > +
> > > > > +             simple-audio-card,codec {
> > > > > +                     sound-dai =3D <&hdmi>;
> > > > > +             };
> > > > > +
> > > > > +             simple-audio-card,cpu {
> > > > > +                     sound-dai =3D <&i2s1>;
> > > > > +                     dai-tdm-slot-num =3D <2>;
> > > > > +                     dai-tdm-slot-width =3D <32>;
> > > >
> > > > It looks weird to have both some TDM setup here, and yet the format=
 in
> > > > i2s?
> > >
> > > Yes, I agree I will check if it's really needed.
> >
> > I think this was explained before.
>
> Possibly, but this should be in a comment or at least the commit log
>
> > Anyway, this is needed to force width to 32, no matter actual sample
> > width. That's a requirement of HDMI codec. I believe Marcus Cooper
> > have another codec which also needs fixed width.
> >
> > There is no similar property for I2S, so TDM one is used here.
>
> Except it's really dedicated to the TDM mode and doesn't really make
> much sense here.
>
> If we have special requirements like this on the codec setup, that
> sounds like a good justification for creating a custom codec instead of
> shoehorning it into simple-card

When all the remarks are fixed would it be possible to merge the rest
of the series without the dts changes ?

I will propose another series to introduce a dedicated codec for that.

>
> Maxime
