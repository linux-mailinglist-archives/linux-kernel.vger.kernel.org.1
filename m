Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BC92C69FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbgK0QpQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Nov 2020 11:45:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34756 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbgK0QpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:45:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id s18so6502909oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PNkdNVtybM7ASEm6wqIScGKsEVgtoQgmQQZVfx855PU=;
        b=MMFGmxtC/nGYZLxOu8F8fUwwtgU54cHXiqMUmumaJkmQhjZQ18owwsJYaQ4JGa9o0r
         geKe639G9dBqamEz5ljvcvHi8VUF8doG9rbrpwZ72onEaylKHpzCx0TMMD5epn6SINtF
         ZqlawvGh5DDZ0coHC3d6mlPF87f6STkegeWfxofWBSoslU5ejd22IZEVQbqN5bZ7Dz0x
         Gdb9Mtkw7MksnJN06AelN9ZcLQYrdJMc9cRMI2NQTuSc1XfSV6nv0i5BjKcdbdwztnmc
         QLjnU75lj5C1pnntX/C3e5bDBXSnqjiTfsa2kPgZVGifdGyrCMLGItUbwLm0wAexQC5o
         7L2Q==
X-Gm-Message-State: AOAM532sKo6uHA8EIIs6GyE9s2Jlw3D9zm0zRVMqOIgyHJ0t67OjeIxZ
        OxH7TbTL27+eus5OOB5Pz0XnHyJXDnxK4ppZv7Q=
X-Google-Smtp-Source: ABdhPJx+9Sh6yRQ40w4dQ0pplbEXiAcCxvTWO/rHlQT0V7qB0CCMd0abmN+DCNLBSZPwBf7tV6tVRhBWCicqXztQv+s=
X-Received: by 2002:aca:4bc3:: with SMTP id y186mr6005674oia.153.1606495514466;
 Fri, 27 Nov 2020 08:45:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606495281.git.agx@sigxcpu.org> <a27f198a0fed19e52a380e59339105c4bf98c989.1606495281.git.agx@sigxcpu.org>
In-Reply-To: <a27f198a0fed19e52a380e59339105c4bf98c989.1606495281.git.agx@sigxcpu.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Nov 2020 17:45:03 +0100
Message-ID: <CAMuHMdUK3gbHwR94BcjRBkNvdpQSJrMn0itrs65Ay5KqUCA-Hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: defconfig: Enable more Librem 5 hardware
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thanks for your patch!

On Fri, Nov 27, 2020 at 5:42 PM Guido Günther <agx@sigxcpu.org> wrote:
> This enables
>
> - CONFIG_BATTERY_MAX17042: battery chip
> - CONFIG_CHARGER_BQ25980: charge controller
> - CONFIG_DRM_PANEL_MANTIX_MLAF057WE5: LCD panel
> - CONFIG_IMX_DCSS: 2nd dislay controller

display

> - CONFIG_LEDS_LM3692X: LCD backlight
> - CONFIG_REGULATOR_TPS65132: regulator for the LCD panel
> - CONFIG_TOUCHSCREEN_EDT_FT5X06: touch controller
> - CONFIG_TYPEC_TPS6598X: USB PD controller
> - CONFIG_VCNL4000: ambient light and proximiry sensor

proximity

>
> as modules.
>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
