Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0553301028
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbhAVWj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbhAVWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:39:41 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10934C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:39:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v24so9730413lfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjH4/GZD6djczXZFW+WAC9AdcW62EHadEo7R2NRlZ6E=;
        b=txWXNUv72/lwPaTQYO5019T/OI+ZNPsLyvYKVgSZPShdyPIbbZken8F+cRAx3/S7UL
         oNvA1n06V4OUvz1OkVg9HIf0H+0cPx/Cp69WeToanTi0W7TQIpNmKgrijc8cfX7CCIBX
         ZzkT1nVeC+SMEf1LSc5tUsVMaZhP5//PsrVJC2E9bDOZ/9E7UUbWlV3tSRFJnLGxw7bx
         PAcZjT3O+Lk2ga485SEe5UKmY83l7JrrvxwBPf+763SNyKy8XGdfuto44T6xzdv/0zEB
         cGjA9tDHKlHjq8mVUC1KAFEfmZLYV0O12xayaIDSLEAxGutX5altLh3t897GYKsO0aju
         e2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjH4/GZD6djczXZFW+WAC9AdcW62EHadEo7R2NRlZ6E=;
        b=qCm5RbAq5blyrau2HuS4jItrs03ObQhyFMYUf8O0EWdYtTQylzbWBcTUzj+laSYS11
         cZb/fIMx+n4RPBipbylsCIjyj7R+7eAynKRwq6IqlREeJRW8u5dLdcUtCv06XjUEFy40
         +igN4ZAfp2vqSbUH7zDhYFWnECemtoSe1CunHsOxu5O8aDS2b7aGZwmR7SBkNM9SNq3n
         PAARiRp4+YkjL1W/DYFvKXMpvxjKzvqTX3uelM23zPB1yixrGcn5jRKXROUsunTNfo8Y
         XJebU2I864/DEfSCf3QgLWfWsuip4vyQiegql1NFQq7jODaNEOI4KPyivYj7W8+jid0y
         fveg==
X-Gm-Message-State: AOAM530hlAHcl68YwCJg2PUjydFQKhhUbjLuzkCgi6Vr0+awEFSWZtJI
        h87z+Wv3mK/aTWynU7x1soVT8vkOt/hQqROJh7Oeuw==
X-Google-Smtp-Source: ABdhPJwGdsWIE7JWi+NhJunl1W6BMNCs4W6TbSQxzDI6CllxC/3GUv+ggJlwUdtHIRE528uMGtBpMhpkCwiumsacLQI=
X-Received: by 2002:ac2:5597:: with SMTP id v23mr288305lfg.649.1611355139576;
 Fri, 22 Jan 2021 14:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20210119124622.9490-1-mike.looijmans@topic.nl> <20210119124622.9490-2-mike.looijmans@topic.nl>
In-Reply-To: <20210119124622.9490-2-mike.looijmans@topic.nl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 23:38:48 +0100
Message-ID: <CACRpkdbFgskpPUoVK7bU1EyChEvD4e9WHhvcUJh4e1UUO2WFdA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

thanks for your patch!

I have a comment about PM:

On Tue, Jan 19, 2021 at 1:46 PM Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
(...)

> +static int bmi088_accel_set_power_state_on(struct bmi088_accel_data *data)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +
> +       ret = pm_runtime_get_sync(dev);
> +       if (ret < 0) {
> +               pm_runtime_put_noidle(dev);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int bmi088_accel_set_power_state_off(struct bmi088_accel_data *data)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +
> +       pm_runtime_mark_last_busy(dev);
> +       ret = pm_runtime_put_autosuspend(dev);
> +
> +       return ret < 0 ? ret : 0;
> +}

I'm not sure you should wrap the pm_runtime calls like this.
I think it is better to inline them.

Next, I think it is better to let suspend/resume, i.e. system PM
reuse runtime PM since you're implementing that. This is why
we invented PM runtime force resume and force suspend.

Here are some drivers that I implemented using that model:
drivers/iio/gyro/mpu3050-core.c
drivers/iio/accel/kxsd9.c
drivers/iio/magnetometer/ak8974.c

The short summary is:
- Only implement runtime suspend/resume.
- SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
   pm_runtime_force_resume)
- In probe() enable runtime PM with autosuspend:
  pm_runtime_get_noresume(dev);
  pm_runtime_set_active(dev);
  pm_runtime_enable(dev);
  pm_runtime_set_autosuspend_delay(dev, NNNN);
  pm_runtime_use_autosuspend(dev);
  pm_runtime_put(dev);
- In remove() disable it like this:
  pm_runtime_get_sync(dev);
  pm_runtime_put_noidle(dev);
  pm_runtime_disable(dev);
- Any time the driver needs the hardware, call:
  pm_runtime_get_sync(dev);
- As soon as you're done using the hardware call:
  pm_runtime_mark_last_busy(dev);
  pm_runtime_put_autosuspend(dev);

The system PM will just hook into the same callbacks and suspend
the hardware using the existing runtime PM hooks.

This works fine in my drivers and saves some complexity and avoids
bugs.

Yours,
Linus Walleij
