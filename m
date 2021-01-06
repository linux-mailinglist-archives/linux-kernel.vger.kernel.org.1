Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13F2EBAA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbhAFHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:41:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:11568 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAFHl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:41:56 -0500
IronPort-SDR: vJj48cNHEIe/Thl86I52nDGJdK74H3WpFjfa3aWrZAx7MUCK0rJ4vZhSb5/oD+kB8GE7PkbH5c
 gAvmMm5EIg/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174668205"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="174668205"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:41:15 -0800
IronPort-SDR: oDapHw/U4AKPKVjVaR4Cs2Wx9ASCWJjEzLfT9bOEELG78L1Pgq+vmEZtgbhYvdJByIOf3Dd6P8
 tkhJVCbdYPkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="361466692"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2021 23:41:12 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     arnd@arndb.de, lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        russell.h.weight@intel.com
Subject: [PATCH 0/2] Add retimer interfaces support for Intel MAX 10 BMC
Date:   Wed,  6 Jan 2021 15:36:05 +0800
Message-Id: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports the ethernet retimers (C827) for the Intel PAC
(Programmable Acceleration Card) N3000, which is a FPGA based Smart NIC.

The 2 retimer chips connect to the Intel MAX 10 BMC on the card. They are
managed by the BMC firmware. Host could query their link states and
firmware version information via retimer interfaces (Shared registers) on
the BMC. The driver creates sysfs interfaces for users to query these
information.


Xu Yilun (2):
  mfd: intel-m10-bmc: specify the retimer sub devices
  misc: add support for retimers interfaces on Intel MAX 10 BMC

 .../ABI/testing/sysfs-driver-intel-m10-bmc-retimer |  32 +++++
 drivers/mfd/intel-m10-bmc.c                        |  19 ++-
 drivers/misc/Kconfig                               |  10 ++
 drivers/misc/Makefile                              |   1 +
 drivers/misc/intel-m10-bmc-retimer.c               | 158 +++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h                  |   7 +
 6 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
 create mode 100644 drivers/misc/intel-m10-bmc-retimer.c

-- 
2.7.4

