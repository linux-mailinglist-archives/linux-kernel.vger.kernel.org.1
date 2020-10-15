Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF48A28EEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgJOIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387734AbgJOIkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:40:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8A22224A;
        Thu, 15 Oct 2020 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602751214;
        bh=iEOV0qFCwAa4x2I6L0Fl5blrVz6Ofac36yk+aR5M4b4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p36N9EioeWHKRZCdCRXZArhO6aOx6gew9HVR/iPljFlmjsblV774sa8gxH5li5rkN
         Jnv0Gfk4vaQfWLMlJkgz4hGBVwVZ3GYUn1HkoBhaTMBdSiFl7EVaP34okdEbS0cu96
         waYgH1X+2jD1CY8Jsnd+uCwWlpp66CcW0oDM215Q=
Date:   Thu, 15 Oct 2020 09:40:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/8] arm64: mm: Move reserve_crashkernel() into
 mem_init()
Message-ID: <20201015084008.GB4537@willie-the-truck>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014191211.27029-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:12:03PM +0200, Nicolas Saenz Julienne wrote:
> crashkernel might reserve memory located in ZONE_DMA. We plan to delay
> ZONE_DMA's initialization after unflattening the devicetree and ACPI's
> boot table initialization, so move it later in the boot process.
> Specifically into mem_init(), this is the last place crashkernel will be
> able to reserve the memory before the page allocator kicks in and there is
> no need to do it earlier.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm64/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Please can you cc me on the whole series next time? I know different
maintainers have different preferences here, but I find it much easier to
figure out what's happening when I can see all of the changes together.

Thanks,

Will
