Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05BD2F4A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAML1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbhAML1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:27:07 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD14C061382
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:26:07 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z16so911759vsp.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8jnevPejbGnXuRE1eNboLtO8z7zKZhz6Hgll9JoqIU=;
        b=XWSAUiVl6lGR7286jXBaM0GJdDCLgq6VJ1wRJAskOKaSoppFAT7jpkgJLupWkCdKfZ
         4OCU8lHhUHQruIBti0gbNY+NyUbKK52OIc6BPl+wqtmcux9JKT+cyJ37RX8tJlWl1EMs
         uJlL7uBqswk8jQTTgVhoOCp5UAECFvUD7MsYlAU9aJ7IJFmdLMmHR0lQP0wW3NVb0BLH
         Tjo9wSbdfAo80iCjE1QwZonmqTZPdyDR7aYhva8RHmMuKdj//riosEAqS7iOPUbLc7yb
         kpSqD6DuE5HsWz9LJS/DUdtDEWQddLlUXgQXwMZ5foMdYz21D0QiKaNGp28PHvR+nRP6
         HyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8jnevPejbGnXuRE1eNboLtO8z7zKZhz6Hgll9JoqIU=;
        b=rBBBncX9NqaDRtZ0jtn+wF8zwMtU8syzn4N3mJZjBo3Gjd6cT0O3QBA/wMHucNTpqI
         6zbozCC9USeetRvqga6o/v3Tv1QsZfo2QY0EwSsEP3yQzygV9uYRok9ORn/mk+qaYXQ/
         4X6Sqv3cJBJy4+C+kH+2lnG1CxLvuuaMBDB/J1HuFZKcsnYra/xDa7eW4fAmL7dw4OU+
         2GwvvvBRwDWjHpkG9lzbUJeIxvzdiCs6B6l4+ZmXsmNUNBtxzLxmLJEoelAWipsHPKw0
         y7Y6FcfWlzal2rsFQiJ3fR/gP9/4pSBQxBKqzg7/OogbelKKNn3j71FHUrwkakSr0d6u
         XndA==
X-Gm-Message-State: AOAM533VpxtLrjdG5rf71E9YihMDTXBqYkgqXHI9YxqUAbs/J88DhCtw
        CsbCoYjyq0iB+2azlIumK6OZVWvwkRKF0v+/CTmnoA==
X-Google-Smtp-Source: ABdhPJzfrPTWrOSLWP09mVB/1TJ84tDQudEsx/cZCljfINMeLiuZZP5UnGxMGp6TAmFAKwKOodVhuHFUYtxQyLmU+D8=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr1189707vsr.19.1610537166735;
 Wed, 13 Jan 2021 03:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:30 +0100
Message-ID: <CAPDyKFrx3ZhHk_k7OOEUWVuW-+wwq-x47-ZCteEB1gDJEFDoWQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: sdhci-of-arasan: Fixed kernel-doc format warning
To:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 at 16:51, Muhammad Husaini Zulkifli
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi,
>
> This patch series are to fix the kernel-doc format warning when using kernel-doc
> script tool and to change code style of mapping the syscon field for readability
> and consistency.
>
> Kindly help to review this patch set.
>
> Thanks.
>
> Muhammad Husaini Zulkifli (2):
>   mmc: sdhci-of-arasan: Fixed kernel-doc format warning
>   mmc: sdhci-of-arasan: Change code style of mapping the syscon field
>
>  drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
