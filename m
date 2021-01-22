Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F78300390
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbhAVM5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbhAVM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:56:48 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF0C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 04:56:06 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o13so7409564lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 04:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbysKLgwDzAo+nX90SpxzAyrCCK68/bvQhdhyAtkNpo=;
        b=QDULxrStPPn057tG9barLLBFRTBLJ8ylUfC0+F54+qfA4SNlZv40pBLuzSI0N/59g+
         SapNPHtGBn0koEhPx0looQTZhW4s0UFM5EVkuMCzoapTRXpEDyc69fqvsU908jFwJhl1
         j/yvSpIt2HaWfzv+03V9uyp8XZPdrS6Fth+Ku9EuwOJYLiz4LOmW9KBVV+H7uB9ILTHo
         76d+qxuVb/0yZGYHVhgwPn0OxgWrekrE33QMuejE4dqntZ4GJoOtPN0Jyx7bDRdcr5qZ
         m6CggsFCwzDH7b5b9jySKPwtmQ3X/dswem/zBMF8fVnBErlwmXTgKtFmBiztB4LRoPvI
         ipow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbysKLgwDzAo+nX90SpxzAyrCCK68/bvQhdhyAtkNpo=;
        b=Sil0qLX+NwpkiR+lB5hFdf0ZeiQxJSTF6a9NDgWhRkW6Bc7Jse25mqr5Bd0ZrvdPpK
         IB1yiRqBLa2oLCFdKpl/kMieuj05bG+Jjw5oJ9fAVpReweHinFS6YxmaMn7eIbrC37WM
         IRSIB0qNleIHAL7R7W89jj0sKk/ZC+hYpBsEEzoX7kGx0tzMAjqdOJeQzLpTAOL9JioO
         j5kxzqmYzSo9fPJrYesT6jEX36Ktkt4fZX0hWyzPCtM0AU7JCyeiREVYc5isJjDkC7fG
         BzG+TL/zr7eMGIbic8/HWjbV4Xz7qi5X0kyuEqCDJxOU/ut9nwCoKXHBTKFIC3FCX/Z6
         ymuQ==
X-Gm-Message-State: AOAM531W6Ouzs5RNJTn2+D2kquny63kyHZc1p4Lwd7szsogp5X49cZFi
        UN5NmPGE4QIcCOc1UN69GXFIO7Q7a0EvYWhx7GiuMw==
X-Google-Smtp-Source: ABdhPJyzQ8QWrLb9ryGYf8zFaFDgdefT9zZMp875FZQAg32906v115z1A2LAgTQWXJX5DB0zn6ghDHXKGH30CeVhH7A=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr129571lfd.291.1611320164547;
 Fri, 22 Jan 2021 04:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20210120004548.31692-1-digetx@gmail.com>
In-Reply-To: <20210120004548.31692-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 13:55:53 +0100
Message-ID: <CACRpkdZynT6T8wnN3xY6hUmZy5emWUe5ep9N3BEV8iQEZLnEew@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: tegra: Fix irq_set_affinity
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 1:46 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> The irq_set_affinity callback should not be set if parent IRQ domain
> doesn't present because gpio-tegra driver callback fails in this case,
> causing a noisy error messages on system suspend:
>
>  Disabling non-boot CPUs ...
>  IRQ 26: no longer affine to CPU1
>  IRQ128: set affinity failed(-22).
>  IRQ130: set affinity failed(-22).
>  IRQ131: set affinity failed(-22).
>  IRQ 27: no longer affine to CPU2
>  IRQ128: set affinity failed(-22).
>  IRQ130: set affinity failed(-22).
>  IRQ131: set affinity failed(-22).
>  IRQ 28: no longer affine to CPU3
>  IRQ128: set affinity failed(-22).
>  IRQ130: set affinity failed(-22).
>  IRQ131: set affinity failed(-22).
>  Entering suspend state LP1
>
> Hence just don't specify the irq_set_affinity callback if parent PMC
> IRQ domain is missing. Tegra isn't capable of setting affinity per GPIO,
> affinity could be set only per GPIO bank, thus there is nothing to do
> for gpio-tegra in regards to CPU affinity without the parent IRQ domain.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Tested-by: Dmitry Osipenko <digetx@gmail.com> # A500 T20 and Nexus7 T30
> Fixes: efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip")
> Reported-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Ick, sorry for the noise!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
