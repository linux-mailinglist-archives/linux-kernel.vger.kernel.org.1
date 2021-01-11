Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D22F1D70
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbhAKSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389981AbhAKSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:04:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9CCC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:03:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d26so671356wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQ88+LI5HEr8LP9MECKHb0an/ILY1uHLC7MWc4xKUSQ=;
        b=nCV1ZS4fAU6hFngRbC7jkRKIcsqPejpew4BRdQ4Ly13ypD++QeZmnDPhiU/2zSCw9+
         Yw7jZGzmxtGbszhlZ7gehioXAMjzXypa6avlszOWtWRD5TWhsSiyX35H2teoKthN/ui7
         FVrSPZ4/XeoXWDQS/byVZYdAJEjkdbdPwGIcM353b45f6urb2PimnhEhz9b+CsXbnx+c
         sLXiNwVrm1OcQG4wBdhbBUOPlsIKUTsNFjPPkYNMBaL7Dv981SGRsghzVSVED+fLBYvr
         N68wnXnivV/CmoxkQ/3xrBdU+nLPuHiJa2WEof02BjcSTON0Afo90YapNzD/LluttZfy
         enDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQ88+LI5HEr8LP9MECKHb0an/ILY1uHLC7MWc4xKUSQ=;
        b=K4gbdnQG1ht8ozP5JFtuKlcAzYFjkyDTZ9RZz60lnw4ElBqBWWem28WeEL2NpAO7Pf
         UFKir7yL9k53qmaDR+Et2wDNaFsOT0nLqrrzax+am4hL/IKoBiDmfnii9WtUsQ2LJBf8
         5tbViYMSNHLlx1ECsJR6uOSNqlerZBLY1s84JiUYRn9WT6d94Xt1bJtfaqSm/qQ+SNVh
         wdG60B2BoXvrdV9WgKI1r983YrHGR0zr+8x0tb3EzwpcQguhuW2fc0vpXXlSpGSNgnuv
         ImjiAkdt9/JhSJD7jl5Kj7Shxijwxeh1HEpip8dilQsqsnwk2esZZDl4HCYWVK1aArYX
         fEww==
X-Gm-Message-State: AOAM532pVj3j1oLlQbyxDKLCZqEwX9ti5NNC+WtyEYw83VBkupy35zyj
        XhUuKN+FPw9hSflqC8pLLxAJ6cTmwGqMSps/WGmyFA==
X-Google-Smtp-Source: ABdhPJzsKB2S8tXBu6i5PVjW2kuyXdlPhHhTEht6hD50Xozy9RUpd2RVduyv0+3+XkChb7CKfLEXBKj0UQa8VJy/PqY=
X-Received: by 2002:a5d:5604:: with SMTP id l4mr311015wrv.127.1610388216078;
 Mon, 11 Jan 2021 10:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20210111154335.23388-1-marcorr@google.com> <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
In-Reply-To: <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 11 Jan 2021 10:03:24 -0800
Message-ID: <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com>
Subject: Re: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        Jianxiong Gao <jxgao@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2021-01-11 15:43, Marc Orr wrote:

minus stable@vger.kernel.org, per gregkh@'s email.

> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 0a4881e59aa7..3d9b17fe5771 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> >       struct scatterlist *sg;
> >       int i;
> >
> > -     for_each_sg(sgl, sg, nents, i)
> > +     for_each_sg(sgl, sg, nents, i) {
> >               dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> >                            attrs);
> > +             sg->dma_address = DMA_MAPPING_ERROR;
>
> There are more DMA API backends than just dma-direct, so while this
> might help paper over bugs when SWIOTLB is in use, it's not going to
> have any effect when those same bugs are hit under other circumstances.
> Once again, the moral of the story is that effort is better spent just
> fixing the bugs ;)

Thanks for the quick feedback. What is the correct fix? I understand
the first half. The NVMe driver should be updated to not call unmap on
an address that has already been unmapped within the DMA direct code.
Where I'm less certain is how to communicate to the NVMe driver that
the mapping failed. In particular, the NVMe code explicitly checks if
the first DMA address in the scatter/gather list is set to
DMA_MAPPING_ERROR. Thus, don't we need to update the DMA direct code
to propagate DMA_MAPPING_ERROR back up to the driver, via the
scatter/gather struct?

I skimmed arch/arm/mm/dma-mapping.c, just now. I can see that this
code sets the address within the scatter/gather struct to
DMA_MAPPING_ERROR before trying to map an IO address and write it into
the struct. Is this a good example to follow?

Thanks,
Marc
