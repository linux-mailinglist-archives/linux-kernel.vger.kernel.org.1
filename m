Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938352CEA66
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgLDJBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:01:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42055 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgLDJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607072525; x=1638608525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BsMTPr1uoiD7uSWtC2NTZsYFHWtaa6TVrHx8UkOU+tQ=;
  b=UNUyh1TImNqxyZHpt+xEqBkTTcWbjfDcf21eG39frM/liJKhy8Yq17uK
   k7ndxYkhFEvRS099D/HMH4HkApPbzvXNKkqpAgopb3eQdmWFJufsIn7Dd
   8aquO4HoFdlzt78BQSaarN9WGbUAyUC4MfF4oxFeeXAvPOrO2YclUCrf4
   Efd3+uhoG7nv3b+8idv2txhZFlhrYHZsHVSTJ19Esv32iwGzWvu/T6EbN
   BxuSSCl41Ajv3cdHzlPjhTsGg37ZYwRBHjRDc2cdgmFvr1Ai/BzGwF1iy
   s5ruvV9flsIfH8JnsUzvvdDZ6vxX3sMQpV9T22hrlwPA5Kj1y84m96D6H
   g==;
IronPort-SDR: XrBaKym2ux0+7EKrgURrijK5CujIhBDy1i3k4kaeBC/qCdLT1JTX3yX9prIjQmuQbMlSg7Skg5
 WavoRw+Cwv8uoSCnOg6noCmeR8qLFiw4vAqMjlkCmchKtCSfdmMAo6JHhcSOQcuLzr3TtMPSIH
 6jkCH7J5H5zD+IoNPLVpye1c2AP4vzuYEvslNKlOhURRcvWM8ohKCNspMKFn+BuPx4F8SbngXG
 Zn6/wxZorolachyWUnRWZ2lLSxWnEAaO1bH2YZcx5Yl8gwXXAPfSbf42YORbjyM3iX0mmqUlBu
 UOc=
X-IronPort-AV: E=Sophos;i="5.78,392,1599494400"; 
   d="scan'208";a="258129849"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 17:18:06 +0800
IronPort-SDR: okFVFATur7bat8tg9u4igMKBcdegzVnOn1nPDF/7gW776008+Bre94/LXPvt8PoL00djLe5dgf
 DrOlN5jzGTmDmLlz1+EnrmllxQmdFH5RA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 00:44:13 -0800
IronPort-SDR: 7ysOSLT+8jkn51QPqEzKKgtz0AeLVWlVMGXCuxxhMB1Z+4wuxgbJg8cu77hJ9lHVZjvX5dciqi
 264C+b/g3SUQ==
WDCIronportException: Internal
Received: from cnf010505.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2020 00:58:41 -0800
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
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor.Dooley@microchip.com
Subject: [PATCH v3 4/5] RISC-V: Enable Microchip PolarFire ICICLE SoC
Date:   Fri,  4 Dec 2020 00:58:34 -0800
Message-Id: <20201204085835.2406541-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204085835.2406541-1-atish.patra@wdc.com>
References: <20201204085835.2406541-1-atish.patra@wdc.com>
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

