Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71CA2D0E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgLGKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLGKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:32:06 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C1C0613D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 02:31:26 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a16so18750736ejj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 02:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avwXTY4xKF4GYJux7MHK5WB/0Z5FSjvXovshldSv0FY=;
        b=Koz8pLD92Bc+OA38U/SVkLaUxErp6GlaZiBlKyqXz1eMnIAAlJ1AzWywkxnWEpTuqH
         jcpvF2CqCxtziXQ7kd8q4pe836G+LkCaA5WsZfZ+pm4I/4SkjmXLtjrf6laDzMx6YhkD
         SyBhLnB81hYrCMvTbf578MOKilnaYFTq/NK1CVGPEbc0M1UMpiq1F8EYEDb7K6Ev5RWH
         aEJnikVY4spRTMvGWM0UD5D+eqnZN53w2nheq9/FxLG3obYGCPgEMKPqABacz7+/06xW
         IhMcpuOukOTei6R7dZMXRvM6D7SIU/KSQDdBaPuloTNPORL20DniuYKo5CX05qvRp1We
         kP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avwXTY4xKF4GYJux7MHK5WB/0Z5FSjvXovshldSv0FY=;
        b=kkeHiGjNpZ+lc2tOmsWTxVdoh545PLUp21/xMNWJGYRDPTVVujiVba7Z1P1orgCVsG
         ARRTLZbY3h0NzN7rv6SB4yp87M1O8z8BU3/b3DkJLIS4/cgkEJ/hxo8NOaC+gFf13J0t
         g6Fbkvc3xd308Sh86XOwh37220eLc/szPCD3Bh/ifcxflfTbvHvtZbkletW2dIc201fP
         4oZClWO1nekKN+hAad2b1Mdi1NPfsLxCW9Fo4TfMcAMcaRuamROivssS5Iw9ifCQ3Evc
         lM/5fHcnp/ihbV18XSxhfGAnlxlMQByHtnfCqN38L0fbzfQGoV6xZ7RfseG6b9Qhc9MG
         7YVw==
X-Gm-Message-State: AOAM533H4ixarsrNBhpTm/wl8j4bXKzXTjxsKzrU2yFvphoxmt50jKGR
        x9OeXpGMgo9OfBqw7W3JX6o5Sb8AmjU4TKMGY/ajZCVbcLY=
X-Google-Smtp-Source: ABdhPJzXz9wKScnULYT5yiqNYTc0tuNX148+tIwRVDm7K1qucm+VxxovDI70gPvRQXH3EBb4Z3MpwQMNCuOuDuVMuAE=
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr17640381ejd.363.1607337085119;
 Mon, 07 Dec 2020 02:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20201203191135.21576-1-info@metux.net>
In-Reply-To: <20201203191135.21576-1-info@metux.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Dec 2020 11:31:14 +0100
Message-ID: <CAMpxmJVkXeH_B4A_e1Vy4H2LcQnNz0BVoZyXNKEXmG8NvgO6cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drivers: gpio: put virtual gpio device into their
 own submenu
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 8:11 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Since we already have a few virtual gpio devices, and more to come,
> this category deserves its own submenu.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5d4de5cd6759..01619eb58396 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1590,6 +1590,8 @@ config GPIO_VIPERBOARD
>
>  endmenu
>
> +menu "Virtual GPIO devices"
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

I'd call this section "Virtual GPIO drivers" because the code contains
drivers not devices.

Bartosz
