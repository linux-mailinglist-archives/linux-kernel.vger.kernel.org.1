Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019D42F0ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbhAKJOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAKJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:14:51 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB681C0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:13:55 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id 73so5710162uac.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii8ZbCcnrhQCcxhX0xAeoVUmfolsHsMOEt+it59Ga2s=;
        b=OpZtj2yrpY0jIs1A+TvuZNpbnN2BoX4ycqNLC3FXujF9FLhz8ntk+J3TAF4PpIIEZ2
         t7NAXUetivZNC88CRSAnpQ/eFbvkzmtibulL96cb2SoXFMQXvzulCEU2kJCvzb8EU8jz
         WoyfEevU9Ra/KlLbVqIqhJ6+B+f7vewJ1bD3DFNfNdg6i9n2+1N4kGxaIyUhz29iPq8R
         tOQUWIpjGslSKtZjgd5+qDYVwrKluR6y+SIb/StJHaSJnJn2RIhO9r7tuRgPZXqwelNU
         VbAzINys5U7UcVS1Ft6dQcJJRoAmgXHKDLFpFFWfB9TTV4VZFwga6oZWk3VQ67hdHsXw
         wS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii8ZbCcnrhQCcxhX0xAeoVUmfolsHsMOEt+it59Ga2s=;
        b=saXYyOpJAdm4lXwpFjDRxy8qIxzVoz8ozQYGu032IwD9j8kUnZZbiwqnLOoWDYweCY
         pq8VQHHvzmnOoYk4HumNXbD4eU0PK4PilCqsazEfB4LcX80vkwtrwZ5ORSiBcpYQGpTO
         9f0iS4mZxZZ+04kQzz+Z8OHFi2YSK95iw2Rt9PFwRz9ypIY+3iYMy+saqZUVi+0IMM1h
         JIqaSrz2dCOkIzLCg6lTQQmJsjtNT7ps//Z20ec5zN3kLpZF1dXy35TyNX48p4NHVuRH
         M9PmpEHuu6vgfkmAPx7GNtMNaSjZRY5/cq4M4MTzlUTnHes635rJ4wbucPIquMvc/OfX
         dFow==
X-Gm-Message-State: AOAM533Be3O/+9dI0dU7NnfNmiUj5bReig/R+CQw1KnHfJWHwUV5rS+7
        0QAVebfh0EScKUreuHmj1CB627NYR+nnhIy6QBdFSw==
X-Google-Smtp-Source: ABdhPJzQQe2XbNPVauIpB12m7fn4Vr8W/ewZCDf62dhp5YKJCEGKFLfSwbgIaGnTmJKo9ZGhVbEwirKZZRuWR/VgHok=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr11234989uam.19.1610356435004;
 Mon, 11 Jan 2021 01:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20201217180638.22748-1-digetx@gmail.com> <20201217180638.22748-22-digetx@gmail.com>
In-Reply-To: <20201217180638.22748-22-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 10:13:18 +0100
Message-ID: <CAPDyKFqm4vqWXFxsogo0UVu7r6APmO2c4QG0zf+1ZUKQTP3P2w@mail.gmail.com>
Subject: Re: [PATCH v2 21/48] PM: domains: Add "performance" column to debug summary
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 at 19:07, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Add "performance" column to debug summary which shows performance state
> of all power domains and theirs devices.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

As I stated for patch 20, I suggest you resend this to the linux-pm
mailing list so it can be picked up by Rafael.

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a3e1bfc233d4..1c60dae8540c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2951,7 +2951,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
>         else
>                 WARN_ON(1);
>
> -       seq_puts(s, p);
> +       seq_printf(s, "%-25s  ", p);
> +}
> +
> +static void perf_status_str(struct seq_file *s, struct device *dev)
> +{
> +       struct generic_pm_domain_data *gpd_data;
> +
> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +       seq_put_decimal_ull(s, "", gpd_data->performance_state);
>  }
>
>  static int genpd_summary_one(struct seq_file *s,
> @@ -2979,7 +2987,7 @@ static int genpd_summary_one(struct seq_file *s,
>         else
>                 snprintf(state, sizeof(state), "%s",
>                          status_lookup[genpd->status]);
> -       seq_printf(s, "%-30s  %-15s ", genpd->name, state);
> +       seq_printf(s, "%-30s  %-50s %u", genpd->name, state, genpd->performance_state);
>
>         /*
>          * Modifications on the list require holding locks on both
> @@ -2987,7 +2995,10 @@ static int genpd_summary_one(struct seq_file *s,
>          * Also genpd->name is immutable.
>          */
>         list_for_each_entry(link, &genpd->parent_links, parent_node) {
> -               seq_printf(s, "%s", link->child->name);
> +               if (list_is_first(&link->parent_node, &genpd->parent_links))
> +                       seq_printf(s, "\n%50s ", link->child->name);
> +               else
> +                       seq_printf(s, "%s", link->child->name);
>                 if (!list_is_last(&link->parent_node, &genpd->parent_links))
>                         seq_puts(s, ", ");
>         }
> @@ -3001,6 +3012,7 @@ static int genpd_summary_one(struct seq_file *s,
>
>                 seq_printf(s, "\n    %-50s  ", kobj_path);
>                 rtpm_status_str(s, pm_data->dev);
> +               perf_status_str(s, pm_data->dev);
>                 kfree(kobj_path);
>         }
>
> @@ -3016,9 +3028,9 @@ static int summary_show(struct seq_file *s, void *data)
>         struct generic_pm_domain *genpd;
>         int ret = 0;
>
> -       seq_puts(s, "domain                          status          children\n");
> +       seq_puts(s, "domain                          status          children                           performance\n");
>         seq_puts(s, "    /device                                             runtime status\n");
> -       seq_puts(s, "----------------------------------------------------------------------\n");
> +       seq_puts(s, "----------------------------------------------------------------------------------------------\n");
>
>         ret = mutex_lock_interruptible(&gpd_list_lock);
>         if (ret)
> --
> 2.29.2
>
