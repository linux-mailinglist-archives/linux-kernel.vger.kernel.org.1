Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250C271966
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUCqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:46:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:53124 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUCqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:46:50 -0400
IronPort-SDR: w0cYPiPv1X/inuaS5G67yTG+ixW6M3ZH+JL1LgUOuPh8at0IF4bZ1Hb1Z+xQLAwzPUu6vbewbv
 qhCgTgHoS4Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="161218607"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="161218607"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 19:46:48 -0700
IronPort-SDR: oxGsi7TfPjHqrQEOePTcJo/GQ00SlPblOpRlQ8cUZVs+bGaSeU/JX21p+yrIY6hAwibPDoXlhs
 T18PdUakYCMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="321538127"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2020 19:46:45 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 0/4] phy: intel: Add Keem Bay USB PHY support
Date:   Mon, 21 Sep 2020 10:44:55 +0800
Message-Id: <20200921024459.20899-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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


Wan Ahmad Zainie (4):
  dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
  phy: intel: Add Keem Bay USB PHY support
  dt-bindings: usb: Add Intel Keem Bay USB controller bindings
  usb: dwc3: of-simple: Add compatible string for Intel Keem Bay
    platform

 .../bindings/phy/intel,phy-keembay-usb.yaml   |  44 +++
 .../bindings/usb/intel,keembay-dwc3.yaml      |  77 +++++
 drivers/phy/intel/Kconfig                     |  12 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-intel-keembay-usb.c     | 319 ++++++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c             |   1 +
 6 files changed, 454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
 create mode 100644 drivers/phy/intel/phy-intel-keembay-usb.c

-- 
2.17.1

