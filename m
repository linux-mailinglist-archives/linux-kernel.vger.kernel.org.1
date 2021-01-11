Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D42F21E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbhAKVhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbhAKVhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:37:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:36:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d13so240950wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0xMi6BcZcyDu0fcZnUeC0nFD2sQudz3pvIy74Uu1Co=;
        b=aoPFqdupBdo2m50fA72kLB51Y4eAj0rEvXhgPGXgU3pHawnWSdq+OOJo+x02/Ttmh/
         GT/usW8NL+/oXIuxlc+SjB3GIpvrLO3AqRas0wNI6fpXwnN2njXJcx7tzXn1i2zmDr5V
         4pBDPqMBoBGacxzqtY5h7ZOC/kYBQeqihZfBx17J4OKktz2sNwOPRv276CKNOAYKINlF
         PzSZSUjORtpor/zgcG4uYxinJsR9F46Id/uhmHZyNxCLMdAMIW3p7iSIFaHG0yE02xYP
         hiewwhR/TQ0wpE4tWLB/7LtTzmTpni+aGYOK1X+x2doEpCEgYjDdFfbtY8HmzStCeiRb
         oylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0xMi6BcZcyDu0fcZnUeC0nFD2sQudz3pvIy74Uu1Co=;
        b=ZYFa8LDcPvbL4zpb6rEgYwVVktwUBd5Qf7zQHh3VUm/ucPHNDKOsTBg5lwgH3yMEMH
         NrlOJqsMQdiWHGUz9HN5W0egIYBmlj7bl43BSAjv+30azoHN8YuFQpyE5ig0CPeqbmkG
         AfNJEW3ziKl3vnPwWm6UkAPiSZVLya0gx6wdp3Lh+pXuUrXyGK86JexNq6zdf739PNoU
         N/+eXiFOUmFGayhPgTYe6ik6p+qcKcVlSpcK5D5auJK+e9bZuG3bJ3WQW2/Y9IFaJQy8
         LzicURQbTJvWPEG4d/5TxdgmOcA9bGqgxYszla9g2LFHRhg+FHwMsTFX9+/gR/kslr1N
         OSEg==
X-Gm-Message-State: AOAM530PqZYy7jLnM27sen8mEE27TLKOQZP2STJcmCMGOy+FgD4Egipp
        xyQv8DfEj/nHlTQ1vFijqlBGGRy9cTVLtcGTKCL0RQBGLDU=
X-Google-Smtp-Source: ABdhPJwc4Tc/s46NcBJR4zTZePqRBiO7sGEbGyK0c71idGH77xhltZxnEMdsrKLPkDWH1LYE57mboh9Z32DxStHJfik=
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr1028748wro.216.1610400988919;
 Mon, 11 Jan 2021 13:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20210111154335.23388-1-marcorr@google.com> <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
 <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com> <bbf6f07c-369b-e470-78ff-815cfb4dbf92@arm.com>
In-Reply-To: <bbf6f07c-369b-e470-78ff-815cfb4dbf92@arm.com>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 11 Jan 2021 13:36:17 -0800
Message-ID: <CAA03e5G6UohDjvA6P1mq4SdcPRQ_LFBvkhwUM9Uo6ztGU_9BQg@mail.gmail.com>
Subject: Re: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        Jianxiong Gao <jxgao@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >>> index 0a4881e59aa7..3d9b17fe5771 100644
> >>> --- a/kernel/dma/direct.c
> >>> +++ b/kernel/dma/direct.c
> >>> @@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> >>>        struct scatterlist *sg;
> >>>        int i;
> >>>
> >>> -     for_each_sg(sgl, sg, nents, i)
> >>> +     for_each_sg(sgl, sg, nents, i) {
> >>>                dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> >>>                             attrs);
> >>> +             sg->dma_address = DMA_MAPPING_ERROR;
> >>
> >> There are more DMA API backends than just dma-direct, so while this
> >> might help paper over bugs when SWIOTLB is in use, it's not going to
> >> have any effect when those same bugs are hit under other circumstances.
> >> Once again, the moral of the story is that effort is better spent just
> >> fixing the bugs ;)
> >
> > Thanks for the quick feedback. What is the correct fix? I understand
> > the first half. The NVMe driver should be updated to not call unmap on
> > an address that has already been unmapped within the DMA direct code.
> > Where I'm less certain is how to communicate to the NVMe driver that
> > the mapping failed. In particular, the NVMe code explicitly checks if
> > the first DMA address in the scatter/gather list is set to
> > DMA_MAPPING_ERROR. Thus, don't we need to update the DMA direct code
> > to propagate DMA_MAPPING_ERROR back up to the driver, via the
> > scatter/gather struct?
>
> Erm, you check the return value of dma_map_sg(). If it's zero, the
> request failed; if it's nonzero, that's how many DMA segments you now
> have to process. See Documentation/core-api/dma-api.rst.
>
> The only guarantee offered about the state of the scatterlist itself is
> that if it is successfully mapped, then the dma_address and dma_length
> fields are valid for that many segments, and if that is fewer than the
> total number of physical segments then the next one after the final DMA
> segment will have a dma_length of 0. In particular there are no
> guarantees at all about the state if the mapping was unsuccessful.
>
> If a driver is failing to keep track of the success/failure status and
> later down the line trying to guess what to do with a list that may or
> may not have been mapped, then frankly that driver should be redesigned
> because that is a terrible anti-pattern. At the very very least it
> should explicitly encode its own "known bad" state upon failure that it
> can then reliably recognise later.

Got it now. I'll get to work on a patch for the NVMe driver to fix the
bug. Thanks for all of these pointers. They are immensely helpful.

Thanks,
Marc
