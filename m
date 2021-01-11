Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBD2F1212
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAKMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbhAKMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:04:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0789EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:04:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2so10823531pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yct/bRwX1SOlF2lOdkoL6Ak94EKf/2hUDGXuoWe6Kh4=;
        b=bJ0XLRD1wmt8vA3mfkwBDMlgMH3i45cBOJeQ+twPiCTBeY576PgXIRI0cNkF6GMYAr
         HSlOS6W+C6+PFkBQvZxoLrC7C98ZccEVnUKI1FXoI92ZGCgQ83DhlN2gqBuKayVsdkUp
         Ymm0Y/4rJk6WT7ZsMnc3ITvuLVOhY2lVz5Hh1x1/vbgJFC8ZNs7grm03Wb5+7xTM0H2a
         mH6MW379K2XOEvz21RDhXjFZl5gdsf7Ds/PtEBLBgoNhtNZTOEI/YkmniyG+6HHhtUU3
         TfL7JTINTe57ojfu1BdULcNSd1740zHMO9hjL/ktHHBCeSz61ZDIOI27c7R/HzlopOXt
         pLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yct/bRwX1SOlF2lOdkoL6Ak94EKf/2hUDGXuoWe6Kh4=;
        b=mGpb4bF6LP71rGCZXCKUl1yDzKJtqYDxYLlOo/kXOcMNCNDt3LkIWCuPdCGYy7EJjc
         ZJ5TA6TFHByoXn4Tb9TzGR4KJvzndbeNP3nvh8HefIFVrCI1d9LIHnWDRm/r/u6KEEr+
         4pUyEkgcwAdWBOIlYyGv90BNDp9mhdKm56JwwkNuYLo08pnaVSNMs9EGfN93Yj7DJD5a
         ABNNn7riuaHbOwfOnoaGVL8TUZSAcA5PMWQJT4HRtLI1T1pKRhgHjSJ+4xkEAVdJd0Uq
         qHkdgJZc6F/WB4vDmoSHPocuJFppe9dc6kXFci4MtuH22ScFOZYLPSeqAXRkxaNwfY1V
         Riag==
X-Gm-Message-State: AOAM530c045OX/Kv6vLbazW9Z3wmWw4yzHo4ct4m7dY37lhLO3LFWOlI
        9R3qPmSkZ+ljcANs1ptk0Gk/7ouQPvxLA6B17uDH5A==
X-Google-Smtp-Source: ABdhPJxrU59cCksNCY7xbJDFzx3T/kHxDH8+ym2V0QgLeeabyX7cdjCLMlGoz+9SPzSnjJ4aObbiaOTZEixtWEvCxSE=
X-Received: by 2002:a63:e151:: with SMTP id h17mr19160314pgk.120.1610366646297;
 Mon, 11 Jan 2021 04:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20210111115930.117393-1-robert.foss@linaro.org>
In-Reply-To: <20210111115930.117393-1-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 11 Jan 2021 13:03:55 +0100
Message-ID: <CAG3jFyvymhoMdewsWg6inTdoBYDEBmCjfnPm-d8E+-9H1OcL6w@mail.gmail.com>
Subject: Re: [PATCH v2] media: ov8856: Configure sensor for GRBG Bayer for all modes
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@linux.intel.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darn, this should have been sent out as v3.

On Mon, 11 Jan 2021 at 13:00, Robert Foss <robert.foss@linaro.org> wrote:
>
> The previously added modes 3264x2448 & 1632x1224 are actually
> configuring the sensor for BGGR mode, this is an issue since
> the mode that is exposed through V4L incorrectly is set as GRBG.
>
> This patch fixes the issue by configuring the sensor to always
> output GRBG Bayer formatted frames.
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Suggested-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> ---
>
>
> Changes since v1:
>  - Sakari: Added mode information to ov8856_mode struct
>  - Sakari: enum_mbus_code updated
>
> Changes since v2:
>  - Andrey: Switched approach to changing the sensor configuration
>    to yield identical Bayer modes for all modes
>
>
>  drivers/media/i2c/ov8856.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 2f4ceaa80593..8a355135c7db 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -428,7 +428,7 @@ static const struct ov8856_reg mode_3264x2448_regs[] = {
>         {0x3810, 0x00},
>         {0x3811, 0x04},
>         {0x3812, 0x00},
> -       {0x3813, 0x02},
> +       {0x3813, 0x01},
>         {0x3814, 0x01},
>         {0x3815, 0x01},
>         {0x3816, 0x00},
> @@ -821,7 +821,7 @@ static const struct ov8856_reg mode_1632x1224_regs[] = {
>         {0x3810, 0x00},
>         {0x3811, 0x02},
>         {0x3812, 0x00},
> -       {0x3813, 0x02},
> +       {0x3813, 0x01},
>         {0x3814, 0x03},
>         {0x3815, 0x01},
>         {0x3816, 0x00},
> --
> 2.27.0
>
