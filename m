Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094132970BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371537AbgJWNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370815AbgJWNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:37:24 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F020AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:37:23 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s15so878512vsm.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zc7t+lOzY7cTGJnijbB9ZWGm7Y121IIAMh0AQlwU3pA=;
        b=YdHU1o5OjK8fiIdbmhMO+IyNC8TEW8YOMBNOvHEY2cYnrBk8/gyhlYYIjqHjd0NJ7N
         Q6JBWCM+gB37AP1jOXbf9Qs6KcHuJqiJ3/FVRG29uZZ8jNuBpdaQ5Kmh+w25khqb98O7
         fuaszBb44mle10AmhDlAgsLQDc7XXCO0ws3mJyf5n05zELyfTPtRGhaM1i8oM7amc2Fc
         DjnSs/nDUeaxSyqWD/mF0nMOPxn1l7Z028HeK7L9fJPPANXe3r3b8yJt+YSKnXOTX5eS
         GLq4LFVkP1G723OStpmTnkAxGBLBZSlWGC7QGzkxDC4GiKD75t2DgvwWH/qbfNQK0Ovd
         dYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zc7t+lOzY7cTGJnijbB9ZWGm7Y121IIAMh0AQlwU3pA=;
        b=MGp6EcNZLwQfy4s9jtnzldp63tlHkXJED7RNKXVGXNQrS4tlQcYfouCe6ZiORRidVw
         RY9P9uF/BMx2OF9CnLElWBdx7fRX7m9eLG452WpJoEIdLwgPzTtuZ7BMrUSyRQ+C1ag8
         +0uCRCqJqKEpv9NfLDTlgiQDJ1utjHohZtNitS6w3BQfOQZ7vU7wCQaVj0CgO7OWpoWK
         P61S0/+jDKsS0REGcsGLMqxGcWK6bXmgw1uBRB1A5M1khJ0itvAq4FmkiX1Fq1GAT8xT
         AVGkPFWi0XCrqigpKf/77VQomuNTyFxgnrRPuYNohoenvosj/CkvZlzftXBAkNrhwGmd
         TksQ==
X-Gm-Message-State: AOAM532v01WqPw07QYOeOxHYlSB9OgXBJHyRYXjrCg84VXvVRWaczOcj
        hdq0qBU2zqwkaBeNC/udN0YsMHEZHPoYMjgJa4o=
X-Google-Smtp-Source: ABdhPJzARGEDC4xlej7yvuuABhHcmbQVxvjDThXOHqDeOTG4DEZsLZNb6d3iTK/9tJ5SYw2WGPPvdSR0KQcyvZVXMYk=
X-Received: by 2002:a67:cc2:: with SMTP id 185mr1422202vsm.42.1603460243020;
 Fri, 23 Oct 2020 06:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201012132404.113031-1-jingxiangfeng@huawei.com>
In-Reply-To: <20201012132404.113031-1-jingxiangfeng@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 23 Oct 2020 09:37:12 -0400
Message-ID: <CAGngYiXY95R5=fUPQ2aBXOQsPXrkp8E4TTmU_75pQZN9OuiUUA@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: jump to correct label in an
 error path
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jing, thank you for your patch.

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>

On Mon, Oct 12, 2020 at 9:17 AM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> In current code, controller_probe() misses to call ida_simple_remove()
> in an error path. Jump to correct label to fix it.
>
> Fixes: 17614978ed34 ("staging: fieldbus: anybus-s: support the Arcx anybus controller")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> index 5b8d0bae9ff3..b5fded15e8a6 100644
> --- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> +++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> @@ -293,7 +293,7 @@ static int controller_probe(struct platform_device *pdev)
>         regulator = devm_regulator_register(dev, &can_power_desc, &config);
>         if (IS_ERR(regulator)) {
>                 err = PTR_ERR(regulator);
> -               goto out_reset;
> +               goto out_ida;
>         }
>         /* make controller info visible to userspace */
>         cd->class_dev = kzalloc(sizeof(*cd->class_dev), GFP_KERNEL);
> --
> 2.17.1
>
