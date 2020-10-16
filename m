Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9629096D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409803AbgJPQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409713AbgJPQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:13:23 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A5DC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:13:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n6so4423400ioc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SzfzkDBitQIi0dWl8hQ69VYetsUqJh1EpiO/PjfBVJ4=;
        b=jYFxSj0G8MEyNA6azgjTlI3p9WfsDHDEmQs6T3SvBZ2nPAHKqlNsKge/SQ531tHmcc
         AKcp/SO2BB1Fkw4uqOgO4xPcvAuls/is8lUdMvYQC/f3NKFiu0nmtm+Bn/y3IMI27SdB
         EVv/SiDOsylMgzjjUSuVh2dBkVf+OTtUjnLp3EDWRYIFPsNAVbZ7XEPR1ge5yEo9tPvw
         1/WhhUZywzgh4WCtd9LFge+gy+I3UA6EWus/7VeckFhN9Wh36+DPxt+JU+rla7OrDvof
         UEOc4BTCnqfvCbZ6fIrXvMvG72jUwxm1v/fpGdA22meHccsaDiS5CqNvbuhFAWPV/aO9
         7jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SzfzkDBitQIi0dWl8hQ69VYetsUqJh1EpiO/PjfBVJ4=;
        b=okL9PN+JPN4uXEcQjvOgAJZKvZqrUIdBzHbcCxedX6ruu+rjFvLJSqW89CzNhuWm/e
         /Tt24M635Oi6jTsWPefJWmrRcjuOQIgYA784L2sWybn4VnztlKBWWKVL/n5xyaT/XE3z
         E35LVpE4YxrFUpTIWKVfhFbKsuO1olVdtNS0p2OjPtA5pZxCWMBY8rK1wwxNChBk/KBz
         V2XMNw2DLu+htuYZr6lkwvHMKDWiQnI0wBGKSVSGV0fj4KVLjjRnPHBrq8dQ1reWVHC1
         +uXrcoAeXgSCJKC4idXxNTV49h5O5KRqs90awHuEH+Uw4Ve1HALe+UW1k98Ykzzmlfov
         eaIA==
X-Gm-Message-State: AOAM532wjcYk/T2H5xOEodXLVMZClXoXRqjNtvUqoFaYli1Of1NFQpIi
        haqPiZxa9FyaPE2xHx7YA5YuWA==
X-Google-Smtp-Source: ABdhPJzTc2rLvv4IerCZW/tHbEy8NKIi/ATblrGysyjzLvEYe0ppftMeHbv9aVUT0VxOy6SpaKvMQQ==
X-Received: by 2002:a02:b80f:: with SMTP id o15mr3153369jam.103.1602864802734;
        Fri, 16 Oct 2020 09:13:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g17sm2378255ilq.15.2020.10.16.09.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:13:22 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTSM5-000edC-4i; Fri, 16 Oct 2020 13:13:21 -0300
Date:   Fri, 16 Oct 2020 13:13:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        chris@chris-wilson.co.uk, airlied@redhat.com, daniel@ffwll.ch,
        sumit.semwal@linaro.org, willy@infradead.org, jhubbard@nvidia.com,
        linmiaohe@huawei.com
Subject: Re: [PATCH 2/2] mm: introduce vma_set_file function v4
Message-ID: <20201016161321.GF36674@ziepe.ca>
References: <20201012085203.56119-1-christian.koenig@amd.com>
 <20201012085203.56119-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201012085203.56119-2-christian.koenig@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:52:03AM +0200, Christian König wrote:
> Add the new vma_set_file() function to allow changing
> vma->vm_file with the necessary refcount dance.
> 
> v2: add more users of this.
> v3: add missing EXPORT_SYMBOL, rebase on mmap cleanup,
>     add comments why we drop the reference on two occasions.
> v4: make it clear that changing an anonymous vma is illegal.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v2)
> ---
>  drivers/dma-buf/dma-buf.c                  |  3 +--
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c      |  4 +---
>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c |  3 +--
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c   |  5 +++--
>  drivers/gpu/drm/msm/msm_gem.c              |  4 +---
>  drivers/gpu/drm/omapdrm/omap_gem.c         |  3 +--
>  drivers/gpu/drm/vgem/vgem_drv.c            |  3 +--
>  drivers/staging/android/ashmem.c           |  6 +++---
>  include/linux/mm.h                         |  2 ++
>  mm/mmap.c                                  | 12 ++++++++++++
>  10 files changed, 26 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
