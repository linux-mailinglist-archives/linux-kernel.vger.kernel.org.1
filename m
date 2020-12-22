Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1292E0EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 20:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgLVT2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 14:28:09 -0500
Received: from foss.arm.com ([217.140.110.172]:39142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgLVT2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 14:28:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C19081FB;
        Tue, 22 Dec 2020 11:27:22 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D97A93F6CF;
        Tue, 22 Dec 2020 11:27:20 -0800 (PST)
Subject: Re: [PATCH v2 3/7] iommu/arm-smmu: Add dependency on io-pgtable
 format modules
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Cc:     will@kernel.org, joro@8bytes.org, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-4-git-send-email-isaacm@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3b0c191d-3fd0-73db-c1e3-4a80aa7953d7@arm.com>
Date:   Tue, 22 Dec 2020 19:27:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1608597876-32367-4-git-send-email-isaacm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-22 00:44, Isaac J. Manjarres wrote:
> The SMMU driver depends on the availability of the ARM LPAE and
> ARM V7S io-pgtable format code to work properly. In preparation

Nit: we don't really depend on v7s - we *can* use it if it's available, 
address constraints are suitable, and the SMMU implementation actually 
supports it (many don't), but we can still quite happily not use it even 
so. LPAE is mandatory in the architecture so that's our only hard 
requirement, embodied in the kconfig select.

This does mean there may technically still be a corner case involving 
ARM_SMMU=y and IO_PGTABLE_ARM_V7S=m, but at worst it's now a runtime 
failure rather than a build error, so unless and until anyone 
demonstrates that it actually matters I don't feel particularly inclined 
to give it much thought.

Robin.

> for having the io-pgtable formats as modules, add a "pre"
> dependency with MODULE_SOFTDEP() to ensure that the io-pgtable
> format modules are loaded before loading the ARM SMMU driver module.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d8c6bfd..a72649f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2351,3 +2351,4 @@ MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>   MODULE_AUTHOR("Will Deacon <will@kernel.org>");
>   MODULE_ALIAS("platform:arm-smmu");
>   MODULE_LICENSE("GPL v2");
> +MODULE_SOFTDEP("pre: io-pgtable-arm io-pgtable-arm-v7s");
> 
