Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F72F5DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbhANJhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbhANJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:37:20 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5832FC061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:36:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ga15so7215528ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WPhESZ2Ino1UQ+7G+F0v8AM8oEjEHY5bkl74A+HS9U=;
        b=SHJ9j/iZ90wmHmG96hK7ogsn+S7r1luxoBa6keVoDk4NWbSCNnoALijDtih8olEzBp
         eDDDm4LvTYIbIOa9nrF326FdHiHrMyGHEI0TXd3HrkbhFqbAVtF/7e5WQUgCknaSHz2x
         oaFoSLatWj55lgEdC8DqqwywnwvJxqk6B9c+akWMvuSp2zsd7hpbZ5o5I5aijPmm7V6s
         zwK4nJ3wNqC2p35i6MuadpL+gY2FguImFJ1W8Ikba4vihJrR/AQPmBP33UibkinQaJwF
         Qv9v/EYxpCWlszMU3oHqnTK2fSoOvRL037tvswAb4X2vqXIa3f/aG5y1lQsta3pccOjm
         akZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WPhESZ2Ino1UQ+7G+F0v8AM8oEjEHY5bkl74A+HS9U=;
        b=tvFviVSiepiDzKWGwUgQkXm9BzMYWUWC1vOoDqCgGD41S6HiNxiovidRv56jj6ShVn
         etFR9IJIvpkzQG+7IkAxsqe3b3bXBbpZaf+AxaftxtfbQhMKB7MyfVFRcRirVEfUDSqu
         fMvAfC/jacne48vLASVbQGBrjowzrfpVeo3U/dYt5wxa656Ky+sjzfc0HYxA87fgOO+R
         bL9UHD8Ljtac22/B74Mz426jyaaxxrFTmPydozV06qwy0kO3ho5P6hQVWDBP0vPx5Awt
         YxB669aqPl2FwEi1nbyD9GuFPRcCWGuaqY4Ad3DAX70pBsh1viGF7jP/XZgkBDH3/HKn
         x9lA==
X-Gm-Message-State: AOAM533swIZTWKjlO98h+svhBk0+C5Ge+meifZMBSnh96bLwwC0tI/rE
        L9DsI5d6FXCl7GMKmBIRh/UEbpSFJg9cR1atJgK0pA==
X-Google-Smtp-Source: ABdhPJyrveNlmYlJtZwqPTnLW1uRvgk2qAwIeuLIPI8/FEwrO+3RCMe8L28l1DrM60nxOvEbNEfYmHp69hbWY7kCXSc=
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr4605167ejd.429.1610616993048;
 Thu, 14 Jan 2021 01:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20210111054428.3273-1-dqfext@gmail.com> <20210111134349.vdhyebdllbaakukk@skbuf>
In-Reply-To: <20210111134349.vdhyebdllbaakukk@skbuf>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 10:36:22 +0100
Message-ID: <CAMpxmJWi=BPvXyE_m0dyfmhuK76wYjVTtmvVEk7xSfPcaTYbkA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] dsa: add MT7530 GPIO support
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     DENG Qingfang <dqfext@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        netdev <netdev@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:43 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 01:44:26PM +0800, DENG Qingfang wrote:
> > MT7530's LED controller can be used as GPIO controller. Add support for
> > it.
> >
> > DENG Qingfang (2):
> >   dt-bindings: net: dsa: add MT7530 GPIO controller binding
> >   drivers: net: dsa: mt7530: MT7530 optional GPIO support
> >
> >  .../devicetree/bindings/net/dsa/mt7530.txt    |  6 ++
> >  drivers/net/dsa/mt7530.c                      | 96 +++++++++++++++++++
> >  drivers/net/dsa/mt7530.h                      | 20 ++++
> >  3 files changed, 122 insertions(+)
> >
> > --
> > 2.25.1
>
> Adding GPIO and LED maintainers to also have a look.
> https://patchwork.kernel.org/project/netdevbpf/cover/20210111054428.3273-1-dqfext@gmail.com/

Can you resend the series with GPIO maintainers in CC?

Bart
