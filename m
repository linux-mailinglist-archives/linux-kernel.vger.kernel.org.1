Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573302D9BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440112AbgLNQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439397AbgLNQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:09:54 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA457C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:09:09 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id q10so9218887vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2aQQjeTAClD8BnlUklr8QIojrz0VDK1/YhYYkZp+14=;
        b=kIZlPMONz6lBq/gIOydcXGUjcQ0cvnJfuO8mypCn3kXK71AWGykGUryj8sLmqsAdFI
         ZUJzP+cGLH/fV3IW7Je5UBQzqFi7Be020MjYizulu8XR/il87US8F0Cbs4ZPNqvxhzl1
         oMJBu2XlH9E252F3Bb3qbUdtEo+LtrF9WOVHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2aQQjeTAClD8BnlUklr8QIojrz0VDK1/YhYYkZp+14=;
        b=FsJzGUxwl+U1gKfZ7RXsZsU+65IWBZufH/1Goa1Hhy8VtANjDjxqJB9BMLAsUqeElo
         CLZVWg6ozqci34K+cAETK5Y8RCBV5sxUVxpnhk7ob+mh+yRzJBGXO+vgVnarDqBMR7+S
         44re4loEpc/su8KWmRBCETW1bp8tyMUml4YKdBOZlbtUpudTdn5kNhr4lGi5sBgIzEwq
         frdYDcRcmgOJ7PCkuLvhfyHct8D8Mq8fChZyHW7g3cBcZeZzYqShs0ru54G8wkeDu8xG
         ht7ucKoDuUdV+oVEaUk+kc0GO4D/4buBmjRtISdcl+Pv7P5VY9BeNrg5ghs1KST1ludi
         BlEA==
X-Gm-Message-State: AOAM5307swk950zs7jZLRms9U7KMkaz0orKx6d+sravEhfZxERJwam6/
        M3xkfN9LjyLUAf5GjUb7ADlyGmeR3B1SfQ==
X-Google-Smtp-Source: ABdhPJz69tripr9tmxI8gTbliFn0/R9bsypAwkG/k+EJv+UL1zh1UzFkrhZ6fRWNeoRNVop4zaZx2A==
X-Received: by 2002:a67:e409:: with SMTP id d9mr7291557vsf.52.1607962148595;
        Mon, 14 Dec 2020 08:09:08 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id z10sm2218872vsf.26.2020.12.14.08.09.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 08:09:07 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id 17so5283317uaq.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:09:07 -0800 (PST)
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr23719280uaa.104.1607962147154;
 Mon, 14 Dec 2020 08:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20201213052948.308263-1-swboyd@chromium.org>
In-Reply-To: <20201213052948.308263-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Dec 2020 08:08:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WWe-0v1=kzw4XGQ9TFUkFcf2nAx0so6TFBg74JH6bVmw@mail.gmail.com>
Message-ID: <CAD=FV=WWe-0v1=kzw4XGQ9TFUkFcf2nAx0so6TFBg74JH6bVmw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-qcom-qspi: Use irq trigger flags from firmware
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 12, 2020 at 9:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force this to be trigger high here, as the firmware
> properly configures the irq flags already. Drop it to save a line.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-qcom-qspi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 5eed88af6899..8e70f5e63e0b 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -516,8 +516,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>         ret = platform_get_irq(pdev, 0);
>         if (ret < 0)
>                 goto exit_probe_master_put;
> -       ret = devm_request_irq(dev, ret, qcom_qspi_irq,
> -                       IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
> +       ret = devm_request_irq(dev, ret, qcom_qspi_irq, 0, dev_name(dev), ctrl);

I don't feel that the old code is really wrong, but I guess it is
weird that it's double-specified (both in the code and in the dts).
...so this is OK w/ me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
