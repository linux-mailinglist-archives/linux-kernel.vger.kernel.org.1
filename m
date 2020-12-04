Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C512CEF0B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbgLDNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLDNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:52:18 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65319C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 05:51:38 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id s85so3278309vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mz+QBXryBtw02WKwvqtBofezUJT1ockyk/QIMMgUvZw=;
        b=PCDIH1vya67kDh+iw8rL1ska13PYiK592n/u69GgSzRS+DGxeAhYxWftIjoDQ6jXsR
         OG8Cs6BifeNdcNkTOKlFDB6bcWCQld+JMxaHLwbFOAk/P0l+4qS5a+uTh4BuX3TrcTJc
         LLw0M/1ogLIHNzL+GbAtacLK1eWdla2RcWvh9n9fwLY0V2s2fUp4gPOVLWuSaAG66NTL
         liTfwrDW2fUgLQ5PCxJ8ATygZYURPaeVhcjNAuWvH/7PK3I2i5rYA5ZHdkGfbW2hYvrT
         JmIeINqgzp8nJAEqZDI5XusQ6zlUYolKjZ6SMS/cNxkyLAskX4yLDsJGVgetns3SjnVZ
         PFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mz+QBXryBtw02WKwvqtBofezUJT1ockyk/QIMMgUvZw=;
        b=LjdvH9eYcL2cGh0nP3MkyVQCHL0F8Hcu2IfORQihN71QfosIAXhIClAJ3hUYXqQeER
         hhTya+2MMF/au+2Z4O+J7uiMbNzQGvsyJG+D+rNYFa82iE8SoAiHXHS3hKJ4444aSujI
         LtWYaa97Im90+CHol79XXmA1czxdrFEA85jJInlawI3ysVt2g4eItucI7Zav5eaSALUX
         iKoXO0Ln+uZ9aoNeynYd8hiUJaWdcAAWKSpN1VrZb75k+cYQVQwoNU3IHFmhXYm5b8vJ
         7abKZkjCuVxta6erXJW0YgxkUqYrjp65Sfrkd8n9z+VGbM0C8bK1MjbXpNMpJHNOSLf6
         ReQw==
X-Gm-Message-State: AOAM530D0fBhlfc4+y7Gl2CU1CLIGamZjncu/j86Ed3uvO/O4AVgSUf8
        jktu0JhhMTZ0cAK+wAbon386i7RADNy9hRwmhe6RyA==
X-Google-Smtp-Source: ABdhPJzGk/t/tL7qP3yXjvmv1gwXx2PLLjyUM+GAGZfIX8dHIabpfg7nwlt7x+ZeP38Bi0Enj1TxsA65ZcY09Di2JGc=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr3685273vsg.48.1607089897636;
 Fri, 04 Dec 2020 05:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20201202185118.29076-1-mw@semihalf.com> <20201202185118.29076-4-mw@semihalf.com>
In-Reply-To: <20201202185118.29076-4-mw@semihalf.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 14:51:01 +0100
Message-ID: <CAPDyKFp_+5G2Bg0rWcW+ZKeee--3znZJhRuXUi1U70ksy+qcjw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mmc: sdhci-xenon: use clk only with DT
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>, jaz@semihalf.com,
        tn@semihalf.com, ard.biesheuvel@arm.com,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 19:51, Marcin Wojtas <mw@semihalf.com> wrote:
>
> As a preparation for supporting ACPI, modify the driver
> to use the clk framework only when booting with DT -
> otherwise rely on the configuration done by firmware.
> For that purpose introduce also a custom SDHCI get_max_clock
> callback.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 61 ++++++++++++--------
>  1 file changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c

[...]

> @@ -637,10 +650,12 @@ static int xenon_runtime_resume(struct device *dev)
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       ret = clk_prepare_enable(pltfm_host->clk);
> -       if (ret) {
> -               dev_err(dev, "can't enable mainck\n");
> -               return ret;
> +       if (dev->of_node) {

I didn't notice this in the earlier version, my apologies, but there
is no need for this check.

clk_prepare_enable() should cope fine with a NULL argument - and you
only reach this path, if the clock was successfully fetched during the
probe or that it was left to stay NULL for non-DT case.

> +               ret = clk_prepare_enable(pltfm_host->clk);
> +               if (ret) {
> +                       dev_err(dev, "can't enable mainck\n");
> +                       return ret;
> +               }
>         }
>
>         if (priv->restore_needed) {
> --
> 2.29.0
>

Kind regards
Uffe
