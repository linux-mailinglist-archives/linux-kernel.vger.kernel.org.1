Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8170C2A7F55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgKEM7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbgKEM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:59:43 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB3C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:59:42 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id w25so691488vsk.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cf6Reenkulcvx1M++5Ft3F89n+TgucGRfAJUzamClvg=;
        b=ws10/iKJk8CyhNwGYsbllaueWggHLsmbWy/ERx4LGC0DAmcxw0jWh5ojrVT+bMKqZ0
         2t3zBnI+FOp4xyiV3Suo3dlXpWLz6bWG7dDiRmoN27iynEgt3w0KGhzyQ3SocRgnsJxC
         s+8zZOJ6WHouDntrP2XqjDagS1cHFcCoRSf86TVyQ7Qv5o3+98iPzshUfMjM+pR0ebU1
         d4ETkZS7VEYG65XgYW7I2yWAROGPP0iReuBeGSa/UgF4leKJ7LhZwIZvMILhOmosnMwq
         ISxh5HWnBGxNQzIoCtrWCt3CmmEr7SKu5+DV8gaquYvhstk2bk3jXu8vBgQwCwv+rexs
         NAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cf6Reenkulcvx1M++5Ft3F89n+TgucGRfAJUzamClvg=;
        b=kzh3qKW8k1CufkAWzu/GwH4e/94AgAldUnN2u32mUC8aiphxVNY0ynSJpKWs+sCqzz
         3GgpRClqClebNt8fUIpTNcU1nV5C8oA3BWR3EmtBh/RwDkB7aXdQQj6fvgLbaskTvR9J
         Zfbfn7QgR/oNPLNBDKahSPnL7hxVDGE1KY6nXyjD6eijamQhnP6D9wFeIpFVdOv0bSSN
         mhF0bN9e/v3nvpbNGp7vk09ItQoP0osmrYMm8Bt/hcxjfYXYsu/cFnQ0ujAuMV286Tf4
         bVmQyrLA6sk8hqjixU4CWcz3skOxVyfnJnBEOD6t3ep6s63eYK9CLhY0TUKXLsyoyDZ4
         k0iQ==
X-Gm-Message-State: AOAM532qEvJ/4p3SelJMsnuYEZvcVwmaUM6DXkqskmcyAxILVci2Ur5H
        qYOdWqB+wP3KhOMLG6Nv/T9sxalHoMZ86gaNKFLm+w==
X-Google-Smtp-Source: ABdhPJyALjYk4dc+ZE9nrx+tFiQQuxVnGKZVVOwn967qwn5WyQmkB9fFCK6Gknms9k31ZhzVwlUZP9EveWxT15FLCmA=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr1011201vsp.34.1604581182187;
 Thu, 05 Nov 2020 04:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20201031142756.2140029-1-trix@redhat.com>
In-Reply-To: <20201031142756.2140029-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:06 +0100
Message-ID: <CAPDyKFpgUAoXSptorC-WqRFUHvuuM6=xUSQwBAXwVSMXPn1PzQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: tifm: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Alex Dubov <oakad@yahoo.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 at 15:28, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/tifm_ms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
> index 786e46798da2..57145374f6ac 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -528,7 +528,7 @@ static int tifm_ms_set_param(struct memstick_host *msh,
>                 } else
>                         return -EINVAL;
>                 break;
> -       };
> +       }
>
>         return 0;
>  }
> --
> 2.18.1
>
