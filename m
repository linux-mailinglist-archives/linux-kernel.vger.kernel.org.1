Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F5A2C41B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgKYOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:05:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKYOFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:05:32 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EC820BED;
        Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606313131;
        bh=G0QniDixREASD/+97G1s9HC8wwScSSPO5MfGlrcrBuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6E+10hEkNV96Jai8iOP93upvTHZb+ZK8e4sVKefiWCAdSxmYRmocF3DBVggpEiRu
         ObmRZhJwV48JYE0SYCgtQi1uegfZo3DFKiHIBhphbs9Guh7RdRhopOLI4nOQDcBIiQ
         N2vkzpcrTEWvhuNfOtwjg84VmtzKsXzCn4BvcXvo=
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v6 0/7] Convert the intel iommu driver to the dma-iommu api
Date:   Wed, 25 Nov 2020 14:05:17 +0000
Message-Id: <160630583051.4094327.7513344162564263042.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
References: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 16:20:50 +0800, Lu Baolu wrote:
> The v5 of this series could be found here.
> 
> https://lore.kernel.org/linux-iommu/20201120101719.3172693-1-baolu.lu@linux.intel.com/
> 
> Changes in this version:
> - Rebase the series to the latest iommu/next branch.
>   https://lore.kernel.org/linux-iommu/20201123100816.GA26619@infradead.org/
> 
> [...]

Applied to arm64 (for-next/iommu/vt-d), thanks!

[1/7] iommu: Handle freelists when using deferred flushing in iommu drivers
      https://git.kernel.org/arm64/c/2a2b8eaa5b25
[2/7] iommu: Add iommu_dma_free_cpu_cached_iovas()
      https://git.kernel.org/arm64/c/230309d08b87
[3/7] iommu: Allow the dma-iommu api to use bounce buffers
      https://git.kernel.org/arm64/c/82612d66d51d
[4/7] iommu: Add quirk for Intel graphic devices in map_sg
      https://git.kernel.org/arm64/c/65f746e8285f
[5/7] iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
      https://git.kernel.org/arm64/c/c062db039f40
[6/7] iommu/vt-d: Convert intel iommu driver to the iommu ops
      https://git.kernel.org/arm64/c/c588072bba6b
[7/7] iommu/vt-d: Cleanup after converting to dma-iommu ops
      https://git.kernel.org/arm64/c/58a8bb39490d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
