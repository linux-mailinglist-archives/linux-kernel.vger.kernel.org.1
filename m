Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C111A53FA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgDKWyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 18:54:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgDKWyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:54:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id s29so1529847edc.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDoR7MPIZ0+UUjjouT8/iWH3LcwGrhQgihvzyqzRNGQ=;
        b=PHQmoASmZM1OUhZeppjw00AbiQw/QXc293IIO0lqpH8/odmnWcu8n+H26Y8XxezF5K
         t5UPPSPm56yRfv5e2FeetYzLaWtV3K+m4JmmKZ4XSAHlO6P7lEePVwucbuYr3mv0nEJz
         vubUUZ9mp/UNWDXEUMDp5KxT9Fv03QCbxQtyrnj8KWSjqrnb8lgUCI5IMPhxGa4PgtDo
         cNpbCbe64oSJl7wyKADWtt4zBbbr1539jwOFObOmYUTYyh7Ott+TeySlb9HdK+U2v816
         gBb0z5xXBGiAgCO+XPUN0PYCVGu8uog2ufHu7PZNDwXf2wUYZ3pjULQMxUrV7csE9s2g
         hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDoR7MPIZ0+UUjjouT8/iWH3LcwGrhQgihvzyqzRNGQ=;
        b=Ef+4oWjteUFzbLl231dW6Sdg/wtlhFyKYPwXBG/NvyeZd0n4xDkLRZD5gXD+2wbrUo
         JFWRrA4t2QvfdnnEuoUrfJvJD/OIZLuYEowhsEzn8QQUmSxtarBk83pkPX9dhDtrf92h
         M/mPhq3VdD0cBl6X1LTYEO9vQL98lPwP3qLEs2AFwBbav1CmCRkn8CfskGhr+aPu1I/6
         Opcs/YRLkFEQuoxrTDuO38mN94tv6Dir7NFb6+0AfPlFMnjwxX17mFWqNOy2pEt3ZRLU
         VCAWGfwy526CqQ5igLn6+wffIRuSzOzLmAPOMXJymFLfaWULGnqd8CnS+IIgcKsPK86N
         d27Q==
X-Gm-Message-State: AGi0PuYJuqjU/fi0PwPLAM1REpWebh4f8r2aWzV3OsEezzTwEPVaf7ju
        oE0Z4EI6T8kl0aIBhCwHr0Ntuu2JxOa8EzQ/edBmpQ==
X-Google-Smtp-Source: APiQypIR0ywLETIZ5z0ZHHvh3nP6YVmecVELlCDEPz+SUBLD+je5yymmncBzfHsVz8clXk2t9cvgaEC9Z15ShKlm6Cc=
X-Received: by 2002:a17:906:4301:: with SMTP id j1mr9880009ejm.46.1586645642328;
 Sat, 11 Apr 2020 15:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200410113913.14430-1-colin.king@canonical.com>
In-Reply-To: <20200410113913.14430-1-colin.king@canonical.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 11 Apr 2020 19:53:51 -0300
Message-ID: <CAAEAJfCQaCCoShLPTA+EWUhMXdF6bKAxcOCj2SR5nPXMmk7LQg@mail.gmail.com>
Subject: Re: [PATCH] media: mantis: remove redundant assignment to variable err
To:     Colin King <colin.king@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thanks for your patch!

On Fri, 10 Apr 2020 at 08:39, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/media/pci/mantis/hopper_vp3028.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/pci/mantis/hopper_vp3028.c b/drivers/media/pci/mantis/hopper_vp3028.c
> index 37bd386f3ed8..ce1e8737b14b 100644
> --- a/drivers/media/pci/mantis/hopper_vp3028.c
> +++ b/drivers/media/pci/mantis/hopper_vp3028.c
> @@ -33,7 +33,7 @@ static int vp3028_frontend_init(struct mantis_pci *mantis, struct dvb_frontend *
>  {
>         struct i2c_adapter *adapter     = &mantis->adapter;
>         struct mantis_hwconfig *config  = mantis->hwconfig;
> -       int err = 0;
> +       int err;
>
>         mantis_gpio_set_bits(mantis, config->reset, 0);
>         msleep(100);

There's a redundant err assignment right below here,
which you can also get rid of:

-       err = mantis_frontend_power(mantis, POWER_ON);
+       mantis_frontend_power(mantis, POWER_ON);

I can't test this, but calling mantis_frontend_power twice
is possibly redundant.

Also, what's the gain from this cleanup? The driver is super
old, and it seems any modern compiler would be oblivious
of the redundant assignment.

Thanks!
Ezequiel
