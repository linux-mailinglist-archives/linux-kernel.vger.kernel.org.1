Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFC247133
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbgHQSWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 14:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390912AbgHQSVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:21:55 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D9320738;
        Mon, 17 Aug 2020 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597688515;
        bh=ywvUa0thchGA9URPQznfjWIyxppEo/JGKZ107vVQVQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y/RXsrrpXvzRbb9Bjm/MkVRUSxhLxuGu8CSdYYwdyLHTiUloID/MsoZ+qpcnBzG9F
         KAZVk+Kkuhw34IvZftks6NNv8s45M65L5zLJWiAaTCMkLiMXoZRaXy6vhf1N/5DAvd
         yv/DYZ8GCSBvu2G6sDH/V7x5/+yPqDVxOT/nOGns=
Received: by mail-oi1-f179.google.com with SMTP id b22so15611410oic.8;
        Mon, 17 Aug 2020 11:21:54 -0700 (PDT)
X-Gm-Message-State: AOAM533VrkiwNbLXRjAEHf/cEqtwBRnADOzy8YSjvDkz6IY+Mgy+Dk/H
        EcOhc3QEAe83yUB1SHjOprTBLgaEsFo1kKID3Q==
X-Google-Smtp-Source: ABdhPJxFsvl9kH86GxixpRdB5tPpGwqT2xFsCvdog8At58/krej8IRcOw7DKZn8zvJK2vP5cE27RU3JaNpXROwleBQs=
X-Received: by 2002:aca:90a:: with SMTP id 10mr10338190oij.106.1597688514113;
 Mon, 17 Aug 2020 11:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200814225637.702584-1-arch0.zheng@gmail.com>
In-Reply-To: <20200814225637.702584-1-arch0.zheng@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Aug 2020 12:21:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7eK3HB_E8OeSbs=xVLYrvOcXD9GxpKr2N4dXZWnBP+g@mail.gmail.com>
Message-ID: <CAL_JsqJ7eK3HB_E8OeSbs=xVLYrvOcXD9GxpKr2N4dXZWnBP+g@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Remove duplicate check in early_init_dt_scan_memory()
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 4:57 PM Qi Zheng <arch0.zheng@gmail.com> wrote:
>
> When the value of the first reg is not NULL, there will be
> two repeated checks. So modify it.

I prefer the way it was. I'm sure the compiler is smart enough to
throw out the 2nd check. Plus, 'linux,usable-memory' being present is
the exception, so usually 'reg' will be NULL.

> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>  drivers/of/fdt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4602e467ca8b..f54412c00642 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1002,10 +1002,11 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>                 return 0;
>
>         reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
> -       if (reg == NULL)
> +       if (reg == NULL) {
>                 reg = of_get_flat_dt_prop(node, "reg", &l);
> -       if (reg == NULL)
> -               return 0;
> +               if (reg == NULL)
> +                       return 0;
> +       }
>
>         endp = reg + (l / sizeof(__be32));
>         hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
> --
> 2.25.1
>
