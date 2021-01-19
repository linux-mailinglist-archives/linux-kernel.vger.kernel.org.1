Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2872FAE94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405297AbhASCBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:01:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11558 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404910AbhASCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:01:14 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DKWzV1FftzMM69;
        Tue, 19 Jan 2021 09:59:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 19 Jan 2021 10:00:15 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Neil Leeder <nleeder@codeaurora.org>,
        "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH 0/2] Use another method to avoid resource conflicts between the SMMU and PMCG drivers
Date:   Tue, 19 Jan 2021 09:59:49 +0800
Message-ID: <20210119015951.1042-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PMCG may implement its resigters space(4KB Page0 and 4KB Page1)
within the SMMUv3 64KB Page0. In this case, when the SMMUv3 driver reserves the
64KB Page0 resource in advance, the PMCG driver try to reserve its Page0 and
Page1 resources, a resource conflict occurs.

commit 52f3fab0067d6fa ("iommu/arm-smmu-v3: Don't reserve implementation
defined register space") reduce the resource reservation range of the SMMUv3
driver, it only reserves the first 0xe00 bytes in the 64KB Page0, to avoid
the above-mentioned resource conflicts.

But the SMMUv3.3 add support for ECMDQ, its registers space is also implemented
in the SMMUv3 64KB Page0. This means we need to build two separate mappings.
New features may be added in the future, and more independent mappings may be
required. The simple problem is complicated because the user expects to map the
entire SMMUv3 64KB Page0.

Therefore, the proper solution is: If the PMCG register resources are located in
the 64KB Page0 of the SMMU, the PMCG driver does not reserve the conflict resources
when the SMMUv3 driver has reserved the conflict resources before. Instead, the PMCG
driver only performs devm_ioremap() to ensure that it can work properly.


Zhen Lei (2):
  perf/smmuv3: Don't reserve the register space that overlaps with the
    SMMUv3
  Revert "iommu/arm-smmu-v3: Don't reserve implementation defined
    register space"

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++-------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ---
 drivers/perf/arm_smmuv3_pmu.c               | 42 +++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 33 deletions(-)

-- 
1.8.3


