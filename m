Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6732FFF90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhAVJxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhAVJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:46:08 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A4C061793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:45:28 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id k22so1647864ual.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8znVvt11Gf6tz3j7rgBydA6WYzetqabHTGjXGWf8sQ=;
        b=fKAf9df3B+5Q3xvUV9EPDSzL5dugIci2p8+8LlVDaw3lkiPXV7VFmtQCAMWAuYyxBP
         cpAIz4u0oafAzp6RAuSraf6NJRnWl9sD1szlojI4MXAzSHhLZlcZ5kVTRfhFUyrg9yGY
         sx5TuiT9W/2S7qm98exNKvTdJRL9WFxZ0OGpjbzQnj2qMz4oaO4xmppDWpTeoaUNQZom
         NqEqUneW8wKJCL+9UiGAShuZjn9eJCsi6mvfBf5jy0OqK7f9+nTOGs/gHmP+Y1K2q6ER
         EPNsH8yOIe1I590YlqNSl2BcarrkG7pYYAChgJIRtD9nQvOS7wwwig+vJQFekotnXFxJ
         WXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8znVvt11Gf6tz3j7rgBydA6WYzetqabHTGjXGWf8sQ=;
        b=DUlknvHY2VPDKwIqrcxj8iOvuvcpo/ek6KGemOdhf5YlzkJiNJnFNP51fu0tVwASSc
         T/CWT5+6+lYKW/wW2qtz295i0R+y/tghk8UwRKuX2bATPOPMYxzUn6m4JScP34L2Jx80
         8ibsP+yWpeF77tcikos5uxmUnntc5bAVNsCrBZDETWiIcX3VE0lfsl5WuIe9IWp1M35K
         sqA0X3INmnUI1WbnMdRUmLPDw/UcCpcbBhrhdL/ORGbXdfelERL5ntZTT43HZ+7K88ZL
         kNQ06OdXCZddyYZn9kG2qyX+Gwiud5eiQT3M2Zbo0fHkLfVagMrB/NJIl4fKX4hg84p8
         m9KQ==
X-Gm-Message-State: AOAM5314anlBdFz7yHhoWZ6Sif8NV6jPuCRD/aoy6OgOgwMkf7Bd74D9
        F8Spuyfjt5PABozXt/S7Z4b7QXsWZ90EyajWUrQOSPwe+HrjhQ==
X-Google-Smtp-Source: ABdhPJxtzw1pzaWNMbHu+VHRXn6WXmioeGbrfQKrhYo5lZJ2VN+DOFrw1lf7f5j6UO/jggyepGcyVcZi+kSqr6Zw76U=
X-Received: by 2002:ab0:768:: with SMTP id h95mr2569551uah.104.1611308727664;
 Fri, 22 Jan 2021 01:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1611128377-66216-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611128377-66216-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:44:51 +0100
Message-ID: <CAPDyKFq+byoyYW8GGnSx1GsbBx8Sci8Dqo2AAuapTyUmEHm_HQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Assign boolean values to a bool variable
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 at 08:39, Jiapeng Zhong
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/mmc/host/atmel-mci.c:2436:2-34: WARNING: Assignment
> of 0/1 to bool variable.
>
> ./drivers/mmc/host/atmel-mci.c:2425:2-20: WARNING: Assignment
> of 0/1 to bool variable.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 444bd3a..6324120 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2401,45 +2401,45 @@ static void atmci_get_cap(struct atmel_mci *host)
>         dev_info(&host->pdev->dev,
>                         "version: 0x%x\n", version);
>
> -       host->caps.has_dma_conf_reg = 0;
> -       host->caps.has_pdc = 1;
> -       host->caps.has_cfg_reg = 0;
> -       host->caps.has_cstor_reg = 0;
> -       host->caps.has_highspeed = 0;
> -       host->caps.has_rwproof = 0;
> -       host->caps.has_odd_clk_div = 0;
> -       host->caps.has_bad_data_ordering = 1;
> -       host->caps.need_reset_after_xfer = 1;
> -       host->caps.need_blksz_mul_4 = 1;
> -       host->caps.need_notbusy_for_read_ops = 0;
> +       host->caps.has_dma_conf_reg = false;
> +       host->caps.has_pdc = true;
> +       host->caps.has_cfg_reg = false;
> +       host->caps.has_cstor_reg = false;
> +       host->caps.has_highspeed = false;
> +       host->caps.has_rwproof = false;
> +       host->caps.has_odd_clk_div = false;
> +       host->caps.has_bad_data_ordering = true;
> +       host->caps.need_reset_after_xfer = true;
> +       host->caps.need_blksz_mul_4 = true;
> +       host->caps.need_notbusy_for_read_ops = false;
>
>         /* keep only major version number */
>         switch (version & 0xf00) {
>         case 0x600:
>         case 0x500:
> -               host->caps.has_odd_clk_div = 1;
> +               host->caps.has_odd_clk_div = true;
>                 fallthrough;
>         case 0x400:
>         case 0x300:
> -               host->caps.has_dma_conf_reg = 1;
> -               host->caps.has_pdc = 0;
> -               host->caps.has_cfg_reg = 1;
> -               host->caps.has_cstor_reg = 1;
> -               host->caps.has_highspeed = 1;
> +               host->caps.has_dma_conf_reg = true;
> +               host->caps.has_pdc = false;
> +               host->caps.has_cfg_reg = true;
> +               host->caps.has_cstor_reg = true;
> +               host->caps.has_highspeed = true;
>                 fallthrough;
>         case 0x200:
> -               host->caps.has_rwproof = 1;
> -               host->caps.need_blksz_mul_4 = 0;
> -               host->caps.need_notbusy_for_read_ops = 1;
> +               host->caps.has_rwproof = true;
> +               host->caps.need_blksz_mul_4 = false;
> +               host->caps.need_notbusy_for_read_ops = true;
>                 fallthrough;
>         case 0x100:
> -               host->caps.has_bad_data_ordering = 0;
> -               host->caps.need_reset_after_xfer = 0;
> +               host->caps.has_bad_data_ordering = false;
> +               host->caps.need_reset_after_xfer = false;
>                 fallthrough;
>         case 0x0:
>                 break;
>         default:
> -               host->caps.has_pdc = 0;
> +               host->caps.has_pdc = false;
>                 dev_warn(&host->pdev->dev,
>                                 "Unmanaged mci version, set minimum capabilities\n");
>                 break;
> --
> 1.8.3.1
>
