Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5DA27A696
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgI1EkT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 00:40:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34956 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgI1EkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:40:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id w11so9547523lfn.2;
        Sun, 27 Sep 2020 21:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MDGs++4RRj95+aWDmWU1XgAa7yuF3b9Kk32dL6Y6dKY=;
        b=RMaLD1pT0naQFcX2KPEjSln+wAzyUKLeOtBq60M0q9J6/CWRzFvjjshBOW6J0nUYop
         SFx56O4YdbYysuXNTPWvBW53jAiJCcgOICQK2D3sVgs4Dqa5VstdC8sSjHQgw4+3efVp
         Qs7ltY6ugJQgif3L1/dE4Qw80lbrvezZnBo6MVOM4I/RzHp7oLY5oCpEY5EPYNhExv8e
         Pi3heJyEcbzjfcHpTOypvtdX0YYsa5MmObIw3vP7wOEQQYnPe4tmzJv0koujZfrSfkeT
         hGzz9+kjWchryNnKHW8EykTHwpjI4lk4h1+zYttRrdK32b1SD5wUG/LsNK5vgPbCto1U
         0lFQ==
X-Gm-Message-State: AOAM531uKh+s36OyiQ3QwtiIQwm3qQkPY4xVtojCfhcopnG+rOm+tvdx
        WUQIE6NfMP58L6tXH0d6eE6zahJl4i/o3A==
X-Google-Smtp-Source: ABdhPJwFRuf1qyI6IM5JBhnbubAqXnQu5bO1PtjZzsD/Zb9z0m15HrfnL5DxlqNYLmMs66/YvDe0eA==
X-Received: by 2002:a05:6512:31c4:: with SMTP id j4mr2928208lfe.323.1601268016425;
        Sun, 27 Sep 2020 21:40:16 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t23sm5703104ljc.125.2020.09.27.21.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 21:40:16 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id z19so9520685lfr.4;
        Sun, 27 Sep 2020 21:40:16 -0700 (PDT)
X-Received: by 2002:a19:dd5:: with SMTP id 204mr3065459lfn.551.1601268015876;
 Sun, 27 Sep 2020 21:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-2-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-2-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 12:40:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v65AhnqD6ec20h9vtd2GjqVsf_yz5+7VSa8giJuFJnd5ag@mail.gmail.com>
Message-ID: <CAGb2v65AhnqD6ec20h9vtd2GjqVsf_yz5+7VSa8giJuFJnd5ag@mail.gmail.com>
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

On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> H6 I2S is very similar to that in H3, except it supports up to 16
> channels.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 224 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index f23ff29e7c1d..2baf6c276280 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -124,6 +124,21 @@
>  #define SUN8I_I2S_RX_CHAN_SEL_REG      0x54
>  #define SUN8I_I2S_RX_CHAN_MAP_REG      0x58
>
> +/* Defines required for sun50i-h6 support */
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK  GENMASK(21, 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)       ((offset) << 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK         GENMASK(19, 16)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)                ((chan - 1) << 16)
> +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK          GENMASK(15, 0)
> +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)     (((1 << num_chan) - 1))
> +
> +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG 0x44
> +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG 0x48
> +
> +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG  0x64
> +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG 0x68
> +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG 0x6C
> +
>  struct sun4i_i2s;
>
>  /**
> @@ -474,6 +489,62 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>         return 0;
>  }
>
> +static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> +                                     const struct snd_pcm_hw_params *params)
> +{
> +       unsigned int channels = params_channels(params);
> +       unsigned int slots = channels;
> +       unsigned int lrck_period;
> +
> +       if (i2s->slots)
> +               slots = i2s->slots;
> +
> +       /* Map the channels for playback and capture */
> +       regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
> +       regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);

Nit, since it supports up to 16 channels, you might want to map all 16 of them
now, instead of having to come back and fix it later.

Code wise, this patch is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

I don't have a scope nor logic analyzer, so I wasn't able to participate in the
LRCK discussion.
