Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB0F2AD624
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgKJM0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:26:42 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B928C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:26:42 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id m6so129789vkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gsnklr3mYZvBcAXWrQJZvljO/2f2xo3pLHWaomWfKM=;
        b=AsreJSV5v2zViOmWEF5BArd1fuqP1AHcftElNgRdDEhKheqMyX+7CjEaNTVKlG7dSr
         F0OWpyQkcM32nEJbiSC0zKvOAe4ICSU5qBw0u/tunZe/W50wSQtzZdMW4psl48Vd1Vtz
         3jdLPN5kPtI30oaQtIKB9JzRK7scZUONYgRqPd7tkAYgQCvqp69/Q33ydZJkA47ctevM
         6rGHhBFq4lnkoCjbwoCwZ/jWYCgkAjbDMCvc+Nv3zoJnJBNmIC2Asdl+QjqLe8eHPwWI
         Nsc4MnkA9wXM5XM5HFCOXl29o1nVTGCLjGkRe5RB+eHtxvYlj5gE5dr49VQx0Treg5Z7
         ROjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gsnklr3mYZvBcAXWrQJZvljO/2f2xo3pLHWaomWfKM=;
        b=g6zSn6wZ0sD0ZfB6tilU0S3jawaCHaHANKPPKrGfQTsAvdy16mIiqi8T5LeRf+blfb
         FrJThoyR51PyBJAPMv3+C3QnRgN++5wd5L9uzOiFHJJDt9QkQeBZWMbRQTdRU/g92vaT
         JNc3U1Yz4rtZrzLZHldGVuvI836cdcso3ZBhA2g5qzB8FZIO8eGIYahJYRecU91dJRj3
         C6LyxA6cH40r1ZSc//kLMTl8bTwlkK4GjFOCFz2jjwCXEWH5CEJ2p1F/UwacvynH7Iqc
         eidwmuHSeAN+3V0PVH+AxZ3X4bCe91qVhzHVSfyhB7wABuI3ElnzVNxUs5JV19aWZ1j9
         nSDg==
X-Gm-Message-State: AOAM532T+hZst+UgtSx7V+yvFXeX7MSKWKVDbGMGGk933UnLBDR8DS8g
        78tRoLku9x/odXZk/7zqlBUugjfNSEruv/0GdUxeJA==
X-Google-Smtp-Source: ABdhPJzB9kvz6yueidsObBUdc09/7o92ArCp7CRCelWNrrBQmYUm/QnuqC58IiY1wIcUcV/RUs0ijAgYt83DMK6Yz7k=
X-Received: by 2002:a05:6122:10eb:: with SMTP id m11mr10060860vko.8.1605011201227;
 Tue, 10 Nov 2020 04:26:41 -0800 (PST)
MIME-Version: 1.0
References: <1604627813-59785-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1604627813-59785-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 13:26:04 +0100
Message-ID: <CAPDyKFpX9T6aKUmnVNLoo5+CW7h7HHGixT0wefDpV3CMyOJKTQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 02:56, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 43c5795..a524443 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2617,7 +2617,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>         struct dw_mci *host = dev_id;
>         u32 pending;
>         struct dw_mci_slot *slot = host->slot;
> -       unsigned long irqflags;
>
>         pending = mci_readl(host, MINTSTS); /* read-only mask reg */
>
> @@ -2632,15 +2631,15 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                          * Hold the lock; we know cmd11_timer can't be kicked
>                          * off after the lock is released, so safe to delete.
>                          */
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>                         dw_mci_cmd_interrupt(host, pending);
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>
>                         del_timer(&host->cmd11_timer);
>                 }
>
>                 if (pending & DW_MCI_CMD_ERROR_FLAGS) {
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>
>                         del_timer(&host->cto_timer);
>                         mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
> @@ -2648,7 +2647,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                         smp_wmb(); /* drain writebuffer */
>                         set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
>
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>                 }
>
>                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> @@ -2661,7 +2660,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 }
>
>                 if (pending & SDMMC_INT_DATA_OVER) {
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>
>                         del_timer(&host->dto_timer);
>
> @@ -2676,7 +2675,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                         set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>                         tasklet_schedule(&host->tasklet);
>
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>                 }
>
>                 if (pending & SDMMC_INT_RXDR) {
> @@ -2692,12 +2691,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 }
>
>                 if (pending & SDMMC_INT_CMD_DONE) {
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>
>                         mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
>                         dw_mci_cmd_interrupt(host, pending);
>
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>                 }
>
>                 if (pending & SDMMC_INT_CD) {
> --
> 2.7.4
>
