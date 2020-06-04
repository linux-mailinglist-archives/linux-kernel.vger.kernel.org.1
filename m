Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E931EEE70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 01:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFDXoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 19:44:16 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14855 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFDXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:44:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed986f50001>; Thu, 04 Jun 2020 16:42:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 16:44:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 16:44:13 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 23:44:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Jun 2020 23:44:10 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed987490002>; Thu, 04 Jun 2020 16:44:09 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v6 0/4] Nvidia Arm SMMUv2 Implementation
Date:   Thu, 4 Jun 2020 16:44:10 -0700
Message-ID: <20200604234414.21912-1-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591314165; bh=1K8sRZ1SkGwFAEYz4zuF0KeLx+srb1vTBWbsBByL7NU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=oytOPy++C/iIi0x+cljApZvalwFLriaghJwWsQvzfzAyj36OH6gqpSXNIYgVVdoV+
         EDAP/UyTbZoucW0N/JY0p+GVMvdrcF4WDOwDoh1x5ILJikGQw4wyCc+hSNaMj34TSn
         UsNlmgzIgWtCSVOWGObiPN8vNozhazOYNwPkYFTAa9IiFBKZPsY9bV/rGnscXskrQR
         5batsIh428y1Dj95B8N9NsHIWy6gVUa1jg596iXwoalDdgB5zQSbHc0aDdu4ORG9wK
         7Cavcip58+BgYeqOafr4iPKvEeH2OeEA6Mh75C27kpKKALVcC3XNOJH/PjMAzPCdoZ
         bkkJoj6nFmWcA==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
Restricted the patch set to driver specific patches.
Fixed the cast warning reported by kbuild test robot.
Rebased on git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git nex=
t

v5 - https://lkml.org/lkml/2020/5/21/1114
v4 - https://lkml.org/lkml/2019/10/30/1054
v3 - https://lkml.org/lkml/2019/10/18/1601
v2 - https://lkml.org/lkml/2019/9/2/980
v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (4):
  iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
  dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
  iommu/arm-smmu: Add global/context fault implementation hooks
  iommu/arm-smmu-nvidia: fix the warning reported by kbuild test robot

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   5 +
 MAINTAINERS                                   |   2 +
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/arm-smmu-impl.c                 |   3 +
 drivers/iommu/arm-smmu-nvidia.c               | 261 ++++++++++++++++++
 drivers/iommu/arm-smmu.c                      |  11 +-
 drivers/iommu/arm-smmu.h                      |   4 +
 7 files changed, 285 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c


base-commit: 431275afdc7155415254aef4bd3816a1b8a2ead0
--=20
2.26.2

