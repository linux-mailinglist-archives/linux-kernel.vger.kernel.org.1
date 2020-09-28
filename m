Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F327B011
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgI1Ohi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgI1Ohi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:37:38 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F12AC061755;
        Mon, 28 Sep 2020 07:37:38 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so1365030ioo.1;
        Mon, 28 Sep 2020 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t4AbdMx+cx7XDkAMRw5fwKPY3/PE3Njw9O2Txe+X7KQ=;
        b=RKnX7n81fRNP7SzOx3e5G8EXU7UK8R6fQQS/GeZPWcPNO0fHznMAlSHnQkm9nvnLrl
         ksK9e3gFSf/5HE6q+1+k4xGuglAUG8x97sx3OWUWZKZkB0+8VC3y+pz8aziKAxRYj0p2
         DX3eEtEQPINky7M7wVu08YpNr86aBIJoIw8Qbdg5q6UCveVdStTyLkrqhJb3ZSgzz6Bw
         mkn7/xxOKikbGxwvlcP82/Eelx8GDoo1TZ+QrTHCpejFZtbB1SX+GfKVDGW3T/i4LHGm
         3jnwLLdiq78cQmGX4gRiJlxjxXVB9GdoOocjRhBSbK4ZzkMrkOdicqNLaXfmwjr1oKI3
         FwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t4AbdMx+cx7XDkAMRw5fwKPY3/PE3Njw9O2Txe+X7KQ=;
        b=AoJnfHEzXFu6dHxHno/oeFtK0DEwlsNIzvtv2pC8HLDKcuP8NXCbmk4vguhf09ree+
         JOyW4DtMf7V1iu42riqkR90X9HTB406fNPESGiCMMwZBWee481e0JVREV3LPXcfeBoNH
         BhkBVKnykJF9t/pfT8p4LAIOchvLKDA/vSujwZByWhJODgADmeaUGe64SNi0uUsrETf/
         mfu9i3v/SHfX2cAxvMahF0+nzJlTznrSmvQF6xFeXpFasc0ZCAyiE96vLSFxcOFPwPze
         U818rZyQlVjWgq1mwFVYasCpK2KQaIDZFexxKx465MczZBrEu4d5xCzuO0JKGJFxjDgl
         gjXA==
X-Gm-Message-State: AOAM533IjHHjUxuaNoc1NVir14GUL6lpSe8Bn3JjjoOz5AaFW6D+a6HX
        Jz7cH8JvMSh4TXJ+dA7+iXq1CVo/LuzYd9GZJZY=
X-Google-Smtp-Source: ABdhPJxOHv47DZJ/ZpY0xtNS8oWIQF4j+pHf/JhqayP0YQAVGa58IT3sFvvEifb5VWXPoiyhxnoRD09w6fFBNOXifxA=
X-Received: by 2002:a6b:908:: with SMTP id t8mr7098983ioi.124.1601303857337;
 Mon, 28 Sep 2020 07:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-2-peron.clem@gmail.com>
 <CAGb2v65AhnqD6ec20h9vtd2GjqVsf_yz5+7VSa8giJuFJnd5ag@mail.gmail.com>
In-Reply-To: <CAGb2v65AhnqD6ec20h9vtd2GjqVsf_yz5+7VSa8giJuFJnd5ag@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 28 Sep 2020 16:37:26 +0200
Message-ID: <CAJiuCcevtzX_+02r54q6tH0+bOF=BM=knnaxN+G3QW035F8gZQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 01/20] ASoC: sun4i-i2s: Add support for
 H6 I2S
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

On Mon, 28 Sep 2020 at 06:40, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Sep 28, 2020 at 3:29 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 I2S is very similar to that in H3, except it supports up to 16
> > channels.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 224 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 224 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index f23ff29e7c1d..2baf6c276280 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -124,6 +124,21 @@
> >  #define SUN8I_I2S_RX_CHAN_SEL_REG      0x54
> >  #define SUN8I_I2S_RX_CHAN_MAP_REG      0x58
> >
> > +/* Defines required for sun50i-h6 support */
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK  GENMASK(21, 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)       ((offset) << 20=
)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK         GENMASK(19, 16)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)                ((chan - 1) << =
16)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK          GENMASK(15, 0)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)     (((1 << num_chan) - 1))
> > +
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG 0x44
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG 0x48
> > +
> > +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG  0x64
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG 0x68
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG 0x6C
> > +
> >  struct sun4i_i2s;
> >
> >  /**
> > @@ -474,6 +489,62 @@ static int sun8i_i2s_set_chan_cfg(const struct sun=
4i_i2s *i2s,
> >         return 0;
> >  }
> >
> > +static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > +                                     const struct snd_pcm_hw_params *p=
arams)
> > +{
> > +       unsigned int channels =3D params_channels(params);
> > +       unsigned int slots =3D channels;
> > +       unsigned int lrck_period;
> > +
> > +       if (i2s->slots)
> > +               slots =3D i2s->slots;
> > +
> > +       /* Map the channels for playback and capture */
> > +       regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x765=
43210);
> > +       regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x765=
43210);
>
> Nit, since it supports up to 16 channels, you might want to map all 16 of=
 them
> now, instead of having to come back and fix it later.

Thanks for the review. Do you mean there is missing MAP0 for RX/TX ?

+ regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0xFEDCBA98);
  regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
+ regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP0_REG, 0xFEDCBA98);
  regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);

Regards,
Clement

>
> Code wise, this patch is
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> I don't have a scope nor logic analyzer, so I wasn't able to participate =
in the
> LRCK discussion.
