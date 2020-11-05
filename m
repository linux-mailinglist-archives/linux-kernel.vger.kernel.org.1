Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0740E2A7B22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgKEJ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgKEJ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:57:38 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:57:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h22so959673wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:message-id:date
         :mime-version;
        bh=+TGCsofaUmGr6nzBBKHycjrA1R9jwaok57A4MZa2F4s=;
        b=qL2v+cFyY+xkNZuz62SNoRVKfbb7gAFxwYzWEzvhFokyqCAW5pUpNM8cK/97gxBCWt
         8vjrtf2DfmiobWuHVXfZ5QDWUO3Y8pfBNX/XrTE7TFFiZe8GqFxDha31JZ8G8i1Zg0OS
         RNgjo36tkYcwTb/kcEYd8iZI82+iJrOdLruzhzcrJ/p2stPUiVekKH8gI6xmEjKdJCZ4
         JAkkBJioNpXPUJ4h4+S1l3juH2MUGNSXKkL+17dgUPhPeGsfqLeexUsovnjVxZ2EH/Gd
         itQnODenm3N+cKFm0VkruGfx40I9yh2gufwytLY08l/37xAp6GURsV1xAWNtiq0vLber
         Tg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:message-id:date:mime-version;
        bh=+TGCsofaUmGr6nzBBKHycjrA1R9jwaok57A4MZa2F4s=;
        b=J99V/6LDWfQ5Njznh34yRHBzuveVC64rTjKGyTOlm8fNPM1ifrnlvsNYqtocZ4VlRk
         sJFJZupohKvHlp8xaU5lEKD0pM0lePNAiQkA81fhaenfY67lAY6B869Vxk+NO1QIqVIZ
         wpkhUV5sIHWWQT7oKyVn15vTY/fRxtWbQLX3rhuoeLrNX99r351nhEXp8tHlURkaS/y4
         b+NIZytfb+J5CEKDmQSmkHlwx5LwQs6d3vh39Gj5djfHYskZY2YFtjuozx3Tt0527kHa
         L03Vee8LVdcXb7c8m+/pViqgi9CLJZf99WUq2m6WfCRVXciMp58uWLPOwuIBh3o59bT5
         bs+A==
X-Gm-Message-State: AOAM531Ot+GXlIyMfu7r/ZC8KyZhYSL8QC87eB0K9qqJMJztGG/hyu4C
        A3eEaEk9ra/XDrb2a18YPQgzIw==
X-Google-Smtp-Source: ABdhPJwBGELixNpYowvhX39sWRrOBjfWBHAiBmfYwVPE7T9/3PTG+y1zLuYgjRuTA/p1a4UY0LDemQ==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr1821947wmd.70.1604570257085;
        Thu, 05 Nov 2020 01:57:37 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id w11sm1936242wmg.36.2020.11.05.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 01:57:36 -0800 (PST)
References: <1604375323-33556-1-git-send-email-tiantao6@hisilicon.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Tian Tao <tiantao6@hisilicon.com>, ulf.hansson@linaro.org,
        khilman@baylibre.com, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-mx-sdio: replace spin_lock_irqsave by
 spin_lock in hard IRQ
In-reply-to: <1604375323-33556-1-git-send-email-tiantao6@hisilicon.com>
Message-ID: <1j361oazxs.fsf@starbuckisacylon.baylibre.com>
Date:   Thu, 05 Nov 2020 10:57:35 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 03 Nov 2020 at 04:48, Tian Tao <tiantao6@hisilicon.com> wrote:

> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/mmc/host/meson-mx-sdio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 1c5299c..d4a4891 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -418,10 +418,9 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
>  {
>  	struct meson_mx_mmc_host *host = (void *) data;
>  	u32 irqs, send;
> -	unsigned long irqflags;
>  	irqreturn_t ret;
>  
> -	spin_lock_irqsave(&host->irq_lock, irqflags);
> +	spin_lock(&host->irq_lock);
>  
>  	irqs = readl(host->base + MESON_MX_SDIO_IRQS);
>  	send = readl(host->base + MESON_MX_SDIO_SEND);
> @@ -434,7 +433,7 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
>  	/* finally ACK all pending interrupts */
>  	writel(irqs, host->base + MESON_MX_SDIO_IRQS);
>  
> -	spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +	spin_unlock(&host->irq_lock);
>  
>  	return ret;
>  }

