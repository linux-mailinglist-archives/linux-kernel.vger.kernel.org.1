Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8882B29497E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441099AbgJUIvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441066AbgJUIvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:51:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA9F21789;
        Wed, 21 Oct 2020 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603270308;
        bh=4h+OCFwSPTmgFlamZlpSXwlJHTKoRjaneJzFZE4B7Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3KbvVk+KhFdwL/JVPEJ0vMyVlvj0blxtoQqmyp0G8n+HQYpNUzASeF76z/iEI3vq
         HF7zfP4hhGbP25E0gz4BW35/cKmugIuqoTokRMnaIcY4kOiILmSdn/Cw+16appdaGR
         lOXjWykj1n9hB9yWyloufkUjRDZx/veSr6cFoQWw=
Date:   Wed, 21 Oct 2020 10:52:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Furquan Shaikh <furquan@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Duncan Laurie <dlaurie@google.com>
Subject: Re: [PATCH] firmware: gsmi: Drop the use of dma_pool_* API functions
Message-ID: <20201021085227.GA1102039@kroah.com>
References: <20201021050141.377787-1-furquan@google.com>
 <20201021051931.GA967331@kroah.com>
 <CAMj1kXHpTNoYgzm+-SEs8Kddr+rVy7n5DOqf+QM8jAJXmDh3kA@mail.gmail.com>
 <CAEGmHFFYuAqqcPEw7UkVSPokAr74ktDcovOPzB74j9dyUYapGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEGmHFFYuAqqcPEw7UkVSPokAr74ktDcovOPzB74j9dyUYapGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:37:52AM -0700, Furquan Shaikh wrote:
> On Tue, Oct 20, 2020 at 11:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 21 Oct 2020 at 07:18, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Oct 20, 2020 at 10:01:41PM -0700, Furquan Shaikh wrote:
> > > > GSMI driver uses dma_pool_* API functions for buffer allocation
> > > > because it requires that the SMI buffers are allocated within 32-bit
> > > > physical address space. However, this does not work well with IOMMU
> > > > since there is no real device and hence no domain associated with the
> > > > device.
> > > >
> > > > Since this is not a real device, it does not require any device
> > > > address(IOVA) for the buffer allocations. The only requirement is to
> > > > ensure that the physical address allocated to the buffer is within
> > > > 32-bit physical address space. This change allocates a page using
> > > > `get_zeroed_page()` and passes in GFP_DMA32 flag to ensure that the
> > > > page allocation is done in the DMA32 zone. All the buffer allocation
> > > > requests for gsmi_buf are then satisfed using this pre-allocated page
> > > > for the device.
> > >
> > > Are you sure that "GFP_DMA32" really does what you think it does?  A
> > > "normal" call with GFP_KERNEL" will give you memory that is properly
> > > dma-able.
> > >
> > > We should not be adding new GFP_DMA* users in the kernel in these days,
> > > just call dma_alloc*() and you should be fine.
> > >
> >
> > The point seems to be that this is not about DMA at all, and so there
> > is no device associated with the DMA allocation.
> >
> > The other 'master' is the CPU running firmware in an execution mode
> > where it can only access the bottom 4 GB of memory, and GFP_DMA32
> > happens to allocate from a zone which is guaranteed to be accessible
> > to the firmware.
> 
> Ard captured the context and requirement perfectly. GFP_DMA32
> satisfies the requirement for allocating memory from a zone which is
> accessible to the firmware in SMI mode. This seems to be one of the
> common ways  how other drivers and common code in the kernel currently
> allocate physical memory below the 4G boundary. Hence, I used the same
> mechanism in GSMI driver.

Then can you please document this a bit better in the changelog,
explaining why this is ok to use this obsolete api, and also in the code
itself so that no one tries to clean it up in the future?

thanks,

greg k-h
