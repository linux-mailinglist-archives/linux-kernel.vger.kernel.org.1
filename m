Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2102B5EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgKQLuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKQLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:50:55 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E4C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:50:53 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id u24so10871973vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gq4awtwtwe+42elAveTI63NHsmqO5Q81Rja7faE+b54=;
        b=AFWLA+790ristxt/kCJc1HcKOy0wktlLiQAECi9QpbkFW2SRevh8ICAGIqD+ON16Xg
         ZZ1qBA9LJDr7pJz6DP1HJhMAg/mxEidRakQJF0pQS5xyhLS3i6CFydJ2RNoaDul220in
         t+kOIr05HWMbeQDBVbaYl556mUj7A0HHjXC3hgtOP18iFwUxuwsJW8hXTHVijq1IvCFn
         eUOrn2+3YG/No59+rA1EDQkM9Vedc+za9tFR/uBcjc7DmMt6YZX5FI6IXtmImEdcnZI/
         VtsWuZQfCNCC7XSl1ZOIDLHnK415TJ9+tac8d2xPFD1opoFRheuBmtG+jQTHQslbn1a0
         t+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gq4awtwtwe+42elAveTI63NHsmqO5Q81Rja7faE+b54=;
        b=dOG8OQAN5zJCP0gMj8esN9/S9Y23Xddaa1rW2MSfg6Xk6DzAZPdQju5gNWQY2VPxdG
         eF723f+Y/SvQii+PgEcHiU+eViR2ifHU4+wkjbvKR7HvAFvMI9/CIQjvR81NpmHTxm+5
         Oifkenzcc4vBFqQSWdgH1G8prSDb2/FiXA0PB05DxIU+54YFp30x+OXfm6n4VnT8sls0
         VnqVr5o4op3OLhhEDhsNlYxzDBOIRpM1pfN2+RetWmzkllBsw+DxYahJziBs37sU7ptp
         ADF7yXLREGXyG0Mhpq6u+nZawWLcNEJO5JzOxjVvr9VG+KsAL6hOGj8oah51TUczkPpr
         YlTA==
X-Gm-Message-State: AOAM5305KnNQjsj8bHBTaOFsxZm5bm842/tl7+iIt8Wlh45IgeuthUOg
        c4FMPnHDMDTIdytfd/vysxuTJF0ZalILaVz7VMLqhA==
X-Google-Smtp-Source: ABdhPJzzBQNaTzVjzhO7R8CpIuSG7UXe3q1rFsbVtNyyRKvtbf1P8EewU5WXXCH8IeTff5cD+ahoNF/8TvGhVFVt/Wg=
X-Received: by 2002:a67:683:: with SMTP id 125mr223849vsg.34.1605613852868;
 Tue, 17 Nov 2020 03:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20201114120819.416311-1-colin.king@canonical.com>
In-Reply-To: <20201114120819.416311-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:16 +0100
Message-ID: <CAPDyKFpwFTEPLHZC9uT9mff64Axo-2bBjGVv4TGEcV4pGwWmig@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Kconfig: fix spelling mistake "hardare" -> "hardware"
To:     Colin King <colin.king@canonical.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020 at 13:08, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Kconfig file. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 310e546e5898..7324a61d7416 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -664,7 +664,7 @@ config MMC_S3C_PIO
>  config MMC_S3C_DMA
>         bool "Use DMA transfers only"
>         help
> -         Use DMA to transfer data between memory and the hardare.
> +         Use DMA to transfer data between memory and the hardware.
>
>           Currently, the DMA support in this driver seems to not be
>           working properly and needs to be debugged before this
> --
> 2.28.0
>
