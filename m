Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D631B2B026D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKLKAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:00:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:19234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKLKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:00:09 -0500
IronPort-SDR: IdqtHMzyfYshQmPnGWMvQWNBU2JYoH5r4Q6lqT3Qd30cAnXwc6ZuJwLUP6zw6+ktfXbsYf+tmp
 1sNYkNYIuyLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="170392472"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="170392472"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 02:00:08 -0800
IronPort-SDR: cGsewaksEy/wE9MZHVP/aH18VqkuUmMIdo1ND5qMx9Bf22bJSitWYBKHl/wqLU0LVRq3apV7la
 8GbM5t6Nn7gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="399346134"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2020 02:00:06 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v3 0/2] phy: intel: Add Keem Bay USB PHY support
Date:   Thu, 12 Nov 2020 17:58:19 +0800
Message-Id: <20201112095821.27110-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Intel Keem Bay USB subsystem incorporates DesignWare USB3.1 controller,
an USB3.1 (Gen1/2) PHY and an USB2.0 PHY. It is a Dual Role Device
(DRD), operating as either a USB host or a USB device.

The patchset is tested on Keem Bay EVM.

Thank you.

Best regards,
Zainie

Changes since v2:
- Remove dependency on OF in Kconfig.
- Remove header file linux/of.h, and add linux/mod_devicetable.h.
- Add comments for each usleep_range() usage, provide reason for the
  delay.
- Replace usleep_range(2, 10) with udelay(2), as per
  Documentation/timers/timers-howto.txt.
- In _probe(), remove variable np and use dev->of_node directly.

Changes since v1:
- Remove 2 patches that had been merged.
- Rebased to v5.10-rc3.
- Add Rob's Reviewed-by tag in the first patch.
- Use ARCH_KEEMBAY in Kconfig.
- Update #include header; remove <linux/of_address.h>, and add
  <linux/bits.h>.
- Remove unnecessary comments.


Wan Ahmad Zainie (2):
  dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
  phy: intel: Add Keem Bay USB PHY support

 .../bindings/phy/intel,phy-keembay-usb.yaml   |  44 +++
 drivers/phy/intel/Kconfig                     |  12 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-intel-keembay-usb.c     | 300 ++++++++++++++++++
 4 files changed, 357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
 create mode 100644 drivers/phy/intel/phy-intel-keembay-usb.c

-- 
2.17.1

