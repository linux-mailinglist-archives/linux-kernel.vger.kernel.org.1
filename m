Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24902F0EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhAKJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhAKJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:11:54 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:11:13 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id z16so9310186vsp.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzsqb244fAIaB0c3Hwq/Q8yeHQrbTVz3BLbnT43mepE=;
        b=RpjsJo01PdFt62gzMkdlO86lMnwyovgap9eY12cGxMf3hDn8GwbNuVluZLOvm1JEo9
         dXxUa1/loNb8fF2e5MZDtxUm5+sa6RX3psbO8UbyGN6o6zSp+eUPCGrj/kvdAtkpqZrM
         TFFI+Q/fVHNTx2BG2y3lf4l8dgDIcnb8PVidXWvsNrXkktt1CWr0ma6rD8UtTyfixOzd
         t5eCg0nJXTm9eOeN0W2xLdBx1itJBAeIoGmtNjgIUBSEM4MYqWfzOBr211UAPKsWvhi5
         7T3npWvl/XQFa5vIMaheXCf0kdHsjstZz4lCl8GxnidCnh036wvkcdIoRpAzJhXKnWGt
         2Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzsqb244fAIaB0c3Hwq/Q8yeHQrbTVz3BLbnT43mepE=;
        b=oY9apN4Loq9VMJZaZVlg/5/wYCDcUICmI6aKGcf3257of29q1ePTJRRuxdj2ItLvE9
         bgZ2pzMjpmV1bj8RcxfXE/8tRMaIzxa/Q/C88XGb1ygFkrB7DpZqdoOWZLc751vaaYkS
         kNSKN+40Yn6oDAZkTynDxcs/c0anEAo6oXF2jpqMhGumKgGmym/vDpYly/4bBT7QYWae
         E7O6E1/OM6Yr/mLUZL2zBbjXQxQViZskPbOOXUzWm0p9DUEH/wodPTylmxBcZMUVLTHI
         vPRcfOsag7y4s1UTWB+TmUmK/KQW+vbmNoI6iAYjtK00Kfh3bxQrr57pcSi/jJ6T8zQY
         IeYw==
X-Gm-Message-State: AOAM5316kolrbWknbroD3hHl65xEfdLBMH7FOBo3UETzZ35MB+CaGkKB
        si9MIvmhOq9EV3eXMNtgRVcLQRN+P0RNKp3kWP1T7vdSoSN7HQ==
X-Google-Smtp-Source: ABdhPJxfQRto1X00FIn3dyo94DunInqE+v0CkSyA5YHYpNlEegjIQEQyhhdsn0xw6MoEjOK1Fms4ez7UWeuBFR/o/7g=
X-Received: by 2002:a67:e286:: with SMTP id g6mr12425479vsf.42.1610356272969;
 Mon, 11 Jan 2021 01:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20201217180638.22748-1-digetx@gmail.com> <20201217180638.22748-21-digetx@gmail.com>
In-Reply-To: <20201217180638.22748-21-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 10:10:36 +0100
Message-ID: <CAPDyKFpc+YqPU0_mNFuRm6H+2c536BOd=PiHawNTUwfv1ZS_7g@mail.gmail.com>
Subject: Re: [PATCH v2 20/48] PM: domains: Make set_performance_state()
 callback optional
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
> Make set_performance_state() callback optional in order to remove the
> need from power domain drivers to implement a dummy callback. If callback
> isn't implemented by a GENPD driver, then the performance state is passed
> to the parent domain.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

This should be ready to be picked up, but maybe it's easier if you
could send this to the linux-pm mailing list separately. Then Rafael
can pick it up.

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eedacb92..a3e1bfc233d4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -339,9 +339,11 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>                         goto err;
>         }
>
> -       ret = genpd->set_performance_state(genpd, state);
> -       if (ret)
> -               goto err;
> +       if (genpd->set_performance_state) {
> +               ret = genpd->set_performance_state(genpd, state);
> +               if (ret)
> +                       goto err;
> +       }
>
>         genpd->performance_state = state;
>         return 0;
> @@ -399,9 +401,6 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>         if (!genpd)
>                 return -ENODEV;
>
> -       if (unlikely(!genpd->set_performance_state))
> -               return -EINVAL;
> -
>         if (WARN_ON(!dev->power.subsys_data ||
>                      !dev->power.subsys_data->domain_data))
>                 return -EINVAL;
> --
> 2.29.2
>
