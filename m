Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B70D281A18
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbgJBRuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbgJBRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:50:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D32C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:50:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so2721444wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qAPpXyP2inoV5988zgEtk6OBNQO3398NaIIov4Pf6CQ=;
        b=RJpr45/4P2FGGNGEF9uVylMkqY1nCY362/Pe04N9/zLIkTKj6c8tlNLV0p5RD/a0TT
         Ty3+xJBDLUvDrEZAqV5tSAB08542QPBDKf/vqu2XDmGQ75qRztQF3N6COsP+/FvHxri2
         qdumrnufMfHTTgIumy0jLCxdGJjwz6xFIYUPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qAPpXyP2inoV5988zgEtk6OBNQO3398NaIIov4Pf6CQ=;
        b=BkwNjHisqHToHbqWWXS5ZJ1BHi4et5cfg/oKnNBVPbf/CJckIwwQ7u699Ti/K4AfW0
         CiVKDHp2jZKcMV1VC4MfqbwJRNuc5cvEI9JkpzPAteis2jY78P16g3SWm9mv7E9tg4vU
         rW96iS9WHV800u7DtKsY9D7B6efE0prLrfOy9IRmR5BigT9xXFc63Uf/t/ulI654wGif
         O8JOov8GpBkn/RqD9NkNhGr9Lv+xA1VWC94WqU1gSyQRo963kUNz9WITz+Tteon2h1ru
         bE+sF2rxzbbLvdOxAQiHz7sPznW057yERGbDcEoP9uuWdc6WCDlROaSf4TBusSckHu3H
         XmwA==
X-Gm-Message-State: AOAM532yYu8w5Bc5SNUPZ8GrDNRCIBict6gEcLRY81EEqhczfVj4AenV
        nzOO1VmvRVE8aRTOofyVHz6Lhw==
X-Google-Smtp-Source: ABdhPJxSyoTgiDrvz+UtW8zZTkuPjuaRZvm7GtOtIfqF/g+LFn4V8JKTG6/VT+K90I9I9WVVS78v7w==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr4667478wrs.153.1601661042072;
        Fri, 02 Oct 2020 10:50:42 -0700 (PDT)
Received: from chromium.org (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id d19sm2604808wmd.0.2020.10.02.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:50:41 -0700 (PDT)
Date:   Fri, 2 Oct 2020 17:50:40 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
Message-ID: <20201002175040.GA1131147@chromium.org>
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930160917.1234225-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Sep 30, 2020 at 06:09:17PM +0200, Christoph Hellwig wrote:
> Add a new API that returns a virtually non-contigous array of pages
> and dma address.  This API is only implemented for dma-iommu and will
> not be implemented for non-iommu DMA API instances that have to allocate
> contiguous memory.  It is up to the caller to check if the API is
> available.

Would you mind scheding some more light on what made the previous attempt
not work well? I liked the previous API because it was more consistent with
the regular dma_alloc_coherent().

> 
> The intent is that media drivers can use this API if either:

FWIW, the USB subsystem also has similar needs, and so do some DRM drivers
using DMA API rather than IOMMU API directly. Basically I believe that all
the users removed in your previous series relied on custom downstream
patches to make DMA_ATTR_NON_CONSISTENT work and could be finally made work
in upstream using this API.

> 
>  - no kernel mapping or only temporary kernel mappings are required.
>    That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
>  - a kernel mapping is required for cached and DMA mapped pages, but
>    the driver also needs the pages to e.g. map them to userspace.
>    In that sense it is a replacement for some aspects of the recently
>    removed and never fully implemented DMA_ATTR_NON_CONSISTENT

What's the expected allocation and mapping flow with the latter? Would that be

pages = dma_alloc_noncoherent(...)
vaddr = vmap(pages, ...);

?

Would one just use the usual dma_sync_for_{cpu,device}() for cache
invallidate/clean, while keeping the mapping in place?

Best regards,
Tomasz
