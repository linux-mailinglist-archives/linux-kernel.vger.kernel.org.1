Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168C12050EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbgFWLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:40:57 -0400
Received: from verein.lst.de ([213.95.11.211]:38974 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732332AbgFWLk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:40:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D029768B05; Tue, 23 Jun 2020 13:40:53 +0200 (CEST)
Date:   Tue, 23 Jun 2020 13:40:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, jean-philippe@linaro.org,
        bbhushan2@marvell.com
Subject: Re: [PATCH] dma-remap: Align the size in dma_common_*_remap()
Message-ID: <20200623114053.GB17496@lst.de>
References: <20200622202320.1331-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622202320.1331-1-eric.auger@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:23:20PM +0200, Eric Auger wrote:
> Running a guest with a virtio-iommu protecting virtio devices
> is broken since commit 515e5b6d90d4 ("dma-mapping: use vmap insted
> of reimplementing it"). Before the conversion, the size was
> page aligned in __get_vm_area_node(). Doing so fixes the
> regression.
> 
> Fixes: 515e5b6d90d4 ("dma-mapping: use vmap insted of reimplementing it")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  kernel/dma/remap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index e739a6eea6e7..a3151a9b0c08 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -24,7 +24,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  {
>  	void *vaddr;
>  
> -	vaddr = vmap(pages, size >> PAGE_SHIFT, VM_DMA_COHERENT, prot);
> +	vaddr = vmap(pages, PAGE_ALIGN(size) >> PAGE_SHIFT, VM_DMA_COHERENT, prot);

Please respin without going over 80 characters.
