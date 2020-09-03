Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2F25BC7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 10:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgICILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgICIKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:10:37 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C280C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 01:10:36 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s127so596629vkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18eisnWBy1lL6GG/nsWIt3CM4+eFkMNzfIhbeVaF+oE=;
        b=vsCcqXyHQIi4uZvLQW6aFn5cqvzT9qvBykDNMNa1WGyCkka6nK4diru80ZM7v20mqH
         Uuq9xo714twU4yaCY61LkPghEVdvRGGFGvuc3T+PLiGjNyZ1ZZknrHE2f3ZhyQjT5bz8
         Uiw3RAPpxjzFRNNtBPmJtYWlqlcKMXEBQ2ustivJ2YZ6xpH93Rh2I5ZAUqi4LC9YQ8Bo
         o170Co2AAaMSjFOOVuc2IrXPieAeOugl/ugKAmwNOOUh7WBoj7mNvCfFrzpYWvoTLB55
         97BDYQd4BTpgjV00rVI8l078Ueod3U1JdPW0jxc4yBzc0vHRkDhBiRmbv1wD0j9GVXjo
         gejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18eisnWBy1lL6GG/nsWIt3CM4+eFkMNzfIhbeVaF+oE=;
        b=micmZYlkyoJrZ78394qqb5gFuTwOQM39cI0lABd9BHpMum+BOGHWg++ZpqwwdvUyS/
         6oLA0MxjPGlA+RVkCj90gzP6hsVsrF655GYLz8pyYf/FXHCRM9QyRCHMVBafvsC7oLBp
         I1erXpletsFyzRjBz8DCgBTfz/Y09Ok+jVsBwpEanzaovD7/XEl+/onHl5UWuG5oWaaV
         OUZStg9sVGBmck96xBsUaNmdYlf/vju8sWIUD1usvc36XHLlyoOfEDHx6wsANQ6EhIom
         OXl2YVIC1EtB5RA+FS6TmY1UlZnxfvl2/ASB3lXZmWiI8c3a2Z//RbSLIihb590ZoLXX
         dbdA==
X-Gm-Message-State: AOAM530WMxgxW0GNlmx/vhDw8DEK0rUB0iYzNRgPWYHwLs38xIVVBIvC
        GXXw/mJHnvSrA7iDRZMfJDkZqmT//3xJ62P9dCgvjw==
X-Google-Smtp-Source: ABdhPJxVLzY2dPrjfxNTc6qI18eW9TM4fEE0Kqv/rA2ePJ7kmt6dVRZpnPvcb0xBW+ENsUQ0YH9YTswRPxsonHrdNhA=
X-Received: by 2002:a05:6122:6bb:: with SMTP id r27mr433666vkq.3.1599120635229;
 Thu, 03 Sep 2020 01:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200902204847.2764-1-krzk@kernel.org>
In-Reply-To: <20200902204847.2764-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:09:58 +0200
Message-ID: <CAPDyKFpi7cCN3SaF4O6fUKwFvtqSFYLyhK_y3akjAa=a-u=H2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: davinci: Fix -Wpointer-to-int-cast on compile test
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Store in interrupt service routine always '1' in end_command, not the
> value of host->cmd to fix compile test warnings on RISC-V:
>
>   drivers/mmc/host/davinci_mmc.c:999:17: warning:
>     cast from pointer to integer of different size [-Wpointer-to-int-cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Follow up to:
> https://lore.kernel.org/linux-arm-kernel/20200902193658.20539-1-krzk@kernel.org/T/#t
>
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index fad1010fb52b..66d740ee7d45 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -996,7 +996,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
>
>         if (qstatus & MMCST0_RSPDNE) {
>                 /* End of command phase */
> -               end_command = (int) host->cmd;
> +               end_command = host->cmd ? 1 : 0;
>         }
>
>         if (end_command)
> --
> 2.17.1
>
