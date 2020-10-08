Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B095287B98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgJHSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:21:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:32109 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJHSV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:21:56 -0400
IronPort-SDR: zmgzx/BpB6kxb+OEswHtFgI0guzPH9HdU3vbyQtSBwF5mzr+YDp+BDd8rx5oayeC7KSfh8nXcK
 v5hO+V0tzL5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250078373"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="250078373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 11:21:56 -0700
IronPort-SDR: Chg/XTQdWr1LDnCCUXQi3nRs6M9ZWgfacurGVYoBejW5BSQFGWOO0ZERpitAKBnqZSfNlGf33Q
 feoQitKleHjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="349572516"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2020 11:21:53 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v5 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Fri,  9 Oct 2020 02:18:40 +0800
Message-Id: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Hi.

The first patch is the header file to handle ATF call.

The second patch is DT binding for arasan controller for uhs support.

The third patch is to introduce the structure device pointer in arasan controller probe.

The fourth patch is to enable UHS-1 Support for Keem Bay EVM.

All of these patches was tested with Keem Bay evaluation module board.

Kindly help to review this patch set.

Thank you.

Changes since v4:
- Fixed comment by Andy and Sudeep on first patch.
- Add Acked-by tag.
- Fixed comment by Michal and Andy on the third patch to replace current users of &pdev->dev.

Changes since v3:
- Add Dt bindings for uhs gpio.
- Fixed comment by Michal and Sudeep on header file for the macro and error code.
- Fixed comment by Andy and created 1 new patch to separate the struc dev pointer in probe func.
- Fixed comment by Michal in arasan controller code.

Changes since v2:
- Removed Document DT Bindings for Keembay Firmware.
- Removed Firmware Driver to handle ATF Service call.
- Add header file to handle API function for device driver to communicate with Arm Trusted Firmware.

Changes since v1:
- Add Document DT Bindings for Keembay Firmware.
- Created Firmware Driver to handle ATF Service call
- Provide API for arasan driver for sd card voltage changes

Muhammad Husaini Zulkifli (4):
  firmware: keembay: Add support for Trusted Firmware Service call
  dt-bindings: mmc: Add uhs-gpio for Keem Bay UHS-1 Support
  mmc: sdhci-of-arasan: Add structure device pointer in probe
  mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |   8 +-
 drivers/mmc/host/sdhci-of-arasan.c            | 163 ++++++++++++++++--
 include/linux/firmware/intel/keembay.h        |  47 +++++
 3 files changed, 199 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/firmware/intel/keembay.h

--
2.17.1

