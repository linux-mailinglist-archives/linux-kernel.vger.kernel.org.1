Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4B26E364
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIQSUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgIQSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:18:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:17:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so2637437qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ki8/NOkpFvs3XxTS93OGfUDB/VnTY+Hw6EkRY5HIJZs=;
        b=GZaBRiQ9WPc7NkQAE0jqjGGYjkOYBWmzeGoKul57v7BPJfgPhtlrZXHUW6mbS6ZDCA
         tNSk9vQhRNReJ9gBsoGDPjgl+T4eT6te0GK4HtRB1w1dPUHxfpiLB1Etmbz21pSgEKGP
         /P0iKQuLf4R0h4k3a9BfatYorU2kLtm8+GgWMrOxkjuSFzBWmNTlzMpRj4B/8yggeu36
         NMJL+gte16yTX0LBooeg+GUUg+VkYShK61Q0Zya9ngcgi9ACOs+sv4aCyOh9uxe8fhq2
         I2Ar1q1ixCmOhpIW2pM0umipFIvANhdcly/BFa+PE/Ozbu6wtOcVsFNuKs/WymIUbFEG
         wlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki8/NOkpFvs3XxTS93OGfUDB/VnTY+Hw6EkRY5HIJZs=;
        b=LwfCE3rJxHpGPrHEZrNXdkKtK3/5aO+3qZIbRdrC5undz46QHXsN/k7RZa6NLPXPgJ
         Ffhj3oD0/SUKNQVmwRe6HNYDm+I3NUnZ6GUt62Lv57yMjO9kKRxMVlCEQRhIK0v72NQX
         u5omIzevXNjGOBRgqgf90J6KckHO0kO6T0Z04rAk/XCuiMPmRyfU4BzyiWXaLJ1QtfS3
         Ted4PozHIaEinhqH43bK171CNKgDPDQkXd/mPKsGKevLvSGLLKWUTpe2j1BjRzOYxdYj
         TXXU+5ZrDN6N5CObkelDcfTgjv/NyBIbXt5z0TQXEo9HyPN51izUmYx1rPFWWx8waJVw
         7apQ==
X-Gm-Message-State: AOAM533X9HFTdmW1JUiknoocB9OtC3MfoKONL16cK3ufGjEN/mKsNNeM
        TatUb9S00GpEgvspA5MFGuoIkNTQuRrAVu80YySu7g==
X-Google-Smtp-Source: ABdhPJyVQHzYu1Aj9+VqPfHZXnK0Aqr173fPvmOQMN/L328PRHuWfV9ruZW1fqpnFhP8GdLA5JaEel77uv4sNSC8hJI=
X-Received: by 2002:ac8:748c:: with SMTP id v12mr28117317qtq.200.1600366658123;
 Thu, 17 Sep 2020 11:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200915075732.100804-1-weiyongjun1@huawei.com>
In-Reply-To: <20200915075732.100804-1-weiyongjun1@huawei.com>
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Date:   Thu, 17 Sep 2020 20:17:27 +0200
Message-ID: <CAMxfBF5n-eCyMR2=yz8P=J=f3smDpw_3N3yZLqH9uQmZCXQy8g@mail.gmail.com>
Subject: Re: [PATCH -next] soc: ti: pruss: Fix return value check
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        "Anna, Suman" <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 15 Sep 2020 at 09:58, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In case of error, the function of_device_get_match_data() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>
> Fixes: ba59c9b43c86 ("soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/soc/ti/pruss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index cc0b4ad7a3d3..582f48051c30 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -126,7 +126,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>         int ret = 0;
>
>         data = of_device_get_match_data(dev);
> -       if (IS_ERR(data))
> +       if (!data)
>                 return -ENODEV;
>
>         clks_np = of_get_child_by_name(cfg_node, "clocks");
> @@ -175,7 +175,7 @@ static int pruss_probe(struct platform_device *pdev)
>         const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
>
>         data = of_device_get_match_data(&pdev->dev);
> -       if (IS_ERR(data)) {
> +       if (!data) {
>                 dev_err(dev, "missing private data\n");
>                 return -ENODEV;
>         }

First of all thank you for reporting this issue. Indeed the IS_ERR is
wrongly used and is leftover from a bit different former internal
implementation. Nevertheless with your fix the driver will not be
functional anymore for all devices without match data (e.g.
"ti,am3356-pruss") which is not what we want.

The proper fix would be removing the mentioned error checks, since the
"data" in both cases is checked later, before usage:
if (data && data->...).

Please let me know if you want to improve this patch by yourself or
want me to push a proper fix with your e.g. "Reported-by:" tag. For me
both solutions are ok.

Thank you,
Grzegorz
