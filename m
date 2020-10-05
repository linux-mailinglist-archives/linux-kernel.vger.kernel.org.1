Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52D12831D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJEIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:23:17 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F423C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:23:17 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id r78so1556001vke.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAtojNlzxsPSd/oxSbWU6AgTlxaiRO+YzHrraKa81XU=;
        b=gyoWLoyN2VqKSQUGjaeXiikTJWtx72t3wYzZbXZx182qcx3MgphEc/i7bNxdWUt4JR
         p6iHceJFvUI4O16eyMMM3reWwuwyMYAufz523LgXdBtppTniJ495/oCKjHGComZeh8LW
         +uJT3KfVpno2D13HeTPcBG+PQQfVJ3q4YdJBwRQNc+FW706nYXyWMK396mRP1z1mgCJ5
         /oe6sjNivB8jf+syiAa2H1rtnkE0D1VmKX4rJwzgZuct8DiXn96wHWXUoMAgP7nuz/cd
         HHmrmQHXkDKXZEgkhdFCqJ4ZlaMdpbVlQINusmhpAkU+BQBH5hrjus6bU9QzdnJVA2Bk
         ZyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAtojNlzxsPSd/oxSbWU6AgTlxaiRO+YzHrraKa81XU=;
        b=Eg/+zC0XV0vD28oi2tqu77GayUJyBt1e21wCl3B9vJHmCnf6wp+64wWh2FWkMNZ1uT
         /FHUE3CcHI9GL6avFpq8G3UgadgMn+XmBstrA/93yrXML6gZjCHs2rHEC/ZNAkG1U7rl
         qvh+Mi02ds44L+jq5qowFSfnewqZjQK10WJTh+1ZPfXFmACkht5H3QZIUergNz4XByvo
         /ol/Jy/Md+2NdLDCnuU3A1pKLsHOk+s9Ltb5XKNe1C4j3I8aRlg88sNSqztfeD87FePz
         dvk8ARLLtcAOF5xPtaX/nHiUmlYKa16fipygkP+5ALLV4RTWWoQE2N/aGYazHh59l5dt
         IN7g==
X-Gm-Message-State: AOAM532ALcRXaPTL+cgcD/JyUPYJ40tWX7ietXWLC0ardDCjUxrRwZW0
        zSyXh/gzA+SnhgjuzqjjlbKYg9DFrA/h002UiZg0ZQ==
X-Google-Smtp-Source: ABdhPJwGZ6eccEIM+OsJP2XgVXqZ+kYGEJi5PQ/SV4uGTlX8apsmqUeuDGFG8ICx3DEANTyofZmeyrlumVW4clNVEGE=
X-Received: by 2002:a1f:1f46:: with SMTP id f67mr2216453vkf.6.1601886196064;
 Mon, 05 Oct 2020 01:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201002164915.938217-1-jbrunet@baylibre.com>
In-Reply-To: <20201002164915.938217-1-jbrunet@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Oct 2020 10:22:40 +0200
Message-ID: <CAPDyKFo6T_P+TQQZSzFgHwLeE08f146KxKBpAutv209MXq0mjA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Brad Harper <bjharper@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tglx

On Fri, 2 Oct 2020 at 18:49, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> IRQF_ONESHOT was added to this driver to make sure the irq was not enabled
> again until the thread part of the irq had finished doing its job.
>
> Doing so upsets RT because, under RT, the hardirq part of the irq handler
> is not migrated to a thread if the irq is claimed with IRQF_ONESHOT.
> In this case, it has been reported to eventually trigger a deadlock with
> the led subsystem.
>
> Preventing RT from doing this migration was certainly not the intent, the
> description of IRQF_ONESHOT does not really reflect this constraint:
>
>  > IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>  >              Used by threaded interrupts which need to keep the
>  >              irq line disabled until the threaded handler has been run.
>
> This is exactly what this driver was trying to acheive so I'm still a bit
> confused whether this is a driver or an RT issue.
>
> Anyway, this can be solved driver side by manually disabling the IRQs
> instead of the relying on the IRQF_ONESHOT. IRQF_ONESHOT may then be removed
> while still making sure the irq won't trigger until the threaded part of
> the handler is done.

Thomas, may I have your opinion on this one.

I have no problem to apply $subject patch, but as Jerome also
highlights above - this kind of makes me wonder if this is an RT
issue, that perhaps deserves to be solved in a generic way.

What do you think?

Kind regards
Uffe

>
> Fixes: eb4d81127746 ("mmc: meson-gx: correct irq flag")
> Reported-by: Brad Harper <bjharper@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 47 ++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 08a3b1c05acb..effc356db904 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -101,8 +101,7 @@
>  #define   IRQ_RESP_STATUS BIT(14)
>  #define   IRQ_SDIO BIT(15)
>  #define   IRQ_EN_MASK \
> -       (IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN | IRQ_RESP_STATUS |\
> -        IRQ_SDIO)
> +       (IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN)
>
>  #define SD_EMMC_CMD_CFG 0x50
>  #define SD_EMMC_CMD_ARG 0x54
> @@ -170,6 +169,7 @@ struct meson_host {
>         dma_addr_t descs_dma_addr;
>
>         int irq;
> +       u32 irq_en;
>
>         bool vqmmc_enabled;
>  };
> @@ -842,22 +842,24 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         struct meson_host *host = dev_id;
>         struct mmc_command *cmd;
>         struct mmc_data *data;
> -       u32 irq_en, status, raw_status;
> +       u32  status, raw_status;
>         irqreturn_t ret = IRQ_NONE;
>
> -       irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
> +       /* Disable irqs */
> +       writel(0, host->regs + SD_EMMC_IRQ_EN);
> +
>         raw_status = readl(host->regs + SD_EMMC_STATUS);
> -       status = raw_status & irq_en;
> +       status = raw_status & host->irq_en;
>
>         if (!status) {
>                 dev_dbg(host->dev,
>                         "Unexpected IRQ! irq_en 0x%08x - status 0x%08x\n",
> -                        irq_en, raw_status);
> -               return IRQ_NONE;
> +                        host->irq_en, raw_status);
> +               goto none;
>         }
>
>         if (WARN_ON(!host) || WARN_ON(!host->cmd))
> -               return IRQ_NONE;
> +               goto none;
>
>         /* ack all raised interrupts */
>         writel(status, host->regs + SD_EMMC_STATUS);
> @@ -908,6 +910,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         if (ret == IRQ_HANDLED)
>                 meson_mmc_request_done(host->mmc, cmd->mrq);
>
> +none:
> +       /* Enable the irq again if the thread will not run */
> +       if (ret != IRQ_WAKE_THREAD)
> +               writel(host->irq_en, host->regs + SD_EMMC_IRQ_EN);
> +
>         return ret;
>  }
>
> @@ -934,15 +941,17 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>         struct mmc_command *next_cmd, *cmd = host->cmd;
>         struct mmc_data *data;
>         unsigned int xfer_bytes;
> +       int ret = IRQ_HANDLED;
>
> -       if (WARN_ON(!cmd))
> -               return IRQ_NONE;
> +       if (WARN_ON(!cmd)) {
> +               ret = IRQ_NONE;
> +               goto out;
> +       }
>
>         if (cmd->error) {
>                 meson_mmc_wait_desc_stop(host);
>                 meson_mmc_request_done(host->mmc, cmd->mrq);
> -
> -               return IRQ_HANDLED;
> +               goto out;
>         }
>
>         data = cmd->data;
> @@ -959,7 +968,10 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>         else
>                 meson_mmc_request_done(host->mmc, cmd->mrq);
>
> -       return IRQ_HANDLED;
> +out:
> +       /* Re-enable the irqs */
> +       writel(host->irq_en, host->regs + SD_EMMC_IRQ_EN);
> +       return ret;
>  }
>
>  /*
> @@ -1133,13 +1145,12 @@ static int meson_mmc_probe(struct platform_device *pdev)
>
>         /* clear, ack and enable interrupts */
>         writel(0, host->regs + SD_EMMC_IRQ_EN);
> -       writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
> -              host->regs + SD_EMMC_STATUS);
> -       writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
> -              host->regs + SD_EMMC_IRQ_EN);
> +       host->irq_en = IRQ_EN_MASK;
> +       writel(host->irq_en, host->regs + SD_EMMC_STATUS);
> +       writel(host->irq_en, host->regs + SD_EMMC_IRQ_EN);
>
>         ret = request_threaded_irq(host->irq, meson_mmc_irq,
> -                                  meson_mmc_irq_thread, IRQF_ONESHOT,
> +                                  meson_mmc_irq_thread, 0,
>                                    dev_name(&pdev->dev), host);
>         if (ret)
>                 goto err_init_clk;
> --
> 2.25.4
>
