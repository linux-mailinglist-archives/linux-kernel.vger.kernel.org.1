Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4925A83E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIBJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:03:39 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193EC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:03:39 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z46so1334546uac.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upktra/6N5emKh7zvhc7gnHBaffqMLEbCV10tmOPScE=;
        b=ccyj7iwV1I8JjY1UHxeji0yJ0pPCBmQh8EC8+5I+78EMJ9CJTqGDgzaHKVJGcpJGUL
         hN/9an7B8iC9RUmg2KYdm3DT1NQjzLHOhZdZzmiOWNfSIO4AtpSo8XFy+Nv81tpUbOgi
         xtUNNIXTRFi/ir0DDVeTakmrL/ktIE7C9ruWEnSo7RQw9vytDoJIQto9IHkd8NgzSSua
         HELp1r21BKjxocLn6wedYf4i5s2I7HlGoXQzcuCbbHY2lZtvhg40gFv4d0xC1bBUzeAi
         Ey+JweUb4u3rDmoX4NS3Y6z864knovorET27+g1K4ysBlA5wfSwI+z1sFEoICVsd55Uz
         8Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upktra/6N5emKh7zvhc7gnHBaffqMLEbCV10tmOPScE=;
        b=e5zAK5S7Uxqhvh2PQ2gBwcno3IzJh1GpN9/qWWOGaw0+rWFaa/pPHhP7JNdXHp7kr/
         NDcVE7aJyB1MuB0eBzPIWByPL4gYw/DVqLWSAK+lF0oUy8nFD+PdhCpGztWCdtPrPT8d
         Cy3/dMgNWgG4coU14nN59c761cB7JmmN2NaXk1ID9tt7WLiEexV9gxtcQEVHszc0bZlt
         ySi2MP8aoO/6q+4LfB8oXPBGVEK8+1qqgZE/30HCetAXgK2RzdZqcqQbLKsHf/bHYlW9
         QSWjBuqciUSsfZD6hYIpYliaS+fS53zhtG4XiVYxqWTK4W0jHdh51//uaJr9OPUk79YH
         Ic3w==
X-Gm-Message-State: AOAM530oTsHSC1Hd3wsKrsNB605zTNzwujQbW55ISXbP0bVuwPpEGXWz
        QASHpfg/GK8YiTPLcaE7j79iJ0HMchWcSWZl7BfN+A==
X-Google-Smtp-Source: ABdhPJzpbY3N1DOxGoSiFAa5u53PceFM0ve5E9HnO0kFcgXs6+5D1tRc8VeQ0iGX/g4t/gGuGWsUVm/lRGJnL+dPCkw=
X-Received: by 2002:a9f:2431:: with SMTP id 46mr3660526uaq.129.1599037418663;
 Wed, 02 Sep 2020 02:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200827075809.1.If179abf5ecb67c963494db79c3bc4247d987419b@changeid>
In-Reply-To: <20200827075809.1.If179abf5ecb67c963494db79c3bc4247d987419b@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:02 +0200
Message-ID: <CAPDyKFobQqtjjvTQbZ+MTex2A--5HcTsNT5MGhaLRA52cXuUMg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Add retries when all tuning phases are
 found valid
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chris Ball <chris@printf.net>,
        Georgi Djakov <gdjakov@mm-sol.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 16:59, Douglas Anderson <dianders@chromium.org> wrote:
>
> As the comments in this patch say, if we tune and find all phases are
> valid it's _almost_ as bad as no phases being found valid.  Probably
> all phases are not really reliable but we didn't detect where the
> unreliable place is.  That means we'll essentially be guessing and
> hoping we get a good phase.
>
> This is not just a problem in theory.  It was causing real problems on
> a real board.  On that board, most often phase 10 is found as the only
> invalid phase, though sometimes 10 and 11 are invalid and sometimes
> just 11.  Some percentage of the time, however, all phases are found
> to be valid.  When this happens, the current logic will decide to use
> phase 11.  Since phase 11 is sometimes found to be invalid, this is a
> bad choice.  Sure enough, when phase 11 is picked we often get mmc
> errors later in boot.
>
> I have seen cases where all phases were found to be valid 3 times in a
> row, so increase the retry count to 10 just to be extra sure.
>
> Fixes: 415b5a75da43 ("mmc: sdhci-msm: Add platform_execute_tuning implementation")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-msm.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b7e47107a31a..1b78106681e0 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1165,7 +1165,7 @@ static void sdhci_msm_set_cdr(struct sdhci_host *host, bool enable)
>  static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> -       int tuning_seq_cnt = 3;
> +       int tuning_seq_cnt = 10;
>         u8 phase, tuned_phases[16], tuned_phase_cnt = 0;
>         int rc;
>         struct mmc_ios ios = host->mmc->ios;
> @@ -1221,6 +1221,22 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         } while (++phase < ARRAY_SIZE(tuned_phases));
>
>         if (tuned_phase_cnt) {
> +               if (tuned_phase_cnt == ARRAY_SIZE(tuned_phases)) {
> +                       /*
> +                        * All phases valid is _almost_ as bad as no phases
> +                        * valid.  Probably all phases are not really reliable
> +                        * but we didn't detect where the unreliable place is.
> +                        * That means we'll essentially be guessing and hoping
> +                        * we get a good phase.  Better to try a few times.
> +                        */
> +                       dev_dbg(mmc_dev(mmc), "%s: All phases valid; try again\n",
> +                               mmc_hostname(mmc));
> +                       if (--tuning_seq_cnt) {
> +                               tuned_phase_cnt = 0;
> +                               goto retry;
> +                       }
> +               }
> +
>                 rc = msm_find_most_appropriate_phase(host, tuned_phases,
>                                                      tuned_phase_cnt);
>                 if (rc < 0)
> --
> 2.28.0.297.g1956fa8f8d-goog
>
