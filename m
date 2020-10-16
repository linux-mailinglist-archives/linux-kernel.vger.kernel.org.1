Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE329062E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407428AbgJPNUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406175AbgJPNUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:20:00 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91101208E4;
        Fri, 16 Oct 2020 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602854399;
        bh=rfvuV6Al+rLb9nUjAfzHGQK9DuIWt6YUWVj+UIEKlz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KD55CXGuyZ12HyX0m/0olwjfr6HTDjY7uf1hHPOTIXPDMBkTlOqSdyRJvJniVYkKO
         Lie30rb7KlUHlIw0WLIWVhZFw4XOcpwDK45E+1tbtu3P6pA0zJcwTiu6i1ACdaFV4g
         jgAIZvyIzEkTNvn854dV6qoNzny0h7hJ8Jrocjq4=
Received: by mail-oi1-f176.google.com with SMTP id c13so2383745oiy.6;
        Fri, 16 Oct 2020 06:19:59 -0700 (PDT)
X-Gm-Message-State: AOAM532VCFhtfNl9e8rsb4TXoWf1HGOPB9MzCfFG6cF+NlHQNnZ/xP6q
        iuuA1ODlNVmoBuBhD8roh7hMYGBWgsu1vr29kA==
X-Google-Smtp-Source: ABdhPJwxbMynzIU6zuNouBn+wKZ+/vyBd3EU7EY1Rlpcr59uCRZiPaTsqPTK2OQmhPBQ1tNjnBtuXZGHrNkXaL1AnJk=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr2509589oia.147.1602854398739;
 Fri, 16 Oct 2020 06:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de> <20201015054244.GD12218@lst.de>
In-Reply-To: <20201015054244.GD12218@lst.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Oct 2020 08:19:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKyRby5tp2JS1COodYf7F7sB_DJivyAe7FqQivp4KM6OA@mail.gmail.com>
Message-ID: <CAL_JsqKyRby5tp2JS1COodYf7F7sB_DJivyAe7FqQivp4KM6OA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
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

On Thu, Oct 15, 2020 at 12:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +     phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> > +     struct of_range_parser parser;
> > +     phys_addr_t subtree_max_addr;
> > +     struct device_node *child;
> > +     phys_addr_t cpu_end = 0;
> > +     struct of_range range;
> > +     const __be32 *ranges;
> > +     int len;
> > +
> > +     if (!np)
> > +             np = of_root;
>
> Requiring of_root to be passed explicitly would seem more natural
> to me than the magic NULL argument.  There doesn't seem to be any
> precedent for that kind of calling convention either.

I prefer that of_root is not more widely exposed and NULL regularly
means 'the whole tree'.

Rob
