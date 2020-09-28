Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E113C27A6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgI1FcU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 01:32:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37529 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1FcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:32:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id z19so9620909lfr.4;
        Sun, 27 Sep 2020 22:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=phlxL4gdu7otO3M0yS2hHFofM05cgFHXHWsfvHe5FGc=;
        b=WsZXfEGtLUv7pz/4VkpCM9hAIt+YO9qpmRzhStd1N1HULPZy9tA8RN+a3/7v0U4hYv
         92v5GXRdFA8lGqZ2mkwXWV8zYt0El2pH6eBk95HB0FNAMmOLzfPqwHMPVBRRczfJ8Z/u
         loY/rDd0ZqcWwUKsDtoJ/GA+oIWT979e52i5WkLjhcmHGV/7he4GhWwEMu4g6WvtSV4c
         uiwjsShu0of3h0lUiy/Hw1ECQMSaSY/XsPCPy/kf0M1kkhaXVorUNdu+lFelXgIwqeMQ
         eyE4BC3WsEYkW1ipcOuo5RGgqpga+pzRpo4/JF+3JhCgRWcWW2Kxb70hGjhHjUa8jaOY
         p8qg==
X-Gm-Message-State: AOAM5324AjOmTiFSHkRH8c7jnofe3K0HgwDkAyri2laCH44AtgLcupBd
        ick18+h36mNclpnpJp+DVFvsuVtiEYt2Cw==
X-Google-Smtp-Source: ABdhPJwKHvxL7Z+1MpH9Jxz2hY+3/GADbyaEfYsVc0Z4DmBUYd6JytBHR5c3q7KGXfTi33JK3JsevA==
X-Received: by 2002:a19:418b:: with SMTP id o133mr3636166lfa.413.1601271136459;
        Sun, 27 Sep 2020 22:32:16 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u1sm2670419lfl.305.2020.09.27.22.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 22:32:16 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id q8so9608546lfb.6;
        Sun, 27 Sep 2020 22:32:15 -0700 (PDT)
X-Received: by 2002:a19:383:: with SMTP id 125mr3418787lfd.356.1601271135695;
 Sun, 27 Sep 2020 22:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-10-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-10-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 13:32:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v64uAHUd=Ag2pQDqH=gjtPVso5dnKKdCn3ihyiVh8V8L=g@mail.gmail.com>
Message-ID: <CAGb2v64uAHUd=Ag2pQDqH=gjtPVso5dnKKdCn3ihyiVh8V8L=g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/20] arm64: dts: allwinner: h6: Add DAI
 node and soundcard for HDMI
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
> Add the I2S node used by the HDMI and a simple-soundcard to
> link audio between HDMI and I2S.
>
> Note that the HDMI codec requires an inverted frame clock and
> a fixed I2S width. As there is no such option for I2S we use
> TDM property of the simple-soundcard to do that.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 28c77d6872f6..a8853ee7885a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -67,6 +67,25 @@ de: display-engine {
>                 status = "disabled";
>         };
>
> +       hdmi_sound: hdmi-sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,name = "sun50i-h6-hdmi";
> +               simple-audio-card,mclk-fs = <128>;
> +               simple-audio-card,frame-inversion;
> +               status = "disabled";
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&hdmi>;
> +               };
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&i2s1>;
> +                       dai-tdm-slot-num = <2>;

Doesn't this end up limiting the number of audio channels HDMI can carry?
AFAICT the TDM properties are all optional, so just leave it out.

Same goes for the other two patches.

> +                       dai-tdm-slot-width = <32>;
> +               };
> +       };
> +
>         osc24M: osc24M_clk {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
> @@ -609,6 +628,19 @@ mdio: mdio {
>                         };
>                 };
>
> +               i2s1: i2s@5091000 {
> +                       #sound-dai-cells = <0>;
> +                       compatible = "allwinner,sun50i-h6-i2s";
> +                       reg = <0x05091000 0x1000>;
> +                       interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
> +                       clock-names = "apb", "mod";
> +                       dmas = <&dma 4>, <&dma 4>;
> +                       resets = <&ccu RST_BUS_I2S1>;
> +                       dma-names = "rx", "tx";
> +                       status = "disabled";
> +               };
> +
>                 spdif: spdif@5093000 {
>                         #sound-dai-cells = <0>;
>                         compatible = "allwinner,sun50i-h6-spdif";
> @@ -739,6 +771,7 @@ ohci3: usb@5311400 {
>                 };
>
>                 hdmi: hdmi@6000000 {
> +                       #sound-dai-cells = <0>;
>                         compatible = "allwinner,sun50i-h6-dw-hdmi";
>                         reg = <0x06000000 0x10000>;
>                         reg-io-width = <1>;

The rest of the patch looks OK.
