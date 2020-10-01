Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618A8280133
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbgJAOZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:25:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:5353 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732478AbgJAOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:25:07 -0400
IronPort-SDR: N0sH4oSoFJlOMjEjMwnWbRrQBNlZ6EtMgcXEkV58SL7BjuKj5uzi/+depi7n7w3HMlZHXuvg7u
 xjmVzlOvCmHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="161975952"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="161975952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 07:24:54 -0700
IronPort-SDR: 2oyD6q+1pgU7g+tns2MMQSQyRywT+gr6/OpkgRA2Hv4O2o513H/0CMdy2/Ooa07KZWIE4ZidAV
 O7DVdSPFmnpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="294992486"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2020 07:24:51 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v2 0/3] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Thu,  1 Oct 2020 22:21:46 +0800
Message-Id: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Hi.

The first patch is to document DT bindings for Keem Bay Firmware Driver and update
the Maintainers list.

The second patch is the firmware driver file.

The third patch is to enable UHS-1 Support for Keem Bay EVM.

The patch was tested with Keem Bay evaluation module board.

Kindly help to review this patch set.

Thank you.

Changes since v1:
- Add Document DT Bindings for Keembay Firmware.
- Created Firmware Driver to handle ATF Service call
- Provide API for arasan driver for sd card voltage changes

Muhammad Husaini Zulkifli (3):
  dt-bindings: arm: firmware: Add binding for Keem Bay Firmware Support
  firmware: Keem Bay: Add support for Arm Trusted Firmware Service call
  mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC

 .../arm/firmware/keembay,firmware.yaml        |  36 +++++
 MAINTAINERS                                   |   7 +
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/intel/Kconfig                |  14 ++
 drivers/firmware/intel/Makefile               |   4 +
 drivers/firmware/intel/keembay_smc.c          | 119 ++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c            | 127 ++++++++++++++++++
 include/linux/firmware/intel/keembay_smc.h    |  27 ++++
 9 files changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/keembay,firmware.yaml
 create mode 100644 drivers/firmware/intel/Kconfig
 create mode 100644 drivers/firmware/intel/Makefile
 create mode 100644 drivers/firmware/intel/keembay_smc.c
 create mode 100644 include/linux/firmware/intel/keembay_smc.h

--
2.17.1

