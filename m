Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760FE2CB7BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbgLBIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387914AbgLBIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:49:54 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE1EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 00:49:13 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so5464678wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 00:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j19GKyry5tuRdKFRzYIexOe7SbGmMibu4GAAw/XxItM=;
        b=a0ZVGGxMZqbRLcIgLri87RcR/pZvLWtvFcJnaCvnJvn4d19HI7fgDub1UDn9FJUPyD
         dQj2V4PAMLsUHyJHQ3xX8zZYCzi6sBz6g2ROup1SUGrBkj8Bd78Ux8RN8RFZSuXlaYPk
         NWQRXjTHRHseUcBgbWsgOta0Xmg9upYVrsEnelJrIelEIKg31ktfNWZwnNUzQF2djsNh
         BQiq94h0h32XeXSmLc/vpYoeTZaVgqp3hC3/16YH+sIF48aj4XKA/2SgCn1oaCXfcmTv
         pbA6ffy0Zl1W/xXSwkCA2WwXgdSMPhK+04kQyXXbS8NxpKwiXpplpgMI512OH1V5ZKcU
         s1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j19GKyry5tuRdKFRzYIexOe7SbGmMibu4GAAw/XxItM=;
        b=TvHrn8nA4Gh1/+RAtOeLQ3P0qTyEYmkpM09wfbOILuNfr7B8PSRO1DO9BYwMmqJWV6
         4KSoBLpVkvQ/ke9wl8ySKFVz1sDesheuNJZg2bPXcFsgZhX4ge+eXEj16PAqp+0u7mU/
         BlsRJ/3IDV0ypl2iBmMlKyMXTLhjM23zH2iCtPgb78QNvufFbpwiSbWHD3QadF9DkMRY
         ezNoVAAEWaBlsqiMhpE/jdvDT6PI8QnW9oZgoB6JoNYC1poe6lDCT0AgUTmwWBbd+Ouj
         TyCPKsPEjyYlERIvTbatXqBt+sPqBkv5xqd2aRrflJFbZECI+iTI6rGQWRAp6EdMiT/A
         zWZA==
X-Gm-Message-State: AOAM5338C8dTSkn0so/0nETl6J1cvfoazYMqJE+HJcPgXp9XrJT+ZL9E
        v7N6/n8Nc/6neJWkakLvsl2yVEShBDSyl30Q
X-Google-Smtp-Source: ABdhPJw6v+SMgDlNtdz/dKvA09A5uJTYLhfUFoDXtNTOstIitHBjaxH2tdopoJgg80NCeRT3jpEtTA==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr1954151wmg.65.1606898952395;
        Wed, 02 Dec 2020 00:49:12 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id b14sm1194792wrx.35.2020.12.02.00.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 00:49:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 08:49:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] mfd: rt4831: Adds support for Richtek RT4831 MFD
 core
Message-ID: <20201202084909.GI4801@dell>
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
 <20201125164207.GD4716@dell>
 <CADiBU3_bgx-K_zxzKCSL8w=meZu3cA3uWoC-3QVsBAuNJW1uiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3_bgx-K_zxzKCSL8w=meZu3cA3uWoC-3QVsBAuNJW1uiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Dec 2020, ChiYuan Huang wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年11月26日 週四 上午12:42寫道：
> >
> > On Mon, 02 Nov 2020, cy_huang wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Adds support Richtek RT4831 MFD core.
> > > RT4831 includes backlight and DSV part that can provode display panel
> > > for postive and negative voltage and WLED driving.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >  drivers/mfd/Kconfig       |  11 +++++
> > >  drivers/mfd/Makefile      |   1 +
> > >  drivers/mfd/rt4831-core.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 131 insertions(+)
> > >  create mode 100644 drivers/mfd/rt4831-core.c
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 8b99a13..a22f002 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1088,6 +1088,17 @@ config MFD_RDC321X
> > >         southbridge which provides access to GPIOs and Watchdog using the
> > >         southbridge PCI device configuration space.
> > >
> > > +config MFD_RT4831
> > > +     tristate "Richtek RT4831 WLED and DSV IC"
> >
> > Please expand on WLED and DSV.
> >
> > This is documentation and should leave nothing to the imagination.
> >
> Rewrite to "Richtek RT4831 four channel WLED and display bias
> voltage", is it okay?

I had to look-up WLED, but I guess it's okay.

"Display Bias Voltage"

> > > +     depends on I2C
> > > +     select MFD_CORE
> > > +     select REGMAP_I2C
> > > +     help
> > > +       This enables support for the Richtek RT4831.
> > > +       RT4831 includes WLED driver and DisplayBias voltage(+/-) regulator.
> > > +       It's common used to provide the display power and to drive the
> > > +       display backlight WLED.
> >
> > Please don't line-wrap unnecessarily.
> >
> > Please re-work the last sentence, as it doesn't quite make sense.
> >
> Rewrite the whole sentence like as below
> "This enables support for the Richtek RT4831. It includes 4 channel
> WLED driving and Display Bias voltage output. It's commonly used to
> provide the LCD power and to drive LCD backlight."

"Display Bias Voltage"

"provide power to the LCD display"

[...]

> > > +static int rt4831_probe(struct i2c_client *client)
> > > +{
> > > +     struct gpio_desc *enable;
> > > +     struct regmap *regmap;
> > > +     unsigned int val;
> > > +     int ret;
> > > +
> > > +     enable = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
> > > +     if (IS_ERR(enable)) {
> > > +             dev_err(&client->dev, "Failed to get chip enable gpio\n");
> >
> > "Failed to get 'enable' GPIO chip"
> >
> May I remove "chip" word? It seems redundant.
> "Failed to get 'enable' GPIO" is better.
> Because 'enable' is a physical input pin for RT4831.

Sounds good.

[...]

> > > +static int rt4831_remove(struct i2c_client *client)
> > > +{
> > > +     struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> > > +
> > > +     /* Make sure all off before module removal */
> >
> > "Disable all <thing your disabling> are disabled before ..."

This should have said:

  "Ensure all <thing your disabling> are disabled before ..."

> May I rewrite it to "Configure WLED driving and DSV output all to be
> disabled before MFD module removal"?

You don't need to mention MFD or modules here since we know how the
Device Driver model works and what .remove() does.

What about:

  "Disable WLED and DSV outputs"

> > > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> > > +}
> > > +
> > > +static void rt4831_shutdown(struct i2c_client *client)
> > > +{
> > > +     struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> > > +
> > > +     /* Make sure all off before machine shutdown */
> >
> > As above.
> >
> like as above ".... before 'machine shutdown'

  "Disable WLED and DSV outputs"

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
