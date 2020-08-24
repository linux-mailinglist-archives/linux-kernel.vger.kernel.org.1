Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6045524FA04
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgHXJwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 05:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgHXJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:51:29 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80398C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:28 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id n12so1833557vkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hW+1aw5Oeh6pgOwck0y4yo/HRz1hOBxqvF5QhQOhfA=;
        b=Tyi4ZHVVjVzwqW9yZS2CGb5VIFwkQ4QTO47BzShFY9qAaUl7/0Tb/z8UOLqYQYxFQ3
         NWKzwyU9iDMKu2lo8rVy0o23kY2MFRYzaoJv6WiIjd6o2psu24GN82nPCBKWX/tWJMRO
         PpKGMTl72L8ogYEtjkL0Z+eH1qfs3L6BbIBcSX7k8w3NLAtN7iFmn0ST2BMMqZ0uuBpr
         SkVRJ9fDkNYyzC6d5Kb9eqkxzXzZvVHtU7tpelDyM15z2+mqHUUf6wmbt7WNy7DDhoNj
         FIYA9Irkgdb7oUWHK+I5dDAh7OTjagIIkHR9dcYWKDkVkmxGA2eEldPw0KGgJKBDN9du
         gYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hW+1aw5Oeh6pgOwck0y4yo/HRz1hOBxqvF5QhQOhfA=;
        b=PH23KU0dLBbAlfGFmQNZjZHNrwKxmcNiYqn8GrpfcyOEFZ+hpRM5tQ6i1HbrqICtEU
         geveCansbP48HooM0ztYnx1jJWWdlEhbUnW+HZdbtisa7YhkXYDCXbG3v8dENgj8sYzN
         RdHiksNUvnBpCakC0DMz0dw4q/ZvuNUH1lLLMYHsKjF11dzGKdR0dtYGVsjDJve5i7fY
         xw7/nbOI3LAHgIYuGhL6jhN6nvdkl9xWiuS3orW2n4902XxqJ6je3TeIrHdLLsue0Zyz
         ahspsrc8CgT23tTk1hGXDpP4qo2WbtQKd3bwWA2pAIGatNC7FOEuN826QA3TBZs2u4C7
         sp0Q==
X-Gm-Message-State: AOAM5301cvdETf8HSG+vT+UJ9AzRwTLBNMJeQoaTxq/4gOmb/8kaJ+mu
        W92FZedvuT7WvvLcSaYzFRQTOmsNxDiAXrBsOGSMXw==
X-Google-Smtp-Source: ABdhPJwXWApawg9i+eOmnZgucXcp/gc+rjQ1KDPLPjawInjvQEnTiAThjuEQkek7/NLrzTZjrx+U7ZCQM0btQNcqieI=
X-Received: by 2002:a1f:9d85:: with SMTP id g127mr1986688vke.101.1598262687548;
 Mon, 24 Aug 2020 02:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200814185011.3252020-1-t.schramm@manjaro.org>
In-Reply-To: <20200814185011.3252020-1-t.schramm@manjaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:50:51 +0200
Message-ID: <CAPDyKFoLV1bKSmEfthoLsJR76Mdb2dbdGC2y6vNYAKE2u6YAaQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: fix timeout calculation
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 at 20:50, Tobias Schramm <t.schramm@manjaro.org> wrote:
>
> Previously the cycle timeout was converted to a microsecond value but
> then incorrectly treated as a nanosecond timeout. This patch changes
> the code to convert both the nanosecond timeout and the cycle timeout
> to a microsecond value and use that directly.
>
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 39bb1e30c2d7..f85e0ad896a9 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -882,9 +882,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>         else
>                 clock_rate = spi->max_speed_hz;
>
> -       timeout = data->timeout_ns +
> +       timeout = data->timeout_ns / 1000 +
>                   data->timeout_clks * 1000000 / clock_rate;
> -       timeout = usecs_to_jiffies((unsigned int)(timeout / 1000)) + 1;
> +       timeout = usecs_to_jiffies((unsigned int)timeout) + 1;
>
>         /* Handle scatterlist segments one at a time, with synch for
>          * each 512-byte block
> --
> 2.28.0
>
