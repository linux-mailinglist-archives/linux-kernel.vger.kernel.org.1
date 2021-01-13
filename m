Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4002D2F4C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbhAMNJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbhAMNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:09:28 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873B4C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:08:14 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id s2so1068467vsk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtnXd+iTDg9Rg+Mw0g6+815d+x7k6NpX0spOlvkZURM=;
        b=K3ThR3oAwHsQDZ7xbu/9Z6R2rjT8kKSP3SkyMW0wlSYsB51z5XKfnUKwBX4AKvt9KM
         tA5GcrNpQvXFDqTJQtPi0kTXaO/Zp6IStPrlpHHNiBaqGOqEXnYUQpL53QFEKvODpWZO
         imW7tIAKGQuoFxvHjS+dbmymtQA4Kyt6Wcu79PG+IfS2dNoz/cz6ZrEZojn2dxKPtVqh
         fsqvFG3GUVjy6V84g4+u6egXd8SNRXYZWg+rYQLI1nQhTi//6pkCUUJtS4SaD4UOsKV8
         CL7EXYn8eEwQSr0T8JOVDX/JMekYRwf6E/9RMLwh8Ul9kLeJTXj2bsrNzJGgFwV0nGsT
         WcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtnXd+iTDg9Rg+Mw0g6+815d+x7k6NpX0spOlvkZURM=;
        b=Oyn3PlShGXipx4iEtZNxv/rBdpG/ekXYxgJEd0eOvhlNuH5GwdC0ZnByFcDzp9Bm1u
         b2ka+BAW7IjmG2Kmf6TviY60fcHQiC2Icxzd4QBXOTtt4FsjFJBjB9h14IKOMgosZh0H
         cI3KnlVkL5Tbh0xEEXgXwklUZE7PR0IIqX63W3K82yWif/Lcn7OLLztVZzq3EGvgb842
         zKMyb3YR+AOiOkXTIQXF5/MBwRrRstdpMqbewAcZtF25lr3hK5NBQfYX9fTYrvLpWdfr
         CmIP6nwz/Z+qKrInXI5J25LFsI2gy/KfqLmECiz34kMtqUjxhUcINB8cypxQoo1mHwWO
         zPow==
X-Gm-Message-State: AOAM530CK9x5/q4/OGju4wZHm6TkEuiXZw2ne0SkNB4sXJqjvJomqUAX
        3HDf77aR8JvxuQKFoBUEIRUQCbwuxc6aHU0TUCBgPjYnatFDbg==
X-Google-Smtp-Source: ABdhPJxBxJLzhErcrlYsDsTsERCk05HcKbtoPrJ+uP6qmTZlC6tz44CDMpxLSFjXCO26CrdrMiUdnEXasFsZ32t/om0=
X-Received: by 2002:a67:e286:: with SMTP id g6mr1920721vsf.42.1610543293702;
 Wed, 13 Jan 2021 05:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20210113113431.522-1-zbestahu@gmail.com>
In-Reply-To: <20210113113431.522-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 14:07:36 +0100
Message-ID: <CAPDyKFqzKf44RV29c+ncKffgRQrz7gSHNGmmKqeYWJMj5rQ0hw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove needless err = 0 in mmc_init_card()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 at 12:34, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Since they will always being in successful path to return 0 directly,
> no need to set err = 0.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ff3063c..54ab1c7 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1697,7 +1697,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         goto free_card;
>
>                 if (err) {
> -                       err = 0;
>                         /*
>                          * Just disable enhanced area off & sz
>                          * will try to enable ERASE_GROUP_DEF
> @@ -1802,7 +1801,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         pr_warn("%s: Enabling HPI failed\n",
>                                 mmc_hostname(card->host));
>                         card->ext_csd.hpi_en = 0;
> -                       err = 0;
>                 } else {
>                         card->ext_csd.hpi_en = 1;
>                 }
> @@ -1831,7 +1829,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         pr_warn("%s: Cache is supported, but failed to turn on (%d)\n",
>                                 mmc_hostname(card->host), err);
>                         card->ext_csd.cache_ctrl = 0;
> -                       err = 0;
>                 } else {
>                         card->ext_csd.cache_ctrl = 1;
>                 }
> @@ -1851,7 +1848,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                                 mmc_hostname(card->host));
>                         card->ext_csd.cmdq_support = false;
>                         card->ext_csd.cmdq_depth = 0;
> -                       err = 0;
>                 }
>         }
>         /*
> --
> 1.9.1
>
