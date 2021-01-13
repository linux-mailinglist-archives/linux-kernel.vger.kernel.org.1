Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9FB2F4A51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbhAMLeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbhAMLeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:34:12 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242CC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:33:32 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k30so920150vsp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YKqseSivN07pOExipzm0CSnXMc2W9yENVH6etrYREQ=;
        b=ewZIG1/ACpd0tugZbt9VoGJMSx5MbiFpyWb/s9oKL4oLBXO2GMmNR5ZqnmmhsaIPsN
         wvdRdsl0APwqxJaiVsphIrRljLX6WoAoF75Il/Ni4Snfrbq/o1iqpFU6Zm7jfk39lElY
         fMvA15R+YA6jfKPZvyUnN7e2igKOJFMhPK/1x1kdHSYbrxF60zBZKk/beJR/3pfpM6nf
         Yea3JGApg0b+oHzdlu1k+E9rvvoBO+x0e/o3RYraSDktuf4C1GQuwU8R7ftoNkIm3mMd
         j3EsUJ3XYnrai7P/4g4AH6cykCPOdYDUvegk7eRQXO0A2KR/0H2YnTEhi7gu33YY1bC5
         v6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YKqseSivN07pOExipzm0CSnXMc2W9yENVH6etrYREQ=;
        b=G4ZDEaGh2y4X9/pfJ+GrKqbSideF2MBE6A/PgkdPehyYf+lc2vGoMbRLgGcv3RNVpo
         qZsT/zJPc1DjokJljbItAz/IKsoMxPgMIqpj1nqjb/FzeYfitshQL8tmwST3nM88R42A
         GmNq7iO5Sa2riatrlspu8LFE8xIk2jig5ly93wfggZkw6FQBiaTIfyjqABAt8Wbva1RI
         OQ9u7+hdIB52Y/hJLu4gc18w0/vjFPnPxU2bXfX2nmY62h8Yg0lOtONXjfIS0RnpdhLd
         vg1fJK8VR28EQRiEplpI3VLtzp25HkVDmDw3OVCfWcSKfiHbagKZFAJ2LbS3olyKss4b
         ZS2Q==
X-Gm-Message-State: AOAM533MytxACXcplKIvx6TacphSOgr7RAC5mGOICatU1lNn5FQCwKsv
        dh9M7mgagS3dUt6howWt5Pfqy9PmNr4bJOfPaKuyYB65V9hLoA==
X-Google-Smtp-Source: ABdhPJyMllODoK52mXu5bEqNNfxetwluwVOGQ/3R/dgnJnIoJpXYBfooMYknCG45gVq+zJBOLOsjpsIXCmgk/+8DvSM=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr1475391vsg.48.1610537611543;
 Wed, 13 Jan 2021 03:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20210113052421.36553-1-samuel@sholland.org>
In-Reply-To: <20210113052421.36553-1-samuel@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:32:55 +0100
Message-ID: <CAPDyKFofFTSZOP=0n_-Qn9RX11cOB1kiJZe8CV3oQ_gSO_Za7w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Ensure host is suspended during system sleep
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 at 06:24, Samuel Holland <samuel@sholland.org> wrote:
>
> If the device suspend process begins before the mmc host's autosuspend
> timeout, the host will continue running during system sleep. Avoid
> this by forcing runtime suspend during a global suspend transition.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 6310693f2ac0..cfee8db7b76d 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1507,6 +1507,8 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
>  #endif
>
>  static const struct dev_pm_ops sunxi_mmc_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
>                            sunxi_mmc_runtime_resume,
>                            NULL)
> --
> 2.26.2
>
