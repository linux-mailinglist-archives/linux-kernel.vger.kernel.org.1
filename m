Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF08D2CEA5C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgLDI7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:59:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41893 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgLDI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607073581; x=1638609581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ri+FugxHPT3MU1bKnCzzrP+ZZtjxordrdt8HgAEL6gc=;
  b=T5aZjZU22RdFGVEgdII9M3ICO9Wb8cWEqGhqkOjIDKi41Ed8qKtVaGN5
   meDYGxo+L6U7k0M+aHMKDxDDUojyWrKITluLK0RgqgNl4pJk2CtL8K1tD
   0pc3HPHnGStMRSYyegIXmBghDpUHrf/HqO4inqRGvD2Obfq++7S5KpZzq
   h/rMryx58u4i3cwTThvnLPX0rGeacg0ivKkuHCG2J1GZIh2Oa5WbgCyeO
   bTHM47gOyx/exk0benK8GFK1xZpuzcSg3OaT2rC4H3jN/hxsE83kZ0ygp
   pS29OXR32vL2sccqbbTiR9RaUK4uIRSgI3QlXsYrnzL1/VXtAHzyo+syl
   w==;
IronPort-SDR: TDHXxQlOT2xTlNlWFk2CJ0zlXBzGM3ENVOxFdHT4l9ZY21gZVZpiZGZxJTCzWEWVfREejpizqO
 FBbSMWWmYwBUeqPxMhro6wgmo3nGVgCozDSVjmuSi+zuCvSuD1jAAwvIHDnHyn61B7CxVFqAC7
 xT9QhdCepJCNKucRB/xgBQQQ/No7K28wtDQhze60W4Hxc+iB1Vd9KM8pBPBBJg6rq8dnSjpzoQ
 lHKLGCjP3aa8wXsZABQYcBQaCb2FF5852FQRcWWswFbhdxpK55Bu0GuJFllbL4ckf1OlgB4m3q
 WHc=
X-IronPort-AV: E=Sophos;i="5.78,392,1599494400"; 
   d="scan'208";a="258129842"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 17:18:02 +0800
IronPort-SDR: gbWdpMovKwWIWTHbC6xhSBZSu+TB0Tt6/sf6JrkDVHU/jRp9KhKIzTli1qkkbcKHW7qEMdTvW8
 FB5fAnkj7cmOWLpIurrDpRS+PLlihF5rs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 00:44:11 -0800
IronPort-SDR: wMWeORjOx1e44CXOWGwWCo0FXrHcpnja4cGMJP9tOytGyrXmo9BVRTO3xMmCnUadpfwslPT4a0
 oJ8PXjwCJL4g==
WDCIronportException: Internal
Received: from cnf010505.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2020 00:58:38 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bin.meng@windriver.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor.Dooley@microchip.com
Subject: [PATCH v3 0/5] Add Microchip PolarFire Soc Support 
Date:   Fri,  4 Dec 2020 00:58:30 -0800
Message-Id: <20201204085835.2406541-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
It is rebased on v5.10-rc6 and depends on clock support. 
Only MMC and ethernet drivers are enabled via this series.
The idea here is to add the foundational patches so that other drivers
can be added to on top of this. The device tree may change based on
feedback on bindings of individual driver support patches.

This series has been tested on Qemu and Polar Fire Soc Icicle kit.
The following qemu series is necessary to test it on Qemu.

The series can also be found at.
https://github.com/atishp04/linux/tree/polarfire_support_upstream_v3

I noticed the latest version of mmc driver[2] hangs on the board with
the latest clock driver. That's why, I have tested with the old clock
driver available in the above github repo.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
[2] https://www.spinics.net/lists/devicetree/msg383626.html

Changes from v2->v3:
1. Fixed a typo in dt binding.
2. Included MAINTAINERS entry for PolarFire SoC.
3. Improved the dts file by using lowercase clock names and keeping phy
   details in board specific dts file.

Changes from v1->v2:
1. Modified the DT to match the device tree in U-Boot.
2. Added both eMMC & SDcard entries in DT. However, SD card is only enabled
   as it allows larger storage option for linux distros.

Atish Patra (4):
RISC-V: Add Microchip PolarFire SoC kconfig option
dt-bindings: riscv: microchip: Add YAML documentation for the
PolarFire SoC
RISC-V: Initial DTS for Microchip ICICLE board
RISC-V: Enable Microchip PolarFire ICICLE SoC

Conor Dooley (1):
MAINTAINERS: add microchip polarfire soc support

.../devicetree/bindings/riscv/microchip.yaml  |  28 ++
MAINTAINERS                                   |   8 +
arch/riscv/Kconfig.socs                       |   7 +
arch/riscv/boot/dts/Makefile                  |   1 +
arch/riscv/boot/dts/microchip/Makefile        |   2 +
.../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
.../boot/dts/microchip/microchip-mpfs.dtsi    | 331 ++++++++++++++++++
arch/riscv/configs/defconfig                  |   4 +
8 files changed, 453 insertions(+)
create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
create mode 100644 arch/riscv/boot/dts/microchip/Makefile
create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi

--
2.25.1

