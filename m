Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1512C2F31CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbhALNb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbhALNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:31:56 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:31:15 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id j140so1436097vsd.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0RONQCsveuH12mcp5SO7WKQEzlPvyEoFcpr2U4wTVM=;
        b=OkQPJCk8ioE3pFgIZYlWQDPW8ITJpfyjad5m44r7MYgwruK3cnZq6XTMJhKn6/AdLr
         117lNPeDu1Bt7ZtXn2Z1q/N/h0mXOJo7Daod7/FWjueAr7y1qIxv/vqtoGCVEl7tbM1R
         vtK2AymwwMYNwc3cDPcAKnv7haOm9KYfeafvC5bO8zaXF9gScIh7S4msSn8qtjwpl4LM
         6zOVVnaUMf5FXn+Y/PY7w0I9yve6AMG1od7pV9ALOWWdgqcwAEWClJJJQJbPBXRvq4ie
         TSj79arUA3SnSxZunuJFeZUZXbkcHtz5kjENaxA0MnL9FU0VVvWN2ShVRbDFYbocrDcE
         HnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0RONQCsveuH12mcp5SO7WKQEzlPvyEoFcpr2U4wTVM=;
        b=UZEsZlc1n2YftlE4eUmdxiUlUBAmDFGKALRN76mh7sKyLpGQ2grjZlusRU9UcfYPCG
         V9Ezj3ZoohyAMgwKn5iD9YehTIvWf8yGGf+Xd/9vixa7tfcLOFtzuk6u+MssDC752B2a
         VhwTaDYhr3RDsNkY8kb905VaZu5Cg4BlCwttL/KbZ0AdTAGvB/YFvHemxE1LzPSe3cLt
         ygrlxN6tRweZ3mzExdpJJ2HnEVQunJoMUtNJgxkhN+l1nNgNk1eU2f8mLoUILnuRO0zr
         RzzdPM92h8dKvr63hQPwTUFAQZ14HvIRx03fpfPgNjDGbKZGqtqWDnmi9jhxlVz653Qq
         JG1A==
X-Gm-Message-State: AOAM533YPMkdAoeHnq+x7fCZxDnDrhRQ+Q8NbkkKB5Nkpsxlgwb71dxs
        x8ZI5zcNTOgaXgeTShEj0bCHHav0Ki1WpmZiyL6I0g==
X-Google-Smtp-Source: ABdhPJwt8/TB1tdd47rzsdts4U5b5Ht0iy4ZvkXfVqAJEhveYbFkAPjQ6ucqokw7W9HAc5TBdHS/iamJPJQStNP+vxg=
X-Received: by 2002:a67:e286:: with SMTP id g6mr3928269vsf.42.1610458275130;
 Tue, 12 Jan 2021 05:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20201217180638.22748-1-digetx@gmail.com> <20201217180638.22748-30-digetx@gmail.com>
In-Reply-To: <20201217180638.22748-30-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jan 2021 14:30:39 +0100
Message-ID: <CAPDyKFrj-8WwK1U7KJaCiWkt2bsohgoEnqhQ4sgwjZzZfX2iMA@mail.gmail.com>
Subject: Re: [PATCH v2 29/48] soc/tegra: pmc: Link domains to the parent Core domain
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- trimmed cc-list

On Thu, 17 Dec 2020 at 19:07, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The Core domain is a parent of PMC power domains, hence PMC domains
> should be set up as a sub-domains of the parent (Core) domain if
> "power-domains" phandle presents in a device-tree node of PMC domain.
>
> This allows to propagate GENPD performance changes to the parent Core
> domain if performance change is applied to PMC domain.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/pmc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 4f96dc7745c4..1a659d1c06d7 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -1236,6 +1236,7 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
>  static int tegra_powergate_init(struct tegra_pmc *pmc,
>                                 struct device_node *parent)
>  {
> +       struct of_phandle_args child_args, parent_args;
>         struct device_node *np, *child;
>         int err = 0;
>
> @@ -1249,6 +1250,24 @@ static int tegra_powergate_init(struct tegra_pmc *pmc,
>                         of_node_put(child);
>                         break;
>                 }
> +
> +               if (of_parse_phandle_with_args(child, "power-domains",
> +                                              "#power-domain-cells",
> +                                              0, &parent_args))
> +                       continue;
> +
> +               child_args.np = child;
> +               child_args.args_count = 0;
> +
> +               err = of_genpd_add_subdomain(&parent_args, &child_args);
> +               of_node_put(parent_args.np);
> +               if (err) {
> +                       if (err == -ENOENT)
> +                               err = -EPROBE_DEFER;

Okay. So this special error treatment is needed because
of_genpd_add_subdomain may return -ENOENT, in case the providers for
the parent-domain and child-domain haven't been registered yet.

I suggest we move this into of_genpd_add_subdomain() instead, thus
letting it return -EPROBE_DEFER when there are parent/child nodes
specified in DT, but the providers are lacking.

> +
> +                       of_node_put(child);
> +                       break;
> +               }
>         }
>
>         of_node_put(np);
> --
> 2.29.2
>

Kind regards
Uffe
