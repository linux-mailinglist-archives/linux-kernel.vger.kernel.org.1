Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56662B2D06
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKNMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:10:10 -0500
Received: from verein.lst.de ([213.95.11.211]:50169 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgKNMKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:10:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E83767373; Sat, 14 Nov 2020 13:10:06 +0100 (CET)
Date:   Sat, 14 Nov 2020 13:10:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v4 2/2] powerpc/dma: Fallback to dma_ops when
 persistent memory present
Message-ID: <20201114121005.GA21068@lst.de>
References: <20201029015241.73920-1-aik@ozlabs.ru> <20201029015241.73920-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029015241.73920-3-aik@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:52:41PM +1100, Alexey Kardashevskiy wrote:
> +EXPORT_SYMBOL_GPL(arch_dma_map_page_direct);

I've dropped the unused exports and applied the series to dma-mapping-for-next.
