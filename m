Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B408296F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372338AbgJWM0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898202AbgJWM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:26:11 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF584C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:26:11 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w25so738886vsk.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbiM058sppBM2ejB0BKsLTyfit1usvLgD9lTKm1udBQ=;
        b=ROZCwsIRP2IVMu9iOTAMvfqGoXLdd4eDrvuamqNxCT7kMI1yF2ub3ixtnQ2y/MS79R
         d8s6eDXGU4X/PXaPwHuWSq5j+WXU9aExYxJp9eby/IYOmGbI80nYUBr1tVLefYOeciNV
         L9v5hKp1+BWlZFTA8UJGITaIM+7D6NPRl5V+fOsLIm4O8/i1GpytSCVonKaQyFXF7eot
         9zmBawTgHsdb9dEoWzzA896vnMLKqccUd/+udRPFp9Kq3eJxhASbVctIDw+6TP/k/vTb
         Tv2b7vvTwehg7ExRWLoO5VQEPxfwrIyxEg1HFRrR1bGznWIRM9Q5IPU45oRwrUun+aH1
         8DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbiM058sppBM2ejB0BKsLTyfit1usvLgD9lTKm1udBQ=;
        b=tYgjdA1gjYOBbfP+HkkIg0Kzlcf7Ppf7Zp2OHZUObK5GEXK1IDyF1cDDLjouZgTJg6
         vu8syGqNZjEyRYI7TW7Zw2D78vgd39yXZ/bHbS1MNSMiAckMaMo8AANjhRzsf85RWirL
         j8to04ye6CEhmR1qkTjkQOIzoeUt+NtKdpdUvtHoa4llgQDTdLBoey3IXjPdxp4c3m4T
         dHANOzV3rl399s7giyjwV6Yh+ill95eWK69qda+I1llcf12alDAlegviRm2XGtDygqMv
         JD30rIknJn5y/0ZQfdenD5/AnrwCpRTWqIAUzEz997Y5uL4gLZH1/iSkiNkRlELdBey+
         qwHA==
X-Gm-Message-State: AOAM531cylia3Jp5XiNELPxOeKtJIBT9/CGqgppep4BCSa1Qckhy1QZV
        zWWOp5nZo9yY02WIq7DZ2yAi/6B48pypXBEcQ2W4WA==
X-Google-Smtp-Source: ABdhPJwCWRGvbGLHU8VapiWEJeresFqhayakEx40w5ZiKSNlLE07YGg25rKi83MAt/isEEkTOm5D8TzAOtGuWwOF22A=
X-Received: by 2002:a67:6c86:: with SMTP id h128mr1072002vsc.42.1603455970903;
 Fri, 23 Oct 2020 05:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201022222337.19857-1-michael@walle.cc>
In-Reply-To: <20201022222337.19857-1-michael@walle.cc>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Oct 2020 14:25:34 +0200
Message-ID: <CAPDyKFrH=G58fSMExb+QA794BhAXk-NFV2djNRObyHTH9R7W3w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: set timeout to max before tuning
To:     Michael Walle <michael@walle.cc>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 at 00:24, Michael Walle <michael@walle.cc> wrote:
>
> On rare occations there is the following error:
>
>   mmc0: Tuning timeout, falling back to fixed sampling clock
>
> There are SD cards which takes a significant longer time to reply to the
> first CMD19 command. The eSDHC takes the data timeout value into account
> during the tuning period. The SDHCI core doesn't explicitly set this
> timeout for the tuning procedure. Thus on the slow cards, there might be
> a spurious "Buffer Read Ready" interrupt, which in turn triggers a wrong
> sequence of events. In the end this will lead to an unsuccessful tuning
> procedure and to the above error.
>
> To workaround this, set the timeout to the maximum value (which is the
> best we can do) and the SDHCI core will take care of the proper timeout
> handling.
>
> Fixes: ba49cbd0936e ("mmc: sdhci-of-esdhc: add tuning support")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

I am not sure for what stable kernel this applies to, but I guess we
will get notified about that, sooner or later.

Kind regards
Uffe


>
> ---
> Changes since v1:
>  - Added fixes tag. Suggested by Ulf Hansson.
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 0b45eff6fed4..baf7801a1804 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1052,6 +1052,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         esdhc_tuning_block_enable(host, true);
>
> +       /*
> +        * The eSDHC controller takes the data timeout value into account
> +        * during tuning. If the SD card is too slow sending the response, the
> +        * timer will expire and a "Buffer Read Ready" interrupt without data
> +        * is triggered. This leads to tuning errors.
> +        *
> +        * Just set the timeout to the maximum value because the core will
> +        * already take care of it in sdhci_send_tuning().
> +        */
> +       sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
> +
>         hs400_tuning = host->flags & SDHCI_HS400_TUNING;
>
>         do {
> --
> 2.20.1
>
