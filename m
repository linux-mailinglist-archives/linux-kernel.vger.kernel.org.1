Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA62B2948FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501937AbgJUHiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501930AbgJUHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:38:09 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD5BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:38:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e20so1002037otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myViQlnJdU12ruMwYNPrFwznxkGVyWFC1aXL8UgqRCU=;
        b=E94QQznauWa6apAy3Zuid3ZW+xcVNSqVFdbe8rM5dA/bzlr/HetsE79d2kmM89UakQ
         M4wIf167FaShpRGEEXGbkIny4NcBflT9cUpQcRIliL7I6PFynYMW7NtsLy3s4fwC5Igz
         W/xW+Kof2Ruw2brtdUzjfABnTZrBaS95IaXIfCrrUZJQt6emJDryWEWgXpyWxfnyvaPB
         ZMyayxgQDe+vo3GOGTO9K8xkLGRoO/34kh7USroT0AtA4qwyol/H3C8DGhmEQX3m4tBa
         rO7mgTavIi0w2Pu7vYdtXeD501cy4Nq2cys4FgA2YbYoTXeWU8tKVW1aWmG+gLeP4OeM
         z3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myViQlnJdU12ruMwYNPrFwznxkGVyWFC1aXL8UgqRCU=;
        b=loGd+uyPj4r6S/0cvAXBPr75TyFEhL7cjZcbxeRURZnOrettt31AcX1x67F6+sdeQV
         dSEu3IHokVK5H1dASCEofX+29iiFmHTHZlpNXBCCagw2vLMvBeCk0D+KSAwpQ5T1ROjN
         J/6Jt8WO44OeAo35Azm+lyzWriSKI/F3FlzYOjat5Jq3HjvyuCKGfdPjrhMs4umwbhT8
         fkxQWnZJ/yZPZW+6q+4hn2AZrdS08TEy9X5TojDIyDLQ0W4uIHyPOsyKBdHNhLGOIiTU
         FbTJisw4zKd+nqc/a9GzuiWZVZmgFKQPnooMh1+KTbjoVwMaZRdI4w1c4ISIvTdH7T1u
         AJmA==
X-Gm-Message-State: AOAM533lKcm6o15/m/G2xqe21U1M7wQ4jpuS7QYf6oQZAn2w53OByWfa
        d9Kyru9D8JSH28S44EFh3du99s41G4sCeN8ht4ZlPHfkkIQ=
X-Google-Smtp-Source: ABdhPJw8SyWRyRpep9/aPFwfVP26kH1mgTSaEMS/bSzijnoybLynnzyd/M+0AnMoJ0MpxI6R+GGAcg+vzL+/kXuW0os=
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr1544203otc.368.1603265888364;
 Wed, 21 Oct 2020 00:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201021050141.377787-1-furquan@google.com> <20201021051931.GA967331@kroah.com>
 <CAMj1kXHpTNoYgzm+-SEs8Kddr+rVy7n5DOqf+QM8jAJXmDh3kA@mail.gmail.com>
In-Reply-To: <CAMj1kXHpTNoYgzm+-SEs8Kddr+rVy7n5DOqf+QM8jAJXmDh3kA@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 21 Oct 2020 00:37:52 -0700
Message-ID: <CAEGmHFFYuAqqcPEw7UkVSPokAr74ktDcovOPzB74j9dyUYapGw@mail.gmail.com>
Subject: Re: [PATCH] firmware: gsmi: Drop the use of dma_pool_* API functions
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 21 Oct 2020 at 07:18, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Oct 20, 2020 at 10:01:41PM -0700, Furquan Shaikh wrote:
> > > GSMI driver uses dma_pool_* API functions for buffer allocation
> > > because it requires that the SMI buffers are allocated within 32-bit
> > > physical address space. However, this does not work well with IOMMU
> > > since there is no real device and hence no domain associated with the
> > > device.
> > >
> > > Since this is not a real device, it does not require any device
> > > address(IOVA) for the buffer allocations. The only requirement is to
> > > ensure that the physical address allocated to the buffer is within
> > > 32-bit physical address space. This change allocates a page using
> > > `get_zeroed_page()` and passes in GFP_DMA32 flag to ensure that the
> > > page allocation is done in the DMA32 zone. All the buffer allocation
> > > requests for gsmi_buf are then satisfed using this pre-allocated page
> > > for the device.
> >
> > Are you sure that "GFP_DMA32" really does what you think it does?  A
> > "normal" call with GFP_KERNEL" will give you memory that is properly
> > dma-able.
> >
> > We should not be adding new GFP_DMA* users in the kernel in these days,
> > just call dma_alloc*() and you should be fine.
> >
>
> The point seems to be that this is not about DMA at all, and so there
> is no device associated with the DMA allocation.
>
> The other 'master' is the CPU running firmware in an execution mode
> where it can only access the bottom 4 GB of memory, and GFP_DMA32
> happens to allocate from a zone which is guaranteed to be accessible
> to the firmware.

Ard captured the context and requirement perfectly. GFP_DMA32
satisfies the requirement for allocating memory from a zone which is
accessible to the firmware in SMI mode. This seems to be one of the
common ways  how other drivers and common code in the kernel currently
allocate physical memory below the 4G boundary. Hence, I used the same
mechanism in GSMI driver.

Thanks,
Furquan
