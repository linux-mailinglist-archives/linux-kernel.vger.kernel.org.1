Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B829E7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgJ2J4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgJ2J4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:56:08 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A6C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:56:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CMLRm3sBKz9sRR;
        Thu, 29 Oct 2020 20:56:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1603965364;
        bh=agmXWLfdIA/pQg1LOAdVjmxcr2Hn93lU+lUVrcQP8co=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cJ89gKM6AYK1YY7ZnpS2yHhbxcLbjmfev6r+5Jf2idhvDbSxMIo9mcs5wY0pZEN+W
         0cIi327yBjBEVGmz2pNNAQhtIV6qLKR3otIH/eMSHWT8mkLPkvUeDXaqyd9QCBHNzm
         CfpAwbuDAh283Mb+6+j6c+iKHCQxlkMPxtW0ZlVJQx/hfchdhnlspaTuscYQS28C6O
         QBWRvvDEFrskk+0H/CtSY0Sfiq0kkRmoVc8ubM3WkGa/iXYDThHknl8QOTMUnF5RxN
         wBM1Rru6FhrMzWGzN5iSbrz6kKMpgR5ihXYDENlh5i9jVI4j2JWzRbw4K4THt9hwP+
         LlKTdcZt3QDnQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 2/2] powerpc/dma: Fallback to dma_ops when persistent memory present
In-Reply-To: <20201029015241.73920-3-aik@ozlabs.ru>
References: <20201029015241.73920-1-aik@ozlabs.ru> <20201029015241.73920-3-aik@ozlabs.ru>
Date:   Thu, 29 Oct 2020 20:56:03 +1100
Message-ID: <878sbpwe30.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> So far we have been using huge DMA windows to map all the RAM available.
> The RAM is normally mapped to the VM address space contiguously, and
> there is always a reasonable upper limit for possible future hot plugged
> RAM which makes it easy to map all RAM via IOMMU.
>
> Now there is persistent memory ("ibm,pmemory" in the FDT) which (unlike
> normal RAM) can map anywhere in the VM space beyond the maximum RAM size
> and since it can be used for DMA, it requires extending the huge window
> up to MAX_PHYSMEM_BITS which requires hypervisor support for:
> 1. huge TCE tables;
> 2. multilevel TCE tables;
> 3. huge IOMMU pages.
>
> Certain hypervisors cannot do either so the only option left is
> restricting the huge DMA window to include only RAM and fallback to
> the default DMA window for persistent memory.
>
> This defines arch_dma_map_direct/etc to allow generic DMA code perform
> additional checks on whether direct DMA is still possible.
>
> This checks if the system has persistent memory. If it does not,
> the DMA bypass mode is selected, i.e.
> * dev->bus_dma_limit = 0
> * dev->dma_ops_bypass = true <- this avoid calling dma_ops for mapping.
>
> If there is such memory, this creates identity mapping only for RAM and
> sets the dev->bus_dma_limit to let the generic code decide whether to
> call into the direct DMA or the indirect DMA ops.
>
> This should not change the existing behaviour when no persistent memory
> as dev->dma_ops_bypass is expected to be set.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
