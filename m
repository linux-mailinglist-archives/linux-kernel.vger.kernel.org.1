Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F18275D49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:24:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIWQYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:24:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 736E630E;
        Wed, 23 Sep 2020 09:24:53 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D263F718;
        Wed, 23 Sep 2020 09:24:52 -0700 (PDT)
Subject: Re: [PATCH] iommu: of: skip iommu_device_list traversal in
 of_iommu_xlate()
To:     Charan Teja Reddy <charante@codeaurora.org>, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1600872826-2254-1-git-send-email-charante@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8722e4bc-efe0-27c4-2b7d-626188da5bfb@arm.com>
Date:   Wed, 23 Sep 2020 17:24:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1600872826-2254-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-23 15:53, Charan Teja Reddy wrote:
> In of_iommu_xlate(), check if iommu device is enabled before traversing
> the iommu_device_list through iommu_ops_from_fwnode(). It is of no use
> in traversing the iommu_device_list only to return NO_IOMMU because of
> iommu device node is disabled.

Well, the "use" is that it keeps the code that much smaller and simpler 
to have a single path for returning this condition. This whole callstack 
isn't exactly a high-performance code path to begin with, and we've 
always assumed that IOMMUs present but disabled in DT would be a pretty 
rare exception. Do you have a system that challenges those assumptions 
and shows any benefit from this change?

Robin.

> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>   drivers/iommu/of_iommu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e505b91..225598c 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -94,9 +94,10 @@ static int of_iommu_xlate(struct device *dev,
>   	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
>   	int ret;
>   
> +	if (!of_device_is_available(iommu_spec->np))
> +		return NO_IOMMU;
>   	ops = iommu_ops_from_fwnode(fwnode);
> -	if ((ops && !ops->of_xlate) ||
> -	    !of_device_is_available(iommu_spec->np))
> +	if (ops && !ops->of_xlate)
>   		return NO_IOMMU;
>   
>   	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
> 
