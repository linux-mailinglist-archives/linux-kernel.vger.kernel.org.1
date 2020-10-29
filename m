Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F929EB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgJ2MJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJ2MJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:09:10 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA985C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:09:10 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id y10so639373vkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OKA9Pgk0ZZ7+DXmqAtn7byrzzqg0DhRt90w2UoAl54=;
        b=p3Nt87l2xN8E/kW1cpinhezE9x7HXKo0TaISvtMl0md3/MASIkPOI4oWfHMDtV2fL8
         HJf8642vtrJwRDG15XPPEhmxdnqKFj1DCvxvW0izscb4zY+MPp/WvvZTLUwkDNI9YTog
         RMbzmKP8cNTp32zafmWVv7TbKNv7p4bZyuZ+QemO5SKdfFmSlt5+kiPbBo+xxxnypH60
         t9nSQ/yHhI6zYAF4FVQiiEOTs4vK48hVWrxgCv3/XszpLqel8WuZDFHQmfkvcEkMHtcl
         AWTYcD6quieQEWNs2sBIikUTjgIQzx/S+gm9fC7VmHV9Sy1HeHWtweWy6MGK4Ldk3KCm
         8w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OKA9Pgk0ZZ7+DXmqAtn7byrzzqg0DhRt90w2UoAl54=;
        b=RQNvXQVPXzL4dykzDLFLlNvweBNnd9UXsqYxhX/igNi2UOJYQwbFT6Ms22Lro2YF+L
         isRkmo7sRnk6i71ZySTflK+5Jtp211jroLXrH9epzNN9w9PMNnRe+jqDoRQM7PgdYRcr
         3di4zzutbMURBmWFfXs/mULkBU2e2RVw4tD1tNgqtBL1FMX3QJpBoY4vtYUGeRMSUBKR
         4n8u4qnpnEqZQymN0ZmyoHyGxnVLhg3mp5Vck4oCHn61Tc0n4j47Vl7MgDa1JJyxdGuJ
         ZlDFlPNWAOYwpt/kvp60PYXDt2dj3W1ebavNc6cFOBttDApykpsRgpMVuLDtGdvdaCpR
         j3eA==
X-Gm-Message-State: AOAM532aVCr4rtyhjA9eahqC5GUhOPSl/3VAzFnVuyGiKIRwgIvxLNSM
        A32a2ltrpdFIF+wUeN2SpGEQi7jKfprNI7zUiaMDGg==
X-Google-Smtp-Source: ABdhPJyfh/wov0bgUNVgZKsf5ChZEKE/xeN/ahZVICTxi8+aUGFoAtBQTKr6ElCer1/at22RWmlzu2bKpXFwdKJFUFg=
X-Received: by 2002:a1f:4c07:: with SMTP id z7mr2571896vka.15.1603973349970;
 Thu, 29 Oct 2020 05:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <1603068193-44688-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1603068193-44688-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Oct 2020 13:08:33 +0100
Message-ID: <CAPDyKFpyASJCE8QtKX=R=eVeeT2=adknBZmWo8GVaaLDv8KAXw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     haotian.jing@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.or>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 at 02:42, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745..fb3e419 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1536,13 +1536,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>         struct mmc_host *mmc = mmc_from_priv(host);
>
>         while (true) {
> -               unsigned long flags;
>                 struct mmc_request *mrq;
>                 struct mmc_command *cmd;
>                 struct mmc_data *data;
>                 u32 events, event_mask;
>
> -               spin_lock_irqsave(&host->lock, flags);
> +               spin_lock(&host->lock);
>                 events = readl(host->base + MSDC_INT);
>                 event_mask = readl(host->base + MSDC_INTEN);
>                 if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> @@ -1553,7 +1552,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 mrq = host->mrq;
>                 cmd = host->cmd;
>                 data = host->data;
> -               spin_unlock_irqrestore(&host->lock, flags);
> +               spin_unlock(&host->lock);
>
>                 if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                         sdio_signal_irq(mmc);
> --
> 2.7.4
>
