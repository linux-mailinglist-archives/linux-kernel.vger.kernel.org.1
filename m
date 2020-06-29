Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5249020CBCA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 04:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgF2C2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 22:28:49 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12339 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgF2C2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:28:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef951ae0000>; Sun, 28 Jun 2020 19:27:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 28 Jun 2020 19:28:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 28 Jun 2020 19:28:46 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 02:28:42 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 29 Jun 2020 02:28:43 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef951da0001>; Sun, 28 Jun 2020 19:28:42 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v7 0/3] Nvidia Arm SMMUv2 Implementation
Date:   Sun, 28 Jun 2020 19:28:35 -0700
Message-ID: <20200629022838.29628-1-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593397678; bh=TJTlxWXvu6KbpRkAPFIrB+f4kpDeqlZxo9h97cOVZhc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=qwXPNBytS+mI/ETX2WZYE/lXj27QvUerZSGX5NylSeK2vGGwHOZwVSG3Yds0DK6FS
         3tDVh2ISM5dKFOSxClZTYXPQ11rGTeYGz5AwffsjpPY0pUM5HLh8dECCmqBxDkOJD0
         xSXEh2RDmus4umMXr/u5ipaWte+3IkzY/AW8ecKZ5BO9ng6IEjBWqGcZOJxRSDFehv
         7u4pJbqdXGjxiUpUKGwcPJK94hC/SgzGpC/99obrAMfltTovlWxiQsSk9S6n3IyG8K
         XP3Z5CY/DW/uA6uym3lFT14pLx60PzRZwBVQDPjsBrB4oGsq75/XMVgTPxFkGmUz/q
         2bcogtulSa4PQ==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v7:
Incorporated the review feedback from Nicolin Chen, Robin Murphy and Thierr=
y Reding.
Rebased and validated patches on top of git://git.kernel.org/pub/scm/linux/=
kernel/git/joro/iommu.git next

v6- https://lkml.org/lkml/2020/6/4/1018
v5 - https://lkml.org/lkml/2020/5/21/1114
v4 - https://lkml.org/lkml/2019/10/30/1054
v3 - https://lkml.org/lkml/2019/10/18/1601
v2 - https://lkml.org/lkml/2019/9/2/980
v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (3):
  iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
  dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
  iommu/arm-smmu: Add global/context fault implementation hooks

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   5 +
 MAINTAINERS                                   |   2 +
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/arm-smmu-impl.c                 |   3 +
 drivers/iommu/arm-smmu-nvidia.c               | 294 ++++++++++++++++++
 drivers/iommu/arm-smmu.c                      |  17 +-
 drivers/iommu/arm-smmu.h                      |   4 +
 7 files changed, 324 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c


base-commit: 48f0bcfb7aad2c6eb4c1e66476b58475aa14393e
--=20
2.26.2

