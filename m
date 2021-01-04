Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF96B2E9704
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhADOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhADOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:18:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1ABC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:17:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j16so27487681edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3YGJhKq0HHQGucgmozYpZHntxUmH5DmRwVgK8AwGuI=;
        b=v/GwiUgY4h1BjISOPH1/5Py5SLZxxMO5Oord6HX0IddfyiNTi/HqwkJ/9E7XmNPAdk
         nbcogLlSkct4rDD8cIGy4NXm3riFpNhQCuQsmhFgxIz1x6/Ug0ZUH1wL2ilZQ+V2DGsq
         vDgAaIaRXLLIweV9TmZ2EzpWIn53U8XhcyoPugzLudsGo+8Csx7Mlj1QDQL2i7TdNPAC
         CW4KqQCQ6ZhODerecqYLHs88o/K5mUew7G/Pt2zH+gy+MUA3HO39622EhjhhPXnVDGXp
         c1yGzJZb7wuOfOM55fOH/cEPA1eCXAJkcykuM7BnPFoP2MnbO6BkJnGLWk8p0cEbGr4p
         c+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3YGJhKq0HHQGucgmozYpZHntxUmH5DmRwVgK8AwGuI=;
        b=MN7zzYJSRtoX6R8S46qsRmTBxQv78FgOu2peHbLEyO3MhG/TIbEAGk+qMS5RL0ygG9
         jFy6bU5gHat/g9ZRkqfDfETCIc1ujntGBiUvEX1Y4SSwL7rElq0VaSehaSIv4FUSrGDC
         wbNVfr7gHNd3ZFcIzYmir3ovPZQH77U2/J7viYpqXgZs40KpbLobkmWVV9mmftslh/4r
         ekvHWmN/gByo2yDDeexp/5BXNkbkB9X+2PKd8NdTmGiCNGjvCRM5agggwUjhejFd/9Np
         DDSLA1wasN+aHxYOn5LxLGrcBEThiLnoIFE2GttKRRZXe8kmgR8lSFJ1zljeO+VvX1mc
         bUlQ==
X-Gm-Message-State: AOAM530XHLOnbotktHHR7DLKrqCNjFlb/BDDTZaG0UkuuChjipvKamfv
        PzkI/uU0q6roExr7oMVJ+KKr/+IV0x9F2UpNzScj5w==
X-Google-Smtp-Source: ABdhPJwKAwnuVOSXfrGZtt7PjGMtlUob47gHSBwlgW4likWCOsuVJtIKI7KiyyrRrNAuyD7juRrBNmtE7FtcJZev5Qw=
X-Received: by 2002:a50:bac4:: with SMTP id x62mr69994137ede.59.1609769876975;
 Mon, 04 Jan 2021 06:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20201224112203.7174-1-nikita.shubin@maquefel.me>
 <20201224112203.7174-3-nikita.shubin@maquefel.me> <CACRpkdadUVHefag4d42BJiOraAmHrXDcK7gzjZrLXn371rMwOA@mail.gmail.com>
In-Reply-To: <CACRpkdadUVHefag4d42BJiOraAmHrXDcK7gzjZrLXn371rMwOA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 4 Jan 2021 15:17:46 +0100
Message-ID: <CAMpxmJU-j93c8qUduehGKdHigswYcnAkhXKx8NmQjPqO7ibJjw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] gpio: ep93xx: drop to_irq binding
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 10:21 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Dec 24, 2020 at 12:22 PM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
>
> > As ->to_irq is redefined in gpiochip_add_irqchip, having it defined in
> > driver is useless, so let's drop it.
> >
> > Also i think it is worth to give a gentle warning in
> > gpiochip_add_irqchip, to prevent people relying on to_irq.
> >
> > For example
> >
> > WARN_ON_ONCE(gc->to_irq,
> > "to_irq is redefined in gpiochip_add_irqchip" \
> > "and you shouldn't rely on it\n");
> >
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Take out the suggestion in the commit message and implement it,
> but I think WARN_ON is too nasty, just use dev_err().
>
> Yours,
> Linus Walleij

This depends on patch 1/3 so I'll wait until you resend with issues addressed.

Bartosz
