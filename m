Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC72F300080
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbhAVKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbhAVKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:38:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6493DC06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:37:36 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id rv9so6935042ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+fAdhRYdbKzh7cy80B+uxwiM0uWD8OWSKWpHJ2K4I8=;
        b=LhUXPi3dzQ8ifspmaTFtAyzvn+NuPllCX6wsUD5fbUrVBoG4y5pS8qrpWP5y319jx/
         ATg8tANOe8/Vpj9UqDWwNJG8jxjL0VdNtAicoVGbksHH8dS53I/WJKwAELpxMkRh+rC4
         Q7T+bLTnrVDenHbzLCUjkivKZrz4ILAvHGlhAPR8m1z+9NTMXScv0SBHG6Na0buG7tSs
         2i3c/Cui4vYfKY7xniySdxdBYy3B3kthV7oI2+H+raEv8/bzz6qMkKRU3+aITvE4gqA/
         Aky4HFzMTdAi02IQhB2orSktSWkGjFLUYTaWu2/Ijk/lQwbyC3+nxYbd7LEepBk0GkvF
         pBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+fAdhRYdbKzh7cy80B+uxwiM0uWD8OWSKWpHJ2K4I8=;
        b=DYdMmyZJSnSseFFrNyEFxz89DvsBZXAWVAvjD6kxq62RkLF4fPOOEB3LpWE5F3LGG7
         Da1qpsJ2aDQAOqCiEPhXYFzi8sWcVTmKzaSYvlUmiBFajzYFvnnMO/fhjSLUCzJfnFYo
         nVRHsBJUYAfObKZHbyUdirQ6HzYNR7Sk5zeUVMISkZ18JFY3nHrpjnVFcfkOXt9XJ2QS
         sg7BfEh0aucF27xa3qyPpjaZ0xyTDzkibStusULFw8kH4N1gHysQo9/l54puEBeLxOup
         cC5bJktu1NP6rhMJv1X1Io9L+mPUmscFZFpbMEGMp1vhB9nl0r+G74WOAw093DhdHrkQ
         RkBg==
X-Gm-Message-State: AOAM531FObMN9L1gqx0Hut1SdJffgnGYF8FH0SSRRRux0LenlnhOHwru
        Jx4N8saUwBzGXisrhj6YW+hEgb0feGZBDSZD1XJl2A==
X-Google-Smtp-Source: ABdhPJzt1YL4wQD6NzcThUhl+9fZSo3D3AsTDEXvXereCC8ddVqas/jbKSpoFiDQ9gnSWNUdr6aY9RsJY3EsWzztukM=
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr2475548ejd.429.1611311855093;
 Fri, 22 Jan 2021 02:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20210119135727.105360-1-warthog618@gmail.com>
In-Reply-To: <20210119135727.105360-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 22 Jan 2021 11:37:23 +0100
Message-ID: <CAMpxmJWGMECwGx-zCNP+F0RJYH3EV87_S36m2kCSaKp3ew6+bg@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: fix line info flags description
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 2:58 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> The description of the flags field of the struct gpio_v2_line_info
> mentions "the GPIO lines" while the info only applies to an individual
> GPIO line.  This was accidentally changed from "the GPIO line" during
> formatting improvements.
>
> Reword to "this GPIO line" to clarify and to be consistent with other
> struct gpio_v2_line_info fields.
>
> Fixes: 2cc522d3931b ("gpio: uapi: kernel-doc formatting improvements")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  include/uapi/linux/gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
> index e4eb0b8c5cf9..7a6f7948a7df 100644
> --- a/include/uapi/linux/gpio.h
> +++ b/include/uapi/linux/gpio.h
> @@ -212,7 +212,7 @@ struct gpio_v2_line_request {
>   * @offset: the local offset on this GPIO chip, fill this in when
>   * requesting the line information from the kernel
>   * @num_attrs: the number of attributes in @attrs
> - * @flags: flags for the GPIO lines, with values from &enum
> + * @flags: flags for this GPIO line, with values from &enum
>   * gpio_v2_line_flag, such as %GPIO_V2_LINE_FLAG_ACTIVE_LOW,
>   * %GPIO_V2_LINE_FLAG_OUTPUT etc, added together.
>   * @attrs: the configuration attributes associated with the line
> --
> 2.30.0
>

Applied, thanks!

Bart
