Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79232FB8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395004AbhASNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:54:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:35121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394693AbhASNsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:48:19 -0500
IronPort-SDR: c5+Ejz8vuqYq5KFA5F5e3Gsrsev+tiPf8MMUBGq9wiNFicogMQR7ba0YxGHnzHvcvUZXAvLwcT
 en/kaUSTaNGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="179012497"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="179012497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 05:46:32 -0800
IronPort-SDR: 9Drec6KDlJklq/AcoxMUfb1QCvAcoxdfbXtmTJNG22mG/Mp0KEG2VcE7luN4EQBo8XIwC9N242
 Rg5zSm+ThUOg==
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="383938590"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.174.34]) ([10.249.174.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 05:46:30 -0800
Cc:     baolu.lu@linux.intel.com, thomas.lendacky@amd.com, will@kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com
Subject: Re: [PATCH 0/2 v2] iommu: fix the failure of deferred attach for
 iommu attach device
To:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
References: <20210119111616.12761-1-lijiang@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e896bbd5-fdf3-ca04-b2f2-f1c7910f1ee0@linux.intel.com>
Date:   Tue, 19 Jan 2021 21:46:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119111616.12761-1-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/19 19:16, Lianbo Jiang wrote:
> This patchset is to fix the failure of deferred attach for iommu attach
> device, it includes the following two patches:
> 
> [1] [PATCH 1/2] dma-iommu: use static-key to minimize the impact in the fast-path
>      This is a prepared patch for the second one, move out the is_kdump_kernel()
>      check from iommu_dma_deferred_attach() to iommu_dma_init(), and use the
>      static-key in the fast-path to minimize the impact in the normal case.
> 
> [2] [PATCH 2/2] iommu: use the __iommu_attach_device() directly for deferred attach
>      Move the handling currently in iommu_dma_deferred_attach() into the
>      iommu core code so that it can call the __iommu_attach_device()
>      directly instead of the iommu_attach_device(). The external interface
>      iommu_attach_device() is not suitable for handling this situation.
> 
> Changes since v1:
> [1] use the __iommu_attach_device() directly for deferred attach
> [2] use static-key to minimize the impact in the fast-path
> 
> Lianbo Jiang (2):
>    dma-iommu: use static-key to minimize the impact in the fast-path
>    iommu: use the __iommu_attach_device() directly for deferred attach
> 
>   drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
>   drivers/iommu/iommu.c     | 12 ++++++++++++
>   include/linux/iommu.h     |  2 ++
>   3 files changed, 25 insertions(+), 18 deletions(-)
> 

Good fix and improvement. For the patches in this series:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
