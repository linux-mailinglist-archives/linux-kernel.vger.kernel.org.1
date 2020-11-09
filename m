Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FEB2AAFD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 04:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgKIDSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 22:18:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:4228 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgKIDSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:18:39 -0500
IronPort-SDR: VTK8oPIDsk8nPhGRsYZ+4vV0dVoPHbfUluP4MFUxMskz6vfqK+dDZ0c6FPuMzjnV8vUyvbwE44
 Bt4+cD9mBc8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="187689004"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="187689004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2020 19:18:38 -0800
IronPort-SDR: 2l1G6DPPNNJf5pPWc39XARrnxuTHhZSUa9Mk7i6cBsaN3wbgLzOciCJu5RiEBHXSYEn7a4YJMK
 gheLaOcT9ePw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="353988795"
Received: from unknown (HELO wwanmoha-iLBPG2.png.intel.com) ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2020 19:18:35 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 0/2] phy: intel: Add Keem Bay USB PHY support
Date:   Mon,  9 Nov 2020 11:16:52 +0800
Message-Id: <20201109031654.22443-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

Changes since v1:
- Remove 2 patches that had been merged. Reduced To, Cc list.
- Rebased to v5.10-rc3.
- Add Rob's Reviewed-by tag in the first patch.
- Use ARCH_KEEMBAY in Kconfig.
- Update #include header; remove <linux/of_address.h>, and add
  <linux/bits.h>.
- Remove unnecessary comments.

Note: I resend this v2 as my previous v2 sent on Oct 28 not seen
in mailing lists.


Wan Ahmad Zainie (2):
  dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
  phy: intel: Add Keem Bay USB PHY support

 .../bindings/phy/intel,phy-keembay-usb.yaml   |  44 +++
 drivers/phy/intel/Kconfig                     |  12 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-intel-keembay-usb.c     | 288 ++++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
 create mode 100644 drivers/phy/intel/phy-intel-keembay-usb.c

-- 
2.17.1

