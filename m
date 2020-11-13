Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C12B2493
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKMTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:36:54 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17898 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgKMTgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:36:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faee05e0000>; Fri, 13 Nov 2020 11:37:02 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 19:36:54 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 13 Nov 2020 19:36:53 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] Add AHCI support for Tegra186
Date:   Fri, 13 Nov 2020 11:36:52 -0800
Message-ID: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605296222; bh=mhFqHEDQm14ydpJ90cQFJG0t5wKwiepPStGAkF4xtuU=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=KMSZSn/tKTUBWB/AFJu2qQd1Mwp/20jm3ZCjR3Fp0alPCLp9clDJvLLytdidWwp1a
         IF87JzJuvqaQF6V9WKqODHMISPJ/ezayiRtr1CsDb5N009UAz9xtQi5+wCHF63yVyy
         XWepCw/3Qy+0aO23V7uQuPYDOin1SqjeVHSQrsZAjYsWt8JrkY/KkFEKNVbKNwuAY2
         Dtn1CFXXYK7twRT93mPOqYXYD6ywxbMC/uSzrB2f3EZ0i8DLbVYmN5SC96qRVxKT29
         g0BKyBbSHC7jd/NtylRFLSrsPsLBztaF8AilzvMS/s5n3//Mru7hyMvoEltwGyhnuu
         La4/ZILaTbq/Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for AHCI-compliant SATA to Tegra186 SoC.

This series includes patches for
- Converting text based dt-binding document to YAML.
- Adding dt-bindings for Tegra186.
- Enabling AHCI-compliance SATA for Jetson TX2.
- Adding Tegra186 support to Tegra AHCI driver.

Delta between patch versions:
[v2]:	v1 feedback related to yaml dt-binding.
	Removed conditional reset order in yaml and updated dts files
	to maintain same order for commonly available resets across
	Tegra124 thru Tegra186.


Sowjanya Komatineni (6):
  arm: tegra: Change order of SATA resets for Tegra124
  arm64: tegra: Change order of SATA resets for Tegra132 and Tegra210
  dt-bindings: ata: tegra: Convert binding documentation to YAML
  dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
  arm64: tegra: Enable AHCI on Jetson TX2
  ata: ahci_tegra: Add AHCI support for Tegra186

 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 175 +++++++++++++++++++++
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
 arch/arm/boot/dts/tegra124.dtsi                    |   6 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |   6 +-
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  28 ++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   6 +-
 drivers/ata/ahci_tegra.c                           |  60 +++++--
 8 files changed, 263 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt

-- 
2.7.4

