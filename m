Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB6284F50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:59:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:56023 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJFP7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:59:09 -0400
IronPort-SDR: m7ErqUHY5zAZeMmsZTOs7yXR6/57StugHOayHdGbZu4wBTP3imMQ12Afoq9URnhtVxj9fYKI4c
 i/h8/WOSTfmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="226148683"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="226148683"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 08:59:01 -0700
IronPort-SDR: DUDxLrhbtUVWop6V/UBF7oro5N3R60Y7kgXItwEN5ZQNXgTaBl6AoYa5iu2XUyPD7UASrxu1EB
 p36BMe9hWtwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="343826665"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2020 08:58:55 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v3 0/2] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Tue,  6 Oct 2020 23:55:47 +0800
Message-Id: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Hi.

The first patch is to enable UHS-1 Support for Keem Bay EVM.

The second patch is the header file to handle ATF call.

These 2 patches was tested with Keem Bay evaluation module board.

Kindly help to review this patch set.

Thank you.

Changes since v2:
- Removed Document DT Bindings for Keembay Firmware.
- Removed Firmware Driver to handle ATF Service call.
- Add header file to handle API function for device driver to communicate with Arm Trusted Firmware.

Changes since v1:
- Add Document DT Bindings for Keembay Firmware.
- Created Firmware Driver to handle ATF Service call
- Provide API for arasan driver for sd card voltage changes

Muhammad Husaini Zulkifli (2):
  mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
  firmware: Keem Bay: Add support for Arm Trusted Firmware Service call

 drivers/mmc/host/sdhci-of-arasan.c            | 127 ++++++++++++++++++
 .../linux/firmware/intel/keembay_firmware.h   |  46 +++++++
 2 files changed, 173 insertions(+)
 create mode 100644 include/linux/firmware/intel/keembay_firmware.h

--
2.17.1

