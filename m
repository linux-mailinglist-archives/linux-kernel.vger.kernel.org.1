Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D27271ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIUGWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:22:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:4790 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIUGWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:22:30 -0400
IronPort-SDR: ODueQ2Vgsi8hp8/LxDpk5PlWKrslcGGLqP4fLCHigf5JkEMoDx0mQe0Yc9rLN80+nIAB6owra/
 /vE5ddTAfiyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="157703146"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="157703146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 23:22:29 -0700
IronPort-SDR: UKrKTMhbaahAv9WpDlD2qnVoNECMqmJXcCG0BJgDVOSXMUypO2FZPaA6z6HLhS6nrpw0pmHaxD
 RHgFnxUk/idg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="510437549"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2020 23:22:26 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux@roeck-us.net, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH v3 0/2] add Intel MAX 10 BMC MFD driver & hwmon sub driver
Date:   Mon, 21 Sep 2020 14:17:49 +0800
Message-Id: <1600669071-26235-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently realized that maintainers may have trouble to apply patches to
their trees if the patches depend on other being-reviewed patches. So I'm
trying to wrapper the 2 patches into one patchset and let all the
maintainers see the dependencies.

But the patch version is then not aligned between the 2 patches. I'm not
sure how to handle it. I just picked the smaller number on Subject, but
you could still see their own version changes in commit message of each
patch. Sorry if it makes confusing.


Patch #1 implements the basic functions of the BMC chip for some Intel
FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
Intel MAX 10 CPLD.

This BMC chip is connected to the FPGA by a SPI bus. To provide direct
register access from the FPGA, the "SPI slave to Avalon Master Bridge"
(spi-avmm) IP is integrated in the chip. It converts encoded streams of
bytes from the host to the internal register read/write on the Avalon
bus. So This driver uses the regmap-spi-avmm for register accessing.

Patch #2 adds support for the hwmon sub device in Intel MAX 10 BMC


Xu Yilun (2):
  mfd: intel-m10-bmc: add Intel MAX 10 BMC chip support for Intel FPGA
    PAC
  hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/intel-m10-bmc-hwmon.rst        |  78 +++++
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c                | 334 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/intel-m10-bmc.c                        | 164 ++++++++++
 include/linux/mfd/intel-m10-bmc.h                  |  65 ++++
 10 files changed, 684 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 Documentation/hwmon/intel-m10-bmc-hwmon.rst
 create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c
 create mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

-- 
2.7.4

