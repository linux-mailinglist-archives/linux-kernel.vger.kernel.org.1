Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B14B29ADA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbgJ0Nm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:42:27 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35430 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbgJ0NmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:42:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id n18so880211vsl.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRBzLxFANfU3G2kDrH38iYpLSy5exX+JwjPfHReW3z8=;
        b=YbhyJgvH8gH8tpgfulJmlDl4MWCGmcYFwXvcGX09Ne7gC3YBWLZsXXapcTZPGq/X4O
         YLUHSZuEcCUDyyxLOn7vI/7GVnCir+BuILQC0N7RqmTORJ5HQyt//ZO93Fdp2Sc0N3dX
         fXEqL2ELRk4sCJrmXZrcm2+W1u4bPGTzkMU3ly8BL+y2dlWWnVf2koe4EWJ69ZQeMGbX
         dMWNtRZs0VfZuDGoGGHKnNm75SKRxMhF/9cl44DBHbrwR4dCPEGYmTKZ/bHSMaeT1M1L
         NvuZIuw389glpYa4t6ZItH//emJ1Qf+LdHyH2nPDOeU5P8VoW/ydu62OATYHk8oOlR8F
         BNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRBzLxFANfU3G2kDrH38iYpLSy5exX+JwjPfHReW3z8=;
        b=jQ4ch/pV+zi3WbaQpBCVGMAmrk3v2K1mdlQ2+AzpOSCbUOuOEZqs8zY2+D+TI/GlwI
         N4Ar/093RcgmAXdbptAqWNbPEC262wKHwJSnaRJ+1h85VxPcUSKbEDH2nrLCjkf5Kr1U
         15JLKYkkTFHDnls4uSPu40okPpFop58c0kkSrU6jTJN+naXGB7u5jm3DlbKKc9fLLfUF
         5FW+Z13r1wGzWdU8GyyXJ/Iw2Tpa/elxORhNpNjhWiBpGe+Xjqiw5u1hJpHuEef5pr0e
         yZLzqIUS+w4Ba1Dv3dPe/Ii4SjrF+4Ict4ll41RxN8BZkCeto8LLx8WOVS7qrD+jyhGA
         QPaA==
X-Gm-Message-State: AOAM530h6efeiuUHacmMuSrhNWiKMiIAr14b8clBFCELUoRMpF/yAMW1
        brle8YcOt1f32VAtPnxo0k0XMo+hCAvCWs5GzDSzjg==
X-Google-Smtp-Source: ABdhPJwdz9hqjK1+EV9J4gvJMsUV5G9FogCC/eBnwXALr8LpB9xme+dc5teAYV4HPS8OHXPs2A9T2KzltAXnCqipCH0=
X-Received: by 2002:a05:6102:41a:: with SMTP id d26mr1541722vsq.48.1603806143952;
 Tue, 27 Oct 2020 06:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201026153810.89512-1-krzk@kernel.org> <20201026153810.89512-2-krzk@kernel.org>
In-Reply-To: <20201026153810.89512-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 14:41:47 +0100
Message-ID: <CAPDyKFpZGEZMoY8nK4p6PS7Odtr23-pJE6EMZstQkFU4B-WdfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: s3cmci: enable compile testing
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 at 16:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can be compile tested to increase build coverage.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 31481c9fcc2e..310e546e5898 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -631,8 +631,8 @@ config MMC_SPI
>
>  config MMC_S3C
>         tristate "Samsung S3C SD/MMC Card Interface support"
> -       depends on ARCH_S3C24XX
> -       depends on S3C24XX_DMAC
> +       depends on ARCH_S3C24XX || COMPILE_TEST
> +       depends on S3C24XX_DMAC || COMPILE_TEST
>         help
>           This selects a driver for the MCI interface found in
>           Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
> --
> 2.25.1
>
