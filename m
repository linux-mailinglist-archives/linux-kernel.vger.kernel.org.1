Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182DB2B255A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgKMU0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43164 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgKMU0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605299175; x=1636835175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BsMTPr1uoiD7uSWtC2NTZsYFHWtaa6TVrHx8UkOU+tQ=;
  b=kjfgFSapsGAbFpp++QrY/JabF4mYF56v7yS38ePXkyD8q9KJOY86CQla
   2YEfi9gYXwciBQnqSVsaembNyb1/M49MXXh1NWUzMlU4SYjHdCnsFtzkm
   Faa/ifrim+m4kDAGqbH/+ynWiGJpFg1jp20bsOdR8jKo7dV3DjYG40UkK
   QfWlUGqU8wp1Zxu53C699rrxBje4GFZ2HINgIE+vuKGSiZjT6dfnb2tpT
   KGNiWmCxs2xoRmxv/zo2fwC1ublkcRrBuTpZVhXS+GdQvrzd3rTXb2UG0
   CkqatuhnjeeOdlg7FZfnVu9hk77YBsR+7z53SerdSLPERZ7inNttMzJ+Q
   w==;
IronPort-SDR: UMRUlSGvVpITd4NARhFZ0JG6HbpLWA8iaYeDfVJymd2HrzKv6o14jwfASnoWGJRVEuz3hl6qaP
 F7CM83jwDbeNhicfFzSyxMNe4/X3nsm9fuckBlfvhSrMgmWiPvw+EuK8OSlCQAJ1N4iey5ZfUR
 4xeiiSKRkyvANBG8nry0BcIIl4t+z3ZblpP/DPu+xq2NdS7QoxcDgmeQfednnPtueEUa/H1oXl
 Dp/B0aB9ZIbnUwib1MJRAAh4fn64zReXFAoA4zdnBo3QpF08cmXK0k+utn+VbYyGefsU0tmL/H
 qhc=
X-IronPort-AV: E=Sophos;i="5.77,476,1596470400"; 
   d="scan'208";a="157074942"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2020 04:26:13 +0800
IronPort-SDR: zV4N8o3PYbL3FqiqusMk0Rinq5agj+WEIT/oTKGubLprfCyriKg/YTZYIhOsHemnO8rCP5n5Ly
 F445J9ghA99PXUJwS04idPRX0KpSCmijilqGd5zZs5OcBfoTVFgZoenBOdWU3lwypsxaNZnPmc
 Le5OdZyLvVmr4ho6OtRRtrLH+sYDe2qlR+/akfE+duQg85e3CxmY+IIbXJC148B/IycgnJKq7J
 VtZEv4l04tfnRXhfA22xLZjXU3k7YgJejI3diOqQCnaoXNJq/0DdErB/0oOBEiQyFBhK2sUhDR
 PJDhZ8utRL93gHy1vYYirkp2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:12:10 -0800
IronPort-SDR: WQtXQjI1u1jqJXD6Sv1H4OJIG4os8y8WaQHEm7RJBJw5K/R+zHrdF8qQ5qhz0MN4Eqf+Nd+vqt
 U7tBX+9yA1foRDd/yjWD6+kDltN7U51VEH7wTi+mihaH4h+RIfsXuwbCsYLaKPQNHNRfoQw8MG
 H2JCuKF+xxvUzzkwCJYl2S/39SzQZkIuis28Bx6w4+yC65F2RW7h/9i/FahuhZ60j8YPR8PPcQ
 Q9iOi3UF4q1mjsTX4GMrbGdK8vRwKOIQPb66bXJFjwqdDFjU6iq3bJhxWeClKT7z8Xe8+cfw/o
 wQ0=
WDCIronportException: Internal
Received: from usa003372.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.22])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Nov 2020 12:26:14 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bin.meng@windriver.com>,
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
Subject: [RFC PATCH v2 4/4] RISC-V: Enable Microchip PolarFire ICICLE SoC
Date:   Fri, 13 Nov 2020 12:25:50 -0800
Message-Id: <20201113202550.3693323-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113202550.3693323-1-atish.patra@wdc.com>
References: <20201113202550.3693323-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Microchip PolarFire ICICLE soc config in defconfig.
It allows the default upstream kernel to boot on PolarFire ICICLE board.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d222d353d86d..2660fa05451e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -16,6 +16,7 @@ CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
+CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
@@ -79,6 +80,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
-- 
2.25.1

