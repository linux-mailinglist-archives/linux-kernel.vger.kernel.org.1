Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE92C1659
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgKWURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:17:19 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11571 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbgKWURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:17:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc18d10000>; Mon, 23 Nov 2020 12:17:21 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:17:18 +0000
Received: from skomatineni-linux.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Nov 2020 20:17:17 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] Add AHCI support for Tegra186
Date:   Mon, 23 Nov 2020 12:17:19 -0800
Message-ID: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162641; bh=qDsiNNSIp8k6a2ZldSYBzOxZ7unw6VDIjkB/xLaSv3s=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=J/7+GAHisuk9QdSLxoNyyiNfG3gI7C9uFX7jvZF1usi1sQMA7NAueVzNWQhqhJVwc
         36e11ShXvYzgVB2ryIK1SjWmNPHPaeCRVksm+tjpuDzcailnW4lR3Hb8Q+PbZKLeat
         eDXYaOtnlmKK+6xcxqywP1liuS6tAE0dElsqMYnVhNBKR85PJSURImbJ2UJNdRiqpg
         ZipU4gfaqLgNLNLV5J3xH8NbzSEuaQYDytLtfXi2vxKApZn1MOw+ghnFCgo22SyBFk
         zVSsXWIJAshCdmPMPF8kTglB+jXJQDPnTxofAzrndbF+hmYSAC2wGs32A/flTP60MN
         HTuCjYhtpQmSw==
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
[v3]:	fixed yaml example to pass dt_binding_check
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

 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 176 +++++++++++++++++++++
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
 arch/arm/boot/dts/tegra124.dtsi                    |   6 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |   6 +-
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  28 ++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   6 +-
 drivers/ata/ahci_tegra.c                           |  60 +++++--
 8 files changed, 264 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt

-- 
2.7.4

