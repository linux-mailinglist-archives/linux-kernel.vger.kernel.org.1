Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF9129D5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgJ1WHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:07:35 -0400
Received: from verein.lst.de ([213.95.11.211]:45194 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730113AbgJ1WH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C423468B02; Wed, 28 Oct 2020 18:21:06 +0100 (CET)
Date:   Wed, 28 Oct 2020 18:21:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v2 1/2] dma: Allow mixing bypass and normal
 IOMMU operation
Message-ID: <20201028172106.GA10015@lst.de>
References: <20201027101841.96056-1-aik@ozlabs.ru> <20201027101841.96056-2-aik@ozlabs.ru> <20201027164858.GA30651@lst.de> <28147035-500d-f3cd-f283-257066343697@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28147035-500d-f3cd-f283-257066343697@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 05:55:23PM +1100, Alexey Kardashevskiy wrote:
>
> It is passing an address of the end of the mapped area so passing a page 
> struct means passing page and offset which is an extra parameter and we do 
> not want to do anything with the page in those hooks anyway so I'd keep it 
> as is.
>
>
>> and
>>     maybe even hide the dma_map_direct inside it.
>
> Call dma_map_direct() from arch_dma_map_page_direct() if 
> arch_dma_map_page_direct() is defined? Seems suboptimal as it is going to 
> be bypass=true in most cases and we save one call by avoiding calling 
> arch_dma_map_page_direct(). Unless I missed something?

C does not even evaluate the right hand side of a || expression if the
left hand evaluates to true.
