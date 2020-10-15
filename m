Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BE28ECCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgJOFk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 01:40:29 -0400
Received: from verein.lst.de ([213.95.11.211]:59161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgJOFk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:40:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CD5C68BEB; Thu, 15 Oct 2020 07:40:26 +0200 (CEST)
Date:   Thu, 15 Oct 2020 07:40:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 8/8] mm: Update DMA zones description
Message-ID: <20201015054026.GC12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de> <20201014191211.27029-9-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014191211.27029-9-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:12:10PM +0200, Nicolas Saenz Julienne wrote:
> The default behavior for arm64 changed, so reflect that.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  include/linux/mmzone.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fb3bf696c05e..4ee2306351b9 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -363,8 +363,9 @@ enum zone_type {
>  	 *  - arm only uses ZONE_DMA, the size, up to 4G, may vary depending on
>  	 *    the specific device.
>  	 *
> -	 *  - arm64 has a fixed 1G ZONE_DMA and ZONE_DMA32 for the rest of the
> -	 *    lower 4G.
> +	 *  - arm64 uses a single 4GB ZONE_DMA, except on the Raspberry Pi 4,
> +	 *    in which ZONE_DMA covers the first GB and ZONE_DMA32 the rest of
> +	 *    the lower 4GB.

Honestly I think this comment just needs to go away.  We can't really list
every setup in a comment in common code.
