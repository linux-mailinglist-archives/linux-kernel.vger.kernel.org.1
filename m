Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9AC2C829C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgK3KuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgK3KuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:50:02 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70966C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:49:22 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id g1so10789331ilk.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrBQ+cllYh0Y6esR/SPkKcDu8fDsRwcNF9P9vUYZvL4=;
        b=EqEeBGdID896KqQP2wGl3MacDZiftoQYvHOoa+q0ty3hiMysQXNvD+Cbzd5XWyH6oC
         /R/jipmJirrS7xxuCq09QfhPWJ6BcZs6J5DXml/OSDTep21CZvCNfFppev46/gu0R/Dp
         L8taqeCxff7s2jiuUfS1zwdg22lepLaEZGuQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrBQ+cllYh0Y6esR/SPkKcDu8fDsRwcNF9P9vUYZvL4=;
        b=XxinWuqLrTGcr5iUaKDJrvVDkrj5KpI0g9/lGuVdAtvzXWfU1she21Zg7YwScsjyk9
         rWb9a+nkM6PsKrAr2lBo8QY1ysCYSgKcAuMTdUXMbQJEMcNB4nivkjluDXgITq6v5YDH
         jsfUEsYBumD9ZO6X2H6xCbmyCnuX5Cvgsx+EQvYuyvqcSP7tBX+mIk+em8WzORGLUsm2
         4j4oPCageiHLxhpSFIlQl/7a3+mGCzM1NAczUxjYFbbYI4yrI/48qcaYXoBC3uZwm7DN
         CZbJGv4nWfKILXg/rw0OtVXa6TDY3dTi1cuooDpXMYO25NVqwCF3Vn983P4Hu6ix13Fk
         4W6Q==
X-Gm-Message-State: AOAM532j9Co02zoZ2YX9nU6HKnA8xMWEIQ0J49XKRXjZlYWPblZKRd5m
        7XJ+AeGWSH6uv5xSSX8hcb99zXUMcZQ8Bw==
X-Google-Smtp-Source: ABdhPJwAdyUNm9zqa397pgYsGBFa2hTAggr5uA2hWSnfoNOxQCpPoawQDJ6rMI8SN05QCy32GepAKw==
X-Received: by 2002:a92:dc07:: with SMTP id t7mr17148700iln.189.1606733361596;
        Mon, 30 Nov 2020 02:49:21 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id c14sm2762729ili.15.2020.11.30.02.49.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 02:49:20 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id z5so11222249iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:49:20 -0800 (PST)
X-Received: by 2002:a02:c042:: with SMTP id u2mr12243455jam.32.1606733360204;
 Mon, 30 Nov 2020 02:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org> <20201130083410.GD32234@lst.de>
In-Reply-To: <20201130083410.GD32234@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 30 Nov 2020 11:49:09 +0100
X-Gmail-Original-Message-ID: <CANiDSCtE3TqOK0cbw0SJ3LfqCsM3B8AFjBomfj4hcftyHXYXLg@mail.gmail.com>
Message-ID: <CANiDSCtE3TqOK0cbw0SJ3LfqCsM3B8AFjBomfj4hcftyHXYXLg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Mon, Nov 30, 2020 at 9:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#ifndef CONFIG_DMA_NONCOHERENT
>
> I think you need to drop this ifdef.  This code should work just fine
> on noncoherent mips and sh platforms.
>
> > +     uvc_urb->pages = dma_alloc_noncontiguous(dma_dev, stream->urb_size,
> > +                                              &uvc_urb->dma,
> > +                                              gfp_flags | __GFP_NOWARN, 0);
> > +     if (!uvc_urb->pages)
> > +             return false;
> > +
> > +     uvc_urb->buffer = vmap(uvc_urb->pages,
> > +                            PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT,
> > +                            VM_DMA_COHERENT, PAGE_KERNEL);
> > +     if (!uvc_urb->buffer) {
> > +             dma_free_noncontiguous(dma_dev, stream->urb_size,
> > +                                    uvc_urb->pages, uvc_urb->dma);
> > +             return false;
> > +     }
> > +
> > +     if (sg_alloc_table_from_pages(&uvc_urb->sgt, uvc_urb->pages,
> > +                             PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT, 0,
> > +                             stream->urb_size, GFP_KERNEL)) {
> > +             vunmap(uvc_urb->buffer);
> > +             dma_free_noncontiguous(dma_dev, stream->urb_size,
> > +                                    uvc_urb->pages, uvc_urb->dma);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
>
> I wonder if we should lift this into a helper.  On the one hand I had
> proliferating struct scatterlist usage, on the other hand it is all over
> the media and drm code anyway, and duplicating this doesn't help anyone.
>
> Possibly including the fallback to the coherent allocating.

Probably Sergey has best opinion of this than mine. I only had to look
into one driver, he has been working with the vb2, which uses the API
much more.



-- 
Ricardo Ribalda
