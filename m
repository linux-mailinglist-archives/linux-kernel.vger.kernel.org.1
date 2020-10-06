Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB2285383
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgJFU4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgJFU4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:56:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1195C0613D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:56:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p13so9136543edi.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZ33m0een3FmBO5zM6YS30Fhun5lzxt8LRsuBmJ9np8=;
        b=Qfg5p3wmaIK8FSiIu4IdCn4X7nejDPhFFZhUVBVUejoaklw0Xl8abJMx/NPlE+GAYD
         GFFRBTXhLKiSTLhMEWACUyrBty03El/kGu4Ye5XJJWvvK/JT9MZ2EHl/BwOPsWpbvWqd
         6hSErfchiydyFBZt3FeeoxPWw3eNiC6MJ1Mv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZ33m0een3FmBO5zM6YS30Fhun5lzxt8LRsuBmJ9np8=;
        b=C28QhRaqk8BDbHFVv8g3aE8ZlIG6GDJYaUd2U1RCjWrk7PucvOtU1aIRHqjB8NOeUO
         89+7oqgdvcjrSv9noS56PVxi7/yQDGXMc/2huCWwNsxRPn6ThyOoctjQG49Xka0huiOO
         H8UnHIXWjkCHVlZEkI8zPsZTn1BJnTG4IqcW1ZHmjJnPMoyq6kGSRQFiISR4iGy4cVwH
         uV7S5Xhp1j4BZWSl7VXj15U3K1WevymjLm0xhbkoFeCZ1MSvchK4xVk74BlCBdUQ0vAC
         NdeVXj5W/VvhEFAF6CbhtSeP1qqiWw2pJsCpYYDzEC9eoeL12637zZCPvIznxN5CO5QF
         aRpw==
X-Gm-Message-State: AOAM5304p7T3Evr5eJyyURLF0WWouGaEz25S3TWi7rp3lKv+QS6lNTkB
        d7PvBVikrQzHnIaWoKgjFj70WXTLVifvbA==
X-Google-Smtp-Source: ABdhPJwJfS6uNbsVFArZNDIsICVQ6k47r05nghoZPMrc2Tenpt9V2sy7d9Y2KAxUZ0M29HzpBGUn9Q==
X-Received: by 2002:a05:6402:1515:: with SMTP id f21mr7909613edw.175.1602017778160;
        Tue, 06 Oct 2020 13:56:18 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id s25sm1941786ejc.29.2020.10.06.13.56.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:56:16 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id n18so7180828wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:56:16 -0700 (PDT)
X-Received: by 2002:adf:df8e:: with SMTP id z14mr6756108wrl.32.1602017775603;
 Tue, 06 Oct 2020 13:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de> <20200930160917.1234225-9-hch@lst.de>
 <20201002175040.GA1131147@chromium.org> <20201005082629.GA13850@lst.de>
In-Reply-To: <20201005082629.GA13850@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 6 Oct 2020 22:56:04 +0200
X-Gmail-Original-Message-ID: <CAAFQd5DcFjTUpOYkaz4nGxozgOc9oGf9QngjbpXWdcwXTT=kmw@mail.gmail.com>
Message-ID: <CAAFQd5DcFjTUpOYkaz4nGxozgOc9oGf9QngjbpXWdcwXTT=kmw@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 10:26 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Oct 02, 2020 at 05:50:40PM +0000, Tomasz Figa wrote:
> > Hi Christoph,
> >
> > On Wed, Sep 30, 2020 at 06:09:17PM +0200, Christoph Hellwig wrote:
> > > Add a new API that returns a virtually non-contigous array of pages
> > > and dma address.  This API is only implemented for dma-iommu and will
> > > not be implemented for non-iommu DMA API instances that have to allocate
> > > contiguous memory.  It is up to the caller to check if the API is
> > > available.
> >
> > Would you mind scheding some more light on what made the previous attempt
> > not work well? I liked the previous API because it was more consistent with
> > the regular dma_alloc_coherent().
>
> The problem is that with a dma_alloc_noncoherent that can return pages
> not in the kernel mapping we can't just use virt_to_page to fill in
> scatterlists or mmap the buffer to userspace, but would need new helpers
> and another two methods.
>
> > >  - no kernel mapping or only temporary kernel mappings are required.
> > >    That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
> > >  - a kernel mapping is required for cached and DMA mapped pages, but
> > >    the driver also needs the pages to e.g. map them to userspace.
> > >    In that sense it is a replacement for some aspects of the recently
> > >    removed and never fully implemented DMA_ATTR_NON_CONSISTENT
> >
> > What's the expected allocation and mapping flow with the latter? Would that be
> >
> > pages = dma_alloc_noncoherent(...)
> > vaddr = vmap(pages, ...);
> >
> > ?
>
> Yes.  Witht the vmap step optional for replacements of
> DMA_ATTR_NO_KERNEL_MAPPING, which is another nightmare to deal with.
>
> > Would one just use the usual dma_sync_for_{cpu,device}() for cache
> > invallidate/clean, while keeping the mapping in place?
>
> Yes.  And make sure the API isn't implemented when VIVT caches are
> used, but that isn't really different from the current interface.

Okay, thanks. Let's see if we can make necessary changes to the videobuf2.

+Sergey Senozhatsky for awareness too.

Best regrards,
Tomasz
