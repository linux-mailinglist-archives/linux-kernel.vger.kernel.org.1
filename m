Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058C02E7446
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL2Vb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgL2Vb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:31:28 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CA8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:30:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w124so16213379oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hJGTOszJFm6kJ1Dkbtqs89ik0P5NwlWWYikycuxmI4=;
        b=mCO9clwy1fiu70HvNODl4jxtxzOac7rh8ToIfG0P5yq3sb2eu4uknoo332UoQvfCxT
         eiOxQugC90zSj238ZTBD2oyCgEM7aHN81yhwnHvd+CHaG4IkMqCzWlUiLLQmmesxMVCV
         Jm0DEXhlN+n3QyNfQHzLVyXfdXMrqEVgikzd/j0319kAWKlc7SR/B1Bv4NohtFxVQDf6
         H5VrfQJuEYn/zk4/u5aDI3DDcho1tV6U8Dnfq4BitfBRSzr3qbIWkPNloLksIb+2C9/K
         2IVHe3G2emCUe9Oi1bA51AMD4YdZaEfOkTafUc8kbnQu4MzKvhczG5oUfNOglbEQyGnH
         1mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hJGTOszJFm6kJ1Dkbtqs89ik0P5NwlWWYikycuxmI4=;
        b=VwB1B1+Bdhvwvzahw+T4RZlrlQ2tMNlPPtKRudwjVQHLIse4gPeVOUGoraphKJMcvW
         uRcGwQnUffKReGNSMBxxVoHnWZYfyceayhgOJdHhATThSkRfuhnnPRi/2POaohxRDAs4
         U+jOkKK/2PGMoTRq21VQ/p0afRdwrKsY5sY2hjJSne+84AsHNH0NggMpmeAD0e2QT7e3
         2mfjF/n2gRkXzZJUr4TeKlmgYfX3eCvPLn7TtWZoNfrQU2r+vBG8BmS4kZL9tceTOxHF
         EFGl2BCerE8s6k6T3cKXB3I4tCdHlV1qOI5QTCcDP1UtcGSopngNVGPR1yY3tJF502BT
         pbAw==
X-Gm-Message-State: AOAM531UNqtl8pKFK0yHCGT8LpKQds2L1EL+2d6Vd5L3iLRZ14+ZrbI3
        sDoGOSu+eyCh17EDxQVfc5UzwJK5usPo6zJB3MQ=
X-Google-Smtp-Source: ABdhPJxzRPwGrjddk9H4egDCDSu2NMH+wgKUTK0+tjq+AbVIldVc5c+vaVNlW++pl5ccI0LE3AJEZFFsj8UIYD4/Hyo=
X-Received: by 2002:a54:4489:: with SMTP id v9mr3676681oiv.154.1609277447495;
 Tue, 29 Dec 2020 13:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20201226072717.32001-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20201226072717.32001-1-dinghao.liu@zju.edu.cn>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 29 Dec 2020 23:30:20 +0200
Message-ID: <CAFCwf13k0Si+NvF2NXNEhXL2oG+ARtv=rCcXtuOwwNm7wH1AJg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Fix memleak in hl_device_reset
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 9:32 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When kzalloc() fails, we should execute hl_mmu_fini()
> to release the MMU module. It's the same when
> hl_ctx_init() fails.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/misc/habanalabs/common/device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> index 5871162a8442..e5028890ead1 100644
> --- a/drivers/misc/habanalabs/common/device.c
> +++ b/drivers/misc/habanalabs/common/device.c
> @@ -1092,6 +1092,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
>                                                 GFP_KERNEL);
>                 if (!hdev->kernel_ctx) {
>                         rc = -ENOMEM;
> +                       hl_mmu_fini(hdev);
>                         goto out_err;
>                 }
>
> @@ -1103,6 +1104,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
>                                 "failed to init kernel ctx in hard reset\n");
>                         kfree(hdev->kernel_ctx);
>                         hdev->kernel_ctx = NULL;
> +                       hl_mmu_fini(hdev);
>                         goto out_err;
>                 }
>         }
> --
> 2.17.1
>
Thanks!

This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -fixes
Oded
