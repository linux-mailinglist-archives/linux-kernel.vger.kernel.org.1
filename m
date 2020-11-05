Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25C02A7F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgKEM7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgKEM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:59:31 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610A6C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:59:31 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id u7so694986vsq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1rpPMQ35EzHEA9++2pEXY5R0+zIu5c3gH//7n5cL98=;
        b=bH0Yp+HvZOSVqvSE8ozL/gGw3MSsO1o2RpFm80wCn5MSCmrxkrDjshFXtqTk2TSGJU
         v1fflSn1UL5+vMc4aY11/Is93upsO0AhudlpkV15zuDmSzf1y74j3YfIJrEwC9QLiN17
         UmmEZrdaVnqGUaENYgtI3pNE1awYeC60AVsS5Rc0Z86LEKXCb2oHo0qF6vRZtGWDaudP
         t0DL54VfoCOQXKznQVHjk6lIwEoibXI7/F+pW5GX4zTfp2uVvu5r/IVeErIjQOLJyq5z
         7+9aQWXzAp9usDISDSfBCcn5zNllyu7MjAYYHEPGVRgoTqMjroA+CiIN8DgyfVCg7cxS
         9ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1rpPMQ35EzHEA9++2pEXY5R0+zIu5c3gH//7n5cL98=;
        b=kELLTkKMVWcThm65Qp3oTpd0kV/rNyBCW0x7v890CbXzAFj3XJUFEwQkqc/kULpOyx
         bH1rGafL1YrjOl96RjWATNyoDIc2BgmgDU3KaCAo7J2tm69NXDEZZLyOUXKcb88z5pfw
         sdcIFZz6qn1nb59juFFPxbM+y9x3YCk+IZZrawsfyL8t+xh6xLwMxSu6J8THSOCT8lMe
         icEIH2OBp/ikXz+1MsvY/gniHdsf5L0rkPhvPDDpi6lf6XRljER0tuBAau5r9OHeEWk2
         IBeQgwHKuWFX8awSqeugQZmgwWW3KYK11B5E5/4xRAgrNhQvw+FphrIWE7gDLRXj90ye
         3PVw==
X-Gm-Message-State: AOAM530R/XCN23wY5LCmkJRTIDCjdhWmgYE+fG4OLXhV/Nb4yNzkQ+bi
        SrN/OqHc68/lAOJq6RGQmzf7Y4BQ6/ua/WHHSzBpYg==
X-Google-Smtp-Source: ABdhPJzt6ZXGtEvxg+dA0mO/hwkKZKqCJRhenVMmcK1Ou/9VmQB+Zebqv9fsEOunJvMxUtXWUlaElGwwMQs0TPH8b2Y=
X-Received: by 2002:a67:f417:: with SMTP id p23mr988628vsn.42.1604581170644;
 Thu, 05 Nov 2020 04:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20201031142505.2139539-1-trix@redhat.com>
In-Reply-To: <20201031142505.2139539-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:58:54 +0100
Message-ID: <CAPDyKFrnsKbw6Vd7=PZ1v2qwPXrGHYnM6djvMABUm9tzqeR5Dg@mail.gmail.com>
Subject: Re: [PATCH] memstick: jmb38x_ms: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Kalle Valo <kvalo@codeaurora.org>, jgg@ziepe.ca,
        leon@kernel.org, chao@kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 at 15:25, <trix@redhat.com> wrote:
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
>  drivers/memstick/host/jmb38x_ms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index e83c3ada9389..f9a93b0565e1 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -748,7 +748,7 @@ static int jmb38x_ms_set_param(struct memstick_host *msh,
>                                       clock_delay);
>                 host->ifmode = value;
>                 break;
> -       };
> +       }
>         return 0;
>  }
>
> --
> 2.18.1
>
