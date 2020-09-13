Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF912681F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 01:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgIMX5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 19:57:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:50540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgIMX5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:57:12 -0400
IronPort-SDR: fy/DpuvMftXtu71AJ5gWQHyOUfqMZaKii62RL/ywHJHlCASpSrxWgdQowjr4WErQNVQpv3MP0F
 RIKYFVjwZCMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="146746551"
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="146746551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 16:57:11 -0700
IronPort-SDR: J0uA/flqbUm8o+USs9+TP+wq1sNPIk2NaB/VM2PyKs48FeAWs4JIenbN1q63v1IhsfgfothrgI
 rIVVezEe3ptQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="305973458"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2020 16:57:08 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        eswara.kota@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v9 0/3] phy: intel: Add Keem Bay eMMC PHY support
Date:   Mon, 14 Sep 2020 07:55:19 +0800
Message-Id: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The first patch is added to rename rename
phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c.

The second patch is to document DT bindings for Keem Bay eMMC PHY.

The the third is the driver file, loosely based on phy-rockchip-emmc.c
and phy-intel-emmc.c. The latter is not being reused as there are
quite a number of differences i.e. registers offset, supported clock
rates, bitfield to set.

The patch was tested with Keem Bay evaluation module board.

Thank you.

Best regards,
Zainie

Changes since v8:
- Amend Reviewed-by tag to single line.
- Add DT bindings for Keem Bay eMMC PHY into lgm eMMC PHY DT bindings
  document.

Changes since v7:
- Add Reviewed-by tag to 1st (Vadivel) and 3rd patch (Andy).
- In 3rd patch,
  - remove maskval and use FIELD_PREP instead,
  - add <linux/bitfield.h> header,
  - use return dev_err_probe(...) for devm_phy_create(...),
  - rearrange depends on in Kconfig file,

Changes since v6:
- Add new patch to rename phy-intel-{combo,emmc}.c to
  phy-intel-lgm-{combo,emmc}.c.
- Add Reviewed-by: Rob Herring <robh@kernel.org> tag to 2nd patch.
- In 3rd patch,
  - add and use generic helper to update register bits,
  - end module name with .ko in Kconfig help.

Changes since resend v5:
- In keembay_emmc_phy_power(), remove redundant return ret;.

Resend v5:
- Include missing changes done for phy-keembay-emmc.c (See Changes since
  v3)

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

*** BLURB HERE ***

Wan Ahmad Zainie (3):
  phy: intel: Rename phy-intel to phy-intel-lgm
  dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
  phy: intel: Add Keem Bay eMMC PHY support

 .../bindings/phy/intel,lgm-emmc-phy.yaml      |  17 +-
 drivers/phy/intel/Kconfig                     |  22 +-
 drivers/phy/intel/Makefile                    |   5 +-
 drivers/phy/intel/phy-intel-keembay-emmc.c    | 307 ++++++++++++++++++
 ...hy-intel-combo.c => phy-intel-lgm-combo.c} |   0
 ...{phy-intel-emmc.c => phy-intel-lgm-emmc.c} |   0
 6 files changed, 343 insertions(+), 8 deletions(-)
 create mode 100644 drivers/phy/intel/phy-intel-keembay-emmc.c
 rename drivers/phy/intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} (100%)
 rename drivers/phy/intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c} (100%)

-- 
2.17.1

