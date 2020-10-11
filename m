Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0828A633
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgJKHrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 03:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgJKHrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 03:47:19 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E90721655;
        Sun, 11 Oct 2020 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602402438;
        bh=LeMk4xJlrd34ez5NF8BLWNvKsm7wmDmT9qOElPmUWJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v/c/sPXgnEOq4jJilWSpg55W4tKtlomIYm1wAbddQ2HT95xbpKy1cqZuTe19B0HXa
         vXtH1ypj1myh2B5wxSb07CcHyn/W0XRokJ8BC/2+18WZAtTserlel3yq1lSoDlkCya
         siAgTAnuorrjI5JTy0j7BmFwcMGRtGYCNnXGXOu4=
Received: by mail-oi1-f176.google.com with SMTP id c13so15217421oiy.6;
        Sun, 11 Oct 2020 00:47:18 -0700 (PDT)
X-Gm-Message-State: AOAM5316OYFJQBItAJwUum5moAVDWxtXLuNal9MS+I6KNN8Ah4O+7iFF
        Bj1ZblS/5FRRyY3AZCzLNVYhMmOzRagb0zZQMkw=
X-Google-Smtp-Source: ABdhPJzehloTufc7iRScDFdIAGd9rllMxSjs4e6a5wOBu7xWhcMoE7AB1Xcx7jsGo6uja6Hkh8/PgItFqPjyPS/T9s4=
X-Received: by 2002:aca:d845:: with SMTP id p66mr7029591oig.47.1602402437582;
 Sun, 11 Oct 2020 00:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de> <20201010151235.20585-3-nsaenzjulienne@suse.de>
In-Reply-To: <20201010151235.20585-3-nsaenzjulienne@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 11 Oct 2020 09:47:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
Message-ID: <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        iommu@lists.linux-foundation.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

$SUBJECT is out of sync with the patch below. Also, for legibility, it
helps if the commit log is intelligible by itself, rather than relying
on $SUBJECT being the first line of the first paragraph.

On Sat, 10 Oct 2020 at 17:12, Nicolas Saenz Julienne
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

I don't think 'safe' strikes the right tone here. You are looking for
the highest CPU address that is addressable by all DMA masters in the
system.

Something like

of_dma_get_max_cpu_address(void)

perhaps? Also, since this is generic code, phys_addr_t is probably a
better type to return.


> +{
> +       struct device_node *np = NULL;
> +       struct of_range_parser parser;
> +       const __be32 *ranges = NULL;

I think you can drop these NULL initializers.

> +       u64 phys_dma_limit = ~0ULL;

PHYS_ADDR_MAX

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
