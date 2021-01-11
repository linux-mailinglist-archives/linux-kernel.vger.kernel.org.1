Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E761A2F1B48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbhAKQnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389062AbhAKQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:43:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400EC06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:42:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e25so507477wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pnjD2UilASpN7loOYOlKYs+Pbcte4indWOVKi/fCTJg=;
        b=jZPGYifKJXu2wyCXuOOqiam6bYFwnCgZIld3hfdNBNiId3bEdbMCzQkxliyHesCEmS
         x6cu7r3uREiid7Hb1dctzIY7498SE+zMrR8HPJDsEgnQILuGz6BIgIgvnrXyuJ0QUoq5
         104uS8DvTxQ8Y4KlApoJiuN2YTQfJTFv1Ef1TZsjopplyIqu1lmKCV0yLutNAtD/+79D
         RQT1/AUVzII+CqjH3dw0cPsE33XX2ktNEHM1jVNreiTO9MfHIKusni1KNxKGlAL8g40T
         rWR6RXsOyXsTbJ7hyZV09aXGOaYCq/Be+Sl97sP7jLbTGEL55i2/RL3N2caecholkxQa
         w1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pnjD2UilASpN7loOYOlKYs+Pbcte4indWOVKi/fCTJg=;
        b=A9TVxvwvZqYZq/ciNZUAEPvpYAhZpWJhW/lhGfXdbn4OokZzu8cheibOq/gf3ngwzI
         Ra+gFeshbWpMG81aDDvLMQ4IIWOybWR/YePkONgGos0wN4VtdMzDKCho+RvAnAOmBq2d
         HDtMiVe5HszU1PeTzp4LW9PiDuzBYlzbXkd/OlZ4qeWITVbYprXVfbpv3INRE6nKOhAI
         0qwP86ueeaHamECUGkWp7T3DtnnvsjpZrVGvfYQve2NHf4mwhSMVpraZC7AXCXDPj/Jc
         A7RijkiYdLRzXpEjQfZtbyMLgg1okmNn8o4t1hCjvm7qP53W2f2aeuUs5z757CANUDxs
         rxfg==
X-Gm-Message-State: AOAM531F+NUJiPgt2ZbRsEQz0QIGv4To7fxA3lHQLCPcLzwOXDPt5djR
        MAxSRaCvH77ghKGh6lh8Yma//g==
X-Google-Smtp-Source: ABdhPJzApE1wVaNIEk7OP7bPmtcjgsSpWlYwuKYrzBqby7CnQK7nLd4dwQgxpqSjJJiQ2SKJafc7Mw==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr509718wmi.164.1610383356061;
        Mon, 11 Jan 2021 08:42:36 -0800 (PST)
Received: from dell ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id v1sm196393wrr.48.2021.01.11.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:42:35 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:42:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20210111164228.GB3575260@dell>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
 <20210109180220.121511-5-j.neuschaefer@gmx.net>
 <X/xKZI04ipiQCUjd@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/xKZI04ipiQCUjd@ulmo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021, Thierry Reding wrote:

> On Sat, Jan 09, 2021 at 07:02:17PM +0100, Jonathan Neuschäfer wrote:
> > The Netronix EC provides a PWM output which is used for the backlight
> > on some ebook readers. This patches adds a driver for the PWM output.
> > 
> > The .get_state callback is not implemented, because the PWM state can't
> > be read back from the hardware.
> > 
> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > ---
> > v7:
> > - no changes
> > 
> > v6:
> > - https://lore.kernel.org/lkml/20201208011000.3060239-5-j.neuschaefer@gmx.net/
> > - Move period / duty cycle setting code to a function
> > - Rename pwmchip_to_priv to ntxec_pwm_from_chip
> > - Set period and duty cycle only before enabling the output
> > - Mention that duty=0, enable=1 is assumed not to happen
> > - Interleave writes to the period and duty cycle registers, to minimize the
> >   window of time that an inconsistent state is configured
> > 
> > v5:
> > - https://lore.kernel.org/lkml/20201201011513.1627028-5-j.neuschaefer@gmx.net/
> > - Avoid truncation of period and duty cycle to 32 bits
> > - Make ntxec_pwm_ops const
> > - Use regmap_multi_reg_write
> > - Add comment about get_state to ntxec_pwm_ops
> > - Add comments about non-atomicity of (period, duty cycle) update
> > 
> > v4:
> > - https://lore.kernel.org/lkml/20201122222739.1455132-5-j.neuschaefer@gmx.net/
> > - Document hardware/driver limitations
> > - Only accept normal polarity
> > - Fix a typo ("zone" -> "zero")
> > - change MAX_PERIOD_NS to 0xffff * 125
> > - Clamp period to the maximum rather than returning an error
> > - Rename private struct pointer to priv
> > - Rearrage control flow in _probe to save a few lines and a temporary variable
> > - Add missing MODULE_ALIAS line
> > - Spell out ODM
> > 
> > v3:
> > - https://lore.kernel.org/lkml/20200924192455.2484005-5-j.neuschaefer@gmx.net/
> > - Relicense as GPLv2 or later
> > - Add email address to copyright line
> > - Remove OF compatible string and don't include linux/of_device.h
> > - Fix bogus ?: in return line
> > - Don't use a comma after sentinels
> > - Avoid ret |= ... pattern
> > - Move 8-bit register conversion to ntxec.h
> > 
> > v2:
> > - https://lore.kernel.org/lkml/20200905133230.1014581-6-j.neuschaefer@gmx.net/
> > - Various grammar and style improvements, as suggested by Uwe Kleine-König,
> >   Lee Jones, and Alexandre Belloni
> > - Switch to regmap
> > - Prefix registers with NTXEC_REG_
> > - Add help text to the Kconfig option
> > - Use the .apply callback instead of the old API
> > - Add a #define for the time base (125ns)
> > - Don't change device state in .probe; this avoids multiple problems
> > - Rework division and overflow check logic to perform divisions in 32 bits
> > - Avoid setting duty cycle to zero, to work around a hardware quirk
> > ---
> >  drivers/pwm/Kconfig     |   8 ++
> >  drivers/pwm/Makefile    |   1 +
> >  drivers/pwm/pwm-ntxec.c | 182 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 191 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-ntxec.c
> 
> Lee, I assume you'll want to pick the whole set up into the MFD tree? If
> so:

Yes, I'll pick this up once we have all the Acks.

The Arm parts usually go in separately.

> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
