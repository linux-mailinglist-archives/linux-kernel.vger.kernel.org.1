Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9C2914EC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439803AbgJQW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439616AbgJQW2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 18:28:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B8C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 15:27:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so6653239ilt.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//RO6M7fhoiCVjKUo6S97GqwILTcd7qYF3tq1WnKm/Q=;
        b=Mvlv8Ylf930IjJ97mw7EJBTPxok2wuOyc+1k7cbreEQABdi/FcXF1uhlOesh8ActoY
         DMwJMKycM1OUYk4L0LTbAcJeAbybn5PdILr7RZZk0OXvkj6ulfmAl1CGK/riYE4dFhbK
         7hV2kjUIJrU6mq6TkEyuxTxPtAgbtlcDp5bWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//RO6M7fhoiCVjKUo6S97GqwILTcd7qYF3tq1WnKm/Q=;
        b=OIVjYmc9iOEqiuFYSQXzqoFHo2f2eobRxnJZjdve1P9QmDZLOMtiAGq20SQhHyBDgN
         f1Gv9oVVeyxYYH7WBLEV2xHTQe6FkHMWJjgXEjlFgNXsrPSBXti68P3CFoBopZx7tCmq
         GnV1at38LuNGA7nX5eHhRIEskutlPabsX0PVf2BGenPgGx6XuBCv+GgPN1fs/oh2AnbL
         VBacY20x+yesKx+orAe5FSlSMtPxucx3rigIcQx2/ZBaQ6EnAWgo7N0du8MHRlHx1PJQ
         +U7RYHBzSyCI2ruM4Xa4ULiRBAwhaF8uHA3wXYGYFjc9Z/IVgVpdnJx9ue6Z61Bf6zsE
         fe/A==
X-Gm-Message-State: AOAM533c46q/+fmdptLvebc/bnO7eB1aftcH9dMUya4eRoN5Cgtsg+ce
        jkIbdN8w6CP3ISxrxoIlvShciJX8c/JhTePEuT2kxQ==
X-Google-Smtp-Source: ABdhPJwYw8S7QQlqFBlPsBGajsi+y854QY2i0/cmaNFr0zra7MM1Khu0NcB0EAVRt+/U1OdsxmXYOSYK0UrzW1purMM=
X-Received: by 2002:a92:5f03:: with SMTP id t3mr7163674ilb.25.1602973678474;
 Sat, 17 Oct 2020 15:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201016184002.GA15797@ubuntu>
In-Reply-To: <20201016184002.GA15797@ubuntu>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 17 Oct 2020 15:27:47 -0700
Message-ID: <CAJCx=g=3YczXwHzw4+pvDwiBdx8mo8qf=ss0_KC1W3uOANr0Vw@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: as3935 change of_property_read to device_property_read
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:41 AM Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
>
> This patch aims to replace the of_property_read_u32 for reading
> the ams,tuning-capacitor-pf, ams,nflwdth properties with
> device_property_read_u32.
>
> Thanks and Regards,
> Vaishnav M A

Could you explain a bit more in the commit message why this is needed?

Also you pop comments that shouldn't be in the commit message below
the "---" line :)

>
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> ---
>  drivers/iio/proximity/as3935.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index c339e7339ec8..7e47ddf89a56 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -355,7 +355,6 @@ static int as3935_probe(struct spi_device *spi)
>         struct iio_dev *indio_dev;
>         struct iio_trigger *trig;
>         struct as3935_state *st;
> -       struct device_node *np = spi->dev.of_node;
>         int ret;
>
>         /* Be sure lightning event interrupt is specified */
> @@ -374,7 +373,7 @@ static int as3935_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>         mutex_init(&st->lock);
>
> -       ret = of_property_read_u32(np,
> +       ret = device_property_read_u32(&spi->dev,
>                         "ams,tuning-capacitor-pf", &st->tune_cap);
>         if (ret) {
>                 st->tune_cap = 0;
> @@ -390,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
>                 return -EINVAL;
>         }
>
> -       ret = of_property_read_u32(np,
> +       ret = device_property_read_u32(&spi->dev,
>                         "ams,nflwdth", &st->nflwdth_reg);
>         if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
>                 dev_err(&spi->dev,
> --
> 2.25.1
>
