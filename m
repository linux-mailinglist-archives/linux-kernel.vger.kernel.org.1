Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAAC2F5D01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbhANJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbhANJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:12:59 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F35C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:12:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so2593091plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2clGFKfMvWdEL24a/hrPW/SoKgcT/5YZOK8G2tupLA=;
        b=X7SGbsqsGRlUtP0PJCg54RJ4TAlmaAHUG3xPdqjVb0oScLVfStGatbndpS03GsNgnP
         Ay7KF7sGV28MuK8UBUQD50tmV7MICCg9iHgn3dDmdiN2V0+w2jb02zv0Fvhtiq/Aou7X
         FWO4E0ky5/69bheieFiKWNwRnHzuorBEbyewE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2clGFKfMvWdEL24a/hrPW/SoKgcT/5YZOK8G2tupLA=;
        b=s/DNt5FkjiRVYrToQuTXuhEL3tJ0tE8sazy25Ovn4qnfVaJ7TRcIpIZRtUcMfdF6t4
         Vf7ZjYmdebUN5bHSalDkN1bE3h0LvmUzcy7nyo5WsVWLBYyCdeIzzec4R9mQIzMRLvqg
         H1krL34v/SYIVRw5eB1QziAzZvhwWhCR//QfXhCdGfkMdTPq8OZXCProDG8kjQtXkzhK
         cZ1XWiifpKTjeEJjRYw+FBsORmcEIgoxnRW8ZDGU3or0Ar1K6SSt6b8XmXc2cJHu5jp1
         jF1s0Stm3H11kpCKz8ulVjJlh4lijV1FV2IIsLvtqkXAuttKuMLhkio0XhokhC+iC8UH
         2nbA==
X-Gm-Message-State: AOAM5315/071aHLI72LLDqPBqIJrQubyf/CavNDXbeoEtce1EI/lcXY8
        hd48kN4FT3FbpV4wNTXbIQyHPaHSuNgAug==
X-Google-Smtp-Source: ABdhPJy9C6cAnQpEbsQZCyhTOnlPYlT+aq9iHVuiVO+8bwpNc2qySGRhOUi1NPBKSto4FHAI7rgh2g==
X-Received: by 2002:a17:902:ea0f:b029:de:5fd5:abb9 with SMTP id s15-20020a170902ea0fb02900de5fd5abb9mr1123175plg.46.1610615532762;
        Thu, 14 Jan 2021 01:12:12 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id q16sm4801579pfg.139.2021.01.14.01.12.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 01:12:12 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id n7so3369396pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:12:12 -0800 (PST)
X-Received: by 2002:a92:ce8f:: with SMTP id r15mr4926327ilo.303.1610615178346;
 Thu, 14 Jan 2021 01:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-3-tientzu@chromium.org>
 <20210113124209.GA1383@lst.de>
In-Reply-To: <20210113124209.GA1383@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 14 Jan 2021 17:06:07 +0800
X-Gmail-Original-Message-ID: <CALiNf2-a6JpbeyfCoGdjFAbguxwW5kn1r_Oq6yr+k1rGum7O8Q@mail.gmail.com>
Message-ID: <CALiNf2-a6JpbeyfCoGdjFAbguxwW5kn1r_Oq6yr+k1rGum7O8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, will@kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, grant.likely@arm.com,
        xypron.glpk@gmx.de, Thierry Reding <treding@nvidia.com>,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rdunlap@infradead.org, dan.j.williams@intel.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org, Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 8:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#ifdef CONFIG_SWIOTLB
> > +     struct io_tlb_mem       *dma_io_tlb_mem;
> >  #endif
>
> Please add a new config option for this code instead of always building
> it when swiotlb is enabled.
>
> > +static int swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> > +                                size_t size)
>
> Can you split the refactoring in swiotlb.c into one or more prep
> patches?
>
> > +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> > +                                 struct device *dev)
> > +{
> > +     struct io_tlb_mem *mem = rmem->priv;
> > +     int ret;
> > +
> > +     if (dev->dma_io_tlb_mem)
> > +             return -EBUSY;
> > +
> > +     if (!mem) {
> > +             mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > +             if (!mem)
> > +                     return -ENOMEM;
>
> What is the calling convention here that allows for a NULL and non-NULL
> private data?

Since multiple devices can share the same pool, the private data,
io_tlb_mem struct, will be initialized by the first device attached to
it.
This is similar to rmem_dma_device_init() in kernel/dma/coherent.c.
I'll add a comment for it in next version.
