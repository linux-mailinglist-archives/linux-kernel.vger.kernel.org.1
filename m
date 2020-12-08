Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFC2D3052
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgLHQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgLHQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:56:45 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06512C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 08:56:04 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id u21so12354725qtw.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zJCFBWmnrCjIsCfIXtOANynWilFtdxBgWzL9qsHoBgk=;
        b=p+scvweiVtiWtaEakkIVG6rtVNVZdKC4xEMfsVUAkGkAs5h511JtSfYxxQKM14TDDZ
         fEfsaNp/p3BIDs6/X5JkgItrkLy28f8w/iXwVs8TOXGvhPzn4yLR4EEZGuAWgZpf7hxm
         oICvzMJUysvE4HibNIZDkAAh0EB5bEH7gm97HngzdHKm0EqEdUZC3jJJlDhbSGP+jrlQ
         i6flmV7bIH7Uj9jADLa2clZybJ4fkdv64UEfyWf+pYG3D/kAh+qY8Li8uChCQAf6Mi78
         64m49oUhL9tAhdmz2zf54q2cz/TMbc7BXuA5mmIQNaBFG1KQeFg56u1CVDBfyUkSVxA2
         DWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zJCFBWmnrCjIsCfIXtOANynWilFtdxBgWzL9qsHoBgk=;
        b=F4P+7UA+8hgN8148AtKwCnQNI8ossF/TVI0+4wyDipCqKt5gNXuUz008HfXbT9bOq3
         W++SkQYlVW12pQC2+IKWprORKkWJNOnvhsCrdEpQrWhGDjFVd0egVaXX9MjBgdBqRFbW
         QIRvE8CALyw1zI1t8pdsiP5rxV8IvYzjKhR1lkb5SBYt10aD3XXht5UduiJelvuYorIR
         qNdtptmApVIJeBrRqPrgzpO5OBpdwbB8r0lf9g5vTOu6w2t5nLclGYXJbrCge80NsLW4
         a4u0AwAlQ0g7tg/zfqrc5ilsR9sQFonkPkWFqZlNbIeXjWjIFYjggQt+V+t3baLKqvOX
         Vvnw==
X-Gm-Message-State: AOAM532J3VXKVSwNv1j8n7ZWDLE8usemEh9Du/yfnbjonZp3lQzyZDAA
        d7wug/ncaT+1z5AXnMx46k21cA==
X-Google-Smtp-Source: ABdhPJz6DEGfHZWtsRRNwbE8f3Jk7xHwzlJ8lJRqvWgr85V2qI9546FeZHjPEkuxohNdKuvO79ZOpw==
X-Received: by 2002:ac8:76c7:: with SMTP id q7mr30486415qtr.317.1607446564196;
        Tue, 08 Dec 2020 08:56:04 -0800 (PST)
Received: from nicolas-tpx395.lan (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id y22sm4953552qkj.129.2020.12.08.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:56:03 -0800 (PST)
Message-ID: <13e1fbc75080aada90fd92954ad1fea39f4c1c7a.camel@ndufresne.ca>
Subject: Re: [PATCH 0/4] Chunk Heap Support on DMA-HEAP
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        hyesoo.yu@samsung.com, willy@infradead.org, david@redhat.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, surenb@google.com,
        pullip.cho@samsung.com, joaodias@google.com, hridya@google.com,
        sumit.semwal@linaro.org, john.stultz@linaro.org,
        Brian.Starkey@arm.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org
Date:   Tue, 08 Dec 2020 11:56:01 -0500
In-Reply-To: <20201117181935.3613581-1-minchan@kernel.org>
References: <20201117181935.3613581-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 17 novembre 2020 à 10:19 -0800, Minchan Kim a écrit :
> This patchset introduces a new dma heap, chunk heap that makes it
> easy to perform the bulk allocation of high order pages.
> It has been created to help optimize the 4K/8K HDR video playback
> with secure DRM HW to protect contents on memory. The HW needs
> physically contiguous memory chunks up to several hundred MB memory.
> 
> The chunk heap is registered by device tree with alignment and memory
> node of Contiguous Memory Allocator(CMA). Alignment defines chunk page size.
> For example, alignment 0x1_0000 means chunk page size is 64KB.
> The phandle to memory node indicates contiguous memory allocator(CMA).
> If device node doesn't have cma, the registration of chunk heap fails.
> 
> This patchset is against on next-20201110.

I believe you have forgot to reference Open Source / Upstream code using this.

regards,
Nicolas

> 
> The patchset includes the following:
>  - cma_alloc_bulk API
>  - export dma-heap API to register kernel module dma heap.
>  - add chunk heap implementation.
>  - devicetree
> 
> Hyesoo Yu (3):
>   dma-buf: add export symbol for dma-heap
>   dma-buf: heaps: add chunk heap to dmabuf heaps
>   dma-heap: Devicetree binding for chunk heap
> 
> Minchan Kim (1):
>   mm: introduce cma_alloc_bulk API
> 
>  .../bindings/dma-buf/chunk_heap.yaml          |  52 ++
>  drivers/dma-buf/dma-heap.c                    |   2 +
>  drivers/dma-buf/heaps/Kconfig                 |   9 +
>  drivers/dma-buf/heaps/Makefile                |   1 +
>  drivers/dma-buf/heaps/chunk_heap.c            | 458 ++++++++++++++++++
>  include/linux/cma.h                           |   5 +
>  include/linux/page-isolation.h                |   1 +
>  mm/cma.c                                      | 129 ++++-
>  mm/page_alloc.c                               |  19 +-
>  mm/page_isolation.c                           |   3 +-
>  10 files changed, 666 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma-buf/chunk_heap.yaml
>  create mode 100644 drivers/dma-buf/heaps/chunk_heap.c
> 


