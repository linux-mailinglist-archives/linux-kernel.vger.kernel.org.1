Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875712C0FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbgKWQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKWQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:07:36 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:36 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id w190so2231040vkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erW0XIM+2y9def48xOpIc4QdS/vND+3STJwJE9GzrvM=;
        b=NpylciofEhMTaLNdbM9e1geQueViMrm5kQlxx0uBp9N20vNsPQ0MItUfE46rsSwk7u
         8zw+2Daf22S1TPyrUA44QJskC0ltQVAadvRihxTvO2RS/jyJOdmwDEPQZlny1uARVT+o
         JTjp6WxOiNcj53fPMYHi4ZUL+IqdrOV1xDDzF6ZWkPPG4y/5pnOnIhyNJ08z5juS3qxB
         UiZqpb5KOm6S+FzbPVkF29sMKBfbSj8246AclN3e2BTpDxz0lUuI7/dkYZvj3cC2wp88
         yg4mFV2ORDKYktD33FA/mgnUvMfD/W+kPHfOqYc93ARJL/Fz/WO8ZBMHOBp3fB9X6W5e
         BwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erW0XIM+2y9def48xOpIc4QdS/vND+3STJwJE9GzrvM=;
        b=ZWGVveaOzSAebyMylBRPdp3CIb+rgnpQzVvMILcIPOnzuHzwUdIyEtOM8DuP0YaHZA
         BTXHG7lrb+w9Ud9clYJbUhUQOjpCxk+NZxFlZG+lKO5ltzTdJkTmQ83afCC5k47VXYIH
         Gqqd7LgfZjmLUkouaKIqFiFCwUwmmhkhMX5qS+QONjf37VsStRNrznZFL6V0oVFQVf3S
         Vz1MTiVsNIIIE4DWpAYKwRYP8DzdbC9S9/UWelGsND+filCsaHwfqEYLdAezqmUR8rqy
         ybJ2MTopomt3OV9q89mnY46Es3KnTPxfy/dDCNZ+uwMkvp4z635vHasn+F/De4z9kauW
         IFfg==
X-Gm-Message-State: AOAM531ZUmpvSFDUyOKn3vQWm1R7ZTrFlouGGxnlWUKWGSspAQNj+m1Y
        HNJc3TDJpIS5ldbKdrsPQTK7fxFeN405a913HNSPDQ==
X-Google-Smtp-Source: ABdhPJw11sLZpk2iJcw5H2+UztqwfIK1pCCTH30flHi05HVt6b1JKFFDYFDtFUO8SBtnEJgqK+HLHZ1Lkfe1gIXhdfs=
X-Received: by 2002:a1f:8f48:: with SMTP id r69mr430105vkd.6.1606147655157;
 Mon, 23 Nov 2020 08:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20201119030237.9414-1-yong.mao@mediatek.com>
In-Reply-To: <20201119030237.9414-1-yong.mao@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:06:57 +0100
Message-ID: <CAPDyKFrqVoMQNDFhhqbiEJPtw28iOzMvZg6rRoyCEA6oTRq85A@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: mediatek: correct the setting of recheck_sdio_irq
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Fabien, Mattijs

On Thu, 19 Nov 2020 at 04:03, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> correct the setting of recheck_sdio_irq for each mediatek SoC.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for fixes, by adding a fixes+stable tags and reported-by tags
from Fabien and Mattijs, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fc5ee5df91ad..d49e5ccfca9e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -463,7 +463,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt8135_compat = {
>         .clk_div_bits = 8,
> -       .recheck_sdio_irq = false,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE,
>         .async_fifo = false,
> @@ -502,7 +502,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
>
>  static const struct mtk_mmc_compatible mt2701_compat = {
>         .clk_div_bits = 12,
> -       .recheck_sdio_irq = false,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -528,7 +528,7 @@ static const struct mtk_mmc_compatible mt2712_compat = {
>
>  static const struct mtk_mmc_compatible mt7622_compat = {
>         .clk_div_bits = 12,
> -       .recheck_sdio_irq = false,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -541,7 +541,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
>
>  static const struct mtk_mmc_compatible mt8516_compat = {
>         .clk_div_bits = 12,
> -       .recheck_sdio_irq = false,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -552,7 +552,7 @@ static const struct mtk_mmc_compatible mt8516_compat = {
>
>  static const struct mtk_mmc_compatible mt7620_compat = {
>         .clk_div_bits = 8,
> -       .recheck_sdio_irq = false,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE,
>         .async_fifo = false,
> @@ -565,6 +565,7 @@ static const struct mtk_mmc_compatible mt7620_compat = {
>
>  static const struct mtk_mmc_compatible mt6779_compat = {
>         .clk_div_bits = 12,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> --
> 2.18.0
>
