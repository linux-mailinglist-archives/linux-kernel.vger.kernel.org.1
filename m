Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874EB28E8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgJNWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 18:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgJNWEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 18:04:43 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C31A2224E;
        Wed, 14 Oct 2020 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602713082;
        bh=2zxpdSUShETO8tOrEebuH3FEpgqr1/cYJUaqMy6YzLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PL3xl9TEA4q0/1MEIx1Ikx+tz3HGIsT86wGyFex+TmWPGfJIfVtla5dKIbE2f9pjP
         biko9X5iDzNpabXOngSdhYPACa4jIGmnH2CVnSWaF3KOAUAQQdusZAqfEUNaUKlK2R
         HLso/M5B0NBXKRByqcy5R7syyu4y/9z9mgu6wzlU=
Received: by mail-oi1-f180.google.com with SMTP id w141so874517oia.2;
        Wed, 14 Oct 2020 15:04:42 -0700 (PDT)
X-Gm-Message-State: AOAM531yNYGa93rH/iOjbzDNhpdBsXqu8yy+P9w/CpTFgAMl7VscSMTI
        6wRU8mFYjEKYL8act2/DMyl/orNKk7oWZVhgqw==
X-Google-Smtp-Source: ABdhPJzXFxZwWyGnc9TNmrtU0RSpAPz5wj+JC9I4DklEciLqy/06NwQfoIR1rLErg1OAmFLR4vmaArWnDM+vbUZxLsc=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr190700oie.152.1602713081587;
 Wed, 14 Oct 2020 15:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de> <20201014191211.27029-5-nsaenzjulienne@suse.de>
In-Reply-To: <20201014191211.27029-5-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Oct 2020 17:04:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
Message-ID: <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] of: unittest: Add test for of_dma_get_max_cpu_address()
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

On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Introduce a test for of_dma_get_max_cup_address(), it uses the same DT
> data as the rest of dma-ranges unit tests.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/unittest.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 06cc988faf78..2cbf2a585c9f 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -869,6 +869,25 @@ static void __init of_unittest_changeset(void)
>  #endif
>  }
>
> +static void __init of_unittest_dma_get_max_cpu_address(void)
> +{
> +#ifdef CONFIG_HAS_DMA

Can't the unittest run without this? I run the unittests under UML.

> +       struct device_node *np;
> +       phys_addr_t cpu_addr;
> +
> +       np = of_find_node_by_path("/testcase-data/address-tests");
> +       if (!np) {
> +               pr_err("missing testcase data\n");
> +               return;
> +       }
> +
> +       cpu_addr = of_dma_get_max_cpu_address(np);
> +       unittest(cpu_addr == 0x50000000ULL,
> +                "of_dma_get_max_cpu_address: wrong CPU addr %pad (expecting %llx)\n",
> +                &cpu_addr, 0x50000000ULL);
> +#endif
> +}
> +
>  static void __init of_unittest_dma_ranges_one(const char *path,
>                 u64 expect_dma_addr, u64 expect_paddr)
>  {
> @@ -3266,6 +3285,7 @@ static int __init of_unittest(void)
>         of_unittest_changeset();
>         of_unittest_parse_interrupts();
>         of_unittest_parse_interrupts_extended();
> +       of_unittest_dma_get_max_cpu_address();
>         of_unittest_parse_dma_ranges();
>         of_unittest_pci_dma_ranges();
>         of_unittest_match_node();
> --
> 2.28.0
>
