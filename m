Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC102C2361
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbgKXK5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:57:34 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E68C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:34 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id v9so6672067uar.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FL1+WADFoaMQ5GZAcE0+T1+hOZlcOs3eYXrVX1e9GnM=;
        b=PgYI9bLGM8AkKqHJmJkmf7K2DQ8IXlJ92aGmTdFqd5sw/DHTZ47Ty1Xs0l+SRYxJuc
         /ukmzPAhGTqf1pXKjXv4ykl/3jiwTZS5NYMzIlfG6Jjn07qCvctk5PGoTOpNIs7UMjac
         jQbqyTc6Z5E2QyzBl2v3sPaL1Rdxv34fkXzLtwvFzSWbh8H4Y0Mz+fAoV4SEAfn3TwHq
         hVExA92A+ck2p0UkBSyQ12qDjc/gm55eL3x9KPtjEmS1FZghbbz5g0QN72lsNt3qWUal
         nv1NISKqVhtRMxYl4+P4OHjnGVVrbx6am2V9WhVP0e6W9kJoteQOpXVZW3YRaZxl0vum
         IVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FL1+WADFoaMQ5GZAcE0+T1+hOZlcOs3eYXrVX1e9GnM=;
        b=Th2gKi8pLr+Y6ktEpmwd9vdzMJ/8bDJNBthBAW6m6IAoTdxuyeta6gCjZBkfmjp2Zz
         g8xD+z7mNrHj1wPdyxwQihnXEtN5F5GTtmJw0GLAbaSY199U9pi5GSHb6XiYH17j+0oZ
         kSGVXzc2RvaFNo8wiq25rlhSQC9EdZZ/DCohw3CD6OPyr3yd2p8LMzkUf0icA7OD7RdL
         1b1g250uxeY4bqif4EJ5w9Oe4mhZfj9znWYFHH3/Q7kcfr5bImVQzhx4jji7pc7AdggT
         Gl9B+4O2a9LoFTpTc2PrVTkMNvW/vX6U62/DH9pyZcZu5S0AeEQFNjKXgEwRCAYG1Xz2
         fiKw==
X-Gm-Message-State: AOAM533YQjwu2X6QaKWokAMO63JmUhiBHFyxGUdNyXi8B17dIL3FhUTd
        FtAcc8adpcPXaH/8xdk7/kYqY47V9BS2ZMm+Cd0D1w==
X-Google-Smtp-Source: ABdhPJx/FU3R0DczPWrp4WPXg+JfvAsXKmAjw/F7dEOJjQY9UYzMjeiLb1It0R9+u2MqvSzQKyarkOZ0YxpqpQQQG84=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr2225910uan.129.1606215453575;
 Tue, 24 Nov 2020 02:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de> <20201124103242.2971199-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201124103242.2971199-4-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 11:56:57 +0100
Message-ID: <CAPDyKFrBR3M2rsOzs9s7oTJ8UYY-XZ9CbMJR+sHJwFL2FvBReg@mail.gmail.com>
Subject: Re: [PATCH 4/4] amba: Make use of bus_type functions
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 at 11:33, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Instead of assigning the needed functions for each driver separately do i=
t
> only once in amba_bustype. Move the definition of the functions to their
> proper place among the other callbacks used there.
>
> This prepares getting rid of these callbacks in struct device_driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/amba/bus.c | 154 ++++++++++++++++++++++-----------------------
>  1 file changed, 77 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 48b5d4b4e889..2f3799ac3edb 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -174,6 +174,80 @@ static int amba_uevent(struct device *dev, struct ko=
bj_uevent_env *env)
>         return retval;
>  }
>
> +/*
> + * These are the device model conversion veneers; they convert the
> + * device model structures to our more specific structures.
> + */
> +static int amba_probe(struct device *dev)
> +{
> +       struct amba_device *pcdev =3D to_amba_device(dev);
> +       struct amba_driver *pcdrv =3D to_amba_driver(dev->driver);
> +       const struct amba_id *id =3D amba_lookup(pcdrv->id_table, pcdev);
> +       int ret;
> +
> +       do {
> +               ret =3D of_clk_set_defaults(dev->of_node, false);
> +               if (ret < 0)
> +                       break;
> +
> +               ret =3D dev_pm_domain_attach(dev, true);
> +               if (ret)
> +                       break;
> +
> +               ret =3D amba_get_enable_pclk(pcdev);
> +               if (ret) {
> +                       dev_pm_domain_detach(dev, true);
> +                       break;
> +               }
> +
> +               pm_runtime_get_noresume(dev);
> +               pm_runtime_set_active(dev);
> +               pm_runtime_enable(dev);
> +
> +               ret =3D pcdrv->probe(pcdev, id);
> +               if (ret =3D=3D 0)
> +                       break;
> +
> +               pm_runtime_disable(dev);
> +               pm_runtime_set_suspended(dev);
> +               pm_runtime_put_noidle(dev);
> +
> +               amba_put_disable_pclk(pcdev);
> +               dev_pm_domain_detach(dev, true);
> +       } while (0);
> +
> +       return ret;
> +}
> +
> +static int amba_remove(struct device *dev)
> +{
> +       struct amba_device *pcdev =3D to_amba_device(dev);
> +       struct amba_driver *drv =3D to_amba_driver(dev->driver);
> +
> +       pm_runtime_get_sync(dev);
> +       if (drv->remove)
> +               drv->remove(pcdev);
> +       pm_runtime_put_noidle(dev);
> +
> +       /* Undo the runtime PM settings in amba_probe() */
> +       pm_runtime_disable(dev);
> +       pm_runtime_set_suspended(dev);
> +       pm_runtime_put_noidle(dev);
> +
> +       amba_put_disable_pclk(pcdev);
> +       dev_pm_domain_detach(dev, true);
> +
> +       return 0;
> +}
> +
> +static void amba_shutdown(struct device *dev)
> +{
> +       struct amba_driver *drv =3D to_amba_driver(dev->driver);
> +
> +       if (drv->shutdown)
> +               drv->shutdown(to_amba_device(dev));
> +}
> +
>  #ifdef CONFIG_PM
>  /*
>   * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
> @@ -239,6 +313,9 @@ struct bus_type amba_bustype =3D {
>         .dev_groups     =3D amba_dev_groups,
>         .match          =3D amba_match,
>         .uevent         =3D amba_uevent,
> +       .probe          =3D amba_probe,
> +       .remove         =3D amba_remove,
> +       .shutdown       =3D amba_shutdown,
>         .dma_configure  =3D platform_dma_configure,
>         .pm             =3D &amba_pm,
>  };
> @@ -251,80 +328,6 @@ static int __init amba_init(void)
>
>  postcore_initcall(amba_init);
>
> -/*
> - * These are the device model conversion veneers; they convert the
> - * device model structures to our more specific structures.
> - */
> -static int amba_probe(struct device *dev)
> -{
> -       struct amba_device *pcdev =3D to_amba_device(dev);
> -       struct amba_driver *pcdrv =3D to_amba_driver(dev->driver);
> -       const struct amba_id *id =3D amba_lookup(pcdrv->id_table, pcdev);
> -       int ret;
> -
> -       do {
> -               ret =3D of_clk_set_defaults(dev->of_node, false);
> -               if (ret < 0)
> -                       break;
> -
> -               ret =3D dev_pm_domain_attach(dev, true);
> -               if (ret)
> -                       break;
> -
> -               ret =3D amba_get_enable_pclk(pcdev);
> -               if (ret) {
> -                       dev_pm_domain_detach(dev, true);
> -                       break;
> -               }
> -
> -               pm_runtime_get_noresume(dev);
> -               pm_runtime_set_active(dev);
> -               pm_runtime_enable(dev);
> -
> -               ret =3D pcdrv->probe(pcdev, id);
> -               if (ret =3D=3D 0)
> -                       break;
> -
> -               pm_runtime_disable(dev);
> -               pm_runtime_set_suspended(dev);
> -               pm_runtime_put_noidle(dev);
> -
> -               amba_put_disable_pclk(pcdev);
> -               dev_pm_domain_detach(dev, true);
> -       } while (0);
> -
> -       return ret;
> -}
> -
> -static int amba_remove(struct device *dev)
> -{
> -       struct amba_device *pcdev =3D to_amba_device(dev);
> -       struct amba_driver *drv =3D to_amba_driver(dev->driver);
> -
> -       pm_runtime_get_sync(dev);
> -       if (drv->remove)
> -               drv->remove(pcdev);
> -       pm_runtime_put_noidle(dev);
> -
> -       /* Undo the runtime PM settings in amba_probe() */
> -       pm_runtime_disable(dev);
> -       pm_runtime_set_suspended(dev);
> -       pm_runtime_put_noidle(dev);
> -
> -       amba_put_disable_pclk(pcdev);
> -       dev_pm_domain_detach(dev, true);
> -
> -       return 0;
> -}
> -
> -static void amba_shutdown(struct device *dev)
> -{
> -       struct amba_driver *drv =3D to_amba_driver(dev->driver);
> -
> -       if (drv->shutdown)
> -               drv->shutdown(to_amba_device(dev));
> -}
> -
>  /**
>   *     amba_driver_register - register an AMBA device driver
>   *     @drv: amba device driver structure
> @@ -339,9 +342,6 @@ int amba_driver_register(struct amba_driver *drv)
>                 return -EINVAL;
>
>         drv->drv.bus =3D &amba_bustype;
> -       drv->drv.probe =3D amba_probe;
> -       drv->drv.remove =3D amba_remove;
> -       drv->drv.shutdown =3D amba_shutdown;
>
>         return driver_register(&drv->drv);
>  }
> --
> 2.29.2
>
