Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23DF27B033
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1OqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 10:46:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42355 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1OqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:46:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id b12so1571146lfp.9;
        Mon, 28 Sep 2020 07:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KCww78yTvjpE9tUq6aOXD0YyyC+MPNJogO8+ZVoVaG0=;
        b=FQDJwyzBrIrRfW5PC6eBiIB808Vw4lD1hO+JOpTcg4XIe3iEaJ71HjQ8NHP5mKgZQE
         AmBfb+1eA5CQM8ObWrx19Hb0KqmaTHzxBrWN1oFmFjdg9qIkhwlj9AV0x6Ke8OOW+zLx
         4/FovrptPhNwSdkuh8yeZ/IoeA1mmlAP+uhG5B+Xh25VlzdiaoK3KPoFvy7aOpXDqtbM
         H0MCvX/xTw1GKpcrWANbPSpNL+/n7x8sFgAmnl+UC7iqjTxLcKZ8jNbD8L+kTdijQ70C
         j4hGPnAD85TFT6f3ZcKqYAHtEup8JTAuBfrpQtAA21Nm16AoWzg/eDODBhAQfoG1yD8k
         d1IA==
X-Gm-Message-State: AOAM53084ZkYmR0qg/CxTSBmSqIJ0D8S7rVjK7+tEdw+objsEW16aqRc
        ZmJaQCGncSU3g6CcJiQsVFNOydAY+cwBmg==
X-Google-Smtp-Source: ABdhPJx8WzDB8Zx00M634qLe440mqjA5KZazOo0NQVBFXPULVsdUGLildJ4trH6zyO6TWJbcEvlrpg==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr681596lfi.224.1601304377436;
        Mon, 28 Sep 2020 07:46:17 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h16sm2875171lfc.63.2020.09.28.07.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 07:46:16 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id c2so1242385ljj.12;
        Mon, 28 Sep 2020 07:46:16 -0700 (PDT)
X-Received: by 2002:a2e:760e:: with SMTP id r14mr509853ljc.331.1601304376547;
 Mon, 28 Sep 2020 07:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-2-peron.clem@gmail.com>
 <CAGb2v65AhnqD6ec20h9vtd2GjqVsf_yz5+7VSa8giJuFJnd5ag@mail.gmail.com> <CAJiuCcevtzX_+02r54q6tH0+bOF=BM=knnaxN+G3QW035F8gZQ@mail.gmail.com>
In-Reply-To: <CAJiuCcevtzX_+02r54q6tH0+bOF=BM=knnaxN+G3QW035F8gZQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 22:46:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Ath4vm+QNky2Le6ickJJ68Q8DJs8k6kqW=xh7DxmnMg@mail.gmail.com>
Message-ID: <CAGb2v64Ath4vm+QNky2Le6ickJJ68Q8DJs8k6kqW=xh7DxmnMg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 01/20] ASoC: sun4i-i2s: Add support for
 H6 I2S
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

On Mon, Sep 28, 2020 at 10:37 PM Clément Péron <peron.clem@gmail.com> wrote:
>
> Hi Chen-Yu,
>
> On Mon, 28 Sep 2020 at 06:40, Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
> > >
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > H6 I2S is very similar to that in H3, except it supports up to 16
> > > channels.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > > ---
> > >  sound/soc/sunxi/sun4i-i2s.c | 224 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 224 insertions(+)
> > >
> > > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > > index f23ff29e7c1d..2baf6c276280 100644
> > > --- a/sound/soc/sunxi/sun4i-i2s.c
> > > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > > @@ -124,6 +124,21 @@
> > >  #define SUN8I_I2S_RX_CHAN_SEL_REG      0x54
> > >  #define SUN8I_I2S_RX_CHAN_MAP_REG      0x58
> > >
> > > +/* Defines required for sun50i-h6 support */
> > > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK  GENMASK(21, 20)
> > > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)       ((offset) << 20)
> > > +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK         GENMASK(19, 16)
> > > +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)                ((chan - 1) << 16)
> > > +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK          GENMASK(15, 0)
> > > +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)     (((1 << num_chan) - 1))
> > > +
> > > +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG 0x44
> > > +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG 0x48
> > > +
> > > +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG  0x64
> > > +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG 0x68
> > > +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG 0x6C
> > > +
> > >  struct sun4i_i2s;
> > >
> > >  /**
> > > @@ -474,6 +489,62 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > >         return 0;
> > >  }
> > >
> > > +static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > > +                                     const struct snd_pcm_hw_params *params)
> > > +{
> > > +       unsigned int channels = params_channels(params);
> > > +       unsigned int slots = channels;
> > > +       unsigned int lrck_period;
> > > +
> > > +       if (i2s->slots)
> > > +               slots = i2s->slots;
> > > +
> > > +       /* Map the channels for playback and capture */
> > > +       regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
> > > +       regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);
> >
> > Nit, since it supports up to 16 channels, you might want to map all 16 of them
> > now, instead of having to come back and fix it later.
>
> Thanks for the review. Do you mean there is missing MAP0 for RX/TX ?
>
> + regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0xFEDCBA98);
>   regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
> + regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP0_REG, 0xFEDCBA98);
>   regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);

Correct.

ChenYu

> Regards,
> Clement
>
> >
> > Code wise, this patch is
> >
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >
> > I don't have a scope nor logic analyzer, so I wasn't able to participate in the
> > LRCK discussion.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/CAJiuCcevtzX_%2B02r54q6tH0%2BbOF%3DBM%3DknnaxN%2BG3QW035F8gZQ%40mail.gmail.com.
