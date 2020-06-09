Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6D1F491C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFIVu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 17:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgFIVu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:50:56 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7DA206D5;
        Tue,  9 Jun 2020 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591739456;
        bh=XTv0AfIhSGBAVmR///EPvXgZuQrSzUx+9M9fNndpuWk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FYWiwtT8vtIEdZWsACy6EuABQDJ0EERJh8aI4qNJOssQy+ay6qAz2Fpj54hAfTRYk
         Pqi/iPfoRC8DmBrdNc7Q9R2XGnptCIOoQyHTgvCUxRcDfsz2ZOHMHOmtRMmZehUJLU
         tRk1KzKwczMBaTpRMv5gKpCGKc9zkgacd3vmwPxo=
Date:   Tue, 9 Jun 2020 14:50:55 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 10/11] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
In-Reply-To: <20200609053949.GA26473@infradead.org>
Message-ID: <alpine.DEB.2.21.2006091326380.2815@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s> <20200603222247.11681-10-sstabellini@kernel.org> <20200608071221.GF15742@infradead.org> <alpine.DEB.2.21.2006081614530.2815@sstabellini-ThinkPad-T480s> <20200609053802.GB3015@infradead.org>
 <20200609053949.GA26473@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Christoph Hellwig wrote:
> On Mon, Jun 08, 2020 at 10:38:02PM -0700, Christoph Hellwig wrote:
> > On Mon, Jun 08, 2020 at 05:38:28PM -0700, Stefano Stabellini wrote:
> > > Yeah, the pfn_valid check is a bit weird by definition because we are
> > > using it to understand whether the address belong to us or to another
> > > VM. To do the pfn_valid check we need to translate the dma address into
> > > something the CPU understands, hence, the dma_to_phys call.
> > > 
> > > Why can't we use the already-provided paddr? Because paddr has been
> > > translated twice:
> > > 1) from dma to maybe-foreign phys address (could be ours, or another VM)
> > > 2) from maybe-foreign address to local (using our local mapping of the foreign page)
> > > 
> > > In fact, it would be clearer if we had all three addresses as parameters
> > > of xen_dma_sync_for_cpu: the dma address, the maybe-foreign physical
> > > address (we tend to call it xenbus address, baddr), the local physical
> > > address. Something like:
> > 
> > I think instead we should move the arch_sync_dma_for_{device,cpu}
> > calls from xen_dma_sync_for_{device,cpu} into the callers, as they
> > are provided by the generic dma-noncoherent.h and optimized out for
> > coherent architectures like x86.  Then the swiotlb-xen.c code only
> > need to call dma_cache_maint as the interface (which would have to
> > grow a better name), which should then only need a single kind of
> > address.
> 
> ... actually I'd keep the xen_dma_sync_for_{device,cpu} names for the
> low-level interface, just move the arch_sync_dma_for_{device,cpu}
> calls up.

I can do that.
