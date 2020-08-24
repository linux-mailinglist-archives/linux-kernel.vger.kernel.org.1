Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE324FA03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgHXJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgHXJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:51:54 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369FAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:54 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id i20so1838135vkk.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2q1ajbiErRira53HKKXrYklVG3PnlJgLsr24GKSESBE=;
        b=fW+0mduXAJo6I00usVYLd80593zek0anWPHqMWg2M/w3DLXpOueIhU9HKiJQoHH6CB
         7RMHX9FGdi13UNc+JEJTIWt/J/udbr+B5Nt25R6/0Kf+mojenLe6j15NWCGTmxFJYJvq
         q9F/aTh7r33Rn15GzhOXIOgW3oLefqKm0t9N1yNSe7hhHsaKdJYx2ob+sb0oBS49Zdvb
         80WyA+2ttjZt0IDoqVYtfhGIFEC/+RUgkRpc4k+pz1vbXfto7qDZPAL2JziGVGw44F+Q
         Yl7GgcXkvIKeQWWCC9OxELndNMl5N63p0PLHj6Eko+s9i8AS3wOL5LddhkyxYEgPRSYq
         VEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2q1ajbiErRira53HKKXrYklVG3PnlJgLsr24GKSESBE=;
        b=e6g6cpggaCFxY5dcn8tafYy5CZYTlAYPKbpVJQrKKJUdBiuRuPQJRd8OsA4vhxd1Om
         YV5p8kTyxO7t9m3gOO0/RxLRbxl24LuHN5KiZSD0KEIRBnOv40mDZLm0ykGlv3QNL5AA
         8hOxtJM0ISBSmggwsphximUIFUDkRtK4+XnJJu3Hog418KAPrLX/tx6mwdIb2ivvH3v3
         l84E4k5BKmZ/CCLSF5pu3os+US+GjQXIo0BikX4Uyef+1xqSbxgMncK4qEj63AhAmp8H
         ikd8kE1ojov7DLm19NcKwHWQmc9rDJ4zZ2TYIsKnMbL+1vcEJ9/Av5Q+aqZ3mQpQaknz
         upKQ==
X-Gm-Message-State: AOAM5308CpTAKjNqlNvatQkSk+UwLTUjI0GBTOfCyiks6H/O6ca1eom8
        LghdacT415IX5mEFNmk+JoIoAB2vQRnEMvfQiKpda+J3CLMOLA==
X-Google-Smtp-Source: ABdhPJyroNBl9bu8cbvuTbtyDsOW3xnOs02H7+FfHBFmEDiB/7+UTI/z2QyyFgKHQXBMWQMkSGOzbbHpaTNuTkxV6Zw=
X-Received: by 2002:a1f:7c45:: with SMTP id x66mr1996597vkc.53.1598262713413;
 Mon, 24 Aug 2020 02:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200822061528.7035-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200822061528.7035-1-madhuparnabhowmik10@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:51:16 +0200
Message-ID: <CAPDyKFqEtSuODBNSgt26gn9k=mHfnCcbN=LjR1BeCmgAM2SXwQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: mmc: host: via-sdmmc: Fix data race bug
To:     madhuparnabhowmik10@gmail.com
Cc:     Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 at 08:15, <madhuparnabhowmik10@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> via_save_pcictrlreg() should be called with host->lock held
> as it writes to pm_pcictrl_reg, otherwise there can be a race
> condition between via_sd_suspend() and via_sdc_card_detect().
> The same pattern is used in the function via_reset_pcictrl()
> as well, where via_save_pcictrlreg() is called with host->lock
> held.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: Rebase v5.9-rc1
>
>  drivers/mmc/host/via-sdmmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 49dab9f42b6d..9b755ea0fa03 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1257,11 +1257,14 @@ static void __maybe_unused via_init_sdc_pm(struct via_crdr_mmc_host *host)
>  static int __maybe_unused via_sd_suspend(struct device *dev)
>  {
>         struct via_crdr_mmc_host *host;
> +       unsigned long flags;
>
>         host = dev_get_drvdata(dev);
>
> +       spin_lock_irqsave(&host->lock, flags);
>         via_save_pcictrlreg(host);
>         via_save_sdcreg(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         device_wakeup_enable(dev);
>
> --
> 2.17.1
>
