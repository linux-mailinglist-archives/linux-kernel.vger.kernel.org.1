Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE927B043
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1Osd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1Osd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:48:33 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB4C061755;
        Mon, 28 Sep 2020 07:48:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e5so1494837ilr.8;
        Mon, 28 Sep 2020 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vQtXU3enAOb8a0F7LbFZw7wLpO431aR2A2CY3HJMkgQ=;
        b=OZaF2CtEYFnNkMyOeRvFckPCRRkEvcgqI67p4VJ2nRQ+vdrZBAapya5VQMhVGqa0Pc
         xM1jN+mltbWDKKk8popL015Sl6sfWqKh+D66ChLMhLuVJu8V5hAQbzLrwIwlkOHBrsAU
         hCeIuDm/Baedvbmnv5KQQfsTPj+vjenjt6PX1yPbszShovNQ8uAPEDS5tGTRhk6A5GXA
         dGsUTLxW9XdXjuLFzEnYTHoCDKph1NapO6746XVw6TL/NCQDzntdVyRLLYVZRdbyf3JA
         QbYIb0ekb+W3b7D/H1r1wCOfVvs2HAQiNWqq1npY7QSVhPe8ILYg21nWzt7uf+PO2zMs
         q1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vQtXU3enAOb8a0F7LbFZw7wLpO431aR2A2CY3HJMkgQ=;
        b=Bnmk54xQNba9qFZBAQ9eLiU54ao+8CZ0PZvN8+64tvKh1iSKy3wqppw0qNmwywDXQp
         j3FbDH+TAGr6QMEdDjZxqe9nSRpiNal9wt5TbdRrUVgYrys2I+0a1WEC7Gl+vsMGlf94
         orLDvW8v1u2BfdAN8i0vTU1lo9jE8krd/Gng3pElfUEjk9+Zxm096kFSZn77dyImMK2v
         TQE9VAZEx0/bWGBI0Bj8qE/78UFKgEpY8bP4B8nR4pNwxChD4IVSbkYYZTzvxZF9H+TO
         z3GRUoWuABNNsBkcUuHcN79ZFAkSEa8YrdAITu5wCQGoufBzTr07AyKSGGyT6Mm9n7c4
         hjww==
X-Gm-Message-State: AOAM533LwKd19SiCiD3XFWAFic7oZznJlzZYHXEeFQIojW6TrcE+Y20f
        rK6gG3pidcYujM+dsh0uskshl7sYTgcAn+7Va1o=
X-Google-Smtp-Source: ABdhPJyzQtJ4Wq6iMS79WrUFhP9745qmyzAStclm/SXxrx+gsno8hRzUha9nYwTBHlnwHYeP91NhtWzAzwbYb+tVqNc=
X-Received: by 2002:a92:217:: with SMTP id 23mr1544245ilc.118.1601304512241;
 Mon, 28 Sep 2020 07:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-3-peron.clem@gmail.com>
 <CAGb2v669XXerfrgK9WzAoMHwArn765yS9Db4_xwwQSXpnm2zqQ@mail.gmail.com>
In-Reply-To: <CAGb2v669XXerfrgK9WzAoMHwArn765yS9Db4_xwwQSXpnm2zqQ@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 28 Sep 2020 16:48:21 +0200
Message-ID: <CAJiuCcfWCSqfq6-DP_SKBgLm63U7oKWJOSLUme1Wf0yXoR=8_g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 02/20] ASoC: sun4i-i2s: Change
 set_chan_cfg() params
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Mon, 28 Sep 2020 at 07:00, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Sep 28, 2020 at 3:29 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >
> > As slots and slot_width can be overwritter in case set_tdm() is
> > called. Avoid to have this logic in set_chan_cfg().
>
> It doesn't seem that set_tdm_slot() would get called concurrently
> with hw_params(), at least not for the simple-card family. If so
> then we'd have more problems like mismatched slots/slot-width
> due to no serialization when interacting with those values.

Sorry maybe the commit log is not clear.
I was not talking about a concurrent effect but more if the slot_width is s=
etted
then we don't properly use it later.

>
> > Instead pass the required values as params to set_chan_cfg().
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
> > index 2baf6c276280..0633b9fba3d7 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -177,8 +177,9 @@ struct sun4i_i2s_quirks {
> >         unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *)=
;
> >         s8      (*get_sr)(const struct sun4i_i2s *, int);
> >         s8      (*get_wss)(const struct sun4i_i2s *, int);
> > -       int     (*set_chan_cfg)(const struct sun4i_i2s *,
> > -                               const struct snd_pcm_hw_params *);
> > +       int     (*set_chan_cfg)(const struct sun4i_i2s *i2s,
> > +                               unsigned int channels,  unsigned int sl=
ots,
> > +                               unsigned int slot_width);
> >         int     (*set_fmt)(const struct sun4i_i2s *, unsigned int);
> >  };
> >
> > @@ -414,10 +415,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_=
i2s *i2s, int width)
> >  }
> >
> >  static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > -                                 const struct snd_pcm_hw_params *param=
s)
> > +                                 unsigned int channels, unsigned int s=
lots,
> > +                                 unsigned int slot_width)
> >  {
> > -       unsigned int channels =3D params_channels(params);
> > -
> >         /* Map the channels for playback and capture */
> >         regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210=
);
> >         regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210=
);
> > @@ -434,15 +434,11 @@ static int sun4i_i2s_set_chan_cfg(const struct su=
n4i_i2s *i2s,
> >  }
> >
> >  static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > -                                 const struct snd_pcm_hw_params *param=
s)
> > +                                 unsigned int channels, unsigned int s=
lots,
> > +                                 unsigned int slot_width)
> >  {
> > -       unsigned int channels =3D params_channels(params);
> > -       unsigned int slots =3D channels;
> >         unsigned int lrck_period;
> >
> > -       if (i2s->slots)
> > -               slots =3D i2s->slots;
> > -
>
> Based on the bug you highlighted in your expanded commit log, the simpler=
 fix
> would be to look at i2s->slot_width in addition to i2s->slots, and replac=
e
> params_physical_width(params) accordingly.

That's what I did in the first version but was pointed out by Samuel
that the same logic
was done several times. As I can avoid it by passing the correct
params it's simpler.

>
> Also, I would put fixes (even preparatory ones) before patches that intro=
duce
> support for new features and hardware. That makes them easier to backport=
 if
> needed.

I will wait for Maxime to comment on this. Regarding the doc fixes tag
should only be used
to fix a previous commit. This will make the fixes commit a bit more
complicated for stable kernel team.

Thanks for your review :)

Regards
Clement


>
>
> ChenYu
>
>
> >         /* Map the channels for playback and capture */
> >         regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210=
);
> >         regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210=
);
> > @@ -467,11 +463,11 @@ static int sun8i_i2s_set_chan_cfg(const struct su=
n4i_i2s *i2s,
> >         case SND_SOC_DAIFMT_DSP_B:
> >         case SND_SOC_DAIFMT_LEFT_J:
> >         case SND_SOC_DAIFMT_RIGHT_J:
> > -               lrck_period =3D params_physical_width(params) * slots;
> > +               lrck_period =3D slot_width * slots;
> >                 break;
> >
> >         case SND_SOC_DAIFMT_I2S:
> > -               lrck_period =3D params_physical_width(params);
> > +               lrck_period =3D slot_width;
> >                 break;
> >
> >         default:
