Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1837728F03B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgJOKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgJOKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:32:06 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD313C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:32:05 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x185so1205148vsb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SatyKykuj6+wusU+fkldlSz6zvf7g6aQpEzSmisHQo=;
        b=EH8oOIvPDHGmcjJEUjI+FbC0PcyeU8y82EV3e6ObXVFcyRPXGjcgvogHfmr2Ok5yrl
         VAsQv36g7PijaMu3KlNS9XkgUaDprdHdPjXAoNf5zA+hg1FNGsphd4kE1DRnBCDM0+SM
         WbCmAMjfZPZIVg33dLGDvErXvGinMN8eQj8YPifuuVDJVz/u6tfNcheNyt/XYqZPYB2V
         vmENhjjHg8NgqUlYVkGLikIKl18GbZ7qBlsjuVX0Vw5js71va2Y2MiTvI95yK+6E07MW
         F9A0RD1751G/JW3JJHamGi4iCrbHYq3iYxW6o2Vv3uigGMeG+kjt3MxW+jfwwI4Vq3cu
         W+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SatyKykuj6+wusU+fkldlSz6zvf7g6aQpEzSmisHQo=;
        b=aSVNAWCEj348zDr2wQ4oMqpVEwGB12arMRNLONVeLUBM+CKZzb28KDj8bvIyF0H52y
         hnJ3VjNgbf0stPT1AjtCWxDNO4r7okgDIkK9TDaH4+ZOFzMDZ/4vPgH+8ztVA3KZ5qXK
         xNQXyRE4xQz9lZjWSexvdUaT6eTFzUatYpNywXRLgw/AOY/A+WGAlyWKImoweaO8VARb
         aOrq+Y2VyJr75e7uXUVAi/bV/AkGJeTnwd1GlG7QmVXHtQTHD/u0UQ75ySyHO2y0EE04
         A7c0vIJF67PVd3wDhI8td1xzXqDiQJ8UD3jCgDfO1Di7VANR1vYtaiPrCsasYwKzv376
         jjzw==
X-Gm-Message-State: AOAM532L1075PIPURH9TrhoqHuAKNFrPS0AjMoanvwNBNkZ7J9bnJKe8
        Kc41/+d0C/qfcIYe58HN7G4/viu3eWjCYVmMWlF4mA==
X-Google-Smtp-Source: ABdhPJxuM0JbleJ7I2fLfYg5p+bT/r6vgA7Gd3CFnq+uGIUxv5tWvw3VJ52PgtnsBx/zvJdTZtCOVrdTZ0ZsD3tuGVs=
X-Received: by 2002:a67:f24e:: with SMTP id y14mr1940388vsm.55.1602757925004;
 Thu, 15 Oct 2020 03:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201015174115.4cf2c19a@xhacker.debian>
In-Reply-To: <20201015174115.4cf2c19a@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Oct 2020 12:31:29 +0200
Message-ID: <CAPDyKFrmYO-Y8kxdzz=XLDJPWCv0mwUL374N=RDGvFS-uPTaLA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode
 is true
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 at 11:41, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> sdhci-of-dwcmshc meets an eMMC read performance regression with below
> command after commit 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto
> Select support"):
>
> dd if=/dev/mmcblk0 of=/dev/null bs=8192 count=100000
>
> Before the commit, the above command gives 120MB/s
> After the commit, the above command gives 51.3 MB/s
>
> So it looks like sdhci-of-dwcmshc expects Version 4 Mode for Auto
> CMD Auto Select. Fix the performance degradation by ensuring v4_mode
> is true to use Auto CMD Auto Select.
>
> Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
> Since v1:
>   - add the performance degradation on sdhci-of-dwcmshc explanation in
>     commit msg
>   - add a comment in the code explaining we require Version 4 Mode because some
>     controllers(e.g sdhci-of-dwcmshc) expect it that way.
>
>  drivers/mmc/host/sdhci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 592a55a34b58..3561ae8a481a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1384,9 +1384,11 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>         /*
>          * In case of Version 4.10 or later, use of 'Auto CMD Auto
>          * Select' is recommended rather than use of 'Auto CMD12
> -        * Enable' or 'Auto CMD23 Enable'.
> +        * Enable' or 'Auto CMD23 Enable'. We require Version 4 Mode
> +        * here because some controllers (e.g sdhci-of-dwmshc) expect it.
>          */
> -       if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> +       if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +           (use_cmd12 || use_cmd23)) {
>                 *mode |= SDHCI_TRNS_AUTO_SEL;
>
>                 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> --
> 2.28.0
>
