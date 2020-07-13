Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6021B242
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGJJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgGJJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:28:36 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58980C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:28:36 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id k7so1604865uan.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOW30LWGVGgHDsxnHhurzdv0a/FILHUvG2/DHcNZoI4=;
        b=bnzvDGU7zXPbziIdRdVi4TSs+noharSMJVfDTIbjqh3RuVKK0nJ/VBqVGTnruLQFrY
         vmR4ws08bcS0UMCkkHbGcBXfdnkR+npTr64BVmBubl8z4WwpMcjFUcwHYJj93aKf4FsJ
         QEj9jZ1WNwB+nj5QMKwXZr5B7oVkw9qdSc9ly0GTwz1qV6LcsRGQ/2ge18PSuOSniSZB
         baYZCaXWJFE6BvQl53n3P9QVXZZWmoituUaX997p1PsqkypK8K+4/5bXQk/ECjb8kY+A
         +VprU+YP1ApyUjZlgGBpCkkk++TTfNmGpn+fbjEAKQ+AtAJKQkbxmHKvjlOAHONidE64
         kliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOW30LWGVGgHDsxnHhurzdv0a/FILHUvG2/DHcNZoI4=;
        b=CYvULI6Vg/2PLaVAvVAj94sdJv5qPsHl0HBj66/va81g9MhRtOFKeDBLF8LNBKutQF
         g5zuBEew3/FenLfST12meZPASL5caSIgB0SBufUJbYgeRpa4d0LjtDH3Vof9D6S5bXxn
         XePwditOcORcXvVKHkGUnznNkcuE2NXpw7sUBkF6q+/u8gFQCpx8g7rQWPL2zWTwKq+x
         dwPwUwkt0ZwHpLuM99/UiZMVan4C25hIStcdLeto8oQkBmTwkNQsdvgqqAm/oljiX6xi
         3SGp5Jk1uhqc66ojQTPpov+yyW5EzK925cowQmyuqIWNTl/MDpUhIO3n71VmRD7zKCt/
         MhWg==
X-Gm-Message-State: AOAM533Tc3Eb/aOmZrQ/nZysndbi7EQ2KeRLitGSFyNlyB0leHHqrrks
        ubOYd/nK+dRjRjebBhPZljMlvLAouKj2XnYRSsKQ8afw1DCIow==
X-Google-Smtp-Source: ABdhPJy4KIKPN5ob6vqVPh6sGXXql1ac/vvDAf9OLPrZvxX6hts8s3kXcH1N61pqeZYYgTXA6zHbse8yWmaHkz76pWM=
X-Received: by 2002:ab0:4e98:: with SMTP id l24mr17930390uah.15.1594373315479;
 Fri, 10 Jul 2020 02:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200709195706.12741-1-eajames@linux.ibm.com> <20200709195706.12741-3-eajames@linux.ibm.com>
In-Reply-To: <20200709195706.12741-3-eajames@linux.ibm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jul 2020 11:27:59 +0200
Message-ID: <CAPDyKFrUUfXQmsrXd8TpSxkyq6up1ZRvwYwrWPsSpCibsxJejw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Fix clock divider calculation
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 at 21:57, Eddie James <eajames@linux.ibm.com> wrote:
>
> When calculating the clock divider, start dividing at 2 instead of 1.
> The divider is divided by two at the end of the calculation, so starting
> at 1 may result in a divider of 0, which shouldn't happen.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied for fixes and by adding a stable tag for v5.4+, thanks!

Kind regards
Uffe




> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 56912e30c47e..a1bcc0f4ba9e 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -68,7 +68,7 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (WARN_ON(clock > host->max_clk))
>                 clock = host->max_clk;
>
> -       for (div = 1; div < 256; div *= 2) {
> +       for (div = 2; div < 256; div *= 2) {
>                 if ((parent / div) <= clock)
>                         break;
>         }
> --
> 2.24.0
>
