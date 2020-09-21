Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78EA2730D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgIURYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgIURYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:24:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0133BC0613D0;
        Mon, 21 Sep 2020 10:24:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h2so14533539ilo.12;
        Mon, 21 Sep 2020 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5SRK8la0UXnQ7Dkerw1wuAG4a5/gTc1jllTQAlHfhlg=;
        b=HfV6houLmggUcURCcB6v+pPJlKPQ+gtN2WmmpK7oEGFgQbNm2B7uM903QVkjDTDbgf
         yPTC+cL1sDL1lVJmkAYnew56seWAZq3HGlZKn5ywC1NvjMuA0a21j1mWTmdIQLUUnU5k
         T9fl6S1HhzA6ycjv+PM1HmprtPTaYdBfRrHddu1LB5ZDrHJQe98EXMMGWVfoV3dR0FAv
         a9UhnG9Aa1lx6fRy/obN/RwN0sx0W33gt1lyz7c0lvlnpkVjFaB95qxWN4F+UmklmZHF
         sd0VDgGDpkCuVprKuBqLQ/9P3CDO6t0VyjtddPAUEgBvFvsErc9EJBEwZTvATAzUQdlh
         2S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5SRK8la0UXnQ7Dkerw1wuAG4a5/gTc1jllTQAlHfhlg=;
        b=qMQUGdnFOhaS0kOiulyjT2/kzLTrAaXGm1jfXxWTj0N7ZZlfETgZ7nnKgxtDNIHugq
         U2VmXInnWdkBzXeZ6cHQmpchwLr5VFhUJEhdJe7e+Yc9UyPXf+Lm62xr3H9aTDACcBZv
         4nTBJ1qH3wKg+/V62W2Ga5egCbEgXzNhAlvIfUSveSAthVlvlKIXxSge3rCgEOmY3WYd
         3h5D8enjRrZTQJ82cr1RnAa9RGfjdkgs5SMGGI6dj+xJhJeXNc83UhfIzDL1/k1ze6lo
         urTzq9hPB7cc7ZDjuPo7qsjYnhfWZ2VHubBpJXGTk+VJ59ZIU0z8Gs8zK/nFytpuvJXp
         2jLw==
X-Gm-Message-State: AOAM530MSAMphzxepZxYLD3BRZDL+ZU45vC1nKUveIPoBFYQ1c2/lh42
        lqW19Uxh0taKdA6oQqZo9WNDykiz17oO1tbcUyI=
X-Google-Smtp-Source: ABdhPJyUU4d4z0gn2QudzccbYRdOIKm+8ufVR0mc2IHAdHigfni2XUwbY8FX+jNpFzfnsMIjl7iDtl0Hk35QzmAF8Do=
X-Received: by 2002:a05:6e02:bc9:: with SMTP id c9mr865485ilu.150.1600709040237;
 Mon, 21 Sep 2020 10:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200921102731.747736-1-peron.clem@gmail.com> <20200921102731.747736-10-peron.clem@gmail.com>
 <20200921135925.q7mde2cnt5jtzkb5@gilmour.lan>
In-Reply-To: <20200921135925.q7mde2cnt5jtzkb5@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 21 Sep 2020 19:23:49 +0200
Message-ID: <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
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

Hi Maxime,

On Mon, 21 Sep 2020 at 15:59, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 21, 2020 at 12:27:18PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > Add a simple-soundcard to link audio between HDMI and I2S.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index 28c77d6872f6..a8853ee7885a 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -67,6 +67,25 @@ de: display-engine {
> >               status =3D "disabled";
> >       };
> >
> > +     hdmi_sound: hdmi-sound {
> > +             compatible =3D "simple-audio-card";
> > +             simple-audio-card,format =3D "i2s";
> > +             simple-audio-card,name =3D "sun50i-h6-hdmi";
> > +             simple-audio-card,mclk-fs =3D <128>;
> > +             simple-audio-card,frame-inversion;
> > +             status =3D "disabled";
> > +
> > +             simple-audio-card,codec {
> > +                     sound-dai =3D <&hdmi>;
> > +             };
> > +
> > +             simple-audio-card,cpu {
> > +                     sound-dai =3D <&i2s1>;
> > +                     dai-tdm-slot-num =3D <2>;
> > +                     dai-tdm-slot-width =3D <32>;
>
> It looks weird to have both some TDM setup here, and yet the format in
> i2s?

Yes, I agree I will check if it's really needed.

Clement

>
> Maxime
