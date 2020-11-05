Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5D2A7F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgKENAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgKENAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:00:01 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9BC0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 05:00:00 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id q68so483874uaq.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 05:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7NcZx/oSdkYK9nn1pweWIk2stuxNmZW+6aZ8xIAheSA=;
        b=a2qltg2ZO2ve892U8tNPLNFReFupQUvEd+42PcGc3wyyE0rdCVDXLJo9Xy/NM2UgdR
         ybjgg1ik4ekokumzQ72UxxZe7zFZ4w0oT+4UE1zbNjuHtlu5VCsMqr/pHtBiKwV5RH8G
         C5cSPkBF9YdLpJEHAwja99I/V12g38cHvCqrt7KQ9js9BB++8nvgMHfbKm3I9tGEngtG
         HIKMBU2X+K+yG6NNTbA0XGSVNJT7pGwCGp+ActTQQRLCHOI9GufpGbI7Z2mNbQbDOBgU
         WWpC8cdMqHtMUDN7Z60ELLJAWumg8aMcA+Ql6y3HhlkLih3K+iGVPalHjboalGGbNRxy
         45fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7NcZx/oSdkYK9nn1pweWIk2stuxNmZW+6aZ8xIAheSA=;
        b=BCwmH3sddGCS+FmF1vcHx8bOwO9KmzMD82QPlCMl6kbxF5b38VAfM9s1SfQ1kjCm9a
         EI/8rpBaBzE9cGLNokma539uskx4Wc9WH7nNNs1aaQirbkuEQn8RE1WcKykQ9apnK7s9
         TcXJRcq3GD6ljBidr/lDzhjDypA71Lz0y81d1XGrJsdrjc+NFKjPtDyuzwsa/7qWuEm5
         QZSZ9WkHkbhgPv8PtBxb0KdwhgODQiYNw5kBuS2S5Cc6z9ZmKDn12MrG4m1HFCg1acn2
         PLWn6hmobcg70AKwUA6sGgtz3G8K9o8HVfB2fLMHoAjINv1BWtrQK4ei2A4rKZFtJC/Z
         cirw==
X-Gm-Message-State: AOAM530a0jUq9yJqhuw2DIBLyvsG/yodGnTJLyg9ERQUEynCFX/8h9BN
        8en93krXJ2YfuWGJM7DlEYSlmqjAXWKqHoj4U308qw==
X-Google-Smtp-Source: ABdhPJyKvAtWA3o6fvZdEP1FXq5fTD1wQx5C/9iCOEtWf1JxjYK3WnwXGODCRXocBQ36+Iib8od5AOXX7f8O8Jguzrw=
X-Received: by 2002:ab0:140e:: with SMTP id b14mr886025uae.100.1604581199978;
 Thu, 05 Nov 2020 04:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20201103163046.14336-1-krzk@kernel.org>
In-Reply-To: <20201103163046.14336-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:21 +0100
Message-ID: <CAPDyKFoKt9pwu=GC0hE7ogVJv=h6NPUjSvk7uNVmnf=FDPWh5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 at 17:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF && !CONFIG_MODULES):
>
>     drivers/mmc/host/meson-gx-mmc.c:1252:34: warning:
>         =E2=80=98meson_mmc_of_match=E2=80=99 defined but not used [-Wunus=
ed-const-variable=3D]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index 4ec41579940a..13f6a2c0ed04 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1265,7 +1265,7 @@ static struct platform_driver meson_mmc_driver =3D =
{
>         .driver         =3D {
>                 .name =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table =3D of_match_ptr(meson_mmc_of_match),
> +               .of_match_table =3D meson_mmc_of_match,
>         },
>  };
>
> --
> 2.25.1
>
