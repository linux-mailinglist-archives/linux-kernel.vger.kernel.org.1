Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877352C89AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgK3Qi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3Qi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:38:28 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D2DC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:37:48 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id u19so15667400edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGdi8zw2UllbWy3UVgiIB3U1ISdHvVn0dXTWbzhqRHw=;
        b=aB1zWDkK5NfvrmnrmOSCL/lbknzHRwKGj1aueBf2V03Sd6MpGnI0JfOynU1L+Ogb+x
         wJytGRe8eBSCzk5p+hrSF8NRWQ9EzWELjDbujZIvG7t/Y6vf84OEwEXFbssX5NFpsO/S
         U2Fy1chzzhaQHsSvYMli6eB50DPVcfkH/hq1h00mVi1+Xp3KaUDnT41QaRyaKzae1sAB
         OwR6d/DjVUjb6cL4LJfm5G+E3KSFWs23XT9/FscKngVfULfqJqECez6rCyRDnk9W3wj+
         g7EGgqpDVMjlU0mcjuOqvOY2x/PVn8LMZhFiiMPRh3RmjL9zpNi6BiJCedilbfGd2LOA
         IfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGdi8zw2UllbWy3UVgiIB3U1ISdHvVn0dXTWbzhqRHw=;
        b=kPiIMwmJ3xUdi7yudW7jVZGfdnHEmTwraWsNuYQN5jti9R/Ol4sEqmJle2YhSk9IZ4
         C2x4p5P474kOi4cET0bW/uLeYwgxgyVuqwM55mEjFqoqayjOqnUDk1MKmwt7uAQC0wN5
         XAiIh3hnQ7aVJylgktTxFQKPlU67nCQi/DkqM52AWZiOJDVBR3w/vb6FV3Hs399Ul1u6
         1Ak/ohgm7FmMspk/95yXV/zZD1B5KMxu4O6VPBVAwkZFHGaSmWT96ijWTAPmJguK58cC
         gIYZ34uYlBCwkmw/idkb+WHLxuvCHlbDF09aKrNjRgqIcrhz4ytLcca9ey79V+A7dUCb
         kEaw==
X-Gm-Message-State: AOAM533Fx3P6rD8UZU2y2wlfe5H7QgHnzwImnmYa3WGtOl6kkU8kHUj6
        KccptZjYdB6BFPTxCiG4NZgDS1AIeeZbeh4lZXZLUA==
X-Google-Smtp-Source: ABdhPJwwPbz1lJhNl39w+VpN8EO/mmbxfDOKDsyQn4TG5vFIeHuiL/TfIgbs7NmsghfoNhd4IHozS7s3SvnOJwmvCUs=
X-Received: by 2002:a05:6402:307c:: with SMTP id bs28mr1919331edb.186.1606754266882;
 Mon, 30 Nov 2020 08:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20201119142104.85566-1-alexandru.ardelean@analog.com> <CAHp75VdkomLMPYZbB7-KerGmyxXxB8hQuAjLtJ0bhB5f5vfuNA@mail.gmail.com>
In-Reply-To: <CAHp75VdkomLMPYZbB7-KerGmyxXxB8hQuAjLtJ0bhB5f5vfuNA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 30 Nov 2020 17:37:35 +0100
Message-ID: <CAMpxmJXbpiiKzxsrBk5mdLf1Kk5_-5pwJYOeCsTTqKmS2QUMTQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: xra1403: remove unneeded spi_set_drvdata()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 4:04 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 4:17 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > There is no matching spi_get_drvdata() call in the driver, so there is no
> > need to do spi_set_drvdata(). This looks like it probably was copied from a
> > driver that used both spi_set_drvdata() & spi_get_drvdata().
>
> While above luckily (*) okay it may not always be the case.
>
> *) it can be paired with dev_get_drvdata() which is usual for PM callbacks.
>
> With amended commit message
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>

I applied this patch. I wasn't sure exactly how you want the commit
message to be changed - it sounds pretty clear to me so I took it.

Bartosz

> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/gpio/gpio-xra1403.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
> > index e2cac12092af..49c878cfd5c6 100644
> > --- a/drivers/gpio/gpio-xra1403.c
> > +++ b/drivers/gpio/gpio-xra1403.c
> > @@ -186,15 +186,7 @@ static int xra1403_probe(struct spi_device *spi)
> >                 return ret;
> >         }
> >
> > -       ret = devm_gpiochip_add_data(&spi->dev, &xra->chip, xra);
> > -       if (ret < 0) {
> > -               dev_err(&spi->dev, "Unable to register gpiochip\n");
> > -               return ret;
> > -       }
> > -
> > -       spi_set_drvdata(spi, xra);
> > -
> > -       return 0;
> > +       return devm_gpiochip_add_data(&spi->dev, &xra->chip, xra);
> >  }
> >
> >  static const struct spi_device_id xra1403_ids[] = {
> > --
> > 2.17.1
