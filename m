Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324182C7107
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391158AbgK1VwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:06 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:45988 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732064AbgK1S55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3E07BFB05;
        Sat, 28 Nov 2020 19:57:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K5MJVIycsqv1; Sat, 28 Nov 2020 19:57:14 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CF7AF4068E; Sat, 28 Nov 2020 19:57:13 +0100 (CET)
Date:   Sat, 28 Nov 2020 19:57:13 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v2 1/1] arm64: defconfig: Enable more Librem 5 hardware
Message-ID: <20201128185713.GA6719@bogon.m.sigxcpu.org>
References: <cover.1606495281.git.agx@sigxcpu.org>
 <a27f198a0fed19e52a380e59339105c4bf98c989.1606495281.git.agx@sigxcpu.org>
 <CAMuHMdUK3gbHwR94BcjRBkNvdpQSJrMn0itrs65Ay5KqUCA-Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUK3gbHwR94BcjRBkNvdpQSJrMn0itrs65Ay5KqUCA-Hg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Nov 27, 2020 at 05:45:03PM +0100, Geert Uytterhoeven wrote:
> Hi Guido,
> 
> Thanks for your patch!
> 
> On Fri, Nov 27, 2020 at 5:42 PM Guido Günther <agx@sigxcpu.org> wrote:
> > This enables
> >
> > - CONFIG_BATTERY_MAX17042: battery chip
> > - CONFIG_CHARGER_BQ25980: charge controller
> > - CONFIG_DRM_PANEL_MANTIX_MLAF057WE5: LCD panel
> > - CONFIG_IMX_DCSS: 2nd dislay controller
> 
> display
> 
> > - CONFIG_LEDS_LM3692X: LCD backlight
> > - CONFIG_REGULATOR_TPS65132: regulator for the LCD panel
> > - CONFIG_TOUCHSCREEN_EDT_FT5X06: touch controller
> > - CONFIG_TYPEC_TPS6598X: USB PD controller
> > - CONFIG_VCNL4000: ambient light and proximiry sensor
> 
> proximity

Both fixed in v2 - odd that checkpatch didn't scream.
Thanks!
 -- Guido

> 
> >
> > as modules.
> >
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
