Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA862F541A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbhAMU2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbhAMU2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:28:30 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99DC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:27:50 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id p14so3876226qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xiamiSWwbUOBjKmwyIt3ehtGjp/ZFC9e/lMyYQA0nWE=;
        b=YnS79eg/YVThThuU6byk2NX5zo/4P8xogbontQ0MTW+mA1V3OS2cNVMGOilMZ8P/QB
         JfFxvzlvh2xr/01Ska9As6SjBrgAtCuOT1xS5giNFPCboeUm2KlBlN61RFeLJEgNhOXc
         23ZbnHn60oYDrK8cgUI/aja7f4gEIX9j6dMWwzr9s3grYk3MKsFFE1ZnOQ4GFJNc0J10
         qucblVVGFS3CtkHCN+YVkocK1RUjaFx5j1Hadj5WkJ/xJ1aLMJMIYrp9nxG6I+FsEfxp
         NnpQ+ywUBGfOXsU/vdWvJ2Q9wisWICqjUZjc+bqNiklp1VY+hJaWgUrSxNEeRLuDAkuX
         rkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xiamiSWwbUOBjKmwyIt3ehtGjp/ZFC9e/lMyYQA0nWE=;
        b=i7M1XjCbIUPq3mbLiSimTSj+HKp70Hw3+QWfBVcJEc9HXiROn+Qu7gS9Vh1bX3qJYU
         11VZH+qIcpN2B3/lC5fiTLeq2I/wlZm+NCetUanbyN6/492Y8kMvcUsUrYELVCVuYitx
         26RTyOv56DmQKoffZAIB6JC6zj6Ip9W4csKBF2WAU0wKsRjNmzzsdAWsEa8P+RUli+mp
         vZwSbzRWqAYj6/o+vSOyLY1sz+u5JSYItR1SUI7+C2HpzEFIEezOi6p/kQF5sPq6Zmkt
         sNAK13BDMflw+j0QwGBDGAI5oEzFTXsOrk3ZOn8yw4e0OswH3kzLo5VBKKrAHKMxwlfH
         wnAA==
X-Gm-Message-State: AOAM533Y86bX/wHpZCGOIVNMggCenrg1e88ZenuxQGup5SycP7Nfhyn0
        HMWvLIu9aTiiioQuCUFedXZq1xWDK1z6sjy3BCfuwA==
X-Google-Smtp-Source: ABdhPJywwDejpVSaJdUM6+6orUxiKAFn3B6GDdOK1Nz/ZM/oTA2mO3ZQAuW2uvs2m5cv9WXQXf98YZZMZYjfqRtpXPw=
X-Received: by 2002:a25:b703:: with SMTP id t3mr6383967ybj.96.1610569669365;
 Wed, 13 Jan 2021 12:27:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210113110330eucas1p1e7efa719b5db55ccf3774450a8c1e452@eucas1p1.samsung.com>
 <20210113110320.13149-1-m.szyprowski@samsung.com>
In-Reply-To: <20210113110320.13149-1-m.szyprowski@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 Jan 2021 12:27:13 -0800
Message-ID: <CAGETcx9wJVnBAe6mKxfi9DC9YFf6DLzAyxBC8DxhQUqpfTDR3A@mail.gmail.com>
Subject: Re: [PATCH] soc: samsung: pm_domains: Convert to regular platform driver
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 3:03 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> When Exynos power domain driver was introduced, the only way to ensure
> that power domains will be instantiated before the devices which belongs
> to them was to initialize them early enough, before the devices are
> instantiated in the system. This in turn required not to use any platform
> device infrastructure at all, as there have been no way to ensure proper
> probe order between devices.
>
> This has been finally changed and patch e590474768f1 ("driver core: Set
> fw_devlink=on by default") ensures that each device will be probbed only
> when its resource providers are ready. This allows to convert Exynos
> power domain driver to regular platform driver.
>
> This is also required by the mentioned commit to enable probing any
> device which belongs to the Exynos power domains, as otherwise the core
> won't notice that the power domains are in fact available.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Some more comments are in the following thread:
> https://lore.kernel.org/lkml/2556a69b-5da5-bf80-e051-df2d02fbc40f@samsung.com/
> ---
>  drivers/soc/samsung/pm_domains.c | 97 ++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
> index ab8582971bfc..5ec0c13f0aaf 100644
> --- a/drivers/soc/samsung/pm_domains.c
> +++ b/drivers/soc/samsung/pm_domains.c
> @@ -16,7 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> -#include <linux/sched.h>
> +#include <linux/pm_runtime.h>
>
>  struct exynos_pm_domain_config {
>         /* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
> @@ -73,15 +73,15 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
>         return exynos_pd_power(domain, false);
>  }
>
> -static const struct exynos_pm_domain_config exynos4210_cfg __initconst = {
> +static const struct exynos_pm_domain_config exynos4210_cfg = {
>         .local_pwr_cfg          = 0x7,
>  };
>
> -static const struct exynos_pm_domain_config exynos5433_cfg __initconst = {
> +static const struct exynos_pm_domain_config exynos5433_cfg = {
>         .local_pwr_cfg          = 0xf,
>  };
>
> -static const struct of_device_id exynos_pm_domain_of_match[] __initconst = {
> +static const struct of_device_id exynos_pm_domain_of_match[] = {
>         {
>                 .compatible = "samsung,exynos4210-pd",
>                 .data = &exynos4210_cfg,
> @@ -92,7 +92,7 @@ static const struct of_device_id exynos_pm_domain_of_match[] __initconst = {
>         { },
>  };
>
> -static __init const char *exynos_get_domain_name(struct device_node *node)
> +static const char *exynos_get_domain_name(struct device_node *node)
>  {
>         const char *name;
>
> @@ -101,60 +101,44 @@ static __init const char *exynos_get_domain_name(struct device_node *node)
>         return kstrdup_const(name, GFP_KERNEL);
>  }
>
> -static __init int exynos4_pm_init_power_domain(void)
> +static int exynos_pd_probe(struct platform_device *pdev)
>  {
> -       struct device_node *np;
> -       const struct of_device_id *match;
> -
> -       for_each_matching_node_and_match(np, exynos_pm_domain_of_match, &match) {
> -               const struct exynos_pm_domain_config *pm_domain_cfg;
> -               struct exynos_pm_domain *pd;
> -               int on;
> +       const struct exynos_pm_domain_config *pm_domain_cfg;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct of_phandle_args child, parent;
> +       struct exynos_pm_domain *pd;
> +       int on, ret;
>
> -               pm_domain_cfg = match->data;
> +       pm_domain_cfg = of_device_get_match_data(dev);
> +       pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return -ENOMEM;
>
> -               pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> -               if (!pd) {
> -                       of_node_put(np);
> -                       return -ENOMEM;
> -               }
> -               pd->pd.name = exynos_get_domain_name(np);
> -               if (!pd->pd.name) {
> -                       kfree(pd);
> -                       of_node_put(np);
> -                       return -ENOMEM;
> -               }
> +       pd->pd.name = exynos_get_domain_name(np);
> +       if (!pd->pd.name)
> +               return -ENOMEM;
>
> -               pd->base = of_iomap(np, 0);
> -               if (!pd->base) {
> -                       pr_warn("%s: failed to map memory\n", __func__);
> -                       kfree_const(pd->pd.name);
> -                       kfree(pd);
> -                       continue;
> -               }
> -
> -               pd->pd.power_off = exynos_pd_power_off;
> -               pd->pd.power_on = exynos_pd_power_on;
> -               pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
> +       pd->base = of_iomap(np, 0);
> +       if (!pd->base) {
> +               kfree_const(pd->pd.name);
> +               return -ENODEV;
> +       }
>
> -               on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
> +       pd->pd.power_off = exynos_pd_power_off;
> +       pd->pd.power_on = exynos_pd_power_on;
> +       pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
>
> -               pm_genpd_init(&pd->pd, NULL, !on);
> -               of_genpd_add_provider_simple(np, &pd->pd);
> -       }
> +       on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
>
> -       /* Assign the child power domains to their parents */
> -       for_each_matching_node(np, exynos_pm_domain_of_match) {
> -               struct of_phandle_args child, parent;
> +       pm_genpd_init(&pd->pd, NULL, !on);
> +       ret = of_genpd_add_provider_simple(np, &pd->pd);
>
> +       if (ret == 0 && of_parse_phandle_with_args(np, "power-domains",
> +                                     "#power-domain-cells", 0, &parent) == 0) {
>                 child.np = np;
>                 child.args_count = 0;
>
> -               if (of_parse_phandle_with_args(np, "power-domains",
> -                                              "#power-domain-cells", 0,
> -                                              &parent) != 0)
> -                       continue;
> -
>                 if (of_genpd_add_subdomain(&parent, &child))
>                         pr_warn("%pOF failed to add subdomain: %pOF\n",
>                                 parent.np, child.np);
> @@ -163,6 +147,21 @@ static __init int exynos4_pm_init_power_domain(void)
>                                 parent.np, child.np);
>         }
>
> -       return 0;
> +       pm_runtime_enable(dev);
> +       return ret;
> +}
> +
> +static struct platform_driver exynos_pd_driver = {
> +       .probe  = exynos_pd_probe,
> +       .driver = {
> +               .name           = "exynos-pd",
> +               .of_match_table = exynos_pm_domain_of_match,
> +               .suppress_bind_attrs = true,
> +       }
> +};
> +
> +static __init int exynos4_pm_init_power_domain(void)
> +{
> +       return platform_driver_register(&exynos_pd_driver);
>  }
>  core_initcall(exynos4_pm_init_power_domain);
> --
> 2.17.1
>

Skimmed through this patch and at a high level, it looks good for what
it's trying to do. Thanks for doing this!

Btw, I assume that this won't work with fw_devlink=off/permissive
(default since 5.10 or earlier)? My concern is that we might
temporarily set fw_devlink=permissive by default if the other
breakages aren't fixed in time for 5.12? How do you want to handle that?

-Saravana
