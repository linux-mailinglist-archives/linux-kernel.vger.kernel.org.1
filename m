Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA4203E08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgFVRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:32:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729957AbgFVRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:32:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 791CB6476C5AEFFEEC27;
        Tue, 23 Jun 2020 01:32:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 01:32:39 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Date:   Tue, 23 Jun 2020 01:28:36 +0800
Message-ID: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in [0], the CPU may consume many cycles processing
arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
get space on the queue takes approx 25% of the cycles for this function.

This series removes that cmpxchg().

For my NVMe test with 3x NVMe SSDs, I'm getting a ~24% throughput
increase:
Before: 1310 IOPs
After: 1630 IOPs

I also have a test harness to check the rate of DMA map+unmaps we can
achieve:

CPU count	32	64	128
Before:		63187	19418	10169
After:		93287	44789	15862

(unit is map+unmaps per CPU per second)

[0] https://lore.kernel.org/linux-iommu/B926444035E5E2439431908E3842AFD24B86DB@DGGEMI525-MBS.china.huawei.com/T/#ma02e301c38c3e94b7725e685757c27e39c7cbde3

John Garry (4):
  iommu/arm-smmu-v3: Fix trivial typo
  iommu/arm-smmu-v3: Calculate bits for prod and owner
  iommu/arm-smmu-v3: Always issue a CMD_SYNC per batch
  iommu/arm-smmu-v3: Remove cmpxchg() in arm_smmu_cmdq_issue_cmdlist()

 drivers/iommu/arm-smmu-v3.c | 233 +++++++++++++++++++++++-------------
 1 file changed, 151 insertions(+), 82 deletions(-)

-- 
2.26.2

