Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64F2FDBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436626AbhATU71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbhATNmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:42:01 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7933C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:41:17 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id p20so5770444vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3rkP3sTkrcG+gjHiR+284Vvr0UULqneoyGJYqtXMhY=;
        b=RRW2kvSzIJp4rJU/Kqn0fcqX+MmV/Rxfbu+0qeGnPqTQaCOSEFO9jzWYxtlEpylmg1
         0RaOwqsIYS0IPUR3OqEfujosWXn0PpeJdZKSKTpcms2WLPBcbCT4Oh4jZoIxRslPJ1ef
         dXB6mDJ2KxNjURiaak4Z9QrP26A55ZankVQ/W1XEcDgv23sqhlZtsATp65kA80f6L3NT
         tHn4DTKyog2t34FT4mcVSAcYbEATj0jxc2UiNYTQ9DheZfUlvrz1qKilmcufjaKsUOP6
         zl6xw3M3idN4j+LCiHNC311d+yjNd4diIr1qUFftwi+F22WXlrqSkwjs60fS1V7jlXcp
         RYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3rkP3sTkrcG+gjHiR+284Vvr0UULqneoyGJYqtXMhY=;
        b=XP7Fn2FFpiPYMxj8Q2LUmu1yLQUCxcLyFB0hdZWk84AZJ7Ew6F7ef0GZSBfvoitrqY
         oyVhp8R2VNJrULrv/7WXQzbA6fXnVlTR5hsiQLouOVe22ecLSQ9haw0J9CPYgx8zo7hY
         X6itFW463ICIN/kW6Iipt6QXJ+sX1lcjEKIaWPNPCbfSCt4ZFCW2iW4wTxeePM8+RWOR
         O3eWSS0EO+3tUqfw4dM69gFP/12cPggu9tM4FfJFTz0hkwM9Lw0Jl7fmyfUsfeAY7C8y
         W3Vjn4IIcaCKQ2KncfgT7Fbaqe0WXHfCr9FvpTs9POGRyU0GDkeLANVQTrsXgkvABwxl
         Cmsw==
X-Gm-Message-State: AOAM5334N24I6LHbDN0q9bvQ5Q6FpS/UxW5HGy2Z59GB3ibwVEiyWqgQ
        gdM/mUqJWunZkKxAOUj5Ug0WMOrutDxlVIzUumGBlw==
X-Google-Smtp-Source: ABdhPJzBqLW0bV1P+US75mAyLIbxmsCSRB1Sa7MywrWLUGSxtciKJ5Z6c6+1S9PAMrKFwB+6/zwn1h0zDkOfj8dx9TQ=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr6403069vsd.55.1611150077036;
 Wed, 20 Jan 2021 05:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
In-Reply-To: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 14:40:41 +0100
Message-ID: <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 at 05:27, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>
> R1J57L mmc chip hw capibility indicates that it supports trim function,
> but this function does not work properly, the SDIO bus does not respond,
> and the IO has been waiting so set quirks to skip trim

Are you sure this is an eMMC problem and not a mmc host driver issue?

Can you elaborate more what happens?

Kind regards
Uffe

>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/mmc/core/quirks.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index d68e6e513a4f..63e02391c133 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -89,6 +89,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
>         MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
>
>         /*
>          *  On Some Kingston eMMCs, performing trim can result in
> @@ -98,6 +100,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_TRIM_BROKEN),
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
> +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_TRIM_BROKEN),
>
>         END_FIXUP
>  };
> --
> 2.25.1
>
