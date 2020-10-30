Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684629FB33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgJ3C0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:26:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34219 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJ3C0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:26:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id y16so5340487ljk.1;
        Thu, 29 Oct 2020 19:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMV8JRqZetrNRbRgXvrwv2LRGFW2iY1pfcrFgn9kKw8=;
        b=Kh17ojqZiXVQnqIAXQh9/pvB5eJPGbvtq9lmRL0g/R2rjU2NruKNtYgVMErRU0WzT/
         7UspPWrESxsZO0vDRcGEK1rqtTVzcXjGHeWFRo48EFtutxTOtR1R4wN8cP9TwrL49bRO
         sY2F73FfRwxONcMkgy/E/YH9pm+egmj1sCix5+7ZYOHq24QezFEku2pR0qEORw0w2iBh
         i72AOps4GSNaTKWgqbj2pRJhKf3XJXXeahTTXqBP8uxIgHV8N/uysKRPqywcbldemTwc
         t7QFtPEVm+uxkSPUFsCHyIayHgjM7YVkPjPRXh6PAenr2HjDJBIFA0Z41xixpHEGOyS0
         5UCw==
X-Gm-Message-State: AOAM530PFMhRGLO4jkN2Jxu7RWCtQJl0iKCRdLdG5yQuCNJbIj868FWs
        Ec/93dc2+DK76KMiPScIzs6wh/7zVce6vA==
X-Google-Smtp-Source: ABdhPJyRtb9C52kh7wNjrSDWDdx3q81NZ3pX2rgWDkI246Rc9kvAOVzHUUq4Tlu7RIFmMD+rT3Z0vw==
X-Received: by 2002:a2e:8e83:: with SMTP id z3mr52600ljk.341.1604024774498;
        Thu, 29 Oct 2020 19:26:14 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f24sm465377lfh.73.2020.10.29.19.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 19:26:14 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id b1so5883378lfp.11;
        Thu, 29 Oct 2020 19:26:13 -0700 (PDT)
X-Received: by 2002:ac2:46fc:: with SMTP id q28mr1114045lfo.551.1604024773741;
 Thu, 29 Oct 2020 19:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201029201537.598182-1-jernej.skrabec@siol.net>
In-Reply-To: <20201029201537.598182-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 30 Oct 2020 10:26:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v665GQBTPqjAju9Cauh94GHBWCcoZf595KhfeYR_kNrKVA@mail.gmail.com>
Message-ID: <CAGb2v665GQBTPqjAju9Cauh94GHBWCcoZf595KhfeYR_kNrKVA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: allwinner: h6: PineH64 model B:
 Add wifi
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 4:10 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> PineH64 model B contains RTL8723CS wifi+bt combo module.
>
> Since bluetooth support is not yet squared away, only wifi is enabled
> for now.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../dts/allwinner/sun50i-h6-pine-h64-model-b.dts   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index f4c8966a6497..3f42b8b29b0f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -10,6 +10,12 @@ / {
>         compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
>
>         /delete-node/ reg_gmac_3v3;
> +
> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> +               post-power-on-delay-ms = <200>;
> +       };
>  };
>
>  &hdmi_connector {
> @@ -19,3 +25,11 @@ &hdmi_connector {
>  &emac {
>         phy-supply = <&reg_aldo2>;
>  };
> +
> +&mmc1 {
> +       vmmc-supply = <&reg_cldo3>;

Please add vqmmc-supply, which according to the schematic is supplied by ALDO1.

After that,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "okay";
> +};
> --
> 2.29.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20201029201537.598182-1-jernej.skrabec%40siol.net.
