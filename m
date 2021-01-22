Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCA2FFC98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 07:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhAVGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 01:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbhAVGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:25:18 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A6EC06174A;
        Thu, 21 Jan 2021 22:24:38 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n2so9021822iom.7;
        Thu, 21 Jan 2021 22:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/ouGLWd79J95AmhZ3hY8iaM6/NouWMMdBryf01BORc=;
        b=RXFwy0WF/4kocTU07A5dF5GGXbJz3CjLlvt61D+pzNFK3I/C+br6ZXBFJ8cWlT2l9m
         /P9+H0hEiMm+CBClCPtVzobsEiga0u/FR9DfeM9as6FgSPrW55e57feCn0X7EcdEl+oX
         v9R+Pw7yrWimMPyrstkAtk/z0XuXUwCER9hg6Px0nkBBPoxSR3OMDRorvwTC2mzwXqCI
         Byw8s8EVw9bTr3Fn6D7rZ2JXMP5bH/glwce/aIuRuhUgjWElkvyo+YVJx6m/GjhRUuZz
         lUX/sRWieJ31368TuS06y9Q8n8rT1x8XLcsDnTcU0c8fEWYZqhm5I9bipS/35v5AXyDZ
         qwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/ouGLWd79J95AmhZ3hY8iaM6/NouWMMdBryf01BORc=;
        b=oKkQugc4Rd9OD7DqcxCdIroRZbYEe+5yt2jfYOzsaOEPdc9Jf4x568L/+dnFSrDfvL
         K55aMwsKDV0BLjWHmUCHE5drEYFaK25l0hVtw7erWty+7Ou0nfRcBt/+3sI1qmxeOL0N
         gm9hKLuvmTLI5xlSpgjxFohZbTTHqTutJFfs02OSWqyJOfmNqCpgspnKQtbbTc5KrnJ/
         eXrYUCJj2QkP7fD0uDdkF7D9m1pv49yU7IIFqwjqYD/uJd/YlBbRHA7fd4Vhtq5k6y5G
         Zq03kN2KnT14LdG63TisLWI7yPWMt8FRsiVsKsJqUVDws16yQq10o72clHLGrNovNh0A
         zODA==
X-Gm-Message-State: AOAM5314esVV2zUGE3qWQ+lFx+MehTFSJMbFw7i48ueYC0XP4wfLe1k3
        qNeM4HxXaQmMp+dfJNYBU11XxGBQegammpRqDgs=
X-Google-Smtp-Source: ABdhPJwFaraYlekAdxing6lHVD5SUikcrEqdByp/yD9aiuP1wvyj94fVw+Mr8VCNwwyW1ncR96fWPcM2KirJkrwPyX8=
X-Received: by 2002:a92:4b06:: with SMTP id m6mr2721405ilg.177.1611296677491;
 Thu, 21 Jan 2021 22:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20210117042539.1609-1-alistair@alistair23.me> <20210117042539.1609-4-alistair@alistair23.me>
 <20210118123158.GE4455@sirena.org.uk>
In-Reply-To: <20210118123158.GE4455@sirena.org.uk>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 21 Jan 2021 22:24:10 -0800
Message-ID: <CAKmqyKMyXk_OjTKD24Qxn4QXJ4FwP4yDQqtmTsxAJMJzy34PcA@mail.gmail.com>
Subject: Re: [PATCH 4/6] regulator: Initial commit of sy7636a
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>, lee.jones@linaro.org,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 4:32 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Jan 16, 2021 at 08:25:37PM -0800, Alistair Francis wrote:
>
> > --- /dev/null
> > +++ b/drivers/regulator/sy7636a-regulator.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Functions to access SY3686A power management chip voltages
> > + *
>
> Please make the entire comment a C++ one so things look more
> intentional.

Fixed.

>
> > + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> > + *
> > + * Author: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
>
> This probably needs an update.
>
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
>
> This boilerplate is redundant and should be removed.

Fixed.

>
> > +static int get_vcom_voltage_op(struct regulator_dev *rdev)
> > +{
> > +     int ret = get_vcom_voltage_mv(rdev->regmap);
> > +
>
> Why is this get_vcom_voltage_mv() function not in the regulator driver,
> and why is it not just inline here?  It also needs namespacing.

I'm not sure what you mean, can you please explain?

>
> > +static int disable_regulator(struct regulator_dev *rdev)
> > +{
> > +     struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
> > +     int ret = 0;
> > +
> > +     mutex_lock(&sy7636a->reglock);
> > +     ret = regulator_disable_regmap(rdev);
> > +     usleep_range(30000, 35000);
> > +     mutex_unlock(&sy7636a->reglock);
>
> Why do you need this delay here, and what purpose is this lock intended

The delay is to allow a power ramp up, I have added a comment.

> to serve?  I can't understand what it's intended to protect.

Apparently the mutex is to protect enable/disable, I don't think it's
required and I will remove it.

>
> > +     mutex_lock(&sy7636a->reglock);
> > +     ret = regulator_is_enabled_regmap(rdev);
> > +     mutex_unlock(&sy7636a->reglock);
>
> This lock usage in particular looks confused.
>
> > +     ret = regulator_enable_regmap(rdev);
> > +     if (ret)
> > +             goto finish;
>
> > +     if (!pwr_good) {
> > +             dev_err(&rdev->dev, "Power good signal timeout after %u ms\n",
> > +                             jiffies_to_msecs(t1 - t0));
> > +             ret = -ETIME;
> > +             goto finish;
> > +     }
>
> This doesn't undo the underlying enable, leaving the regulator in a
> partially enabled state.

Thanks, fixed.

>
> > +static const struct regulator_ops sy7636a_vcom_volt_ops = {
> > +     .get_voltage = get_vcom_voltage_op,
> > +     .enable = enable_regulator_pgood,
> > +     .disable = disable_regulator,
> > +     .is_enabled = sy7636a_regulator_is_enabled,
> > +};
>
> The namespacing for functions is very random and prone to clashes.

Fixed.

> Given the power good signal I'd also expect a get_status() operation.

Added.

>
> > +static int sy7636a_regulator_suspend(struct device *dev)
> > +{
> > +     int ret;
> > +     struct sy7636a *sy7636a = dev_get_drvdata(dev->parent);
> > +
> > +     ret = get_vcom_voltage_mv(sy7636a->regmap);
> > +
> > +     if (ret > 0)
> > +             sy7636a->vcom = (unsigned int)ret;
> > +
> > +     return 0;
> > +}
>
> What's going on here, and if you are going to store this value over
> suspend why not store it in a variable of the correct type?  In general

It is part of the vendor's kernel, they specifically added it to
ensure vcom is set on resume.

I have fixed the variable type.

> it's surprising to need a suspend operation for a regulator.
>
> > +     sy7636a->pgood_gpio = gdp;
> > +     dev_info(sy7636a->dev,
> > +             "Power good GPIO registered (gpio# %d)\n",
> > +             desc_to_gpio(sy7636a->pgood_gpio));
>
> This print is just adding noise to the boot process.

Removed.


Alistair
