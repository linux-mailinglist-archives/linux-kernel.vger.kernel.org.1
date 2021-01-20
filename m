Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116062FD713
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbhATRcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390163AbhATOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:09:03 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:08:22 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id d6so5664783vkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yuYd0oPowGkxYlpvWp25gunp0Rm2AZcot0EW1oLqcA=;
        b=QeF5IRoVM/96DbzFmBtOzGI6ulIok9zjigjtK8VxGGgoPDH8H2hZmMljVyXmV16d4e
         4Yw9niP3Bp3SumCYp/oXmRBF4y73ZAFaiPFd8mczeWnJJRW97lkvtk5W176tdmk/zF5e
         y4lB2tM7w27Yr0I1rhzioyg3OqsRT7Kf/KU5HdM7X950uyilAIyV9sqjDB7s1/94+my6
         Wr7ommEraRK8O8SE8b5w6cB3CJwH4/qkhff7gKNJXPfCMR8+7GTZtpXXL3XLFkxN1Hq7
         ThCaD2fcrZ5GvacUXvKvOpro4wW2om/8o8Gf9OSpxzgzAB+8J/pq22lUHXqsd8ywCq5F
         JV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yuYd0oPowGkxYlpvWp25gunp0Rm2AZcot0EW1oLqcA=;
        b=fIe3IIZVMpRnHHJUYTphosAi4Rw5sVWkSBaqEh1RCdJcmUiV4kOK0wXJOgsX9OO80G
         04b/H+apNk9thZ2LJp0MyvksLAkBV6ovmpZyIaIxhvPD3TdLlBU34midbGiCG/x5m9NN
         nmk+QRsA7Bj88WoQRQTruk0pmDCdWFGIXNd+VRzQpFWs8504vVMNPmvhhQy45ZN8Vcgl
         45jVPxlwEFEA/1eNrjld7Kcy8Jh2hwLmfqOILrxBAHVpHypRvePIOJdOv7wYpJ9a+sH0
         dPAV3NX2XFzha/VqrDNX4Tbh/8DtFsIjg1AlrfVe6rnxCV8/6HF6R8wCtvPSce0Riiro
         Vm3A==
X-Gm-Message-State: AOAM533SCZakBqewGpEwv83YByv8ikuhqfq1GoHUUBxw9JsBzVKnAfLL
        BCff6l8NsXLeOgYo1XEvqy9YvT+EqOGm8S47S+yXSQ==
X-Google-Smtp-Source: ABdhPJz6M+BPmVNSztofB1Zs6zVNJhx0ylJZX8DRD5+bAXaXzsmmpFnRhJVy59llitExc/bQP68Mp6bnlSXbhvaOpKI=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr6975512vka.7.1611151701878;
 Wed, 20 Jan 2021 06:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20210118084520.241-1-zbestahu@gmail.com>
In-Reply-To: <20210118084520.241-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 15:07:44 +0100
Message-ID: <CAPDyKFp4h=hLeeoCHKqGRx3V0TabiT1dDO4FTCPnkukm=Wh-ew@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: remove unused host parameter of mmc_sd_get_csd()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
        zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 at 09:45, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> The host parameter is not used in the body of mmc_sd_get_csd(),
> so let's remove it. Update related code at the same time.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: fix minor commit message.
>
>  drivers/mmc/core/sd.c   | 4 ++--
>  drivers/mmc/core/sd.h   | 2 +-
>  drivers/mmc/core/sdio.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6f054c4..6fa51a6 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -860,7 +860,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>         return err;
>  }
>
> -int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
> +int mmc_sd_get_csd(struct mmc_card *card)
>  {
>         int err;
>
> @@ -1046,7 +1046,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>         }
>
>         if (!oldcard) {
> -               err = mmc_sd_get_csd(host, card);
> +               err = mmc_sd_get_csd(card);
>                 if (err)
>                         goto free_card;
>
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index 497c026..1af5a03 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -10,7 +10,7 @@
>  struct mmc_card;
>
>  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
> -int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
> +int mmc_sd_get_csd(struct mmc_card *card);
>  void mmc_decode_cid(struct mmc_card *card);
>  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 694a212..0fda778 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -751,7 +751,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>          * Read CSD, before selecting the card
>          */
>         if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
> -               err = mmc_sd_get_csd(host, card);
> +               err = mmc_sd_get_csd(card);
>                 if (err)
>                         goto remove;
>
> --
> 1.9.1
>
