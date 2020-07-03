Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2245213656
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGCIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:24:28 -0400
Received: from foss.arm.com ([217.140.110.172]:36410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCIY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:24:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DB4A2F;
        Fri,  3 Jul 2020 01:24:27 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91FAE3F73C;
        Fri,  3 Jul 2020 01:24:25 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: Add SMMU ID2 register fixup hook
To:     Tomasz Nowicki <tn@semihalf.com>, will@kernel.org, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-2-tn@semihalf.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d3540512-09c7-0fa5-2b35-6f1112a575a9@arm.com>
Date:   Fri, 3 Jul 2020 09:24:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702201633.22693-2-tn@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02 21:16, Tomasz Nowicki wrote:
> We already have 'cfg_probe' hook which meant to override and apply
> workarounds while probing ID registers. However, 'cfg_probe' is called
> at the very end and therefore for some cases fixing up things becomes complex
> or requires exporting of SMMU driver structures. Hence, seems it is better and
> cleaner to do ID fixup right away. In preparation for adding Marvell
> errata add an extra ID2 fixup hook.

Hmm, the intent of ->cfg_probe was very much to give impl a chance to 
adjust the detected features before we start consuming them, with this 
exact case in mind. Since the Cavium quirk isn't actually doing that - 
it just needs to run *anywhere* in the whole probe process - I'm under 
no illusion that I put the hook in exactly the right place first time 
around ;)

The diff below should be more on the mark...

Robin.

----->8-----
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..884ffca5b1eb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1891,6 +1891,9 @@ static int arm_smmu_device_cfg_probe(struct 
arm_smmu_device *smmu)
  			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
  	}

+	if (smmu->impl && smmu->impl->cfg_probe)
+		return smmu->impl->cfg_probe(smmu);
+
  	/* Now we've corralled the various formats, what'll it do? */
  	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S)
  		smmu->pgsize_bitmap |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
@@ -1909,7 +1912,6 @@ static int arm_smmu_device_cfg_probe(struct 
arm_smmu_device *smmu)
  	dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n",
  		   smmu->pgsize_bitmap);

-
  	if (smmu->features & ARM_SMMU_FEAT_TRANS_S1)
  		dev_notice(smmu->dev, "\tStage-1: %lu-bit VA -> %lu-bit IPA\n",
  			   smmu->va_size, smmu->ipa_size);
@@ -1918,9 +1920,6 @@ static int arm_smmu_device_cfg_probe(struct 
arm_smmu_device *smmu)
  		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
  			   smmu->ipa_size, smmu->pa_size);

-	if (smmu->impl && smmu->impl->cfg_probe)
-		return smmu->impl->cfg_probe(smmu);
-
  	return 0;
  }

