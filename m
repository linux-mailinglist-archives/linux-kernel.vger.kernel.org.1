Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C812CEFCF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgLDOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgLDOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:39:21 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB8C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:38:40 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id i62so1292212vkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rFsPOyzDEAkhAWBobg07vqGOOi8qrbig0PJm/UVChY=;
        b=g8CObh4D8pRxkse8jIebJ1PeRL+SQhOD/hmBQhqW53cyRN9N9c9dB2F8mdh5b6+U5T
         79sJuW/TGRyTpH254nwe8bXaMCUEgwQnGH/IoD10GG/D+57tYmPY+y+aAT01UxVc8DBC
         euDhuE+X9YYs/Yp5NSBIb6MqjFXYZ5SRcyQIsFMvwl+Oiq60EEoewDsuaby72iMi+Sp0
         HSVQ0e4goFxsnJrSYGJBpkPSEEsad6gASNt1JTvmpqIiDLfPNOOj6Y/b20CI7haVe2yx
         vQ30GbLc+HNlwu4YZv9HfhPX8BHnTwhyjyQeSobT2rQNQkIwCNQILwiJM34rc5P8GpqG
         54mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rFsPOyzDEAkhAWBobg07vqGOOi8qrbig0PJm/UVChY=;
        b=oTujYxb98kuoxVuJpcfF9N7jnnxteRQP1YkIq9HQ5pxmd/I77+aycXd0YdsCx6z0bF
         gz0Nv5dQ2EMwyT+IwTTRB5hTmB94ix8oimCpiDNP2sMkSp+RjuBV6Sx79mWbnWbv7Ent
         P34wfBOzF1WS8p/0Ru5SrkldBBY/Vp9CtrTxsGELze6L6JDgktyx2q1zsgjZppf+zEep
         1yTv+wCCMCki4aWbpSCwhSD/qFnc42kGv5I+XkHhLQ/I8QxDIqetF7WlBG4xZIV0OgTq
         5VBcfJnJFjsw0HXUD5LC8M+qYwZmiJhCkDWyaN+YCi8LrrxCYjfqYQIhmK+gfnoqEBo+
         xM/Q==
X-Gm-Message-State: AOAM533iEBaOEATID/S7s2wTl1QtO8inP/ue7t+WZf/pjpzZvFOngsUo
        KudYvNUESSnZCj6RQc9qjbmGvENNEXZNMFI/txb0NQ==
X-Google-Smtp-Source: ABdhPJz3QI5y2PQEc0bxQyphxPQcoxsWuIeSn5xJpQHZGCLRI80B0b5CqhWoFAsSqbl/eeT5c7RHMRWgnnzQWyZiKVw=
X-Received: by 2002:a1f:8f48:: with SMTP id r69mr3906021vkd.6.1607092719799;
 Fri, 04 Dec 2020 06:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20201125033630.603863-1-jeremy.linton@arm.com>
In-Reply-To: <20201125033630.603863-1-jeremy.linton@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:02 +0100
Message-ID: <CAPDyKFqNqzRD+jMgrvawD8yVsUYCjt5JvNUtYdk48gKh09_eOA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Use more concise device_property_read_u64
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 at 04:36, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Since we only need a single u64 the _array form is
> unnecessarily. Use device_property_read_u64 instead.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index feba64fbde16..ad4ae88a7f74 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>         if (host->v4_mode)
>                 sdhci_do_enable_v4_mode(host);
>
> -       device_property_read_u64_array(mmc_dev(host->mmc),
> -                                      "sdhci-caps-mask", &dt_caps_mask, 1);
> -       device_property_read_u64_array(mmc_dev(host->mmc),
> -                                      "sdhci-caps", &dt_caps, 1);
> +       device_property_read_u64(mmc_dev(host->mmc),
> +                                "sdhci-caps-mask", &dt_caps_mask);
> +       device_property_read_u64(mmc_dev(host->mmc),
> +                                "sdhci-caps", &dt_caps);
>
>         v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>         host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
> --
> 2.26.2
>
