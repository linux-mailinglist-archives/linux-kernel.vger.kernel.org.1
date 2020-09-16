Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED4C26C6AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgIPR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgIPR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:57:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD1C02C2AA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:40:06 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so6784466edk.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYwFJVVyWUnvr3RRMVPcQVxmSTwmiXnhNz3uXivvFZA=;
        b=C1Hh9LyW50A8UnujcPZRIXI0ouy2JMnjXJvBkcGhAKb2pLUbr1rD4bPI3jdCJXHhnC
         tx3ak9cITTK4qeciTuBhe8nVxr3oz32O6JPmpklUrcf2776BVokaN923bZ9/rq88Rh5K
         CF1wLbCxUlvSOeWui43H0Jvz9TEqBo+LVxGxtnCSlu6/rGeSy9LnezIIZbEdZhJ98SIt
         F9fdJ6pwCbq21caas/gFAcjGFFn4O7xzi5uk7AG7yJSql8cb9NbKx8HG67QxQrrjfa0Y
         o7Cxv4lii7MsmwlOmqGbeKr/SdJLsWrtqDsad358aHKAYoOJnI+XawOA4KNF9f6Eb5al
         QZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYwFJVVyWUnvr3RRMVPcQVxmSTwmiXnhNz3uXivvFZA=;
        b=FvvWJOEC8pcjVjXgGE8OqcDaRFnA6Xq/udzUumKmVYswV7/GAcwRFQupC03bSosgm5
         Xys9XosZhYhLvbCZRLBdw3I68CzMTnjisA6/fEb1enygQSOexP7X7g0V+s072fD4mHUk
         7lHwu0uAxp3tunn1ueV8p5p+3VVfHTX2b1XsmqJ5/Ilcqb3LXAq7XfvcqhD8YHPzFp6X
         2owuxNNi1eBsibxdkYaLMAQSjU1lwnAgWl9lPlYsiaZYDLJpScqDlEALYGXD8/wtDMPj
         SzuLvNIxDE2eaDOwMWuwe4epxUGpjvsZfBCsgJVu3g/NkboGljQAqvVi4WDSsTA9bK0B
         oGiA==
X-Gm-Message-State: AOAM5320XaRFLbPaqoIndI1w80uzyQ7uUsrs+jDpLSykAoJrsm+IYmm0
        QWoxy83iLN+W/gG3NOVq1izRUYxGS8dN78vn/qWzMQ==
X-Google-Smtp-Source: ABdhPJwOo9r6FDUzpRY8OEBlsg9uhT7ZY2IDJIhHGcJvcQ0nag1UhTOihVozgoZqTeaMaapgroNGI4E/cvmpKLiV1VY=
X-Received: by 2002:a05:6402:17ec:: with SMTP id t12mr27216734edy.328.1600270805229;
 Wed, 16 Sep 2020 08:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200916152909.6812-1-vadym.kochan@plvision.eu>
In-Reply-To: <20200916152909.6812-1-vadym.kochan@plvision.eu>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 16 Sep 2020 17:39:54 +0200
Message-ID: <CAMpxmJV3Rq65SY4MvLc8ONcpzt4DGZ3Kz5GpGi0TGZqHcJPWwg@mail.gmail.com>
Subject: Re: [PATCH] misc: eeprom: set type id as EEPROM for nvmem devices
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 5:29 PM Vadym Kochan <vadym.kochan@plvision.eu> wrote:
>
> Set type as NVMEM_TYPE_EEPROM to expose this info via
> sysfs:
>
> $ cat /sys/bus/nvmem/devices/0-00560/type
> EEPROM
>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> Checked only with at24.
>
>  drivers/misc/eeprom/at24.c          | 1 +
>  drivers/misc/eeprom/at25.c          | 1 +
>  drivers/misc/eeprom/eeprom_93xx46.c | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2591c21b2b5d..800300296c74 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -678,6 +678,7 @@ static int at24_probe(struct i2c_client *client)
>                         return err;
>         }
>
> +       nvmem_config.type = NVMEM_TYPE_EEPROM;
>         nvmem_config.name = dev_name(dev);
>         nvmem_config.dev = dev;
>         nvmem_config.read_only = !writable;
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index ed8d38b09925..3a586a7c4b1a 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -348,6 +348,7 @@ static int at25_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, at25);
>         at25->addrlen = addrlen;
>
> +       at25->nvmem_config.type = NVMEM_TYPE_EEPROM;
>         at25->nvmem_config.name = dev_name(&spi->dev);
>         at25->nvmem_config.dev = &spi->dev;
>         at25->nvmem_config.read_only = chip.flags & EE_READONLY;
> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
> index 94cfb675fe4e..7c45f82b4302 100644
> --- a/drivers/misc/eeprom/eeprom_93xx46.c
> +++ b/drivers/misc/eeprom/eeprom_93xx46.c
> @@ -455,6 +455,7 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
>         edev->pdata = pd;
>
>         edev->size = 128;
> +       edev->nvmem_config.type = NVMEM_TYPE_EEPROM;
>         edev->nvmem_config.name = dev_name(&spi->dev);
>         edev->nvmem_config.dev = &spi->dev;
>         edev->nvmem_config.read_only = pd->flags & EE_READONLY;
> --
> 2.17.1
>

Please split it into separate patches - these drivers have different
maintainers.

Bartosz
