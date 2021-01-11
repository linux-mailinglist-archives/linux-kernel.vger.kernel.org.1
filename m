Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9381B2F1D77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbhAKSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbhAKSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:06:48 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:06:08 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id q10so30517vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hIqbsA4z2h5Be7bj6HoZKJF66sCsHJwjbSpsq6eWvA=;
        b=aUlPgCzGPzZzDNtYDzKEyB+O7zqmMVvkT8RMKQLx2BnTm1W/fvnNT4Ne447W02+HK1
         2frubjc9IsAP40/PvfoDBX304y/MU1Q1cHzNL9SHHCcymIrVeUfPtfMgTrgp5z+EiVh3
         9v/JIlo0LK5MICwuuEmV8iWR+ZdNI6m2JH+ZBogOVd0fnpqwR848vGqOLlEgE4DSY22N
         Eh5XPALV6ZpDdbmHNq55mB8kv0dlJ3oFEjBc0ZYpc9S0ZOlZLkCDa9bz9M110rZm+pa/
         zwc0V+q0uCRLOoWeR83URUz3Ijvmj5yOv55kvWYjjNWrSQrMcfzJq981qc3MUOtOnsjR
         RsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hIqbsA4z2h5Be7bj6HoZKJF66sCsHJwjbSpsq6eWvA=;
        b=gCn3Nl1ZQZpZPdi5wrEgOgRzUgw64t1e6w7nrzhhpjrzbcEzSDqiIQxkOdcVtmMmhI
         tCbxJZsRYtQn4lrR6DonTIg7jmvEcbbYk0WEh5P4h3ty/Z9o9ZlfJhuNI72LIwzfqz6N
         EXs/n2bdP1WjjSwGx/PfgJ+K99IrbH26r+swkhMpkFHDXHkuD6ZW4SnEdgW7NNmcquYS
         hwF259U+sFHk29A3zmXar/ImdY3NWYHeMXE7+Hk6o8vpw/MgJB8r0kUYo0vw0VXG7ufq
         Iaip9GcDoD1xNSFQiK4hlwdiNA0uWiERPZH3CKo4eU7rFuXSznlVjR3U9TxwRsyqkqu0
         VLgg==
X-Gm-Message-State: AOAM530K6nuobk5yCb8cpPv6y8NUcCcWcd5v9E/FAGdUg6VKD+wyGaR9
        DeMSgnX3mS/WYFLDEnAl/Vi4zAT95eTWSMydiBeEkA==
X-Google-Smtp-Source: ABdhPJyeYIqH+aQarOVipg/BAePxI08f6Oj9Bi/3WI85Am3nrYgm68R8VtPzjEwjGDaARlcEuWhtOwdmH1AK++XV7Ds=
X-Received: by 2002:a67:70c6:: with SMTP id l189mr825996vsc.34.1610388366074;
 Mon, 11 Jan 2021 10:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20201208203527.49262-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20201208203527.49262-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:05:29 +0100
Message-ID: <CAPDyKFpvjdbWnCD9KRnZAimc_X0CaYS9uCVceuEOX+7THifLpQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs-mmc: Fix a resource leak in an error handling
 path in 'mxs_mmc_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Doug Anderson <dianders@chromium.org>,
        Chris Ball <cjb@laptop.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 21:35, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If 'mmc_of_parse()' fails, we must undo the previous 'dma_request_chan()'
> call.
>
> Fixes: abd37cccd47f ("mmc: mxs: use mmc_gpio_get_ro for detecting read-only status")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next (by dropping the fixes tag as it seems non-critical
anyway), thanks!

Kind regards
Uffe



> ---
> I'm not 100% sure of the Fixes tag, but it seems to be the root cause. The
> erroneous 'out_clk_disable' has then been kept around in the following
> commits
> ---
>  drivers/mmc/host/mxs-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 56bbc6cd9c84..947581de7860 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -628,7 +628,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> -               goto out_clk_disable;
> +               goto out_free_dma;
>
>         mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
>
> --
> 2.27.0
>
