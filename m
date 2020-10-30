Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83F2A0E55
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgJ3THX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgJ3THX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:07:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B48BC0613CF;
        Fri, 30 Oct 2020 12:07:23 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so8625721ion.3;
        Fri, 30 Oct 2020 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kRnMiBAqbQrnQNWoGObw/GN72MYVN3PVOyPP/xbkSv4=;
        b=SpSa0e4NexLm00Kgmenuq9+x90MS+prPInmNNlAj0OlEmSIi5GYyIJzEg/BLwp0pOn
         bCD0nJO4bx+7KsyO1p9X2YaaZrPZmvBJl60VjVWxZce/4fElgFD87VfGS42oeZ9YwCCG
         Zj3mlct0tQags16wHsGZTCijv+dUaTOd5yR7ToFvcXHBAZgBHqJh0lAQ/2gbIsC3tii4
         XemUJFlPUAecRWF5nZUOhFlWkfnaTMlKGruZv6q4IAiz7+H7z1ZhpBA6KANL8eMs0Hyy
         ToFM4o52BcClrMjo0uztS67L6EI+lVqNshUPM+wC+fne1XKGHSH+uPE4EeCB4UrnG8Sk
         gsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kRnMiBAqbQrnQNWoGObw/GN72MYVN3PVOyPP/xbkSv4=;
        b=IXmoclusRC7qWoUu717H/N0gyu5bFQ5kFfJNuz/AL7H/66J4ctDoWgMZ3b/6zovGvT
         uynyn92XuxaoJH1dol+ICxOqG+qxR3883S7d8WV16VDMeBxMwR3tW4Vq0CsITxfpcGrX
         IWvH2TLwiCYhVjPuhu4QWVG0kZxo08cdy8YLHuEWNqENdjwmaB4RGmQ7tt3bmhWmOo59
         5baTVvnWzraUohJlc2o2Uztrx0wM1bGWX8CZdjN5O7om3pfzlpK1n7zc9Pbkfrw6aoQw
         STeg7P0fs1NQkw4e0GMm696c2Cv8zlRNAeG47dVs5MzM8GBUx8eF/X/vL3rMWuqF/ogD
         L0IA==
X-Gm-Message-State: AOAM533DabECoaZcEb6im59qLM+dW2sTNgosVjnimZgR3nfAI6d2rp2I
        D13e6frk2py4i8mwCHKQ/srWvzpEC4fASsnpPTM=
X-Google-Smtp-Source: ABdhPJyHHJZwON07JsYGXD+WzKKqSo4WezgeeFyNNwPtTNagJNoLm+UN3ag55BdCObIQ1+1dmhE4aXc+492+h8Di5G4=
X-Received: by 2002:a02:5b09:: with SMTP id g9mr3051607jab.89.1604084842581;
 Fri, 30 Oct 2020 12:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201030144648.397824-1-peron.clem@gmail.com> <20201030144648.397824-2-peron.clem@gmail.com>
 <20201030161131.dlzzpy3atiiddx4n@gilmour.lan>
In-Reply-To: <20201030161131.dlzzpy3atiiddx4n@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 30 Oct 2020 20:07:11 +0100
Message-ID: <CAJiuCceRyRie_3sp7dZsFeHWCV+CFXX8R206kmMwq4_EHvfK=w@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ASoC: sun4i-i2s: Fix lrck_period computation
 for I2S justified mode
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, 30 Oct 2020 at 17:11, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, Oct 30, 2020 at 03:46:34PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Left and Right justified mode are computed using the same formula
> > as DSP_A and DSP_B mode.
> > Which is wrong and the user manual explicitly says:
> >
> > LRCK_PERDIOD:
> > PCM Mode: Number of BCLKs within (Left + Right) channel width.
> > I2S/Left-Justified/Right-Justified Mode: Number of BCLKs within each
> > individual channel width(Left or Right)
> >
> > Fix this by using the same formula as the I2S mode.
> >
> > Fixes: 7ae7834ec446 ("ASoC: sun4i-i2s: Add support for DSP formats")
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
Thanks for the ACK

just noticed that the case was not properly sorted.

Do you agree that sorting like this is better ?
        case SND_SOC_DAIFMT_I2S:
+       case SND_SOC_DAIFMT_LEFT_J:
+       case SND_SOC_DAIFMT_RIGHT_J:

If I have to push a new series I will fix it

Regards,
Clement

> Thanks!
> Maxime
