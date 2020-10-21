Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFD29486B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394708AbgJUGho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387905AbgJUGho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:37:44 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACB022251
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603262263;
        bh=AQ/86TVM6iLeRjlI/SosdsV5fD8IEm1Xoxsqfvo1i+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aJLG7B8ouNSJAL7BY7PQPyc6Eci5fr4GcbWGBnl1QccrCzozzRjkzSjBd+pEPmT7w
         jf3v0DICOE0f9Vd/Bxg7XbCGCCU/Q1ymYLfpMcd5EhJRxJb8mAlrX6r181PpwS29IT
         tGR2B7sv2kOp1iMi/Yncrg4ubIcxfhY37kFzCfes=
Received: by mail-ot1-f43.google.com with SMTP id i12so914787ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 23:37:43 -0700 (PDT)
X-Gm-Message-State: AOAM532uXzkHXJWqb3epolOg5SBiMD8Qq+ZVJeMoA8NY7I9Gxa8ea9VP
        OI54gZKg22+JbmRt9ARb4LxFN1MENjSegz19D4E=
X-Google-Smtp-Source: ABdhPJwE+OjtGRdyTBziCIT8XgqA4jXtnVJhNOQwdaKewaU+FKBOQY7QbvjbVXJpUj40lynIzBVAB4KD0AeIpbJWElQ=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr1422873ots.90.1603262262278;
 Tue, 20 Oct 2020 23:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201021050141.377787-1-furquan@google.com> <20201021051931.GA967331@kroah.com>
In-Reply-To: <20201021051931.GA967331@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 21 Oct 2020 08:37:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHpTNoYgzm+-SEs8Kddr+rVy7n5DOqf+QM8jAJXmDh3kA@mail.gmail.com>
Message-ID: <CAMj1kXHpTNoYgzm+-SEs8Kddr+rVy7n5DOqf+QM8jAJXmDh3kA@mail.gmail.com>
Subject: Re: [PATCH] firmware: gsmi: Drop the use of dma_pool_* API functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Furquan Shaikh <furquan@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        dlaurie@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 at 07:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 20, 2020 at 10:01:41PM -0700, Furquan Shaikh wrote:
> > GSMI driver uses dma_pool_* API functions for buffer allocation
> > because it requires that the SMI buffers are allocated within 32-bit
> > physical address space. However, this does not work well with IOMMU
> > since there is no real device and hence no domain associated with the
> > device.
> >
> > Since this is not a real device, it does not require any device
> > address(IOVA) for the buffer allocations. The only requirement is to
> > ensure that the physical address allocated to the buffer is within
> > 32-bit physical address space. This change allocates a page using
> > `get_zeroed_page()` and passes in GFP_DMA32 flag to ensure that the
> > page allocation is done in the DMA32 zone. All the buffer allocation
> > requests for gsmi_buf are then satisfed using this pre-allocated page
> > for the device.
>
> Are you sure that "GFP_DMA32" really does what you think it does?  A
> "normal" call with GFP_KERNEL" will give you memory that is properly
> dma-able.
>
> We should not be adding new GFP_DMA* users in the kernel in these days,
> just call dma_alloc*() and you should be fine.
>

The point seems to be that this is not about DMA at all, and so there
is no device associated with the DMA allocation.

The other 'master' is the CPU running firmware in an execution mode
where it can only access the bottom 4 GB of memory, and GFP_DMA32
happens to allocate from a zone which is guaranteed to be accessible
to the firmware.
