Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8793727ABBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1KX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1KX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:23:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A190EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:23:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so7794742ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcQ3Q5G7b1iYSZV9wYb2LjY+OnGWWHVqpPN2pZmnPAM=;
        b=xdjR0uBbD8V3PgvOy2pnav7PYFNuSjlZqObOj0QX/LlRX8GwcdXfGkYoYsT77+BLC2
         viXOj9LPAa84LbZxoO+SzNTAiNAQY3Ui4fA/HdzdXqt1VLf08uPL9OkxUuhWpkJi5hNA
         xNdLvZVbsvdfZdWhUtjBT4ZJYgl9Fgh/bplxAWmdWsn4XEBe46y9E3V9VQd6J2PcBNl+
         WvHYDXlJUwVmYsPnc2zOwdHOISaLcjEtAkJyU1UjWi+rGpiMINEEup5vCh1efUIufWFZ
         mPVoddcOm/AOmN4LwMLN3a4l2rhWoW52fU/5xV8jMITcEJAJyzukiuiJ9FywlUUK2dCQ
         1W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcQ3Q5G7b1iYSZV9wYb2LjY+OnGWWHVqpPN2pZmnPAM=;
        b=F7JMgxDdP00+0ASMBQsh7HWPgy+ILWcW2XjLLmwUCJGZQ1ih0KimWVTvjNDKylgVj0
         3JVA8PkWaf7YNJaZL7mAyLV5NdmvT8iBrALgM5gPDK7Ljo3c/+AyCbb4LVP3vrC0vUct
         SMpDWJkqEi9Au6rBUfgo6Ql1IjHST6PXCC2pffqmZ6wuvaraJUVXqfVNolp+GOFYv1zK
         N78TBcWfH2rvMA6jEB9HCajytlYShRnhZ+zizaf0L4ZcaliO/BVEajuDdIZDR5I0eMMr
         FwUFdb7pyysIWDjqVY8pTTZtJ2V9pfcg/ARR/wjWVGXwg6NLPk3iNRbYCD9/3Y+dpuid
         Be8A==
X-Gm-Message-State: AOAM532anpuRTeWOVaAhj7z4OBbLOD//KTcrIfdORGpOd7usfpL0Nqdm
        r0ZOVKdGH0br+Cu4fdXMAuBleZi/VUXAbGmx1MkqMQ==
X-Google-Smtp-Source: ABdhPJz+qlAAw4d5faIhEVhDwipCEy9QfC5hjH+z40kZktFm1EUNksrZRJG/94w6YS06dIpL8UQ6go/Z6/AiyOk6Zs0=
X-Received: by 2002:a17:906:850e:: with SMTP id i14mr917595ejx.168.1601288636377;
 Mon, 28 Sep 2020 03:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpxmJV0jwLAn3Xee_3zDiF_DQF-8uy52qxU1WAbr9xiVb0WLQ@mail.gmail.com>
 <20200928094452.7005-1-lists@wildgooses.com>
In-Reply-To: <20200928094452.7005-1-lists@wildgooses.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 28 Sep 2020 12:23:45 +0200
Message-ID: <CAMpxmJXv5+hegJX_m5Pw72O9Fiez++ELN6EqSP0MiPyrcm79Kw@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-amd-fch: Correct logic of GPIO_LINE_DIRECTION
To:     Ed Wildgoose <lists@wildgooses.com>
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:45 AM Ed Wildgoose <lists@wildgooses.com> wrote:
>
> The original commit appears to have the logic reversed in
> amd_fch_gpio_get_direction. Also confirmed by observing the value of
> "direction" in the sys tree.
>
> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
> Fixes: e09d168f13f0 ("gpio: AMD G-Series PCH gpio driver")
> ---
>  drivers/gpio/gpio-amd-fch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-amd-fch.c b/drivers/gpio/gpio-amd-fch.c
> index 4e44ba4d7..2a21354ed 100644
> --- a/drivers/gpio/gpio-amd-fch.c
> +++ b/drivers/gpio/gpio-amd-fch.c
> @@ -92,7 +92,7 @@ static int amd_fch_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
>         ret = (readl_relaxed(ptr) & AMD_FCH_GPIO_FLAG_DIRECTION);
>         spin_unlock_irqrestore(&priv->lock, flags);
>
> -       return ret ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
> +       return ret ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
>  }
>
>  static void amd_fch_gpio_set(struct gpio_chip *gc,
> --
> 2.26.2
>

Queued for fixes, thanks!

Bartosz
