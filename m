Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307DC2D2749
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgLHJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLHJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:16:46 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AABC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:16:00 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id u19so16834658edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKbroCBz7rOKy383pNZ1k7Wl5tQXAIwK8AanppyWRXA=;
        b=ynaZElSiXc5gn43s0Nrkcc8u6JtLfrLNVgncDYewtSkJU8e8vT/BJSVAcUJ3bPXrrL
         YfNVfcz9EllKZyAPS7fP6p73r2Yb1BEqHq0fchHuIbtZQwDDN7DWi4FNe+UYHXovmwXQ
         NoLttNbBOoWzu5jeLSE3InEwSD/y07nkcbe1TUxUHWw0mR3dEfs2v6C4jj4cctGzemRP
         CVyhROuLp29sUKjDu30S/XqtrFLwtI+G7SvUEflhUjGxe7KIhe8fiiAaJabfdxfQraRz
         Ybb0V7xVfQJBiKQTg4MfZ/T8rglXkeqdq4fBQPBQGt5yOJHhKCAWuqveOVEPAmEGSuBS
         Y5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKbroCBz7rOKy383pNZ1k7Wl5tQXAIwK8AanppyWRXA=;
        b=nUp96p0vtz1tkzuPToSpazpIC26AzQeWdlSnxN7uaX7/NkW9qtxGZGbwtd1aJG/rES
         ZhxZDv03vFlkeccjDZQoKY+UXisEDnO+9AAy9HMq22fLMSbzrbr7mlO4LXycby2xsnfl
         JPus+naVskGbGxRGgh85iFeP7BGDtboRQ10LPXjzRFfhmUjocKq/sQdaM8R536zl5u4a
         EKBD2RGZxtSxmBkSi9Z+qJWJHguY4n6iH9KnKrMI0wQfMDDHgKNtzgbBvQ/ThkNscGRr
         7GhwZo1HOyq+hfPCbm5qEHDuJzcoB0M1qi4Uqf/hTyh6xQGHR7VotOofx/hdWEnPVrM+
         HbFw==
X-Gm-Message-State: AOAM531FcRuEFVxGbC22bsdXM7XGDzEqn10sY3aFqD66d2M13I/ICEOO
        EYRscq0fytwIAJZLhEkNAoTu0lLBFAj1CzXj0hmxbg==
X-Google-Smtp-Source: ABdhPJwrCpNw6Q4nOUFUhX6r5AE5MDGZtLQsv27hIB8jh4ievkFMx/MJInj7m07ISCBqR9rOWG3KTQO/DAgYlzWNz2c=
X-Received: by 2002:a50:b742:: with SMTP id g60mr1530053ede.113.1607418959063;
 Tue, 08 Dec 2020 01:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20201207203816.18269-1-info@metux.net>
In-Reply-To: <20201207203816.18269-1-info@metux.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 8 Dec 2020 10:15:48 +0100
Message-ID: <CAMpxmJWinRPUrmpcqsLaE62uAQpZ3Cb1ys3s7oHmeKM6rUUqQg@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: gpio: put virtual gpio device into their own submenu
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 9:38 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Since we already have a few virtual GPIO drivers, and more to come,
> this category deserves its own submenu.
>
> changes v2: fixed menu title (replaced "devices" by "drivers")
> changes v3: added patch changelog

This should be below the --- under all tags because we don't want this
in the actual log that goes into git.

>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5d4de5cd6759..8596f9320971 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1590,6 +1590,8 @@ config GPIO_VIPERBOARD
>
>  endmenu
>
> +menu "Virtual GPIO drivers"
> +
>  config GPIO_AGGREGATOR
>         tristate "GPIO Aggregator"
>         help
> @@ -1613,4 +1615,6 @@ config GPIO_MOCKUP
>           tools/testing/selftests/gpio/gpio-mockup.sh. Reference the usage in
>           it.
>
> +endmenu
> +
>  endif
> --
> 2.11.0
>

I fixed up the above and applied the patch, thanks!

Bartosz
