Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8CB2B2557
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKMU0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43164 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605299171; x=1636835171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aMGUJyhItmKZRJpcyfb3GcMubGvsstL4VJvXXylXx24=;
  b=mo/4EqwYt/vJ5vRwFE+54zQNGTesTMnii582sRlZ5RXDgTUBcQlznZwM
   NOTJ7NqNc8EG3FjEwI+DGTOPpjIlNSsl2NmBQEA7SbdwcdnySgGFizQ4f
   xvbZwSs82iI+W8jnxO1FttmUlaaUj2A3zA2Kcy/5lUrhbZLYFxoa9LpLL
   RQUAUqW5ZAcw3d1sFhQw+AeN4VEATFQA7ylL9WecGwDysoZMBM/OffQFz
   8oFNqZFxE9nvKNDdh9fytwosCUgxOkGUXBsmmf/xo/NCkgBKpHGvM0VEv
   8ADDOFYBLUhgijjd8q3VzN1O2Q27dIUSLFmqBl2oOclVvfkmdPPR7AAOa
   A==;
IronPort-SDR: GvT65azZmgLwc59EIrQoI2m4/qwDap8RpGvDQjl7ZxURfdMgdpp5GLJWCTMAgfuICy/GobxELG
 BPkzNhCCfEu+yYiSxFV25FW4OdYt6m+A4skW4yMJZhcugDi7ROMJC9EUltUqgNgaUzsv5IGGmu
 IHwNLvBRnbTkMX/7CKquRHj8qAr6Ku9rOoTWcqGnkRWldmUccZpeuxM5kHnA55X8XqETzhlkL0
 oIBOnapG6DK1ZIRNkkmdmueLKRFVUjp0vb1Vbngbt2fUC+wbMbaYlP4k0Qb8/aFZh03fmS3+nd
 18o=
X-IronPort-AV: E=Sophos;i="5.77,476,1596470400"; 
   d="scan'208";a="157074936"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2020 04:26:11 +0800
IronPort-SDR: Nz+OGuTERmoGQg2D188Pub6lsQthrwIU2wGXQnsrB1+gyJW5bIppdkPGEeehNo3u3wMHZb1KWW
 35WLrUGkQTjrJrZiZ671kldLNiCnIpss33rPshIPF4eam7jJKpCxgMhJCNX7iYxM7Lcq99nHu+
 85AhAFJZBUdauVoWcRTyvzPlm52QJsOE2peLQe67jPuhJQPsooppLDEEJjk0rEuq7n9kNR+RGS
 i5tLcc/Kv+a46wFUMNBtsOeE6R/zgHOnxO8NDTHRG8j9k0Gbypv4U2kYTUtJWpogAAH/2tmeKo
 ubMr+XXBrIau98NNF1w2uWS0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:12:08 -0800
IronPort-SDR: rFi0Qt+Ab2PLPGASxi8YGY51ueh2j8HSBInPX4L6oSpxE3yB1nxkkVjJFgFzIyP65RA6tjRJRf
 lDdvuy5JFqS0iZtICpeXAlpHnDGUS/xxGuMcmjZFpiuNOHXYzy7TYLG3t8N74yLCZi4nn/RNAO
 pDvshD5qtKC4VLfSvNCuZZfD7SfpbiBGUAPAsLfPM8K40ByqpqxyZK4WXpNu3kmZFEDiv29ByD
 vNRZnfSiJ7+ouT1WWcVLzrSCl5+bR9wCYCOWe+cXCH7GHP0IeQu8R58sj21nP0leA3oO86yCZc
 9+c=
WDCIronportException: Internal
Received: from usa003372.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.22])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Nov 2020 12:26:12 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com, Ivan.Griffin@microchip.com,
        Conor.Dooley@microchip.com
Subject: [RFC PATCH v2 0/4] Add Microchip PolarFire Soc Support 
Date:   Fri, 13 Nov 2020 12:25:46 -0800
Message-Id: <20201113202550.3693323-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
It is rebased on v5.10-rc3 and depends on clock support. 
Only MMC and ethernet drivers are enabled via this series.
The idea here is to add the foundational patches so that other drivers
can be added to on top of this. The device tree may change based on
feedback on bindings of individual driver support patches.

This series has been tested on Qemu and Polar Fire Soc Icicle kit.
The following qemu series is necessary to test it on Qemu.

The series can also be found at.
https://github.com/atishp04/linux/tree/polarfire_support_upstream_v2

I noticed the latest version of mmc driver[2] hangs on the board with
the latest clock driver. That's why, I have tested with the old clock
driver available in the above github repo.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
[2] https://www.spinics.net/lists/devicetree/msg383626.html

@Cyril: I have added you as the maintainer for this board as I am not sure
who else from Microchip should be the added to the maintainer list. Please
let me know and I can add the entry to the MAINTAINERS file in next version.

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

.../devicetree/bindings/riscv/microchip.yaml  |  27 ++
arch/riscv/Kconfig.socs                       |   7 +
arch/riscv/boot/dts/Makefile                  |   1 +
arch/riscv/boot/dts/microchip/Makefile        |   2 +
.../microchip/microchip-mpfs-icicle-kit.dts   |  54 +++
.../boot/dts/microchip/microchip-mpfs.dtsi    | 342 ++++++++++++++++++
arch/riscv/configs/defconfig                  |   4 +
7 files changed, 437 insertions(+)
create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
create mode 100644 arch/riscv/boot/dts/microchip/Makefile
create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi

--
2.25.1

