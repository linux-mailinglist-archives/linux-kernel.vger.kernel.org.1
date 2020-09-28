Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09A027A7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1GxF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 02:53:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44752 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgI1GxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:53:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id b19so98286lji.11;
        Sun, 27 Sep 2020 23:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ks9FfGEmMHZLEsPsJfUxgzn6i0sxrDqEyXegeg+9Gd4=;
        b=AX5+VizZU87tv+53paicwS3a8WNJ708gWwK+DEQNIyX0im7Bo0uUOeJi8ce25XdjVM
         mccS1VO5zPwcUphCn1b8vqsF03BR044LPdgaFnpyVhIMXD45L8/BHIevAlRJJcUJID/z
         sbGy5R9TMNGW/u1QUJVCHirCR+lXt0h3SOTkjBz8mKCGEg+9SFCsGtjpNYhrORul3bSB
         4E1RNZ6HEhbovMVqkDhyW0ZssuiXHvrNuwH9M3WgIajuMB8X0gdSlfdU8qvKyPaSHbJ0
         3XuADsn99MXv9LpRDKF02TgBNI+1t3jqrbpteLd6AyaA1h3HbqtUMc+TkRbv9pugIHTu
         ZNyA==
X-Gm-Message-State: AOAM5332Y+tQ+9YeSpxUG3+5C37Jk2sChoPg2hX0aSESGnDi/w4qld3H
        g00yH7TT3nHiwWrLCG9Q1L4onAblC1IalA==
X-Google-Smtp-Source: ABdhPJyHZNKnHbnaJR6wKmZ+jjIiWW/rqBRHz29DVgtUE5IL/lk/Rfw/1iluooBNziFDeMKw0z1mMw==
X-Received: by 2002:a2e:240e:: with SMTP id k14mr4179253ljk.169.1601275982705;
        Sun, 27 Sep 2020 23:53:02 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 68sm8537ljf.14.2020.09.27.23.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 23:53:02 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 77so9832181lfj.0;
        Sun, 27 Sep 2020 23:53:02 -0700 (PDT)
X-Received: by 2002:a19:b97:: with SMTP id 145mr3130963lfl.193.1601275982109;
 Sun, 27 Sep 2020 23:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 14:52:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v660m4U1XPXWc=9G7GSW5e515VVXq7vPLJwXmAfoqWpvhA@mail.gmail.com>
Message-ID: <CAGb2v660m4U1XPXWc=9G7GSW5e515VVXq7vPLJwXmAfoqWpvhA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 00/20] Add Allwinner H3/H5/H6/A64 HDMI audio
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
> Hi,
>
> This is exactly the same as v4 but with more details in some commit log
> and also device-tree soundcard and DAI node have been merged.
>
> Regards,
> Clement
>
> Change since v4;
> - add more comment on get_wss() and set_channel_cfg() patch
> - merge soundcard and DAI HDMI patches
>
> Change since v3:
> - add Samuel Holland patch to reconfigure FIFO_TX_REG when suspend is enabled
> - readd inversion to H6 LRCK sun50i_h6_i2s_set_soc_fmt()
> - Fix get_wss() for sun4i
> - Add a commit to fix checkpatch warning
>
> Change since v2:
> - rebase on next-20200918
> - drop revert LRCK polarity patch
> - readd simple-audio-card,frame-inversion in dts
> - Add patch for changing set_chan_cfg params
>
> Change since v1:
> - rebase on next-20200828
> - add revert LRCK polarity
> - remove all simple-audio-card,frame-inversion in dts
> - add Ondrej patches for Orange Pi board
> - Add arm64 defconfig patch
>
> Clément Péron (6):
>   ASoC: sun4i-i2s: Change set_chan_cfg() params
>   ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
>   ASoC: sun4i-i2s: Fix sun8i volatile regs
>   arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
>   arm64: defconfig: Enable Allwinner i2s driver
>   ASoC: sun4i-i2s: fix coding-style for callback definition
>
> Jernej Skrabec (3):
>   ASoC: sun4i-i2s: Add support for H6 I2S
>   dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
>   arm64: dts: allwinner: h6: Add DAI node and soundcard for HDMI
>
> Marcus Cooper (7):
>   ASoC: sun4i-i2s: Set sign extend sample
>   ASoc: sun4i-i2s: Add 20 and 24 bit support
>   arm: dts: sunxi: h3/h5: Add DAI node and soundcard for HDMI
>   arm64: dts: allwinner: a64: Add DAI node and soundcard for HDMI
>   arm: sun8i: h3: Add HDMI audio to Orange Pi 2
>   arm: sun8i: h3: Add HDMI audio to Beelink X2
>   arm64: dts: allwinner: a64: Add HDMI audio to Pine64
>
> Ondrej Jirman (3):
>   arm64: dts: allwinner: Enable HDMI audio on Orange Pi PC 2
>   ARM: dts: sun8i-h3: Enable HDMI audio on Orange Pi PC/One
>   arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio

Acked-by: Chen-Yu Tsai <wens@csie.org>

for all the board DTS file changes.
