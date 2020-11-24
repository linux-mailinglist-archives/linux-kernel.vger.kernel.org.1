Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3E2C297E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbgKXO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbgKXO0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:26:00 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FAFC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:26:00 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id v185so1593422vkf.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KG8e5alurpzWsF4jajWReOxdS4vWE5nC7cfgCJfHE7o=;
        b=g/xUqz/xefjW2ksNTDU8JYI1zBpoXrIpxp0AUyWvbQVQgjWYR5M9htWM+WmCbF66g0
         r8sKwpkIIuv4vuLR9UHv90nTBobtYw7qBiFQCxR3K3pEbqc9r3P7GP68MP2VDqh7FvwE
         wR6wQRL4GyVBLYIa+R15z+kPsOIg1dlwQnmi3dhpPvjQSbRyu3SAO3+lEPRcO9OhKB1q
         3GT9a/R5Z1DR+Lmedxts69H/GShmSqlM9kdTpGfFWO3+/j7lqUZuDhZl6Ql53qKllW48
         BImiXC46bb6uRitmmEWw1LdnygAkyDKlyaC4l9Bl5aErzdyL7GOTPXScYHs1XLbDifqf
         Izhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KG8e5alurpzWsF4jajWReOxdS4vWE5nC7cfgCJfHE7o=;
        b=T5CJoOKjf+iggYz4tUVPhSm2o8eFTldLP5es9Ucc3sUh0TBMygQ/fZjn7Hhmbkl96U
         MalqXXsGuPVqgg4WN7Q/UhAjRcBp9TBmAG+YxqMS8FareqIP2GPXJ/hmoKYX16b9WE1f
         LB/z0nmUdMWIFlBpw7kN6Kqw67TEzaK7OP79bpflt3dbEPbyekgTA11LiDsdGpZVQyV4
         7k4MJ2EQpVE1dpDLjYQhjjYl70SAsOGwlksE4SJaBti/Tbwm79QGqMQyQzZFNygzcF5N
         kmPqj+wnuLaifZ25EW3WJHpwKPAJYfpM8TBgkuRCJTRYg7TlqlIQAYP/CeQim8nTJKDI
         eP6A==
X-Gm-Message-State: AOAM5332sUd4Om8hGxr3wRb8wjhfrJ55GG7j9EOly/F8h0nPy5YxKPM/
        AM/Ll+tSbW8k9Xc/tz6lmj7Bldgxk2eTkjzhzj5GbA==
X-Google-Smtp-Source: ABdhPJy6HKalBTH6OZFShSJXcEikfluUqZ+puytamY9rxBoTg0WnLNWKjGH9RzcZNSULA1ntvmmWdHLw+M+BH/7yj0E=
X-Received: by 2002:a1f:8f48:: with SMTP id r69mr3987608vkd.6.1606227959664;
 Tue, 24 Nov 2020 06:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20201121021431.3168506-1-chengzhihao1@huawei.com>
In-Reply-To: <20201121021431.3168506-1-chengzhihao1@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:22 +0100
Message-ID: <CAPDyKFq3S2cdL0pCOLU7rfxFmNrQOZvproKVQ=Af7=sXHrFKOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: pxamci: Fix error return code in pxamci_probe
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 at 03:11, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> Fix to return the error code from devm_gpiod_get_optional() instaed
> of 0 in pxamci_probe().
>
> Fixes: f54005b508b9a9d9c ("mmc: pxa: Use GPIO descriptor for power")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 29f6180a0036..316393c694d7 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -731,6 +731,7 @@ static int pxamci_probe(struct platform_device *pdev)
>
>                 host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>                 if (IS_ERR(host->power)) {
> +                       ret = PTR_ERR(host->power);
>                         dev_err(dev, "Failed requesting gpio_power\n");
>                         goto out;
>                 }
> --
> 2.25.4
>
