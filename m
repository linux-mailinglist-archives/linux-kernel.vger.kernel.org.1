Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C45290388
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394530AbgJPKyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 06:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394145AbgJPKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:54:03 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D5C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 03:54:02 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n141so516694vke.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gX7X4zWON0bftlFn4XXnLtE0UHVfpOuxgLEkuD6BtH8=;
        b=dQnevoKfC82sMyf+qVuml7qjHoxc5TW0sfQ7sNI7/vcf7td84Nm8vc0D4qztkYvbjg
         D4QPcADffWm1vRbOYhu5GPyh7aNvwm/rC7m7f8sERjaUkTnVvJs+xGnxbOaz+LZ2apym
         do0c8boqX+VpXRCnVAtRmW+Qa/UvmHG7p7a+4rLJcAxRMLs62Xv+8W275WbmcAtmZuhe
         TIYuDTt/vtgtT2GymrLRh9Xjb7wmeVqB3IBkH8EHhzYC+LydEctuFGdrBoM/qUn4Ikti
         IVmi/XbUC4t9LMwnz9oPaVMBH0eeSghLb/4707vpTgnDsLheKJEBtvDkipVZiLuXpuTO
         xRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gX7X4zWON0bftlFn4XXnLtE0UHVfpOuxgLEkuD6BtH8=;
        b=bf2oVdQLvB6q6O8Aw6bm/qPic5r+w/yxKCyDyrBZ3Uuc+MBvq7GQRjSTKDLzb9Z0Y7
         jFGLYR0MepmZif+cf/LWjo0mt/CyZ/lhb0321TKorfREhr9hXEnqCY8mZ/9wQvEvQdrz
         aMTlTaVPKhyXfIGbnb542HIwVVgdYS9rhQWCP0eE5uZY6Wah4DRzT4m6L3NvcZoCSgGb
         YZOSe7YEGiMhUSZknws7+WiKx1hK5h9YR1ckVjOwXzWyqjpT8APoS9anKKjvGQ3lDKfj
         vWEIaQDGKZ7+TSwoweCWw3S1XJ7A/wnHipP+dekU0urWD80DDGF+4783Z4rIsCTgalyJ
         dnIw==
X-Gm-Message-State: AOAM532GRU4G2GTfSmNPTnS0n2aRNSJbtP/0nHP5cB38D1DSLs1bHppB
        xtck/BZkdtQmHjPOIXF/4rBKz2+PgTolBE5M2AelZkqtnwLKbQ==
X-Google-Smtp-Source: ABdhPJwRGOKSJtz3Xl/5ArDppme07QDTdwyCpTxliyHHyXa2VlbdoIaHwMP5skx9ZyNu3ZIs66hrCYviZQzcdzVjhV8=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr1722731vkk.6.1602845641921;
 Fri, 16 Oct 2020 03:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201015231149.9333-1-michael@walle.cc>
In-Reply-To: <20201015231149.9333-1-michael@walle.cc>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Oct 2020 12:53:25 +0200
Message-ID: <CAPDyKFoMmsYhwvNDdprtWiY+EMjXQx5uFvn4+fHmCG8zj6aryQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set timeout to max before tuning
To:     Michael Walle <michael@walle.cc>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 at 01:12, Michael Walle <michael@walle.cc> wrote:
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
> Signed-off-by: Michael Walle <michael@walle.cc>

Sound like this should be tagged for stable, right?

Kind regards
Uffe

> ---
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
