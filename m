Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC78828BBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgJLPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388984AbgJLPZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:25:25 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DD2208D5;
        Mon, 12 Oct 2020 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602516324;
        bh=bIkKTbcUZtX9LoLNwSifZfSlJSm+lTIbvj8ANEPWg+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uxZf4iW79VnNA5czZ7+lfYfL5mZh/NTtQp8P1PUO/mrWTeniv1u3OVK8c7bMYmXVw
         wU947G/HociXcrlo7OV167y6SyyB9Lqora51+m25lwRLW/rlQgarEnehXa9R0cIao6
         JNo23nmkZcwJ70/WjKMzFieZygaW1q7ZDG+w2wzU=
Received: by mail-ot1-f51.google.com with SMTP id m11so16122203otk.13;
        Mon, 12 Oct 2020 08:25:24 -0700 (PDT)
X-Gm-Message-State: AOAM531TDwHuHn0zHsJJs8yM8vE+GBwaSnlJwSCkF2rJLGMJJwTTmX13
        6CheKC1FVGJQiL7N5kAtMhSeZR0b0sCPhXFcTQ==
X-Google-Smtp-Source: ABdhPJzn/48d6MtUs58/VlMn2lXXGtFdr5KMFZ9WLc1IRZmoznfmeWfNkAM04VmTyhwnzuvsMRlIu9LYOOnGR3XI80o=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr15487657otm.129.1602516323477;
 Mon, 12 Oct 2020 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de> <20201010151235.20585-3-nsaenzjulienne@suse.de>
In-Reply-To: <20201010151235.20585-3-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Oct 2020 10:25:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2cs+cko-UuTd37fnBKO_=3jQeyjB49USvm_VTBwcS8g@mail.gmail.com>
Message-ID: <CAL_JsqL2cs+cko-UuTd37fnBKO_=3jQeyjB49USvm_VTBwcS8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 10:12 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> The function provides the CPU physical address addressable by the most
> constrained bus in the system. It might be useful in order to
> dynamically set up memory zones during boot.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/address.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |  7 +++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index eb9ab4f1e80b..755e97b65096 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1024,6 +1024,40 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  }
>  #endif /* CONFIG_HAS_DMA */
>
> +/**
> + * of_dma_safe_phys_limit - Get system wide DMA safe address space
> + *
> + * Gets the CPU physical address limit for safe DMA addressing system wide by
> + * searching for the most constraining dma-range. Otherwise it returns ~0ULL.
> + */
> +u64 __init of_dma_safe_phys_limit(void)
> +{
> +       struct device_node *np = NULL;
> +       struct of_range_parser parser;
> +       const __be32 *ranges = NULL;
> +       u64 phys_dma_limit = ~0ULL;
> +       struct of_range range;
> +       int len;
> +
> +       for_each_of_allnodes(np) {
> +               dma_addr_t cpu_end = 0;
> +
> +               ranges = of_get_property(np, "dma-ranges", &len);
> +               if (!ranges || !len)
> +                       continue;
> +
> +               of_dma_range_parser_init(&parser, np);
> +               for_each_of_range(&parser, &range)
> +                       if (range.cpu_addr + range.size > cpu_end)
> +                               cpu_end = range.cpu_addr + range.size;

This doesn't work if you have more than one level of dma-ranges. The
address has to be translated first. It should be okay to do that on
the start or end address (if not, your DT is broken).

Please add/extend a unittest for this.

> +
> +               if (phys_dma_limit > cpu_end)
> +                       phys_dma_limit = cpu_end;
> +       }
> +
> +       return phys_dma_limit;
> +}
> +
>  /**
>   * of_dma_is_coherent - Check if device is coherent
>   * @np:        device node
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 481ec0467285..958c64cffa92 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -558,6 +558,8 @@ int of_map_id(struct device_node *np, u32 id,
>                const char *map_name, const char *map_mask_name,
>                struct device_node **target, u32 *id_out);
>
> +u64 of_dma_safe_phys_limit(void);
> +
>  #else /* CONFIG_OF */
>
>  static inline void of_core_init(void)
> @@ -995,6 +997,11 @@ static inline int of_map_id(struct device_node *np, u32 id,
>         return -EINVAL;
>  }
>
> +static inline u64 of_dma_safe_phys_limit(void)
> +{
> +       return ~0ULL;
> +}
> +
>  #define of_match_ptr(_ptr)     NULL
>  #define of_match_node(_matches, _node) NULL
>  #endif /* CONFIG_OF */
> --
> 2.28.0
>
