Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB52D273E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgLHJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:14:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46506 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHJOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:14:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id k2so18705095oic.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EGQR2culyGmiGFkRWmTZwJqkIzkyjnCwKsV3S+AsiM=;
        b=Z0UR5BGOLD1h/JK0wbdqoo6aIZKDNdL67Wdilegz8k9NYJ9WNuo4bwnXbAsSFAAWjY
         bOdBjZ9t14wLmuDS1nLKh+lQe/A9WYyzBjMYiRBS9qnaLdlXmiIt3y2KtoALliFWeu2V
         IcHW1WicerPI0fjpWRF/CK+tV1OZ/6V7oHGcDgQFkjptavuds6o6pWTRNOOsaP7W72tr
         UHF4Tmtv2IIx4txUTKdog3IFw8fU8HKzLmwaaacSuLLHIaayeE81NV7Zp1Gmh2+zaJJg
         XzM1nxg3Z70YhRRoSFpRzo03pL4YcFJFKgw+N+JPVMoJ8iD5wLdyWDogpUt0ZnjsdNng
         JIGA==
X-Gm-Message-State: AOAM532rR/eLFTpyrcFtwIIPBfBK+eo8wqtxN56jhmmyeKBWVFsbG84V
        3xoDqA83DilzRbm4Wxwz8/Ma0AffYNZV59S46OA=
X-Google-Smtp-Source: ABdhPJxldlti3eHVhWkgVpBbjoYDMdHrVluoGc9x3slqnFFctpFrbNpWqpvf1xQKT3khbMkKxyco0lgSZK8sfnGHC98=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr1949478oih.153.1607418849898;
 Tue, 08 Dec 2020 01:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20201207185952.261697-1-krzk@kernel.org>
In-Reply-To: <20201207185952.261697-1-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Dec 2020 10:13:58 +0100
Message-ID: <CAMuHMdWqMRUf=rZMxTgJx3PQAL6q22wBOi6A_e-o8z+0jyrTgw@mail.gmail.com>
Subject: Re: [PATCH] soc: fix comment for freeing soc_dev_attr
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Dec 7, 2020 at 8:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The soc_dev_attr is stored soc_dev->attr during soc_device_register() so
> it could be used till the cleanup call: soc_device_unregister().
> Therefore this memory should not be freed prior, but after unregistering
> soc device.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch!

> --- a/drivers/base/soc.c
> +++ b/drivers/base/soc.c
> @@ -168,7 +168,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
>  }
>  EXPORT_SYMBOL_GPL(soc_device_register);
>
> -/* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
> +/* Ensure soc_dev->attr is freed after calling soc_device_unregister. */

"Ensure" makes it sound like the freeing is taken care of, which is not,
as it should be handled by the caller.

What about "soc_dev->attr should be freed after calling soc_device_unregister."?

>  void soc_device_unregister(struct soc_device *soc_dev)
>  {
>         device_unregister(&soc_dev->dev);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
