Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CEF218DA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgGHQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:58:06 -0400
Received: from verein.lst.de ([213.95.11.211]:36225 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHQ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:58:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 792D068B05; Wed,  8 Jul 2020 18:58:02 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:58:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200708165802.GA1131@lst.de>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708164936.9340-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 06:49:39PM +0200, Nicolas Saenz Julienne wrote:
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. So stop using it.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> An more costly alternative would be adding an option to
> dma_alloc_from_contiguous() so it fails when the allocation doesn't fall
> in a specific zone.

Which seems like the right thing to do.  But then again for 5.8 I think
something less invasive like your patch might be better.  Waiting for
a few more opinions for now.
