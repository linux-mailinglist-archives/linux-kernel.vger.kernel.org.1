Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05F2C235E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbgKXK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:57:21 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8EC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:21 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id u16so4667596vkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hU262f2HnxuyZTfh5JckIXsgmt3xi8/poiOz2lwFaaA=;
        b=wk6+VYMguzeNCjGJncZmPFPwpYJGiNgN4zubHvWbUwro66ZSJT6VmfcFA9ZUpFTL/u
         kJMrUyGDjcIU4N2Q6DpSsGWrbZ2kaWU1+eiG2eMeSKoFooX3Oix7mBB622BstcvbKyKV
         bRoW1mXbgkgS2MtAjAy76amkuP3IQxqwAAlYSnh8uIELQprOQuaspaVd07jBiXDErQdN
         LLaPZcO7XZYjRhO73F3AsQJAca7bqF2sARp2kcKCXUW9qfZGr/o1XNBAck+5Krkk229n
         Yh+ffDDb96f+zcf+qUTjmyfzopt45jNJalkrLQHbrc7iIEtfkqyltCRXh3pszED/WR1D
         dmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hU262f2HnxuyZTfh5JckIXsgmt3xi8/poiOz2lwFaaA=;
        b=sZAmIb5SWfTjgcSuhHFbu9WSt1419imA7nFBEBVGq4qC7/zf0k6VM4bES3Sjy2lmzW
         Xe79iY+fT65vYLpmIvCQuaOF8SAXcUq/X35DJyqLgwTcLHke3Km0LBQWQmpekdJ8GyxU
         R+dG9usw1Iaw7n+Q5zaz8KNNhDsTjzj1qTMi5AccLVixcZjny3olAMX5GGMomHZxa+9o
         1ZkhBG1ffAwVu8g9QtmzUPRk0mjpWOfz2fcmvaBzccfyGXN9S0/qACA+JOdDxljv5zIu
         KBNJ+0zZbKaf6XGuNA8XxnrRkFeTe/klMhRydkJkx2n2QWCiG0Z1SSFoxOM/hvbC8KQM
         A0QA==
X-Gm-Message-State: AOAM532yYtoP+VwHVsIz1PZfYcJ0Fiwhrce6RYIHD6IuHAq82rrKHOen
        itPLLIeJe0fxkgqM6u396sdO+lALJ5r5I1dBz2g+nTXZSKyhxQ==
X-Google-Smtp-Source: ABdhPJxQfFu/Vpu7788dZxGuli6si0gWNoMI5GT2W0PAqQMomavKphMlfuJUJGa3lMz21r2ZOHffV9M/D0Na5EMapIE=
X-Received: by 2002:a1f:2ed2:: with SMTP id u201mr3125274vku.7.1606215440944;
 Tue, 24 Nov 2020 02:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de> <20201124103242.2971199-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201124103242.2971199-2-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 11:56:44 +0100
Message-ID: <CAPDyKFoS60VjCSAqSBmtjpxGrVefHT4xt+O5qzsjBYRmQsJ8OA@mail.gmail.com>
Subject: Re: [PATCH 2/4] amba: Fix resource leak for drivers without .remove
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
> Consider an amba driver with a .probe but without a .remove callback (e.g=
.
> pl061_gpio_driver). The function amba_probe() is called to bind a device
> and so dev_pm_domain_attach() and others are called. As there is no remov=
e
> callback amba_remove() isn't called at unbind time however and so calling
> dev_pm_domain_detach() is missed and the pm domain keeps active.
>
> To fix this always use the core driver callbacks and handle missing amba
> callbacks there. For probe refuse registration as a driver without probe
> doesn't make sense.
>
> Fixes: 7cfe249475fd ("ARM: AMBA: Add pclk support to AMBA bus infrastruct=
ure")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>


> ---
>  drivers/amba/bus.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 8658e0533b67..8c4a42df47c6 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -300,10 +300,11 @@ static int amba_remove(struct device *dev)
>  {
>         struct amba_device *pcdev =3D to_amba_device(dev);
>         struct amba_driver *drv =3D to_amba_driver(dev->driver);
> -       int ret;
> +       int ret =3D 0;
>
>         pm_runtime_get_sync(dev);
> -       ret =3D drv->remove(pcdev);
> +       if (drv->remove)
> +               ret =3D drv->remove(pcdev);
>         pm_runtime_put_noidle(dev);
>
>         /* Undo the runtime PM settings in amba_probe() */
> @@ -320,7 +321,9 @@ static int amba_remove(struct device *dev)
>  static void amba_shutdown(struct device *dev)
>  {
>         struct amba_driver *drv =3D to_amba_driver(dev->driver);
> -       drv->shutdown(to_amba_device(dev));
> +
> +       if (drv->shutdown)
> +               drv->shutdown(to_amba_device(dev));
>  }
>
>  /**
> @@ -333,12 +336,13 @@ static void amba_shutdown(struct device *dev)
>   */
>  int amba_driver_register(struct amba_driver *drv)
>  {
> -       drv->drv.bus =3D &amba_bustype;
> +       if (!drv->probe)
> +               return -EINVAL;
>
> -#define SETFN(fn)      if (drv->fn) drv->drv.fn =3D amba_##fn
> -       SETFN(probe);
> -       SETFN(remove);
> -       SETFN(shutdown);
> +       drv->drv.bus =3D &amba_bustype;
> +       drv->drv.probe =3D amba_probe;
> +       drv->drv.remove =3D amba_remove;
> +       drv->drv.shutdown =3D amba_shutdown;
>
>         return driver_register(&drv->drv);
>  }
> --
> 2.29.2
>
