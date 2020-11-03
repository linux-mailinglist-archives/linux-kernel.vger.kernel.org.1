Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEFA2A46A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgKCNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:35:54 -0500
Received: from 8bytes.org ([81.169.241.247]:39136 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgKCNfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:35:52 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7FD9A433; Tue,  3 Nov 2020 14:35:51 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:35:50 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
Message-ID: <20201103133549.GI22888@8bytes.org>
References: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Wed, Oct 28, 2020 at 11:18:24PM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
> and the completion wait write-back regions. However, when allocating
> the pages, they could be part of large mapping (e.g. 2M) page.
> This causes #PF due to the SNP RMP hardware enforces the check based
> on the page level for these data structures.
> 
> So, fix by calling set_memory_4k() on the allocated pages.
> 
> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/init.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 82e4af8f09bb..75dc30226a7c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -29,6 +29,7 @@
>  #include <asm/iommu_table.h>
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
> +#include <asm/set_memory.h>
>  
>  #include <linux/crash_dump.h>
>  
> @@ -672,11 +673,22 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
>  	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
>  }
>  
> +static void *__init iommu_alloc_4k_pages(gfp_t gfp, size_t size)
> +{
> +	void *buf;
> +	int order = get_order(size);
> +
> +	buf = (void *)__get_free_pages(gfp, order);
> +	if (!buf)
> +		return buf;
> +	return set_memory_4k((unsigned long)buf, (1 << order)) ? NULL : buf;
> +}
> +

Please make the 4k split only if SNP is actually enabled in the system.

Regards,

	Joerg
