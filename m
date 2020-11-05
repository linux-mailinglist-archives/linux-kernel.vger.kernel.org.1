Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938532A7F53
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbgKEM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbgKEM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:59:40 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9200C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:59:39 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y78so702945vsy.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcYVD8LEqXgQj8+4xZ30P3SoEK5SbThnfnXSJjWjj9U=;
        b=q3c0CcJWW3Yp5+fRoMt39iQyOeS16ql9LOwD6JST77IzqGimB6hDkQmKyGf9q07dTg
         Hiv+5YhxhzPXf5zPBDdkaM98jkridKcrZVGRWsHcSEG8cAA9nnrzQpuMWQCIhURAkpv5
         SyeiQ8ROkWtj1hNvnIhruS6z7NQS2PLw5lhj/eQr49u4UzlIlknlMdbbTgxd82qksol4
         kUU4EEH9npzfO5NN6gZYdvCvxFt73b3ETOwxUFtcsWRu5zWFjf8W2psR8TcD/t/FU213
         sEt7c6kLwi/agHhLjDtqM6LUD0OOyvK4flWQoFDxHV0e8ZJ5Yl9EaD6Df+kltIk6Ux1Q
         K2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcYVD8LEqXgQj8+4xZ30P3SoEK5SbThnfnXSJjWjj9U=;
        b=fWzpPdxeBp7Uvg66N7s15V9Mr+8nO4+NWDW45WrCAYztCC6xyHkrLgPmJlYC5NBUUg
         PZ5ZNE4vG3Y3d4bHyyaP97AZxPiiKdLr8NWgTvEHjMvFFzn3kQ0oCTRriLtWong4ciJP
         mgXQcDLu16tjkBq8kUSnnLVdHZW+YTGi0pdLqm690GQ3DA4jmib9kFNMKKS1D21nVs6G
         txtZDmSYw39jJENOK0IA62KSB57fIlb7ApVx28PumJdKKTAKKvgY4TGiUY4eMv/XMpis
         3RVbWZc+jaefhNlIvh64GQ4NI0DTllm6m3/CmdNpzNrhuUnwlTQ59UOKlRDrxn4lmhLU
         fzCA==
X-Gm-Message-State: AOAM533dVAVfqBoWkcZp2FphMs1SVzUlfsJkzHHVM5oSA3EpRKS5QIUX
        Jq3V0twKR5I+8QBmoAD/GIVjwn+FDyaumQwDy/cWBb5f+KU=
X-Google-Smtp-Source: ABdhPJyCXPYThdRo5a7gJehCWV1WQyzo/STXalTghHHdtLgldG1yVsd5Ox8OKcIRoIGYwJGamQ0szslq9j9NbWuiT5Y=
X-Received: by 2002:a67:310d:: with SMTP id x13mr1036122vsx.19.1604581179098;
 Thu, 05 Nov 2020 04:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20201031152708.2146690-1-trix@redhat.com>
In-Reply-To: <20201031152708.2146690-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:02 +0100
Message-ID: <CAPDyKFphxHnrWmdG3DoTEX9MpS+23ZwjKK3xny4_UWdpTbUzDQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Doug Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 at 16:27, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 90cd179625fc..2a757c88f9d2 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -290,7 +290,7 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
>                 default:
>                         s = ", (R? response)";
>                         break;
> -               }; s; }));
> +               } s; }));
>         host->cmd = cmd;
>
>         switch (mmc_resp_type(cmd)) {
> --
> 2.18.1
>
