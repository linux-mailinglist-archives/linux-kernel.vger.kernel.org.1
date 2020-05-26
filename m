Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE4D1E1A93
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 07:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEZFGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 01:06:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:42947 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgEZFGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 01:06:20 -0400
IronPort-SDR: +LHUp/ev/fC01KoCDc4N3lIjolK5UrgyQNqlPBkpUIGAwOzrMWrFgRiPUk4T6J+AALUcmAV7bN
 4Uo3mf4GNhRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 22:06:19 -0700
IronPort-SDR: ucfUPh8XPtGtKHP3jL+4IsikV7JBLKIicpnKhi4u1JAL6hom0EThRi5NH02ISxdTOKWDxjQLln
 IFbuMMLGNGHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="255059506"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 25 May 2020 22:06:17 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, adrian.hunter@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 0/2] phy: intel: Add Keem Bay eMMC PHY support
Date:   Tue, 26 May 2020 13:04:50 +0800
Message-Id: <20200526050452.8837-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

Changes since v1:
- Rework phy-keembay-emmc.c to make it similar to phy-intel-emmc.c.
- Use regmap_mmio, and remove reference to intel,syscon.
- Use node name phy@....
- Update license i.e. use dual license.


Wan Ahmad Zainie (2):
  dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
  phy: intel: Add Keem Bay eMMC PHY support

 .../bindings/phy/intel,keembay-emmc-phy.yaml  |  45 +++
 drivers/phy/intel/Kconfig                     |   8 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-keembay-emmc.c          | 321 ++++++++++++++++++
 4 files changed, 375 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/phy-keembay-emmc.c

-- 
2.17.1

