Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E172C235F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbgKXK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:57:27 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE5C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:26 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id k12so6672220uae.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tAqRwMIUc4klvn6SlWKiHlnSYstEpCnu5WY0StL4rIg=;
        b=c6L310/W9WuE8LB46O3wjlbd018o8ulm2iLbojt9gyOYQg4urHc++08p+8PrDXShzC
         LaOwqqkOxEJyb698vzU4tJqPs8BGFNA0PKcz+7OIXhEwMN5VbqZF9ReQGuDAKiFshKtt
         lQDRLr6+MVw0K6PZTEufSYpKISykVqRKrB0g67/a7ys9SFYSQljZRENbZHmY/rp4Hdho
         FBUV0qxk1OZ/NINxs7JFiOhilRwxNzqzC7NqHOuAP2EkRApk8RXbymnlqo9RfaBQORqr
         J0+rbPvDS8Iq3+WpNH43WjU1YtArB/+j1o/eYEmCqFBcO4gxZeqWm8KMaUj/Luj0K5UN
         XQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tAqRwMIUc4klvn6SlWKiHlnSYstEpCnu5WY0StL4rIg=;
        b=uRrpHh9X5ZKoiikR4BSLARufvrKgolHyrqKv8fRWfnoMcAJY1bT335bTnKkROh9wp2
         pumtumyg6+drsV9MPUo9AzBYR9AjnbHgDjYGVxYxo1DsCTo5la2/vtylszSBs+rvyooS
         PflPoSNPNQeNn1tEOov9pTpc33u0HoLB8w1xLpK8dhLcD8x7w8Z+bsdoEfzoEnnb6BkH
         QZgw4QTe7WulbQEbtWvGCFq6v7E4MPwVMstV17LqE4ygvJ77sXWaLDbY8X2WLxCLJAQB
         Hg6LKZEt1YhVDJ4mNk89Ifny7JAR8c532j4yCHLNqmWAhsTP1lKFZg6Row8kiVbw+a4O
         Kp8Q==
X-Gm-Message-State: AOAM531WwhK5yKYlJcr3jQXhAjFWUUkMbUYT6Ae6INJ/VFQOs7LmY+A4
        R7ci8ER+sqpAkE88dVHk3KXCAB1v7/Zod/89Fk+pVNaTByvLBA==
X-Google-Smtp-Source: ABdhPJxun6aRfYnOh6ghQOI8l08zLoxFL3CrTRWgv/cTKSlHzOkwdsJZum/AIzXFUEL6LVPKACWhojs0DTxBno1GZzM=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr2538453uak.19.1606215445865;
 Tue, 24 Nov 2020 02:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 11:56:49 +0100
Message-ID: <CAPDyKFpCu4sJbWEUBTiqQKswX_x1ww4-Qygeva==iejvEKax7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] amba: reorder functions
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
> Put helpers (here: amba_get_enable_pclk and amba_put_disable_pclk) at
> the top of the file and then define callbacks directly before the
> structs they are used in; in the same order.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>


> ---
>  drivers/amba/bus.c | 77 +++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index ecc304149067..8658e0533b67 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -56,31 +56,28 @@ amba_lookup(const struct amba_id *table, struct amba_=
device *dev)
>         return NULL;
>  }
>
> -static int amba_match(struct device *dev, struct device_driver *drv)
> +static int amba_get_enable_pclk(struct amba_device *pcdev)
>  {
> -       struct amba_device *pcdev =3D to_amba_device(dev);
> -       struct amba_driver *pcdrv =3D to_amba_driver(drv);
> +       int ret;
>
> -       /* When driver_override is set, only bind to the matching driver =
*/
> -       if (pcdev->driver_override)
> -               return !strcmp(pcdev->driver_override, drv->name);
> +       pcdev->pclk =3D clk_get(&pcdev->dev, "apb_pclk");
> +       if (IS_ERR(pcdev->pclk))
> +               return PTR_ERR(pcdev->pclk);
>
> -       return amba_lookup(pcdrv->id_table, pcdev) !=3D NULL;
> +       ret =3D clk_prepare_enable(pcdev->pclk);
> +       if (ret)
> +               clk_put(pcdev->pclk);
> +
> +       return ret;
>  }
>
> -static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
> +static void amba_put_disable_pclk(struct amba_device *pcdev)
>  {
> -       struct amba_device *pcdev =3D to_amba_device(dev);
> -       int retval =3D 0;
> -
> -       retval =3D add_uevent_var(env, "AMBA_ID=3D%08x", pcdev->periphid)=
;
> -       if (retval)
> -               return retval;
> -
> -       retval =3D add_uevent_var(env, "MODALIAS=3Damba:d%08X", pcdev->pe=
riphid);
> -       return retval;
> +       clk_disable_unprepare(pcdev->pclk);
> +       clk_put(pcdev->pclk);
>  }
>
> +
>  static ssize_t driver_override_show(struct device *_dev,
>                                     struct device_attribute *attr, char *=
buf)
>  {
> @@ -152,6 +149,31 @@ static struct attribute *amba_dev_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(amba_dev);
>
> +static int amba_match(struct device *dev, struct device_driver *drv)
> +{
> +       struct amba_device *pcdev =3D to_amba_device(dev);
> +       struct amba_driver *pcdrv =3D to_amba_driver(drv);
> +
> +       /* When driver_override is set, only bind to the matching driver =
*/
> +       if (pcdev->driver_override)
> +               return !strcmp(pcdev->driver_override, drv->name);
> +
> +       return amba_lookup(pcdrv->id_table, pcdev) !=3D NULL;
> +}
> +
> +static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +       struct amba_device *pcdev =3D to_amba_device(dev);
> +       int retval =3D 0;
> +
> +       retval =3D add_uevent_var(env, "AMBA_ID=3D%08x", pcdev->periphid)=
;
> +       if (retval)
> +               return retval;
> +
> +       retval =3D add_uevent_var(env, "MODALIAS=3Damba:d%08X", pcdev->pe=
riphid);
> +       return retval;
> +}
> +
>  #ifdef CONFIG_PM
>  /*
>   * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
> @@ -229,27 +251,6 @@ static int __init amba_init(void)
>
>  postcore_initcall(amba_init);
>
> -static int amba_get_enable_pclk(struct amba_device *pcdev)
> -{
> -       int ret;
> -
> -       pcdev->pclk =3D clk_get(&pcdev->dev, "apb_pclk");
> -       if (IS_ERR(pcdev->pclk))
> -               return PTR_ERR(pcdev->pclk);
> -
> -       ret =3D clk_prepare_enable(pcdev->pclk);
> -       if (ret)
> -               clk_put(pcdev->pclk);
> -
> -       return ret;
> -}
> -
> -static void amba_put_disable_pclk(struct amba_device *pcdev)
> -{
> -       clk_disable_unprepare(pcdev->pclk);
> -       clk_put(pcdev->pclk);
> -}
> -
>  /*
>   * These are the device model conversion veneers; they convert the
>   * device model structures to our more specific structures.
>
> base-commit: 95065cb54210eba86bed10cb2118041524d54573
> --
> 2.29.2
>
