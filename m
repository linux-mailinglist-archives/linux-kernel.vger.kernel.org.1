Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021F22CD0B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbgLCICg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgLCICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:02:35 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967FEC061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 00:01:49 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id y22so1105849edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 00:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuHOe2Akk+J2QlLhyukacf2T9N/gwVrROTnJh+LYhs4=;
        b=EkMCF9aat7r8j0C4i0IhP/4yixIPCsHiv4aS8xJM37D5skQz6JTOvy00LnNj26hCOH
         vo0L2AC8XvXwGaaBsknW6dYFSEasyMyaqJywrTUGK144dfeal6MA5GPI5qn4G6KTBc99
         po5whjHpThY7nFCifXlSMSYB4Mv2JRVvrO2yPvx/e2yRWlbf3aPtDDjKH9PY7LAzvtOg
         jz9TixThxbFD4y8RBCPlRXrU6rEQZMKOS5ic1vc+VfHlEoRWXRwg//Nzhs5D2ew0UeQF
         JQreqGwNEj78/0qKi4+vFIk5J6N6BDkH1ozDeBqxDKVKmfBcGjOHFolgMm3Ecs5ptIBK
         JAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuHOe2Akk+J2QlLhyukacf2T9N/gwVrROTnJh+LYhs4=;
        b=prAN95fSWiNGrpwQ4XGJ1Qpj9RM0xORDFDmMnFr0lew2+r+ZRpZSI3t04zQuHCuVwV
         gcF3S2YS7DfFjcwCE4o3kbfv/XCpOajzUIPCgZTtJt88PTLcYebTbm7lStd/M8fy3sa0
         uWySqjLBZBY55A4og6XuG+0UUY8vznQNWuQLAB85E5EN/0M8eGzBHBamlGrpfLT/0QHd
         eZM0Xha16GeDDwnnii/NABS7PJfs8ekbta+RHQWSARldtrArpIg6Xnkt+spD/W6tTkCj
         iNRgfHbSg7MJnbNBjkovFesJ8KoGMAUjBOJNfytLBD/W9BBHcuKt20Ys1OX2DvwAxK7+
         6bGA==
X-Gm-Message-State: AOAM5322TBjM8Uv8jyAibL4jD2iVQlebQYx0zSJ5Tcu5uAM6qqSiTU8o
        FLhOumvETtos5a15lqaDpldFHlr9UGnvwfeFeBEqhw==
X-Google-Smtp-Source: ABdhPJxPRhOJ0mVusBf7DGxwNYxazF+B0dm42xTTpebRsIgCx4qZcDu8yl6pTQtVn0Q3Ma+cXndWRbx6dbfXdcasMYc=
X-Received: by 2002:aa7:d54b:: with SMTP id u11mr1694134edr.341.1606982508208;
 Thu, 03 Dec 2020 00:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20201203073910.20113-1-biwen.li@oss.nxp.com>
In-Reply-To: <20201203073910.20113-1-biwen.li@oss.nxp.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 3 Dec 2020 09:01:37 +0100
Message-ID: <CAMpxmJV97uexBKK3zHuOWfBQ77uorgxadUcrieBP2fLPs0dPeA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpc8xxx: resolve coverity warnings
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, aisheng.dong@nxp.com,
        LKML <linux-kernel@vger.kernel.org>, jiafei.pan@nxp.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 8:31 AM Biwen Li <biwen.li@oss.nxp.com> wrote:
>
> From: Biwen Li <biwen.li@nxp.com>
>
> Resolve coverity warnings as follows,
>     cond_at_most: Checking gpio >= 28U implies that gpio may be up
>     to 27 on the false branch.
>     overrun-call: Overrunning callees array of size 3 by passing
>     argument gpio (which evaluates to 27)
>     in call to *mpc8xxx_gc->direction_output
>
>     cond_at_least: Checking gpio <= 3U implies that gpio is at least 4 on
>     the false branch.
>     overrun-call: Overrunning callee's array of size 3 by passing argument
>     gpio (which evaluates to 4) in call to *mpc8xxx_gc->direction_output
>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  drivers/gpio/gpio-mpc8xxx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index a6c2bbdcaa10..12c9a91d87b7 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
>   * Copyright (C) 2016 Freescale Semiconductor Inc.
> + * Copyright 2020 NXP

A copyright notice on a two-line change is a bit too much, don't you think?

>   *
>   * This file is licensed under the terms of the GNU General Public License
>   * version 2.  This program is licensed "as is" without any warranty of any
> @@ -80,7 +81,7 @@ static int mpc5121_gpio_dir_out(struct gpio_chip *gc,
>  {
>         struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
>         /* GPIO 28..31 are input only on MPC5121 */
> -       if (gpio >= 28)
> +       if (gpio >= 28U)
>                 return -EINVAL;

I don't really understand the commit message but looking at the code
is even more confusing. What are you fixing here actually?

Bartosz

>
>         return mpc8xxx_gc->direction_output(gc, gpio, val);
> @@ -91,7 +92,7 @@ static int mpc5125_gpio_dir_out(struct gpio_chip *gc,
>  {
>         struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
>         /* GPIO 0..3 are input only on MPC5125 */
> -       if (gpio <= 3)
> +       if (gpio <= 3U)
>                 return -EINVAL;
>
>         return mpc8xxx_gc->direction_output(gc, gpio, val);
> --
> 2.17.1
>
