Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085B6283673
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJENXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJENXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:23:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0601C0613CE;
        Mon,  5 Oct 2020 06:23:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g7so9045732iov.13;
        Mon, 05 Oct 2020 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=weoxlCL4s68iLYumYf/JNpJEA/fRjS1GFyVHxrT3h78=;
        b=Gbr3xWDvbVqxUML79XLnV/AUmP/ErPLZoHbMZ7f0nGxyEBzHSpYYq4zpcU/awEGQ+w
         /mo76U6ltG3G9MhSVSuhSghO6J4kuPoXF+gNIrsI8ugoQCx0wyHPEk0ZBVaRlToS5mUW
         QZLxg51j9mlubjHWEJFlTvAmhCsae4AKO4/CeWSpv5l20h09PRlcnQDWQLTR3hMzJONF
         9VOlF5pWJx+mwbrYkncigo3MGAbXWkHPR7kL/uc3H8l6pQjfrtmNSfmKP7+sYtWpT3bX
         QiGD96Qpw34aPE2eV0ad+h5U5cnv35lOUUWiz0cR+0Kt9NbqWrQXCuGjHJmpsmMfMZmO
         9CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=weoxlCL4s68iLYumYf/JNpJEA/fRjS1GFyVHxrT3h78=;
        b=gfWRYlCfopUbFldoTTxrXPv8b32csN/KU4KaSQkeAP4EuDGDDKxnes+AT1fx+AR576
         yDf0DANewOiRhlPT0MX60jBqot3X7d8CytJ47rG4NuYvXz9ARIOsfze1XG/6zT355k02
         KVZANXOWtxVaybFLcRFy6w9cH+lhG4o7aos14irTOD9SHbIkHJ8fo/zz1MP48ABt1lti
         hxikvMeu/Akh8uEZP1np3N9C37VeHCHDzhEbOOVXwBiV7EuhOEHPGFiZuoiJMNSVkU6y
         fPosqT/9hjwoJKdE/UoqMkT6zxKcbWuEW/iFgoCmHkO9RL98BQ1OLcRSCMAJEqzJ0OqU
         eDpQ==
X-Gm-Message-State: AOAM530Lfhog1rwmr7NXcJpwXn8HLoKRiC8SAfG2VZYfsFy4YxenGmQO
        KSAYmxmhyllhceyqqiO9EhZ3ZWTkXkl1LWd+elw=
X-Google-Smtp-Source: ABdhPJxZh95BTj0yf592D4+DfAkmrPfpqjg+t/pG5W4Z8g+/qjc469AxGm523yI3fUgNrf6hbzOVvshXIvNKx3AHCIk=
X-Received: by 2002:a5d:8ace:: with SMTP id e14mr10756345iot.124.1601904203837;
 Mon, 05 Oct 2020 06:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201003141950.455829-1-peron.clem@gmail.com> <20201003141950.455829-3-peron.clem@gmail.com>
 <20201005121307.v6jpyeyfi4kxc2cl@gilmour.lan>
In-Reply-To: <20201005121307.v6jpyeyfi4kxc2cl@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 5 Oct 2020 15:23:12 +0200
Message-ID: <CAJiuCcdd6_kzsxEERZbj2Budjmuyv6gV_sPG8LjLY=fk+MO8zQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 5 Oct 2020 at 14:13, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sat, Oct 03, 2020 at 04:19:38PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > As slots and slot_width can be set manually using set_tdm().
> > These values are then kept in sun4i_i2s struct.
> > So we need to check if these values are setted or not
> > in the struct.
> >
> > Avoid to check for this logic in set_chan_cfg(). This will
> > duplicate the same check instead pass the required values
> > as params to set_chan_cfg().
> >
> > This will also avoid a bug when we will enable 20/24bits support,
> > i2s->slot_width is not actually used in the lrck_period computation.
> >
> > Suggested-by: Samuel Holland <samuel@sholland.org>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 36 ++++++++++++++----------------------
> >  1 file changed, 14 insertions(+), 22 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index c5ccd423e6d3..1f577dbc20a6 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -177,8 +177,9 @@ struct sun4i_i2s_quirks {
> >       unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
> >       s8      (*get_sr)(const struct sun4i_i2s *, int);
> >       s8      (*get_wss)(const struct sun4i_i2s *, int);
> > -     int     (*set_chan_cfg)(const struct sun4i_i2s *,
> > -                             const struct snd_pcm_hw_params *);
> > +     int     (*set_chan_cfg)(const struct sun4i_i2s *i2s,
> > +                             unsigned int channels,  unsigned int slot=
s,
> > +                             unsigned int slot_width);
> >       int     (*set_fmt)(const struct sun4i_i2s *, unsigned int);
> >  };
> >
> > @@ -414,10 +415,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_=
i2s *i2s, int width)
> >  }
> >
> >  static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > -                               const struct snd_pcm_hw_params *params)
> > +                               unsigned int channels, unsigned int slo=
ts,
> > +                               unsigned int slot_width)
> >  {
> > -     unsigned int channels =3D params_channels(params);
> > -
> >       /* Map the channels for playback and capture */
> >       regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
> >       regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
> > @@ -434,15 +434,11 @@ static int sun4i_i2s_set_chan_cfg(const struct su=
n4i_i2s *i2s,
> >  }
> >
> >  static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > -                               const struct snd_pcm_hw_params *params)
> > +                               unsigned int channels, unsigned int slo=
ts,
> > +                               unsigned int slot_width)
> >  {
> > -     unsigned int channels =3D params_channels(params);
> > -     unsigned int slots =3D channels;
> >       unsigned int lrck_period;
> >
> > -     if (i2s->slots)
> > -             slots =3D i2s->slots;
> > -
> >       /* Map the channels for playback and capture */
> >       regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
> >       regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
> > @@ -467,11 +463,11 @@ static int sun8i_i2s_set_chan_cfg(const struct su=
n4i_i2s *i2s,
> >       case SND_SOC_DAIFMT_DSP_B:
> >       case SND_SOC_DAIFMT_LEFT_J:
> >       case SND_SOC_DAIFMT_RIGHT_J:
> > -             lrck_period =3D params_physical_width(params) * slots;
> > +             lrck_period =3D slot_width * slots;
> >               break;
> >
> >       case SND_SOC_DAIFMT_I2S:
> > -             lrck_period =3D params_physical_width(params);
> > +             lrck_period =3D slot_width;
> >               break;
> >
> >       default:
> > @@ -490,15 +486,11 @@ static int sun8i_i2s_set_chan_cfg(const struct su=
n4i_i2s *i2s,
> >  }
> >
> >  static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > -                                   const struct snd_pcm_hw_params *par=
ams)
> > +                                   unsigned int channels, unsigned int=
 slots,
> > +                                   unsigned int slot_width)
> >  {
> > -     unsigned int channels =3D params_channels(params);
> > -     unsigned int slots =3D channels;
> >       unsigned int lrck_period;
> >
> > -     if (i2s->slots)
> > -             slots =3D i2s->slots;
> > -
> >       /* Map the channels for playback and capture */
> >       regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0xFEDCB=
A98);
> >       regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543=
210);
> > @@ -525,11 +517,11 @@ static int sun50i_h6_i2s_set_chan_cfg(const struc=
t sun4i_i2s *i2s,
> >       case SND_SOC_DAIFMT_DSP_B:
> >       case SND_SOC_DAIFMT_LEFT_J:
> >       case SND_SOC_DAIFMT_RIGHT_J:
> > -             lrck_period =3D params_physical_width(params) * slots;
> > +             lrck_period =3D slot_width * slots;
> >               break;
> >
> >       case SND_SOC_DAIFMT_I2S:
> > -             lrck_period =3D params_physical_width(params);
> > +             lrck_period =3D slot_width;
> >               break;
> >
> >       default:
> > @@ -565,7 +557,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_subst=
ream *substream,
> >       if (i2s->slot_width)
> >               slot_width =3D i2s->slot_width;
> >
> > -     ret =3D i2s->variant->set_chan_cfg(i2s, params);
> > +     ret =3D i2s->variant->set_chan_cfg(i2s, channels, slots, slot_wid=
th);
>
> Isn't slots and slot_width set to 0 here ?

No, there is still a check before calling the set_cfg function.

  unsigned int slot_width =3D params_physical_width(params);
  unsigned int channels =3D params_channels(params);
  unsigned int slots =3D channels;

  if (i2s->slots)
  slots =3D i2s->slots;

  if (i2s->slot_width)
  slot_width =3D i2s->slot_width;

ret =3D i2s->variant->set_chan_cfg(i2s, channels, slots, slot_width);

So slot_width will be equal to params_physical_width(params);
like before

Clement

>
> And therefore, wouldn't we set lrck_period to 0 if we're using any
> format but I2S?
>
> More importantly, I'm not really convinced this needs to be done, and it
> introduces some side effects that are not explained.
>
> Maxime
