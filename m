Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC40D2C8ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgK3UNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgK3UNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:13:54 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A540CC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:13:14 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id m6so3028969vkl.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNqM/C8eL45x9LNKyk86/gn0/dc3HpN6rTLp60H8hWQ=;
        b=Vq0OS8S8QXQplFzhvSngxUne0rTUSvj1r2no9nGC+YhPX4w6H1iUWzAStM2+tXFEul
         Ted40Zr5ZUL53ooRcvb7OpxTEa1IFf53x9Ws6GL/leS2QM7IpV5dSjc5XCN3cKZPuDZk
         iAi4CapWv33D/JN77dul4CJkEzcdZado6aqqIZHKdiKwnBv150EAX7D1eqebmdjLwGW4
         yZ4TP7GYG32knC9mGosk6flndLsv63NLToCtjnU/NVoNzGdvNor/VSU52ZxsKwc2HgFz
         ZW0Fw3ZBRqZUNYI/GDcooKzYl2NzIGP6oxQVsSAbEY3DrYn804UU8kUa8MozfAuJ3UZr
         52Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNqM/C8eL45x9LNKyk86/gn0/dc3HpN6rTLp60H8hWQ=;
        b=kfPSg5b5RGfo7QGLbYdrKNUjtgQj6ooRCzW5RhLU6+zU8Ei9kL8ifqMPCXro9drG5M
         U01RpbA/sjn0ZA6/+T48OyF/M+qBM1IM8FLb+uGPqZw3O9m1kbbxjjTq/JCW5wyzlF8/
         WRI4Wjbji6IuO5SViS1eo2/f4n6tK+ZDi1+rQ5ff4YYVk8mQpuwEBm3Z3yvDuI5Y98pl
         FzdYg7jJ8zgDzdxbbR2KXc91DNOdxHU7T2jsQ4bHwB+1/phW8VCV0kWJT/RFeyRblhY4
         B9kgAFCiqRJhnGtEtCuBq0Lo6NM/VLUEPTHCeU0sVLsQBvFG4MOFQcVox5KKvizkWshU
         n/uw==
X-Gm-Message-State: AOAM532mUB5DZqfTd5AFr+m0OSAKbBsjNXuZ/gTTIwMG5NTffIJ69av1
        MCGksZPLii7UHHhdUFIAKFh2h/AX7BadfZT+3M3cY6nGVQo=
X-Google-Smtp-Source: ABdhPJwMscxJgygcIsM3wT+PFwQPqfG1eCy0/h5Ayg+R+9IUU+MAAapyxsntsMpYxTXYJsBv2oOK4VciBcgXSAM+nAw=
X-Received: by 2002:a1f:5587:: with SMTP id j129mr17952226vkb.0.1606767193811;
 Mon, 30 Nov 2020 12:13:13 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
In-Reply-To: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 30 Nov 2020 15:13:02 -0500
Message-ID: <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus, thank you for reaching out !

On Mon, Nov 30, 2020 at 2:06 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> But reverting your patch brings back the display. So it appears as if it does not
> fix a breakage, rather breaks a previously working setup.

The patch in question fixes an important breakage: before the patch, literally
hundreds of SPI drivers no longer worked - only if the SPI bus master
driver was using gpio descriptors.

We knew that there was a chance that our fix would break something else.
But hopefully "it fixes more than it breaks"

>
> What should we do?
>

Can you try the following patch ?

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 7ceb0ba27b75..c173d7de73b3 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -208,8 +208,8 @@ static void spi_gpio_chipselect(struct spi_device
*spi, int is_active)
        if (spi_gpio->cs_gpios) {
                struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];

-               /* SPI chip selects are normally active-low */
-               gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH)
? is_active : !is_active);
+               /* SPI chip select polarity handled by gpiolib*/
+               gpiod_set_value_cansleep(cs, is_active);
        }
 }
