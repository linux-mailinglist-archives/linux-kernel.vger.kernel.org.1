Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC252A35C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgKBVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgKBVDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:03:55 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB62208B6;
        Mon,  2 Nov 2020 21:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604351034;
        bh=QIKekPJv96xapfmbeqZyRV7a8wmsfIVO5Ur1tFoBsxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CRnAq/wtmByBOoYx6V660YQRskTnHR9OSZtGMGbDhceo0HaOQq8ExSCwlBTJZU67/
         7+EdwCiOci/5xcpmUCMEKbhzur7k8vzQm+klaLkVJwNkE9a4SWOr4V0X9/EFV+EPl7
         hdeF+vxR15bfQ3DHwlRqmx/Ac5qW0dNeY937DLcs=
Received: by mail-oi1-f179.google.com with SMTP id x1so16060285oic.13;
        Mon, 02 Nov 2020 13:03:54 -0800 (PST)
X-Gm-Message-State: AOAM532afU8upChQxncV+3hkGuVuGQPjsAj4JxrTvfj8Q6IxGmkayGPz
        WiJ4j5g7Gz2kzuG5HqMwr7hpw1Q/GEHHvH+wKg==
X-Google-Smtp-Source: ABdhPJxFDSpXQtYVkltDyCL0k7wfhpIaDYr2QVmapb626fGuhI4EWsl4osaRewc4U9X7lcZXH/ws1+nFb7iAqLwe9h8=
X-Received: by 2002:a54:4588:: with SMTP id z8mr15353oib.147.1604351034017;
 Mon, 02 Nov 2020 13:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20201029172550.3523-1-nsaenzjulienne@suse.de> <20201029172550.3523-4-nsaenzjulienne@suse.de>
In-Reply-To: <20201029172550.3523-4-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Nov 2020 15:03:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK17XTkHg1YVeyKmfEL7BO2xGxjUC2WccBEbcY+vOngDA@mail.gmail.com>
Message-ID: <CAL_JsqK17XTkHg1YVeyKmfEL7BO2xGxjUC2WccBEbcY+vOngDA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] of/address: Introduce of_dma_get_max_cpu_address()
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
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:26 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
> physical address addressable by all DMA masters in the system. It's
> specially useful for setting memory zones sizes at early boot time.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes since v4:
>  - Return max address, not address limit (one-off difference)
>
> Changes since v3:
>  - use u64 with cpu_end
>
> Changes since v2:
>  - Use PHYS_ADDR_MAX
>  - return phys_dma_t
>  - Rename function
>  - Correct subject
>  - Add support to start parsing from an arbitrary device node in order
>    for the function to work with unit tests
>
>  drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |  7 +++++++
>  2 files changed, 49 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
