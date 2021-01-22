Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7347330105A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAVWyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbhAVWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:48:37 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B99CC061793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:47:56 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f11so8326074ljm.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIWgpxTzAU7neyLO5D8TajLhANUxOv5nY7y9DCeaEWs=;
        b=h//3sL6KUkJSBcB5nEzL5E4dPLIsbya6teNaf37vh/c4AtQZPFnYyvkI0mJ1Ltd3mi
         Szs7f8j7jaygtecvGggDrQQY/AOFN630S/RUKaIRjiBw6btTBRjSPCLDpvWJKpshVeF/
         4W/vu64bNdRRuXYIWPWgJ8F/5zdgBCLvgvkFjp3N3gObDHQlGqJyKoDgk5RPJh8Cf5G2
         5QCTieOHwA8k4uOi8FFXX5DDfmwYkfLZNcyYRAXWq6AUb0zGNcuMkhZ28aAiQRxscJFr
         M7xlU0E3DlY5/IMUsxPd6QfL2+DTMMARrgXq2IxayqP81vVA254gpo17eY9C/Tu9hs2K
         +soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIWgpxTzAU7neyLO5D8TajLhANUxOv5nY7y9DCeaEWs=;
        b=rLvV/glQqOc0ljsRHyyyjf98Vf5aPJEuEeM3w1QCqexHs94BgEuuL0Xst7EBpuIaNR
         TqK86qUn3C1uLp5drgjTRmq2vXV4vXnBXRmicK4imo1TCguE2tu7q4mTHDsjeKltEiDZ
         GfOqTCuCUq3VfQFy1mRmfiUpY4yRKOGtLu8rve/qFrvMK5hRfHJ81f0AYYesULi0ejQO
         bwAhGH9AyZWjovu2rBg6SljYBsivrkTUGJzRx9WZ3UvxCwo/7tK1bfhzdVVDfGJCfqyV
         NcSFoBPfKpLjfb6d35febBIHK+0r66Arurkm5sUi5l0TbmWSavEPUJPXep3G3mUhtOWD
         zn6A==
X-Gm-Message-State: AOAM533H5/1gQ93lTE1rfu/3gJmi57A22B7pJ1W4RzjmLEhRDKX9c7rO
        /eSl6sbKvnVbFD/kaWAXc/vzmsBT+pOreUKo5j0SMZyNAxiwog==
X-Google-Smtp-Source: ABdhPJzoMWpLu1sd1E0uopGczpCuawrVcYbO8BSD89jWRBAsY/YPKGcQeZu2gy5KLDUwD4A7OlfUU0/ukrGAGDhXIaw=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr79313ljk.74.1611355675097;
 Fri, 22 Jan 2021 14:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20210121121355.31654-1-brgl@bgdev.pl>
In-Reply-To: <20210121121355.31654-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 23:47:44 +0100
Message-ID: <CACRpkdZ-TT8wwRr6bJgvqjBcw5OkyB7+jyBO3AKdhaWSQTxuVw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: tweak the Kconfig help text
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 1:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> gpio-mockup doesn't require SYSFS to be selected so drop that bit from
> the Kconfig text.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
