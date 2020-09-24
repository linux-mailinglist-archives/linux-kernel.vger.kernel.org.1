Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B357277296
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgIXNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgIXNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:38:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3A6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:38:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i1so3437270edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xik+LU5D4/fnn9O5Zg87zvohwDV0OOxnMU6Rsd+HY5c=;
        b=bZq4o3WQtLEJr2hF7mu9T4voHEBiRZ/TRwujICZ9S7HZhEwolwqG/vQ7kdo5O4CyP4
         oLSU+r7N7Xllvo9LRKTKkXdRSl06zc1J1mF+kRJI9EUJdNLfEb0Zd5227/HqtRZuMK1b
         YdKMV32umoR833Fj8DoHg5lE7GpkmpqmyqQD8penWeGszWRjo6JbNdwNTXj9Y/f3NRDQ
         E7DpO2ULfgrybDDJtmMI/eTqX6pRyQEQSHOL4FZULVTe1MLBStA1OGaqljfBHPhAFcZ0
         WLSe32GdalfrwK8CwaBPP2Vp9KvNvg2Kq/eXn9z1QeJMTTihSei/Ae+OXG/zu8nJ+EFl
         PSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xik+LU5D4/fnn9O5Zg87zvohwDV0OOxnMU6Rsd+HY5c=;
        b=fAJEkZQlYGPC9fIG9w99CCMz5D9iX12PP7TaDxWg96EPDtAKC0iN+4z5Utk5vA+UJc
         /4chYfq8aKnD2ODWEucQm/Cg4pr49t7YzxNk/kfEflULZeR2IniXRt0W/SOgym5rsa03
         U37RNHUEzBu1SlOT/l0hhbGIbfaB6zGdUb5s1FUKuiViOsFyrNaxY4JBvF6LNpCg4RcS
         vDPox0rYYT9VcNMWCWfU6NLKKmHkFXLL5LU1W1gX799VWvG9VF++17OxIbiXaqOKChax
         QA4uvTo3GC0COq7qpc7DLIQut+N+UbddlSseiTCHbKhEC7syfEDM+Fp1I6o5scIk43UH
         8vRA==
X-Gm-Message-State: AOAM531b/N7r9FgK4qZSxIiA00LZYfdI5AIhMmBv4+75ErLPM1hzs7un
        OSCiyVjMFIOlVq9d30J/RIjYqQMFpmjliF0CH3bc6w==
X-Google-Smtp-Source: ABdhPJwUCSvUnwIjhMwXdH5/5JtzPZNKnNR+yIgd72G5d87Unxa+rzC+LUlKdHxuhlTagtPeDVImVhVFGvN3yixC0jU=
X-Received: by 2002:a50:e79c:: with SMTP id b28mr1109705edn.371.1600954680607;
 Thu, 24 Sep 2020 06:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200916204216.9423-1-rentao.bupt@gmail.com>
In-Reply-To: <20200916204216.9423-1-rentao.bupt@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 24 Sep 2020 15:37:49 +0200
Message-ID: <CAMpxmJWR7VqU9urj=-KypKLm3aFooMd9iyusYtr5dNY2oOgXQQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: fix ast2600 bank properties
To:     rentao.bupt@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, openbmc@lists.ozlabs.org,
        taoren@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:42 PM <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> GPIO_U is mapped to the least significant byte of input/output mask, and
> the byte in "output" mask should be 0 because GPIO_U is input only. All
> the other bits need to be 1 because GPIO_V/W/X support both input and
> output modes.
>
> Similarly, GPIO_Y/Z are mapped to the 2 least significant bytes, and the
> according bits need to be 1 because GPIO_Y/Z support both input and
> output modes.
>
> Fixes: ab4a85534c3e ("gpio: aspeed: Add in ast2600 details to Aspeed driver")
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  drivers/gpio/gpio-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 879db23d8454..d07bf2c3f136 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1114,8 +1114,8 @@ static const struct aspeed_gpio_config ast2500_config =
>
>  static const struct aspeed_bank_props ast2600_bank_props[] = {
>         /*     input      output   */
> -       {5, 0xffffffff,  0x0000ffff}, /* U/V/W/X */
> -       {6, 0xffff0000,  0x0fff0000}, /* Y/Z */
> +       {5, 0xffffffff,  0xffffff00}, /* U/V/W/X */
> +       {6, 0x0000ffff,  0x0000ffff}, /* Y/Z */
>         { },
>  };
>
> --
> 2.17.1
>

Queued for fixes, thanks!

Bartosz
