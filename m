Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5144D283662
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJENPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:15:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34844 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJENPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:15:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id w11so10835736lfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 06:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cBoMJtsS2QIM7l/tvd/09+d4HrK6HDbi11UZa2qXqw=;
        b=Hc/jL+s5quRzYlOnXKTr+hRTDJcvzOV4IL+Z1U7CXXhpV5PWSCDA2cM4Uum9ZYL6gI
         2Zbtyc3em5SFhZ4ajMkw6YI/NQ3CfMl5lSUTKeOzJBKckw5kvibBQlaO3ZQBRkcRK2RR
         uwjhT4LEpQtB3L0OdLJ19EnDnH1njHbfCjIEsWc4kJreyaZOvCajXJlnN8REXSAdPFw+
         3ZdeOCBzzEGNIQz6mwOYC9AgVoggko5UfPLs9jRB6av8HAlNb/t9U4Knuv8IFukN1dtT
         6R1ArZpEJjPvtmsDxhFUtS3EFJgLKF3E2U3VTnH2XpqkWIZ7P4bdM3lOFodjUDyqjpCA
         As6g==
X-Gm-Message-State: AOAM533rm/QgFGBHaUOcmWYtxCJbFScIW1hgaZL64nN19X5hHpciQl/+
        ud2dtlY26B7zZTk1AGRor74e4NR/i3QdMQ==
X-Google-Smtp-Source: ABdhPJw75XL7IWZVDGgSwJ3XQpEnyGDn21uVnz0xzeIO3+LhxeUoVuGgGr4cptX8JD+kPOqalyKWiA==
X-Received: by 2002:ac2:4281:: with SMTP id m1mr2598791lfh.574.1601903721805;
        Mon, 05 Oct 2020 06:15:21 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 136sm116115lfi.176.2020.10.05.06.15.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 06:15:21 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id z19so10839255lfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 06:15:21 -0700 (PDT)
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr5248254lfr.571.1601903720884;
 Mon, 05 Oct 2020 06:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201001021148.15852-1-samuel@sholland.org> <20201001021148.15852-21-samuel@sholland.org>
 <20201005120101.igzzwosnq6bzbua6@gilmour.lan>
In-Reply-To: <20201005120101.igzzwosnq6bzbua6@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 5 Oct 2020 21:15:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v67hsAfBJVjuhCQ-_ihnP3XRPeMEVik5j1ViCTmgt_JDWg@mail.gmail.com>
Message-ID: <CAGb2v67hsAfBJVjuhCQ-_ihnP3XRPeMEVik5j1ViCTmgt_JDWg@mail.gmail.com>
Subject: Re: [PATCH 20/25] ASoC: sun8i-codec: Protect the clock rate while
 streams are open
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 8:01 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Sep 30, 2020 at 09:11:43PM -0500, Samuel Holland wrote:
> > The codec's clock input is shared among all AIFs, and shared with other
> > audio-related hardware in the SoC, including I2S and SPDIF controllers.
> > To ensure sample rates selected by userspace or by codec2codec DAI links
> > are maintained, the clock rate must be protected while it is in use.
> >
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  sound/soc/sunxi/sun8i-codec.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> > index 501af64d43a0..86065bee7cd3 100644
> > --- a/sound/soc/sunxi/sun8i-codec.c
> > +++ b/sound/soc/sunxi/sun8i-codec.c
> > @@ -416,27 +416,32 @@ static int sun8i_codec_get_lrck_div_order(unsigned int slots,
> >       unsigned int div = slots * slot_width;
> >
> >       if (div < 16 || div > 256)
> >               return -EINVAL;
> >
> >       return order_base_2(div);
> >  }
> >
> > +static unsigned int sun8i_codec_get_sysclk_rate(unsigned int sample_rate)
> > +{
> > +     return sample_rate % 4000 ? 22579200 : 24576000;
> > +}
> > +
> >  static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> >                                struct snd_pcm_hw_params *params,
> >                                struct snd_soc_dai *dai)
> >  {
> >       struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
> >       struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
> >       unsigned int sample_rate = params_rate(params);
> >       unsigned int slots = aif->slots ?: params_channels(params);
> >       unsigned int slot_width = aif->slot_width ?: params_width(params);
> > -     unsigned int sysclk_rate = clk_get_rate(scodec->clk_module);
> > -     int lrck_div_order, word_size;
> > +     unsigned int sysclk_rate = sun8i_codec_get_sysclk_rate(sample_rate);
> > +     int lrck_div_order, ret, word_size;
> >       u8 bclk_div;
> >
> >       /* word size */
> >       switch (params_width(params)) {
> >       case 8:
> >               word_size = 0x0;
> >               break;
> >       case 16:
> > @@ -466,17 +471,30 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> >                          (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
> >
> >       /* BCLK divider (SYSCLK/BCLK ratio) */
> >       bclk_div = sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, sample_rate);
> >       regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> >                          SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
> >                          bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
> >
> > -     if (!aif->open_streams) {
> > +     /* SYSCLK rate */
> > +     if (aif->open_streams) {
> > +             ret = clk_set_rate(scodec->clk_module, sysclk_rate);
> > +             if (ret < 0)
> > +                     return ret;
> > +     } else {
> > +             ret = clk_set_rate_exclusive(scodec->clk_module, sysclk_rate);
>
> It's not really clear to me why we wouldn't want to always protect the
> clock rate here?

I believe the intention is to allow a window, i.e. when no audio
blocks are running,
when it is possible to switch between sample rate families?

ChenYu

> > +             if (ret == -EBUSY)
> > +                     dev_err(dai->dev, "%s: clock is busy! Sample rate %u Hz "
> > +                             "conflicts with other audio streams.\n",
>
> This string creates a checkpatch warning.
>
> Maxime
