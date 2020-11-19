Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60C2B8E01
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKSIyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:54:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12983 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:54:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb632bf0000>; Thu, 19 Nov 2020 00:54:23 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 08:54:09 +0000
Received: from jckuo-lt.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 19 Nov 2020 08:54:07 +0000
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v5 00/16] Tegra XHCI controller ELPG support
Date:   Thu, 19 Nov 2020 16:53:49 +0800
Message-ID: <20201119085405.556138-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605776063; bh=CmXb3eYWUiDlzWr3hDdd1ob3Q9NsgunCKgz7xTZ9kKs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=Qx81zObipdI2BpYvHgXz+7B/Rw3N/Sjmaklbh3SDUb4xXUCGOsCBZN0Wvnf1BZl3c
         RmTVf70lAMhhLQSicMVpGH4hwXuLf+fTPLS6mDUSAcr7AOwVpNNyXYaYBQUZTcTQVR
         g/SpLf5JM3rNwTK5UqRKKXDBU+t6fER8owdlPX4BPTuoi8dA5O6qgdvlAlhBC8AQ4t
         uNlmEZbrH5tG4WzSShy17Rc0Yi/XmoDuVxFSJPFLndT8AZ+3LfwfgKA+XJ+7BhrRsS
         7Iqy/mg46FxM4N4wt+HWmMoAqQemhwE1K5r52prBSgmKCMrJk+SrMa/a9NqF4IoHS+
         5kuYtpXj6Xl+A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra XHCI controler can be placed in ELPG (Engine Level PowerGated)
state for power saving when all of the connected USB devices are in
suspended state. This patch series includes clk, phy and pmc changes
that are required for properly place controller in ELPG and bring
controller out of ELPG.

JC Kuo (16):
  clk: tegra: Add PLLE HW power sequencer control
  clk: tegra: Don't enable PLLE HW sequencer at init
  phy: tegra: xusb: Move usb3 port init for Tegra210
  phy: tegra: xusb: tegra210: Do not reset UPHY PLL
  phy: tegra: xusb: Rearrange UPHY init on Tegra210
  phy: tegra: xusb: Add Tegra210 lane_iddq operation
  phy: tegra: xusb: Add sleepwalk and suspend/resume
  soc/tegra: pmc: Provide USB sleepwalk register map
  arm64: tegra210: XUSB PADCTL add "nvidia,pmc" prop
  dt-bindings: phy: tegra-xusb: Add nvidia,pmc prop
  phy: tegra: xusb: Add wake/sleepwalk for Tegra210
  phy: tegra: xusb: Tegra210 host mode VBUS control
  phy: tegra: xusb: Add wake/sleepwalk for Tegra186
  arm64: tegra210/tegra186/tegra194: XUSB PADCTL irq
  usb: host: xhci-tegra: Unlink power domain devices
  xhci: tegra: Enable ELPG for runtime/system PM

 .../phy/nvidia,tegra124-xusb-padctl.txt       |    1 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |    1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |    1 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |    2 +
 drivers/clk/tegra/clk-pll.c                   |   12 -
 drivers/clk/tegra/clk-tegra210.c              |   53 +-
 drivers/phy/tegra/xusb-tegra186.c             |  558 ++++-
 drivers/phy/tegra/xusb-tegra210.c             | 1889 +++++++++++++----
 drivers/phy/tegra/xusb.c                      |   92 +-
 drivers/phy/tegra/xusb.h                      |   22 +-
 drivers/soc/tegra/pmc.c                       |   94 +
 drivers/usb/host/xhci-tegra.c                 |  613 ++++--
 include/linux/clk/tegra.h                     |    4 +-
 include/linux/phy/tegra/xusb.h                |   10 +-
 14 files changed, 2787 insertions(+), 565 deletions(-)

--=20
2.25.1

