Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B92CEFD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgLDOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgLDOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:40:04 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71545C08E863
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:39:00 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id n18so1905106ual.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALFvhZ1OjbfVf/iAkbXtpPEl6kf7hFGESlUg72YwV2s=;
        b=s3Ku7AVE/9HH3DtwPJCfcA81tzqrP0dq8xSrkCN0QiwbH/+JoOwR6RvK1IlmjghAXd
         0ieHFh843CCnahnuHpDrm6y8SBYLZByGQaSbhLCTRwzXMnxueF4/+gz6e8szcZTvV3dY
         5EcmxsyWv/AMyx2WqithnYA33e8SJeiKc3wVrfky9TCUzo9wUNNKQzaScpg3jlGHPyxu
         yWWo+K37fKgomlEB96lOu2lfM7682x5HWKycXPfYejW6tbMdXcNSg5uRoNZAk89GHafO
         hyo3YXqoS10TSskEcywdeExjeoOJNwcngDBp4mfnGP7WYpySKgHPgOk1h/SWFdolhkN3
         2aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALFvhZ1OjbfVf/iAkbXtpPEl6kf7hFGESlUg72YwV2s=;
        b=ocaKEyc5kT4KOFxgtNBUHTCRHmydEzIxJfmbBdBO5O6+SbRBMvtaCi+NAdQIS/pXdD
         bwosaMZ2V6XpIIT1SRVwCKxXvh9JK23UdUr1BYWMgRq7+1JBpfj2+RucTCGvb1CjJSCp
         9a6T27BtuYNEEcSmvLOqoU3QGkfQT0xagj/SfTsTy0tQKu7mhiS6O10YAwOibc7NiCYQ
         f+VwVCZnrcbp7oWBYTYNm+BSAN7efUTLzJvUo6eQL0rDsbABHIXjRJHcf4Gx/Qp2kjfU
         YLwl50Z4qj5lcwJiRZOrOgHXw9dR2Fj9smNHK5jD70FFtvQw7mfSpKgkqUx/3aqcxRFT
         QBQw==
X-Gm-Message-State: AOAM532WRrt++aO+f69iJPU5ZX/cbLCtoZnqTjD0qi7Nj0m6usG6xh+H
        P2unFe9A12JKLF4KwxPiZ3sSqoio4wJUaVzsPEKSSA==
X-Google-Smtp-Source: ABdhPJwYn0T6jy/eo/USN9DAFcjbAf/fm07eYkJrF/ELqPyes0vB0Xl/fQW8PCZhOiWLNKZ9Fig4P3TrEJKZ7fe/V1s=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr3340200uan.129.1607092739611;
 Fri, 04 Dec 2020 06:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20201202202320.22165-1-huobean@gmail.com>
In-Reply-To: <20201202202320.22165-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:20 +0100
Message-ID: <CAPDyKFpq-45z4MdMek0jGjR88QuG8PangcHRV+CJ4u57EcSqzg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Let CMD13 polling only for MMC IOCTLS with
 the R1B response
To:     Bean Huo <huobean@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zliua@micron.com,
        "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 21:23, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> The CMD13 polling is only needed for the command with R1B Resp. For the
> command with R1 Resp, such as open-ended multiple block read/write
> (CMD18/25) commands, the device will just wait for its next paired command.
> There is no need to poll device status through CMD13.
>
> Meanwhile, based on the original change commit (mmc: block: Add CMD13 polling
> for MMC IOCTLS with R1B response), and comment in __mmc_blk_ioctl_cmd(),
> current code is not in line with its original purpose. So fix it with this patch.
>
> Fixes: a0d4c7eb71dd ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
> Cc: stable@vger.kernel.org
> Reported-by: Zhan Liu <zliua@micron.com>
> Signed-off-by: Zhan Liu <zliua@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for fixes, thanks!

Note, I took the liberty to rephrase the commit message (and the
header) to clarify things a bit more.

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8d3df0be0355..42e27a298218 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -580,7 +580,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>
>         memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
>
> -       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B)) {
> +       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
>                 /*
>                  * Ensure RPMB/R1B command has completed by polling CMD13
>                  * "Send Status".
> --
> 2.17.1
>
