Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B712B5B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgKQIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQIrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:47:03 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BDF82222E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605602822;
        bh=8mKP2PnMrXb8pSAFGjkUhR+y2OSQJy+Trmhkg0W7hpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fdmNQDuEiGHH46IjOLmJt9wa7LV4cw0Bd/lKBgyQbnlm+E8u6L4sKiI4fMY9Fbq8z
         3i1FtjyHLtJOIdAD7bYyOgtUsQWCM6dAQLZ61BDBE2AJaN7AC1GgO1xuolo+VHr6XH
         +c2ha47R73VAVLu1f8fO0f4BQlKashOt0duHQudE=
Received: by mail-oi1-f182.google.com with SMTP id c80so21842599oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:47:02 -0800 (PST)
X-Gm-Message-State: AOAM532YuDy3EAn+tk6eiDi3DsAyjoLlZrDJA9+5Ugj5Je+T02FuRV7t
        AkaeVkppzFmfsAysGIqEP744sS8YmMpbl1QOen4=
X-Google-Smtp-Source: ABdhPJy5rB97+CycGiCUgJFFfUgyRHTiWOe3TzWvRjnUoqr7eQTRND3JQTQmMnyskkIyldZwfB21jtR4kbCQh3cOmiQ=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr1772480oib.33.1605602821777;
 Tue, 17 Nov 2020 00:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20201117032015.11805-1-cbz@baozis.org>
In-Reply-To: <20201117032015.11805-1-cbz@baozis.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Nov 2020 09:46:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF+QoUwCdG=HL6Geyv8mxPTZF4PqEiFCXZm2kFQDC4N+Q@mail.gmail.com>
Message-ID: <CAMj1kXF+QoUwCdG=HL6Geyv8mxPTZF4PqEiFCXZm2kFQDC4N+Q@mail.gmail.com>
Subject: Re: [PATCH] irqchip/exiu: Fix the index of fwspec for IRQ type
To:     Chen Baozi <cbz@baozis.org>, Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Marc)

On Tue, 17 Nov 2020 at 04:20, Chen Baozi <cbz@baozis.org> wrote:
>
> From: Chen Baozi <chenbaozi@phytium.com.cn>
>
> Since fwspec->param_count of ACPI node is two, the index of IRQ type
> in fwspec->param[] should be 1 rather than 2.
>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> ---
>  drivers/irqchip/irq-sni-exiu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
> index 1d027623c776..abd011fcecf4 100644
> --- a/drivers/irqchip/irq-sni-exiu.c
> +++ b/drivers/irqchip/irq-sni-exiu.c
> @@ -136,7 +136,7 @@ static int exiu_domain_translate(struct irq_domain *domain,
>                 if (fwspec->param_count != 2)
>                         return -EINVAL;
>                 *hwirq = fwspec->param[0];
> -               *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> +               *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>         }
>         return 0;
>  }
> --
> 2.28.0
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
