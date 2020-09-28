Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B305F27A6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1FBB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 01:01:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45049 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1FBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:01:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id d15so9528521lfq.11;
        Sun, 27 Sep 2020 22:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uJ0Z1+alQsvst1vnVb83YEvZMpgNSPYBJqhAVUeQTf0=;
        b=DoDZJgNBHgsFAhRbHwLO/LmZrkzVQ9csJDS46Gt2k74ZtA9PT9FM2H+0qzlEywirts
         TMAn6teFwG0rkl8H7ZoA6W1VmIwmxI5wdRjiFlpNWM/pcxMu8YHI/yK4tKJw8iMvfKyB
         MnUTCH87zhupMCVzE3mYR768fvB0tUtOxQRjcYTwvvqpD7UaK2hz1QmK8Exv1xnFTvIo
         JfvSdiriv7hcKAJZBks2aHpgZgBtFfbsH8uUm0Zsrs4IBt2RYwDWXjUfwQmetQAmQg4e
         UCpm3yKJIx6kplisg8fgVUv2Xx/MJBVdE0/dHi0Bd6TnQEPLTlOYSz860ShEU4ywwHfo
         UwBg==
X-Gm-Message-State: AOAM530uRY0VGB029U2CiH2ShZhI6kcu5STTilyZszCeXkEhH9+wiyjl
        zD9mqwwMcUsHpXOj0EOlzGKw3R2HHLAIeQ==
X-Google-Smtp-Source: ABdhPJxvtx3o3b+WlNMoTkuQCtGB0d3gogRn1nBIwykfXosmHDoFN/a+o9emIH2k+B1q4UIZdbFgjg==
X-Received: by 2002:a19:589:: with SMTP id 131mr3390283lff.229.1601269257671;
        Sun, 27 Sep 2020 22:00:57 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j12sm2712105lfj.5.2020.09.27.22.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 22:00:57 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y17so9513718lfa.8;
        Sun, 27 Sep 2020 22:00:57 -0700 (PDT)
X-Received: by 2002:a19:dd5:: with SMTP id 204mr3081226lfn.551.1601269257025;
 Sun, 27 Sep 2020 22:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-3-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-3-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 13:00:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v669XXerfrgK9WzAoMHwArn765yS9Db4_xwwQSXpnm2zqQ@mail.gmail.com>
Message-ID: <CAGb2v669XXerfrgK9WzAoMHwArn765yS9Db4_xwwQSXpnm2zqQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 02/20] ASoC: sun4i-i2s: Change
 set_chan_cfg() params
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> As slots and slot_width can be overwritter in case set_tdm() is
> called. Avoid to have this logic in set_chan_cfg().

It doesn't seem that set_tdm_slot() would get called concurrently
with hw_params(), at least not for the simple-card family. If so
then we'd have more problems like mismatched slots/slot-width
due to no serialization when interacting with those values.

> Instead pass the required values as params to set_chan_cfg().
>
> This will also avoid a bug when we will enable 20/24bits support,
> i2s->slot_width is not actually used in the lrck_period computation.
>
> Suggested-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 2baf6c276280..0633b9fba3d7 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -177,8 +177,9 @@ struct sun4i_i2s_quirks {
>         unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
>         s8      (*get_sr)(const struct sun4i_i2s *, int);
>         s8      (*get_wss)(const struct sun4i_i2s *, int);
> -       int     (*set_chan_cfg)(const struct sun4i_i2s *,
> -                               const struct snd_pcm_hw_params *);
> +       int     (*set_chan_cfg)(const struct sun4i_i2s *i2s,
> +                               unsigned int channels,  unsigned int slots,
> +                               unsigned int slot_width);
>         int     (*set_fmt)(const struct sun4i_i2s *, unsigned int);
>  };
>
> @@ -414,10 +415,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
>  }
>
>  static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> -                                 const struct snd_pcm_hw_params *params)
> +                                 unsigned int channels, unsigned int slots,
> +                                 unsigned int slot_width)
>  {
> -       unsigned int channels = params_channels(params);
> -
>         /* Map the channels for playback and capture */
>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
> @@ -434,15 +434,11 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>  }
>
>  static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> -                                 const struct snd_pcm_hw_params *params)
> +                                 unsigned int channels, unsigned int slots,
> +                                 unsigned int slot_width)
>  {
> -       unsigned int channels = params_channels(params);
> -       unsigned int slots = channels;
>         unsigned int lrck_period;
>
> -       if (i2s->slots)
> -               slots = i2s->slots;
> -

Based on the bug you highlighted in your expanded commit log, the simpler fix
would be to look at i2s->slot_width in addition to i2s->slots, and replace
params_physical_width(params) accordingly.

Also, I would put fixes (even preparatory ones) before patches that introduce
support for new features and hardware. That makes them easier to backport if
needed.


ChenYu


>         /* Map the channels for playback and capture */
>         regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
>         regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
> @@ -467,11 +463,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>         case SND_SOC_DAIFMT_DSP_B:
>         case SND_SOC_DAIFMT_LEFT_J:
>         case SND_SOC_DAIFMT_RIGHT_J:
> -               lrck_period = params_physical_width(params) * slots;
> +               lrck_period = slot_width * slots;
>                 break;
>
>         case SND_SOC_DAIFMT_I2S:
> -               lrck_period = params_physical_width(params);
> +               lrck_period = slot_width;
>                 break;
>
>         default:
