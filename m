Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD714293093
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgJSVfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733210AbgJSVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:35:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BAC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:35:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y20so1679002iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CN0bQxKJkdcKJBjwvzgGWcX5vlVJWJkhBAisHK3glqI=;
        b=poFCyAQbQtgZYozTVKwBGhba69C9R2VOpfR1iB0iElMus57vyyz10YsJB878DKPliS
         kN73S07IJiB8OYmcccldcZonVDJCILp65e87Vf1nE4OzUvOTuaF1/x8PzORo4VxJMaYc
         Z+mDBDRf9bN6NInVliqmqoGyzwBt0Mwph5OnSUtheXfQit7/rXWwETHYFbqzZvrVO8Ky
         3BWEVScOiJ/Thf8K+jSlS7lQNOKyoKQVyErxvrTEGVxAK3QRv/bvyrdB733Va/pI1WMG
         4JThrWGVDVn9DDRShxybwafgkdfbXYTvesdZwLlWX3YQRDT4m64J6olTMzca5LdFOF5L
         jtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CN0bQxKJkdcKJBjwvzgGWcX5vlVJWJkhBAisHK3glqI=;
        b=Xm0J6Cn6BXEbYU2M+qr9TUtOkNagUhbwFiZejCHlVlsuUgngNsKYWoNOQdxKUDYagr
         1fCV8GAazel6+AzwrxvLiryZeCsgSz9OfVzjg6BpyGkoSIPc2T8aenXM3+RvdVDgRNuz
         H+e6VQd6mCt1EMLIepmF1qbU3wxwdSyvATbTJgZgJDVLW7PUfUOSmLEBax50qt/Z3nyQ
         D6+rIus/xy1K0j8gtFypKKdxM9g3TefC0cSyP/D3XZvKEs50/iEXlnOxstZdWKfiMPm+
         1R5Erkotupbk0usG+vh1QHeSGmWBqPVBATwFW5CMVZ9ppamIM41HFerjNnAuQGpN/nuC
         ocaA==
X-Gm-Message-State: AOAM531uBAW9CknCXn4uu+0OdiSVtNuycB+H8q9pkjy6sNzEy43Sq5Y+
        8spmBfefomk5hJ0y5tQLiJpm/+W2h7NBiDgJFTz+7Q==
X-Google-Smtp-Source: ABdhPJw4mQAJXYE67VbfXCXw8FFkQWxvEARRSqm1Z8RIqdlt6/XcS+mKeyENnU8XkmzZf9eX++gROLYZIf3rsQUjrn0=
X-Received: by 2002:a5e:cb45:: with SMTP id h5mr1257113iok.172.1603143314653;
 Mon, 19 Oct 2020 14:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201017211035.257110-1-luka.kovacic@sartura.hr>
 <20201017211035.257110-5-luka.kovacic@sartura.hr> <CAHp75VdQnNXdhs52+WFt4bQKwZ3u5euFd3d65XU+-sMSFjt8jA@mail.gmail.com>
In-Reply-To: <CAHp75VdQnNXdhs52+WFt4bQKwZ3u5euFd3d65XU+-sMSFjt8jA@mail.gmail.com>
From:   Luka Kovacic <luka.kovacic@sartura.hr>
Date:   Mon, 19 Oct 2020 23:35:03 +0200
Message-ID: <CADZsf3ZtrK1M1QQtVLOhx7tBk7k73M5P+A1kyx=t8RA4m=Hhpg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] drivers: leds: Add the iEi WT61P803 PUZZLE LED driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Sun, Oct 18, 2020 at 8:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Oct 18, 2020 at 12:18 AM Luka Kovacic <luka.kovacic@sartura.hr> wrote:
> >
> > Add support for the iEi WT61P803 PUZZLE LED driver.
> > Currently only the front panel power LED is supported.
> >
> > This driver depends on the iEi WT61P803 PUZZLE MFD driver.
>
> ...

I'll expand the description a bit.

>
> > +/**
> > + * struct iei_wt61p803_puzzle_led - MCU LED Driver
> > + *
> > + * @mcu:               MCU struct pointer
> > + * @response_buffer    Global MCU response buffer allocation
> > + * @lock:              General mutex lock to protect simultaneous R/W access to led_power_state
> > + * @led_power_state:   State of the front panel power LED
> > + * @cdev:              LED classdev
> > + */
> > +struct iei_wt61p803_puzzle_led {
> > +       struct iei_wt61p803_puzzle *mcu;
> > +       unsigned char *response_buffer;
> > +       struct mutex lock;
> > +       int led_power_state;
>
> > +       struct led_classdev cdev;
>
> If you are using container_of() and move this member to be first, you
> will effectively make the container_of() a no-op.
>
> > +};
> > +
> > +static inline struct iei_wt61p803_puzzle_led *cdev_to_iei_wt61p803_puzzle_led
> > +       (struct led_classdev *led_cdev)
> > +{
> > +       return dev_get_drvdata(led_cdev->dev->parent);
>
> Why not simply call container_of()

I agree, container_of() is much cleaner, when used here.

>
> > +}
>
> ...
>
> > +       ret = fwnode_property_read_u32(child, "reg", &reg);
> > +       if (ret || reg > 1) {
> > +               dev_err(dev, "Could not register 'reg' (%lu)\n", (unsigned long)reg);
>
> When you cast explicitly during printf() you are doing something wrong
> in 99.9% cases.
> What's wrong with %u in this case?

I'll remove the cast, %u should be okay.

>
> > +               ret = -EINVAL;
> > +               goto err_child_node;
> > +       }
>
> --
> With Best Regards,
> Andy Shevchenko

Kind regards,
Luka
