Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B11FC259
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 01:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgFPXer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 19:34:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:5561 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFPXen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 19:34:43 -0400
IronPort-SDR: gBhqEhejMETHRpP6DaKlCpewzsprfX52T9XwAqc7XsNCMQE0NpPoB5N1oiXH59hKP3YSmFNAqT
 wyXO0fGa5V+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 16:34:41 -0700
IronPort-SDR: R5pbt93QtwvAwi2k8gNlUim5YH6uxmGR5y5OApouSsM9hQGLKaoMyx+tK1qdfmG1H84PGiORO9
 Uapt1LJVqd8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="263155654"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2020 16:34:37 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, adrian.hunter@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [RESEND v5 0/2] phy: intel: Add Keem Bay eMMC PHY support
Date:   Wed, 17 Jun 2020 07:32:50 +0800
Message-Id: <20200616233252.15619-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The first part is to document DT bindings for Keem Bay eMMC PHY.

The second is the driver file, loosely based on phy-rockchip-emmc.c
and phy-intel-emmc.c. The latter is not being reused as there are
quite a number of differences i.e. registers offset, supported clock
rates, bitfield to set.

The patch was tested with Keem Bay evaluation module board.

Thank you.

Best regards,
Zainie

Resend v5:
- Include missing changes done for phy-keembay-emmc.c (See Changes since v3)

Changes since v4:
- In Kconfig file, add depends on ARM64 || COMPILE_TEST and
  depends on OF && HAS_IOMEM.
- In Kconfig file, reword the help section to be more verbose.

Changes since v3:
- Exit keembay_emmc_phy_power() with return ret;.
- In keembay_emmc_phy_init(), use PTR_ERR_OR_ZERO(...).
- In keembay_emmc_phy_probe(), devm_regmap_init_mmio(...) in single
  line.

Changes since v2:
- Modify DT example to use single cell for address and size.

Changes since v1:
- Rework phy-keembay-emmc.c to make it similar to phy-intel-emmc.c.
- Use regmap_mmio, and remove reference to intel,syscon.
- Use node name phy@....
- Update license i.e. use dual license.



Wan Ahmad Zainie (2):
  dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
  phy: intel: Add Keem Bay eMMC PHY support

 .../bindings/phy/intel,keembay-emmc-phy.yaml  |  44 +++
 drivers/phy/intel/Kconfig                     |  12 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-keembay-emmc.c          | 316 ++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/phy-keembay-emmc.c

-- 
2.17.1

