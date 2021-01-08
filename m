Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD02EFA80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbhAHV1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:27:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:1112 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbhAHV1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:27:49 -0500
IronPort-SDR: GoPp17UkMGb0VqS0OQUGQX/Iau3VMyjQkXRmWMF3/gSyWDa3jr3E1dfB0GAj0XTZm5sOa+9kc+
 1ld34qStRYiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="156842608"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="156842608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:03 -0800
IronPort-SDR: tQ9psplyzf4WcGvEwRDUO6Cu+1a5w0wvIQaDO8Rcl+PHGCliO23X6XixD9eko+T8A3UZfdxcGM
 rM7uvzUCmZ1w==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="497965274"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:02 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 3AAFA6363;
        Fri,  8 Jan 2021 13:26:03 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGk-0009bf-Sx; Fri, 08 Jan 2021 13:26:03 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/34] Intel Vision Processing base enabling
Date:   Fri,  8 Jan 2021 13:25:26 -0800
Message-Id: <20210108212600.36850-1-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Gross <mgross@linux.intel.com>

Second try, the first attempt failed to land on lore.

The Intel Vision Processing Unit (VPU) is an IP block that is showing up for
the first time as part of the Keem Bay SOC.  Keem Bay is a quad core A53 Arm
SOC.  It is designed to be used as a stand alone SOC as well as in an PCIe
Vision Processing accelerator add in card.

This is version 2 of the earlier patch set:
Subject: [PATCH 00/22] Intel Vision Processing Unit base enabling part 1
Date: Tue,  1 Dec 2020 14:34:49 -0800

It also include all the part 2 patches along with updates addressing feedback
from the earlier posting.
The most notable are:
* added a VPU mailbox IPC driver
* reworked the Keem Bay IPC driver to use that mailbox
* folding a refactoring of the xlink core patch into the xlink core set.
* Documentation updates
* corrected MAINTAINER file entries WRT sustained vrs maintained use.
* adds associated drivers:
	* tsens -- thermal managment
	* HDDL -- device manageme
	* Xlink SMBus
	* vpu manager -- user mode interface


Thanks for looking at these and providing feedback.

--mark

C, Udhayakumar (8):
  dt-bindings: misc: intel_tsens: Add tsens thermal bindings
    documentation
  misc: Tsens ARM host thermal driver.
  misc: Intel tsens IA host driver.
  Intel tsens i2c slave driver.
  misc:intel_tsens: Intel Keem Bay tsens driver.
  dt-bindings: misc: hddl_dev: Add hddl device management documentation
  misc: Hddl device management for local host
  misc: HDDL device management for IA host

Daniele Alessandrelli (4):
  dt-bindings: mailbox: Add Intel VPU IPC mailbox bindings
  mailbox: vpu-ipc-mailbox: Add support for Intel VPU IPC mailbox
  dt-bindings: Add bindings for Keem Bay IPC driver
  keembay-ipc: Add Keem Bay IPC module

Li, Tingqian (2):
  dt-bindings: misc: Add Keem Bay vpumgr
  misc: Add Keem Bay VPU manager

Paul Murphy (2):
  dt-bindings: Add bindings for Keem Bay VPU IPC driver
  keembay-vpu-ipc: Add Keem Bay VPU IPC module

Ramya P Karanth (1):
  Intel Keem Bay XLink SMBus driver

Seamus Kelly (7):
  xlink-ipc: Add xlink ipc device tree bindings
  xlink-ipc: Add xlink ipc driver
  xlink-core: Add xlink core device tree bindings
  xlink-core: Add xlink core driver xLink
  xlink-core: Enable xlink protocol over pcie
  xlink-core: Enable VPU IP management and runtime control
  xlink-core: add async channel and events

Srikanth Thokala (9):
  misc: xlink-pcie: Add documentation for XLink PCIe driver
  misc: xlink-pcie: lh: Add PCIe EPF driver for Local Host
  misc: xlink-pcie: lh: Add PCIe EP DMA functionality
  misc: xlink-pcie: lh: Add core communication logic
  misc: xlink-pcie: lh: Prepare changes for adding remote host driver
  misc: xlink-pcie: rh: Add PCIe EP driver for Remote Host
  misc: xlink-pcie: rh: Add core communication logic
  misc: xlink-pcie: Add XLink API interface
  misc: xlink-pcie: Add asynchronous event notification support for
    XLink

mark gross (1):
  Add Vision Processing Unit (VPU) documentation.

 .../mailbox/intel,vpu-ipc-mailbox.yaml        |   69 +
 .../bindings/misc/intel,hddl-client.yaml      |  114 +
 .../bindings/misc/intel,intel-tsens.yaml      |  122 +
 .../bindings/misc/intel,keembay-vpu-mgr.yaml  |   48 +
 .../misc/intel,keembay-xlink-ipc.yaml         |   49 +
 .../bindings/misc/intel,keembay-xlink.yaml    |   27 +
 .../bindings/soc/intel/intel,keembay-ipc.yaml |   45 +
 .../soc/intel/intel,keembay-vpu-ipc.yaml      |  153 ++
 Documentation/hwmon/index.rst                 |    2 +
 Documentation/hwmon/intel_tsens_host.rst      |   71 +
 Documentation/hwmon/intel_tsens_sensor.rst    |   67 +
 Documentation/i2c/busses/index.rst            |    1 +
 .../i2c/busses/intel-xlink-smbus.rst          |   71 +
 Documentation/index.rst                       |    1 +
 .../misc-devices/hddl_device_client.rst       |  212 ++
 .../misc-devices/hddl_device_server.rst       |  205 ++
 Documentation/misc-devices/index.rst          |    2 +
 Documentation/vpu/index.rst                   |   20 +
 Documentation/vpu/vpu-stack-overview.rst      |  270 +++
 Documentation/vpu/xlink-core.rst              |   81 +
 Documentation/vpu/xlink-ipc.rst               |   51 +
 Documentation/vpu/xlink-pcie.rst              |   90 +
 MAINTAINERS                                   |   54 +
 drivers/mailbox/Kconfig                       |   11 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/vpu-ipc-mailbox.c             |  297 +++
 drivers/misc/Kconfig                          |    7 +
 drivers/misc/Makefile                         |    7 +
 drivers/misc/hddl_device/Kconfig              |   26 +
 drivers/misc/hddl_device/Makefile             |    7 +
 drivers/misc/hddl_device/hddl_device.c        |  565 +++++
 drivers/misc/hddl_device/hddl_device_lh.c     |  764 +++++++
 drivers/misc/hddl_device/hddl_device_rh.c     |  837 +++++++
 drivers/misc/hddl_device/hddl_device_util.h   |   52 +
 drivers/misc/intel_tsens/Kconfig              |   54 +
 drivers/misc/intel_tsens/Makefile             |   10 +
 drivers/misc/intel_tsens/intel_tsens_host.c   |  351 +++
 drivers/misc/intel_tsens/intel_tsens_i2c.c    |  119 +
 .../misc/intel_tsens/intel_tsens_thermal.c    |  651 ++++++
 .../misc/intel_tsens/intel_tsens_thermal.h    |   38 +
 drivers/misc/intel_tsens/keembay_thermal.c    |  169 ++
 drivers/misc/intel_tsens/keembay_tsens.h      |  366 +++
 drivers/misc/vpumgr/Kconfig                   |    9 +
 drivers/misc/vpumgr/Makefile                  |    3 +
 drivers/misc/vpumgr/vpu_common.h              |   31 +
 drivers/misc/vpumgr/vpu_mgr.c                 |  370 +++
 drivers/misc/vpumgr/vpu_smm.c                 |  554 +++++
 drivers/misc/vpumgr/vpu_smm.h                 |   30 +
 drivers/misc/vpumgr/vpu_vcm.c                 |  585 +++++
 drivers/misc/vpumgr/vpu_vcm.h                 |   84 +
 drivers/misc/xlink-core/Kconfig               |   33 +
 drivers/misc/xlink-core/Makefile              |    5 +
 drivers/misc/xlink-core/xlink-core.c          | 1331 +++++++++++
 drivers/misc/xlink-core/xlink-core.h          |   25 +
 drivers/misc/xlink-core/xlink-defs.h          |  181 ++
 drivers/misc/xlink-core/xlink-dispatcher.c    |  436 ++++
 drivers/misc/xlink-core/xlink-dispatcher.h    |   26 +
 drivers/misc/xlink-core/xlink-ioctl.c         |  554 +++++
 drivers/misc/xlink-core/xlink-ioctl.h         |   36 +
 drivers/misc/xlink-core/xlink-multiplexer.c   | 1164 ++++++++++
 drivers/misc/xlink-core/xlink-multiplexer.h   |   35 +
 drivers/misc/xlink-core/xlink-platform.c      |  273 +++
 drivers/misc/xlink-core/xlink-platform.h      |   65 +
 drivers/misc/xlink-ipc/Kconfig                |    7 +
 drivers/misc/xlink-ipc/Makefile               |    4 +
 drivers/misc/xlink-ipc/xlink-ipc.c            |  878 +++++++
 drivers/misc/xlink-pcie/Kconfig               |   20 +
 drivers/misc/xlink-pcie/Makefile              |    2 +
 drivers/misc/xlink-pcie/common/core.h         |  247 ++
 drivers/misc/xlink-pcie/common/interface.c    |  126 +
 drivers/misc/xlink-pcie/common/util.c         |  375 +++
 drivers/misc/xlink-pcie/common/util.h         |   70 +
 drivers/misc/xlink-pcie/common/xpcie.h        |  102 +
 drivers/misc/xlink-pcie/local_host/Makefile   |    6 +
 drivers/misc/xlink-pcie/local_host/core.c     |  819 +++++++
 drivers/misc/xlink-pcie/local_host/dma.c      |  577 +++++
 drivers/misc/xlink-pcie/local_host/epf.c      |  522 +++++
 drivers/misc/xlink-pcie/local_host/epf.h      |  103 +
 drivers/misc/xlink-pcie/remote_host/Makefile  |    6 +
 drivers/misc/xlink-pcie/remote_host/core.c    |  623 +++++
 drivers/misc/xlink-pcie/remote_host/main.c    |   95 +
 drivers/misc/xlink-pcie/remote_host/pci.c     |  525 +++++
 drivers/misc/xlink-pcie/remote_host/pci.h     |   67 +
 drivers/misc/xlink-smbus/Kconfig              |   26 +
 drivers/misc/xlink-smbus/Makefile             |    5 +
 drivers/misc/xlink-smbus/xlink-smbus.c        |  467 ++++
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/intel/Kconfig                     |   33 +
 drivers/soc/intel/Makefile                    |    5 +
 drivers/soc/intel/keembay-ipc.c               | 1364 +++++++++++
 drivers/soc/intel/keembay-vpu-ipc.c           | 2036 +++++++++++++++++
 include/linux/hddl_device.h                   |  153 ++
 include/linux/intel_tsens_host.h              |   34 +
 include/linux/soc/intel/keembay-ipc.h         |   30 +
 include/linux/soc/intel/keembay-vpu-ipc.h     |   62 +
 include/linux/xlink-ipc.h                     |   48 +
 include/linux/xlink.h                         |  146 ++
 include/linux/xlink_drv_inf.h                 |   72 +
 include/uapi/misc/vpumgr.h                    |   64 +
 include/uapi/misc/xlink_uapi.h                |  145 ++
 101 files changed, 21854 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
 create mode 100644 Documentation/hwmon/intel_tsens_host.rst
 create mode 100644 Documentation/hwmon/intel_tsens_sensor.rst
 create mode 100644 Documentation/i2c/busses/intel-xlink-smbus.rst
 create mode 100644 Documentation/misc-devices/hddl_device_client.rst
 create mode 100644 Documentation/misc-devices/hddl_device_server.rst
 create mode 100644 Documentation/vpu/index.rst
 create mode 100644 Documentation/vpu/vpu-stack-overview.rst
 create mode 100644 Documentation/vpu/xlink-core.rst
 create mode 100644 Documentation/vpu/xlink-ipc.rst
 create mode 100644 Documentation/vpu/xlink-pcie.rst
 create mode 100644 drivers/mailbox/vpu-ipc-mailbox.c
 create mode 100644 drivers/misc/hddl_device/Kconfig
 create mode 100644 drivers/misc/hddl_device/Makefile
 create mode 100644 drivers/misc/hddl_device/hddl_device.c
 create mode 100644 drivers/misc/hddl_device/hddl_device_lh.c
 create mode 100644 drivers/misc/hddl_device/hddl_device_rh.c
 create mode 100644 drivers/misc/hddl_device/hddl_device_util.h
 create mode 100644 drivers/misc/intel_tsens/Kconfig
 create mode 100644 drivers/misc/intel_tsens/Makefile
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_host.c
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_i2c.c
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_thermal.c
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_thermal.h
 create mode 100644 drivers/misc/intel_tsens/keembay_thermal.c
 create mode 100644 drivers/misc/intel_tsens/keembay_tsens.h
 create mode 100644 drivers/misc/vpumgr/Kconfig
 create mode 100644 drivers/misc/vpumgr/Makefile
 create mode 100644 drivers/misc/vpumgr/vpu_common.h
 create mode 100644 drivers/misc/vpumgr/vpu_mgr.c
 create mode 100644 drivers/misc/vpumgr/vpu_smm.c
 create mode 100644 drivers/misc/vpumgr/vpu_smm.h
 create mode 100644 drivers/misc/vpumgr/vpu_vcm.c
 create mode 100644 drivers/misc/vpumgr/vpu_vcm.h
 create mode 100644 drivers/misc/xlink-core/Kconfig
 create mode 100644 drivers/misc/xlink-core/Makefile
 create mode 100644 drivers/misc/xlink-core/xlink-core.c
 create mode 100644 drivers/misc/xlink-core/xlink-core.h
 create mode 100644 drivers/misc/xlink-core/xlink-defs.h
 create mode 100644 drivers/misc/xlink-core/xlink-dispatcher.c
 create mode 100644 drivers/misc/xlink-core/xlink-dispatcher.h
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.c
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.h
 create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.c
 create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.h
 create mode 100644 drivers/misc/xlink-core/xlink-platform.c
 create mode 100644 drivers/misc/xlink-core/xlink-platform.h
 create mode 100644 drivers/misc/xlink-ipc/Kconfig
 create mode 100644 drivers/misc/xlink-ipc/Makefile
 create mode 100644 drivers/misc/xlink-ipc/xlink-ipc.c
 create mode 100644 drivers/misc/xlink-pcie/Kconfig
 create mode 100644 drivers/misc/xlink-pcie/Makefile
 create mode 100644 drivers/misc/xlink-pcie/common/core.h
 create mode 100644 drivers/misc/xlink-pcie/common/interface.c
 create mode 100644 drivers/misc/xlink-pcie/common/util.c
 create mode 100644 drivers/misc/xlink-pcie/common/util.h
 create mode 100644 drivers/misc/xlink-pcie/common/xpcie.h
 create mode 100644 drivers/misc/xlink-pcie/local_host/Makefile
 create mode 100644 drivers/misc/xlink-pcie/local_host/core.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/dma.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.h
 create mode 100644 drivers/misc/xlink-pcie/remote_host/Makefile
 create mode 100644 drivers/misc/xlink-pcie/remote_host/core.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/main.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/pci.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/pci.h
 create mode 100644 drivers/misc/xlink-smbus/Kconfig
 create mode 100644 drivers/misc/xlink-smbus/Makefile
 create mode 100644 drivers/misc/xlink-smbus/xlink-smbus.c
 create mode 100644 drivers/soc/intel/Kconfig
 create mode 100644 drivers/soc/intel/Makefile
 create mode 100644 drivers/soc/intel/keembay-ipc.c
 create mode 100644 drivers/soc/intel/keembay-vpu-ipc.c
 create mode 100644 include/linux/hddl_device.h
 create mode 100644 include/linux/intel_tsens_host.h
 create mode 100644 include/linux/soc/intel/keembay-ipc.h
 create mode 100644 include/linux/soc/intel/keembay-vpu-ipc.h
 create mode 100644 include/linux/xlink-ipc.h
 create mode 100644 include/linux/xlink.h
 create mode 100644 include/linux/xlink_drv_inf.h
 create mode 100644 include/uapi/misc/vpumgr.h
 create mode 100644 include/uapi/misc/xlink_uapi.h

-- 
2.17.1
