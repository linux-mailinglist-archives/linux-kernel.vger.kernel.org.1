Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86052E96F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbhADOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbhADOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:15:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF64C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:15:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b73so27456991edf.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCxd/PUSwUofs28XjI+jmkN/DEXzfHZxj/dT0gyHcnk=;
        b=VHjNnt2s4dQeSW9LopBNt9rWpaKMF9XN+LBbbACmtxwZnGiBIurK/5FsVB5AzmS+Mc
         0yRYeWtNDGAsC+owrj+8qKPfsDTGYhutapyGAfMsAgmECMtKlzJm+pHQsK8Aic1qNvRs
         SkrqF2XydKJz3jDPCOeh23IfQvNWOVSvMRbKwGy+nMbEEHGjPs9W7AolHvo//KUmxFpa
         X4Cj/5PEqiCdYomqICsT63KOwTqLdyNK/i/gISskuKBd+lkcO6CmGiNzgja5MC7xCxiZ
         L+yUkxqYre2hA515uEllcPlA853IVtamqZMKAUWWXVzWEmIz/v076EAhiwlGmhHHmz/J
         nC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCxd/PUSwUofs28XjI+jmkN/DEXzfHZxj/dT0gyHcnk=;
        b=ljNs3UMW4z1df9peIdPLmRp0BlZw5kh8ACRzQo6fWXLOG66tbBvJmYaFwqlULiI5St
         ycHQ0Sokqz8bvu+AaNtRMjESmZ/mFQmwsykMVwZ4S4aaAQaDMVKgfF0aIkIkar7uJ0st
         tULnzqjLHQMkHcQfTd3jAt8E8ndWwk8xftLF8jatE1LBgxRXiVyzNGA5YvfeIyHPUnR6
         xwU23fJbD3wpNf5CdRJd8K/2/4LxVdlxQ4muIgIQxS+GAMxr+XR04xe/a1mNeWbhcq27
         S7PlXcL1kBk2dVvw3SmJOQ/MdtKQTkVJSpcy+QeIcjh3SsB3kfo1WTFCjS3MZtpMrTZc
         TjAQ==
X-Gm-Message-State: AOAM533aZpLAkH0sDpeh8FafO75XN25TSwKF2wYePN6OXH3wDDbiGFkQ
        LiiAGIUpWfD9psCEv8hzDTPFOxB/Hgg5ZZJvspgOoQ==
X-Google-Smtp-Source: ABdhPJz0E/ceV53tnHAH+mJe21UbyhmOoq/FdVVavN6bd1kaBMjWKHYRGo2gMkT45CeYjc24r4lPRbQOZ0OZdkh2UiA=
X-Received: by 2002:a50:b742:: with SMTP id g60mr70299542ede.113.1609769718075;
 Mon, 04 Jan 2021 06:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20201228150052.2633-1-nikita.shubin@maquefel.me>
In-Reply-To: <20201228150052.2633-1-nikita.shubin@maquefel.me>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 4 Jan 2021 15:15:07 +0100
Message-ID: <CAMpxmJVN8bH5KJ1-W76Ac6MOH3fy5Xo_B1ozsWkLVacJhxOHsA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: warning on gpiochip->to_irq defined
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 4:02 PM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> gpiochip->to_irq method is redefined in gpiochip_add_irqchip.
>
> A lot of gpiod driver's still define ->to_irq method, let's give
> a gentle warning that they can no longer rely on it, so they can remove
> it on ocassion.
>
> Fixes: e0d8972898139 ("gpio: Implement tighter IRQ chip integration")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/gpio/gpiolib.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5ce0c14c637b..44538d1a771a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1489,6 +1489,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                 type = IRQ_TYPE_NONE;
>         }
>
> +       if (gc->to_irq)
> +               chip_err(gc, "to_irq is redefined in %s and you shouldn't rely on it\n", __func__);
> +
>         gc->to_irq = gpiochip_to_irq;
>         gc->irq.default_type = type;
>         gc->irq.lock_key = lock_key;
> --
> 2.29.2
>

I know Linus suggested using chip_err() here but since this doesn't
cause the function to fail, I'd say this should be chip_warn().

Unless Linus has any objections, please change it.

Bartosz
