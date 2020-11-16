Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5A2B4358
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgKPMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:10:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:31993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgKPMKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:10:21 -0500
IronPort-SDR: 2TXpRXF53NI3G+giSnGKvRNfqp4tIYSwVmI3qlfVbScmGt2h4gULIllxb5HyS9mRDQtDYjU+2i
 +5IF4VJAEQIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="255446422"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="255446422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:10:20 -0800
IronPort-SDR: EFKImNVRssMy75btCwPCV89BGq+SkVhKv0Znc1JAS/hYpQm9sqhGw2OWQuj+abUct9Z5cErj7L
 p7YBvryIIypA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="356259710"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2020 04:10:18 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 0/2] phy: intel: Add Keem Bay USB PHY support
Date:   Mon, 16 Nov 2020 20:08:29 +0800
Message-Id: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

Changes since v3:
- Revise commit log message of the driver patch.
- In Kconfig, use depends on ARCH_KEEMBAY || COMPILE_TEST.
- Use genmask() to define USS_CPR_MASK.
- In keembay_regmap_config struct, specify .max_register.

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
 drivers/phy/intel/phy-intel-keembay-usb.c     | 301 ++++++++++++++++++
 4 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
 create mode 100644 drivers/phy/intel/phy-intel-keembay-usb.c

-- 
2.17.1

