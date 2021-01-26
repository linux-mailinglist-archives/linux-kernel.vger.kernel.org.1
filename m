Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACE304DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbhAZXRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:17:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:50985 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388298AbhAZFmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:42:18 -0500
IronPort-SDR: V56N+ukb04cwajzqw0jCLL+Fj7zPerLhBDgeNK47NGpnhE5qsIfr3JNq3k9hwBY4KCMPbMGvy3
 d2DBJgV8Ev1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="167524673"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="167524673"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:40 -0800
IronPort-SDR: GAomlZNvFvEUuH9zg6nSmUFQW11iP8HgxU2OzyRRCiGXOLcIqoEJUO9MTWcPHzkqY25nzW5zL9
 Y7EHErurDV0g==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387693708"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:40 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 43F596365;
        Mon, 25 Jan 2021 21:40:40 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 23AD93609A3; Mon, 25 Jan 2021 21:40:40 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/34] Intel Vision Processing base enabling
Date:   Mon, 25 Jan 2021 21:40:02 -0800
Message-Id: <20210126054036.61587-1-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Gross <mgross@linux.intel.com>

The Intel Vision Processing Unit (VPU) is an IP block that is showing up for
the first time as part of the Keem Bay SOC.  Keem Bay is a quad core A53 Arm
SOC.  It is designed to be used as a stand alone SOC as well as in an PCIe
Vision Processing accelerator add in card.

This thrid version of this patch set includes updates to xling-pci some minor
updates to a Kconfig help text and global use of EXPORT_SYMBOL_GPL based on
review feedback.

At the bottom of this coverletter is the delta between v2 and V3 for easy
review of the modifications.  Feels like things are converging. :)

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
 drivers/misc/intel_tsens/Kconfig              |   55 +
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
 drivers/misc/vpumgr/vpu_vcm.c                 |  584 +++++
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
 drivers/misc/xlink-pcie/common/core.h         |  245 ++
 drivers/misc/xlink-pcie/common/interface.c    |  124 +
 drivers/misc/xlink-pcie/common/util.c         |  373 +++
 drivers/misc/xlink-pcie/common/util.h         |   68 +
 drivers/misc/xlink-pcie/common/xpcie.h        |  100 +
 drivers/misc/xlink-pcie/local_host/Makefile   |    6 +
 drivers/misc/xlink-pcie/local_host/core.c     |  817 +++++++
 drivers/misc/xlink-pcie/local_host/dma.c      |  575 +++++
 drivers/misc/xlink-pcie/local_host/epf.c      |  482 ++++
 drivers/misc/xlink-pcie/local_host/epf.h      |  101 +
 drivers/misc/xlink-pcie/remote_host/Makefile  |    6 +
 drivers/misc/xlink-pcie/remote_host/core.c    |  621 +++++
 drivers/misc/xlink-pcie/remote_host/main.c    |   93 +
 drivers/misc/xlink-pcie/remote_host/pci.c     |  523 +++++
 drivers/misc/xlink-pcie/remote_host/pci.h     |   65 +
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
 include/linux/xlink_drv_inf.h                 |   70 +
 include/uapi/misc/vpumgr.h                    |   64 +
 include/uapi/misc/xlink_uapi.h                |  145 ++
 101 files changed, 21788 insertions(+)
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

diff --git a/Documentation/vpu/xlink-core.rst b/Documentation/vpu/xlink-core.rst
index 1c471ec803d3..441c18230491 100644
--- a/Documentation/vpu/xlink-core.rst
+++ b/Documentation/vpu/xlink-core.rst
@@ -55,7 +55,7 @@ When a user wants to send data across an interface via xLink it firstly calls
 xlink connect which connects to the relevant interface (PCIe, USB, IPC, etc.)
 and then xlink open channel.
 
-Then it calls xlink write function, this takes the data, passes it to the
+Then it calls xlink write function. This takes the data, passes it to the
 kernel which packages up the data and channel and then adds it to a transmit
 queue.
 
@@ -70,7 +70,7 @@ any data it adds it to channel packet container.
 
 The application at this side of the interface will have called xlink connect,
 opened the channel and called xlink read function to read data from the
-interface and if any exists for that channel , the data gets popped from the
+interface and if any exists for that channel, the data gets popped from the
 channel packet container and copied from kernel space to user space buffer
 provided by the call.
 
diff --git a/Documentation/vpu/xlink-pcie.rst b/Documentation/vpu/xlink-pcie.rst
index 2d877c966b1e..85a70990e9c9 100644
--- a/Documentation/vpu/xlink-pcie.rst
+++ b/Documentation/vpu/xlink-pcie.rst
@@ -15,7 +15,7 @@ Introduction
 ============
 The Xlink-pcie driver provides transport layer implementation for
 the data transfers to support Xlink protocol subsystem communication with the
-peer device. i.e, between remote host system and Keem Bay device.
+peer device, i.e., between remote host system and Keem Bay device.
 
 The Keem Bay device is an ARM-based SOC that includes a vision processing
 unit (VPU) and deep learning, neural network core in the hardware.
@@ -65,8 +65,8 @@ XLink PCIe communication between local host and remote host is achieved through
 ring buffer management and MSI/Doorbell interrupts.
 
 The Xlink-pcie driver subsystem registers the Keem Bay device as an endpoint
-driver and provides standard linux PCIe sysfs interface, #
-/sys/bus/pci/devices/xxxx:xx:xx.0/
+driver and provides standard Linux PCIe sysfs interface:
+'/sys/bus/pci/devices/xxxx:xx:xx.0/'
 
 
 XLink protocol subsystem
diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
index bdd87518a1bc..bd575d99281d 100644
--- a/drivers/misc/intel_tsens/Kconfig
+++ b/drivers/misc/intel_tsens/Kconfig
@@ -20,12 +20,12 @@ config INTEL_TSENS_I2C_SLAVE
 	select I2C
 	select I2C_SLAVE
 	help
-	  This option enables tsens i2c slave driver.
+	  This option enables tsens I2C slave driver.
 
 	  This driver is used for reporting thermal data via I2C
 	  SMBUS to remote host.
 	  Enable this option if you want to have support for thermal
-	  management controller
+	  management controller.
 	  Say Y if using a processor that includes the Intel VPU such as
 	  Keem Bay.  If unsure, say N.
 
@@ -40,6 +40,7 @@ config KEEMBAY_THERMAL
 	  values from Keem Bay SoC.
 	  Say Y if using a processor that includes the Intel VPU such as
 	  Keem Bay.  If unsure, say N.
+
 config INTEL_TSENS_IA_HOST
 	tristate "Temperature sensor driver for intel tsens remote host"
 	depends on I2C && THERMAL
diff --git a/drivers/misc/intel_tsens/intel_tsens_thermal.c b/drivers/misc/intel_tsens/intel_tsens_thermal.c
index 83aec191555c..5a08e6f216f2 100644
--- a/drivers/misc/intel_tsens/intel_tsens_thermal.c
+++ b/drivers/misc/intel_tsens/intel_tsens_thermal.c
@@ -495,7 +495,7 @@ static int intel_tsens_config_dt(struct intel_tsens_priv *priv)
 
 		ts = devm_kzalloc(&pdev->dev, sizeof(struct intel_tsens),
 				  GFP_KERNEL);
-		if (!ts){
+		if (!ts) {
 			of_node_put(s_node);
 			return -ENOMEM;
 		}
diff --git a/drivers/misc/intel_tsens/keembay_tsens.h b/drivers/misc/intel_tsens/keembay_tsens.h
index 7a61c09de261..e9b927a31e22 100644
--- a/drivers/misc/intel_tsens/keembay_tsens.h
+++ b/drivers/misc/intel_tsens/keembay_tsens.h
@@ -61,7 +61,7 @@ enum keembay_thermal_sensor_en {
 
 #define KEEMBAY_SENSOR_BASE_TEMP 27
 
-static int const raw_kmb[] = {
+static const int raw_kmb[] = {
 39956,  -39637, -39319, -39001, -38684,
 
 38367,  -38050, -37734, -37418, -37103,
diff --git a/drivers/misc/vpumgr/vpu_vcm.c b/drivers/misc/vpumgr/vpu_vcm.c
index 03311dbd579a..44b9408d478e 100644
--- a/drivers/misc/vpumgr/vpu_vcm.c
+++ b/drivers/misc/vpumgr/vpu_vcm.c
@@ -361,8 +361,7 @@ int vcm_wait(struct vpumgr_ctx *v, s32 submit_id,
 	rc = wait_for_completion_interruptible_timeout(&vcmd->complete, timeout);
 	if (rc < 0) {
 		goto exit;
-	}
-	else if (rc == 0) {
+	} else if (rc == 0) {
 		rc = -ETIMEDOUT;
 		goto exit;
 	} else {
diff --git a/drivers/misc/xlink-core/xlink-core.c b/drivers/misc/xlink-core/xlink-core.c
index 8c1fd3f54afa..23c0025f6f0d 100644
--- a/drivers/misc/xlink-core/xlink-core.c
+++ b/drivers/misc/xlink-core/xlink-core.c
@@ -418,7 +418,7 @@ enum xlink_error xlink_stop_vpu(void)
 #endif
 	return X_LINK_SUCCESS;
 }
-EXPORT_SYMBOL(xlink_stop_vpu);
+EXPORT_SYMBOL_GPL(xlink_stop_vpu);
 enum xlink_error xlink_start_vpu(char *filename)
 {
 #ifdef CONFIG_XLINK_LOCAL_HOST
@@ -430,13 +430,13 @@ enum xlink_error xlink_start_vpu(char *filename)
 #endif
 	return X_LINK_SUCCESS;
 }
-EXPORT_SYMBOL(xlink_start_vpu);
+EXPORT_SYMBOL_GPL(xlink_start_vpu);
 
 enum xlink_error xlink_initialize(void)
 {
 	return X_LINK_SUCCESS;
 }
-EXPORT_SYMBOL(xlink_initialize);
+EXPORT_SYMBOL_GPL(xlink_initialize);
 
 enum xlink_error xlink_connect(struct xlink_handle *handle)
 {
@@ -500,7 +500,7 @@ enum xlink_error xlink_connect(struct xlink_handle *handle)
 	mutex_unlock(&xlink->lock);
 	return X_LINK_ERROR;
 }
-EXPORT_SYMBOL(xlink_connect);
+EXPORT_SYMBOL_GPL(xlink_connect);
 
 enum xlink_error xlink_data_available_event(struct xlink_handle *handle,
 					    u16 chan,
@@ -537,7 +537,7 @@ enum xlink_error xlink_data_available_event(struct xlink_handle *handle,
 		xlink_destroy_event(event);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_data_available_event);
+EXPORT_SYMBOL_GPL(xlink_data_available_event);
 enum xlink_error xlink_data_consumed_event(struct xlink_handle *handle,
 					   u16 chan,
 					   xlink_event data_consumed_event)
@@ -573,7 +573,7 @@ enum xlink_error xlink_data_consumed_event(struct xlink_handle *handle,
 		xlink_destroy_event(event);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_data_consumed_event);
+EXPORT_SYMBOL_GPL(xlink_data_consumed_event);
 enum xlink_error xlink_open_channel(struct xlink_handle *handle,
 				    u16 chan, enum xlink_opmode mode,
 				    u32 data_size, u32 timeout)
@@ -601,7 +601,7 @@ enum xlink_error xlink_open_channel(struct xlink_handle *handle,
 		xlink_destroy_event(event);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_open_channel);
+EXPORT_SYMBOL_GPL(xlink_open_channel);
 
 enum xlink_error xlink_close_channel(struct xlink_handle *handle,
 				     u16 chan)
@@ -629,7 +629,7 @@ enum xlink_error xlink_close_channel(struct xlink_handle *handle,
 
 	return rc;
 }
-EXPORT_SYMBOL(xlink_close_channel);
+EXPORT_SYMBOL_GPL(xlink_close_channel);
 
 static enum xlink_error do_xlink_write_data(struct xlink_handle *handle,
 					    u16 chan, u8 const *pmessage,
@@ -717,7 +717,7 @@ enum xlink_error xlink_write_data(struct xlink_handle *handle,
 	rc = do_xlink_write_data(handle, chan, pmessage, size, 0);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_write_data);
+EXPORT_SYMBOL_GPL(xlink_write_data);
 
 enum xlink_error xlink_write_data_user(struct xlink_handle *handle,
 				       u16 chan, u8 const *pmessage, u32 size)
@@ -754,7 +754,7 @@ enum xlink_error xlink_write_control_data(struct xlink_handle *handle,
 		xlink_destroy_event(event);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_write_control_data);
+EXPORT_SYMBOL_GPL(xlink_write_control_data);
 
 static enum xlink_error do_xlink_write_volatile(struct xlink_handle *handle,
 					 u16 chan, u8 const *message,
@@ -819,7 +819,7 @@ enum xlink_error xlink_write_volatile(struct xlink_handle *handle,
 	rc = do_xlink_write_volatile(handle, chan, message, size, 0);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_write_volatile);
+EXPORT_SYMBOL_GPL(xlink_write_volatile);
 
 enum xlink_error xlink_read_data(struct xlink_handle *handle,
 				 u16 chan, u8 **pmessage, u32 *size)
@@ -848,7 +848,7 @@ enum xlink_error xlink_read_data(struct xlink_handle *handle,
 		xlink_destroy_event(event);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_read_data);
+EXPORT_SYMBOL_GPL(xlink_read_data);
 
 enum xlink_error xlink_read_data_to_buffer(struct xlink_handle *handle,
 					   u16 chan, u8 *const message, u32 *size)
@@ -877,7 +877,7 @@ enum xlink_error xlink_read_data_to_buffer(struct xlink_handle *handle,
 		xlink_destroy_event(event);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_read_data_to_buffer);
+EXPORT_SYMBOL_GPL(xlink_read_data_to_buffer);
 
 enum xlink_error xlink_release_data(struct xlink_handle *handle,
 				    u16 chan, u8 * const data_addr)
@@ -905,7 +905,7 @@ enum xlink_error xlink_release_data(struct xlink_handle *handle,
 		xlink_destroy_event(event);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_release_data);
+EXPORT_SYMBOL_GPL(xlink_release_data);
 
 enum xlink_error xlink_disconnect(struct xlink_handle *handle)
 {
@@ -948,7 +948,7 @@ enum xlink_error xlink_disconnect(struct xlink_handle *handle)
 	}
 	return rc;
 }
-EXPORT_SYMBOL(xlink_disconnect);
+EXPORT_SYMBOL_GPL(xlink_disconnect);
 
 enum xlink_error xlink_get_device_list(u32 *sw_device_id_list,
 				       u32 *num_devices)
@@ -973,7 +973,7 @@ enum xlink_error xlink_get_device_list(u32 *sw_device_id_list,
 	}
 	return X_LINK_SUCCESS;
 }
-EXPORT_SYMBOL(xlink_get_device_list);
+EXPORT_SYMBOL_GPL(xlink_get_device_list);
 enum xlink_error xlink_get_device_name(struct xlink_handle *handle, char *name,
 				       size_t name_size)
 {
@@ -995,7 +995,7 @@ enum xlink_error xlink_get_device_name(struct xlink_handle *handle, char *name,
 		rc = X_LINK_SUCCESS;
 	return rc;
 }
-EXPORT_SYMBOL(xlink_get_device_name);
+EXPORT_SYMBOL_GPL(xlink_get_device_name);
 enum xlink_error xlink_get_device_status(struct xlink_handle *handle,
 					 u32 *device_status)
 {
@@ -1017,7 +1017,7 @@ enum xlink_error xlink_get_device_status(struct xlink_handle *handle,
 		rc = X_LINK_SUCCESS;
 	return rc;
 }
-EXPORT_SYMBOL(xlink_get_device_status);
+EXPORT_SYMBOL_GPL(xlink_get_device_status);
 enum xlink_error xlink_boot_device(struct xlink_handle *handle,
 				   const char *binary_name)
 {
@@ -1039,7 +1039,7 @@ enum xlink_error xlink_boot_device(struct xlink_handle *handle,
 		rc = X_LINK_SUCCESS;
 	return rc;
 }
-EXPORT_SYMBOL(xlink_boot_device);
+EXPORT_SYMBOL_GPL(xlink_boot_device);
 enum xlink_error xlink_reset_device(struct xlink_handle *handle)
 {
 	enum xlink_error rc;
@@ -1057,7 +1057,7 @@ enum xlink_error xlink_reset_device(struct xlink_handle *handle)
 		rc = X_LINK_SUCCESS;
 	return rc;
 }
-EXPORT_SYMBOL(xlink_reset_device);
+EXPORT_SYMBOL_GPL(xlink_reset_device);
 enum xlink_error xlink_set_device_mode(struct xlink_handle *handle,
 				       enum xlink_device_power_mode power_mode)
 {
@@ -1077,7 +1077,7 @@ enum xlink_error xlink_set_device_mode(struct xlink_handle *handle,
 		rc = X_LINK_SUCCESS;
 	return rc;
 }
-EXPORT_SYMBOL(xlink_set_device_mode);
+EXPORT_SYMBOL_GPL(xlink_set_device_mode);
 enum xlink_error xlink_get_device_mode(struct xlink_handle *handle,
 				       enum xlink_device_power_mode *power_mode)
 {
@@ -1097,7 +1097,7 @@ enum xlink_error xlink_get_device_mode(struct xlink_handle *handle,
 		rc = X_LINK_SUCCESS;
 	return rc;
 }
-EXPORT_SYMBOL(xlink_get_device_mode);
+EXPORT_SYMBOL_GPL(xlink_get_device_mode);
 
 static int xlink_device_event_handler(u32 sw_device_id, u32 event_type)
 {
@@ -1222,7 +1222,7 @@ enum xlink_error xlink_register_device_event(struct xlink_handle *handle,
 					    event_notif_fn, 0);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_register_device_event);
+EXPORT_SYMBOL_GPL(xlink_register_device_event);
 
 enum xlink_error xlink_unregister_device_event(struct xlink_handle *handle,
 					       u32 *event_list,
@@ -1269,7 +1269,7 @@ enum xlink_error xlink_unregister_device_event(struct xlink_handle *handle,
 	}
 	return X_LINK_SUCCESS;
 }
-EXPORT_SYMBOL(xlink_unregister_device_event);
+EXPORT_SYMBOL_GPL(xlink_unregister_device_event);
 
 /* Device tree driver match. */
 static const struct of_device_id kmb_xlink_of_match[] = {
diff --git a/drivers/misc/xlink-ipc/xlink-ipc.c b/drivers/misc/xlink-ipc/xlink-ipc.c
index c04b8f44f684..e98a5a4b66a2 100644
--- a/drivers/misc/xlink-ipc/xlink-ipc.c
+++ b/drivers/misc/xlink-ipc/xlink-ipc.c
@@ -426,7 +426,7 @@ int xlink_ipc_connect(u32 sw_device_id)
 
 	return 0;
 }
-EXPORT_SYMBOL(xlink_ipc_connect);
+EXPORT_SYMBOL_GPL(xlink_ipc_connect);
 
 /*
  * xlink_ipc_write() - platform write interface.
@@ -471,7 +471,7 @@ int xlink_ipc_write(u32 sw_device_id, void *data, size_t * const size,
 
 	return rc;
 }
-EXPORT_SYMBOL(xlink_ipc_write);
+EXPORT_SYMBOL_GPL(xlink_ipc_write);
 
 /*
  * xlink_ipc_read() - platform read interface.
@@ -513,7 +513,7 @@ int xlink_ipc_read(u32 sw_device_id, void *data, size_t * const size,
 	}
 	return rc;
 }
-EXPORT_SYMBOL(xlink_ipc_read);
+EXPORT_SYMBOL_GPL(xlink_ipc_read);
 
 /*
  * xlink_ipc_get_device_list() - platform get device list interface.
@@ -538,7 +538,7 @@ int xlink_ipc_get_device_list(u32 *sw_device_id_list, u32 *num_devices)
 	*num_devices = i;
 	return 0;
 }
-EXPORT_SYMBOL(xlink_ipc_get_device_list);
+EXPORT_SYMBOL_GPL(xlink_ipc_get_device_list);
 
 /*
  * xlink_ipc_get_device_name() - platform get device name interface.
@@ -566,7 +566,7 @@ int xlink_ipc_get_device_name(u32 sw_device_id, char *device_name,
 	strncpy(device_name, xlink_dev->device_name, size);
 	return 0;
 }
-EXPORT_SYMBOL(xlink_ipc_get_device_name);
+EXPORT_SYMBOL_GPL(xlink_ipc_get_device_name);
 
 /*
  * xlink_ipc_get_device_status() - platform get device status interface.
@@ -587,7 +587,7 @@ int xlink_ipc_get_device_status(u32 sw_device_id, u32 *device_status)
 	*device_status = intel_keembay_vpu_status(xlink_dev->vpu_dev);
 	return 0;
 }
-EXPORT_SYMBOL(xlink_ipc_get_device_status);
+EXPORT_SYMBOL_GPL(xlink_ipc_get_device_status);
 
 static void kernel_callback(struct device *dev, enum intel_keembay_vpu_event event)
 {
@@ -619,7 +619,7 @@ int xlink_ipc_register_for_events(u32 sw_device_id,
 	rc = intel_keembay_vpu_register_for_events(xlink_dev->vpu_dev, kernel_callback);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_ipc_register_for_events);
+EXPORT_SYMBOL_GPL(xlink_ipc_register_for_events);
 /*
  * xlink_ipc_unregister_for_events() - platform register for events
  *
@@ -636,7 +636,7 @@ int xlink_ipc_unregister_for_events(u32 sw_device_id)
 	rc = intel_keembay_vpu_unregister_for_events(xlink_dev->vpu_dev);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_ipc_unregister_for_events);
+EXPORT_SYMBOL_GPL(xlink_ipc_unregister_for_events);
 
 /*
  * xlink_ipc_boot_device() - platform boot device interface.
@@ -683,7 +683,7 @@ int xlink_ipc_boot_device(u32 sw_device_id, const char *binary_name)
 	pr_info("VPU was ready.\n");
 	return 0;
 }
-EXPORT_SYMBOL(xlink_ipc_boot_device);
+EXPORT_SYMBOL_GPL(xlink_ipc_boot_device);
 
 /*
  * xlink_ipc_reset_device() - platform reset device interface.
@@ -717,7 +717,7 @@ int xlink_ipc_reset_device(u32 sw_device_id)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(xlink_ipc_reset_device);
+EXPORT_SYMBOL_GPL(xlink_ipc_reset_device);
 
 /*
  * xlink_ipc_open_channel() - platform open channel interface.
@@ -738,7 +738,7 @@ int xlink_ipc_open_channel(u32 sw_device_id, u32 channel)
 						KMB_VPU_IPC_NODE_LEON_MSS, channel);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_ipc_open_channel);
+EXPORT_SYMBOL_GPL(xlink_ipc_open_channel);
 
 /*
  * xlink_ipc_close_channel() - platform close channel interface.
@@ -759,7 +759,7 @@ int xlink_ipc_close_channel(u32 sw_device_id, u32 channel)
 						 KMB_VPU_IPC_NODE_LEON_MSS, channel);
 	return rc;
 }
-EXPORT_SYMBOL(xlink_ipc_close_channel);
+EXPORT_SYMBOL_GPL(xlink_ipc_close_channel);
 
 /*
  * xlink ipc driver functions
diff --git a/drivers/misc/xlink-pcie/common/core.h b/drivers/misc/xlink-pcie/common/core.h
index 34b6c268aac5..87b302f87cfd 100644
--- a/drivers/misc/xlink-pcie/common/core.h
+++ b/drivers/misc/xlink-pcie/common/core.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_CORE_HEADER_
 #define XPCIE_CORE_HEADER_
diff --git a/drivers/misc/xlink-pcie/common/interface.c b/drivers/misc/xlink-pcie/common/interface.c
index 4ad291ff97c8..5d30c27dd18d 100644
--- a/drivers/misc/xlink-pcie/common/interface.c
+++ b/drivers/misc/xlink-pcie/common/interface.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include <linux/xlink_drv_inf.h>
 
@@ -22,7 +20,7 @@ int xlink_pcie_get_device_list(u32 *sw_device_id_list, u32 *num_devices)
 
 	return 0;
 }
-EXPORT_SYMBOL(xlink_pcie_get_device_list);
+EXPORT_SYMBOL_GPL(xlink_pcie_get_device_list);
 
 int xlink_pcie_get_device_name(u32 sw_device_id, char *device_name,
 			       size_t name_size)
@@ -33,7 +31,7 @@ int xlink_pcie_get_device_name(u32 sw_device_id, char *device_name,
 	return intel_xpcie_get_device_name_by_id(sw_device_id,
 						 device_name, name_size);
 }
-EXPORT_SYMBOL(xlink_pcie_get_device_name);
+EXPORT_SYMBOL_GPL(xlink_pcie_get_device_name);
 
 int xlink_pcie_get_device_status(u32 sw_device_id, u32 *device_status)
 {
@@ -68,19 +66,19 @@ int xlink_pcie_get_device_status(u32 sw_device_id, u32 *device_status)
 
 	return 0;
 }
-EXPORT_SYMBOL(xlink_pcie_get_device_status);
+EXPORT_SYMBOL_GPL(xlink_pcie_get_device_status);
 
 int xlink_pcie_boot_device(u32 sw_device_id, const char *binary_name)
 {
 	return 0;
 }
-EXPORT_SYMBOL(xlink_pcie_boot_device);
+EXPORT_SYMBOL_GPL(xlink_pcie_boot_device);
 
 int xlink_pcie_connect(u32 sw_device_id)
 {
 	return intel_xpcie_pci_connect_device(sw_device_id);
 }
-EXPORT_SYMBOL(xlink_pcie_connect);
+EXPORT_SYMBOL_GPL(xlink_pcie_connect);
 
 int xlink_pcie_read(u32 sw_device_id, void *data, size_t *const size,
 		    u32 timeout)
@@ -90,7 +88,7 @@ int xlink_pcie_read(u32 sw_device_id, void *data, size_t *const size,
 
 	return intel_xpcie_pci_read(sw_device_id, data, size, timeout);
 }
-EXPORT_SYMBOL(xlink_pcie_read);
+EXPORT_SYMBOL_GPL(xlink_pcie_read);
 
 int xlink_pcie_write(u32 sw_device_id, void *data, size_t *const size,
 		     u32 timeout)
@@ -100,13 +98,13 @@ int xlink_pcie_write(u32 sw_device_id, void *data, size_t *const size,
 
 	return intel_xpcie_pci_write(sw_device_id, data, size, timeout);
 }
-EXPORT_SYMBOL(xlink_pcie_write);
+EXPORT_SYMBOL_GPL(xlink_pcie_write);
 
 int xlink_pcie_reset_device(u32 sw_device_id)
 {
 	return intel_xpcie_pci_reset_device(sw_device_id);
 }
-EXPORT_SYMBOL(xlink_pcie_reset_device);
+EXPORT_SYMBOL_GPL(xlink_pcie_reset_device);
 
 int xlink_pcie_register_device_event(u32 sw_device_id,
 				     xlink_device_event event_notif_fn)
@@ -117,10 +115,10 @@ int xlink_pcie_register_device_event(u32 sw_device_id,
 	return intel_xpcie_pci_register_device_event(sw_device_id,
 						     event_notif_fn);
 }
-EXPORT_SYMBOL(xlink_pcie_register_device_event);
+EXPORT_SYMBOL_GPL(xlink_pcie_register_device_event);
 
 int xlink_pcie_unregister_device_event(u32 sw_device_id)
 {
 	return intel_xpcie_pci_unregister_device_event(sw_device_id);
 }
-EXPORT_SYMBOL(xlink_pcie_unregister_device_event);
+EXPORT_SYMBOL_GPL(xlink_pcie_unregister_device_event);
diff --git a/drivers/misc/xlink-pcie/common/util.c b/drivers/misc/xlink-pcie/common/util.c
index ec808b0cd72b..d99125f61ba0 100644
--- a/drivers/misc/xlink-pcie/common/util.c
+++ b/drivers/misc/xlink-pcie/common/util.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include "util.h"
 
diff --git a/drivers/misc/xlink-pcie/common/util.h b/drivers/misc/xlink-pcie/common/util.h
index 908be897a61d..5295783b0437 100644
--- a/drivers/misc/xlink-pcie/common/util.h
+++ b/drivers/misc/xlink-pcie/common/util.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_UTIL_HEADER_
 #define XPCIE_UTIL_HEADER_
diff --git a/drivers/misc/xlink-pcie/common/xpcie.h b/drivers/misc/xlink-pcie/common/xpcie.h
index d6e06f91ad91..b5cf9242a59a 100644
--- a/drivers/misc/xlink-pcie/common/xpcie.h
+++ b/drivers/misc/xlink-pcie/common/xpcie.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_HEADER_
 #define XPCIE_HEADER_
diff --git a/drivers/misc/xlink-pcie/local_host/core.c b/drivers/misc/xlink-pcie/local_host/core.c
index a343e30d8b45..bfb14c18c24c 100644
--- a/drivers/misc/xlink-pcie/local_host/core.c
+++ b/drivers/misc/xlink-pcie/local_host/core.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include <linux/of_reserved_mem.h>
 
diff --git a/drivers/misc/xlink-pcie/local_host/dma.c b/drivers/misc/xlink-pcie/local_host/dma.c
index 811e5eebb7ab..42978fb0db49 100644
--- a/drivers/misc/xlink-pcie/local_host/dma.c
+++ b/drivers/misc/xlink-pcie/local_host/dma.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/wait.h>
diff --git a/drivers/misc/xlink-pcie/local_host/epf.c b/drivers/misc/xlink-pcie/local_host/epf.c
index b3112ca47bad..7fceed9d2a4f 100644
--- a/drivers/misc/xlink-pcie/local_host/epf.c
+++ b/drivers/misc/xlink-pcie/local_host/epf.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -128,31 +126,13 @@ static irqreturn_t intel_xpcie_host_interrupt(int irq, void *args)
 	return IRQ_HANDLED;
 }
 
-static int intel_xpcie_check_bar(struct pci_epf *epf,
-				 struct pci_epf_bar *epf_bar,
-				 enum pci_barno barno,
-				 size_t size, u8 reserved_bar)
-{
-	if (reserved_bar & (1 << barno)) {
-		dev_err(&epf->dev, "BAR%d is already reserved\n", barno);
-		return -EFAULT;
-	}
-
-	if (epf_bar->size != 0 && epf_bar->size < size) {
-		dev_err(&epf->dev, "BAR%d fixed size is not enough\n", barno);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int intel_xpcie_configure_bar(struct pci_epf *epf,
-				     const struct pci_epc_features
-					*epc_features)
+static void
+intel_xpcie_configure_bar(struct pci_epf *epf,
+			  const struct pci_epc_features *epc_features)
 {
 	struct pci_epf_bar *epf_bar;
 	bool bar_fixed_64bit;
-	int ret, i;
+	int i;
 
 	for (i = BAR_0; i <= BAR_5; i++) {
 		epf_bar = &epf->bar[i];
@@ -161,25 +141,7 @@ static int intel_xpcie_configure_bar(struct pci_epf *epf,
 			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
 		if (epc_features->bar_fixed_size[i])
 			epf_bar->size = epc_features->bar_fixed_size[i];
-
-		if (i == BAR_2) {
-			ret = intel_xpcie_check_bar(epf, epf_bar, BAR_2,
-						    BAR2_MIN_SIZE,
-						    epc_features->reserved_bar);
-			if (ret)
-				return ret;
-		}
-
-		if (i == BAR_4) {
-			ret = intel_xpcie_check_bar(epf, epf_bar, BAR_4,
-						    BAR4_MIN_SIZE,
-						    epc_features->reserved_bar);
-			if (ret)
-				return ret;
-		}
 	}
-
-	return 0;
 }
 
 static void intel_xpcie_cleanup_bar(struct pci_epf *epf, enum pci_barno barno)
@@ -341,9 +303,7 @@ static int intel_xpcie_epf_bind(struct pci_epf *epf)
 	xpcie_epf->epc_features = features;
 	if (features) {
 		align = features->align;
-		ret = intel_xpcie_configure_bar(epf, features);
-		if (ret)
-			return ret;
+		intel_xpcie_configure_bar(epf, features);
 	}
 
 	ret = intel_xpcie_setup_bars(epf, align);
diff --git a/drivers/misc/xlink-pcie/local_host/epf.h b/drivers/misc/xlink-pcie/local_host/epf.h
index ad79416476d5..40bf4ff36580 100644
--- a/drivers/misc/xlink-pcie/local_host/epf.h
+++ b/drivers/misc/xlink-pcie/local_host/epf.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_EPF_HEADER_
 #define XPCIE_EPF_HEADER_
diff --git a/drivers/misc/xlink-pcie/remote_host/core.c b/drivers/misc/xlink-pcie/remote_host/core.c
index 2e20e1490076..3be0492aa57c 100644
--- a/drivers/misc/xlink-pcie/remote_host/core.c
+++ b/drivers/misc/xlink-pcie/remote_host/core.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include "pci.h"
 
diff --git a/drivers/misc/xlink-pcie/remote_host/main.c b/drivers/misc/xlink-pcie/remote_host/main.c
index fd31ee3c153b..efc9143a2fac 100644
--- a/drivers/misc/xlink-pcie/remote_host/main.c
+++ b/drivers/misc/xlink-pcie/remote_host/main.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include "pci.h"
 #include "../common/core.h"
diff --git a/drivers/misc/xlink-pcie/remote_host/pci.c b/drivers/misc/xlink-pcie/remote_host/pci.c
index 0046bff5f604..6a79782b983e 100644
--- a/drivers/misc/xlink-pcie/remote_host/pci.c
+++ b/drivers/misc/xlink-pcie/remote_host/pci.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include <linux/mutex.h>
 #include <linux/pci.h>
diff --git a/drivers/misc/xlink-pcie/remote_host/pci.h b/drivers/misc/xlink-pcie/remote_host/pci.h
index a05dedf36a12..b082bfb73e4f 100644
--- a/drivers/misc/xlink-pcie/remote_host/pci.h
+++ b/drivers/misc/xlink-pcie/remote_host/pci.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_PCI_HEADER_
 #define XPCIE_PCI_HEADER_
diff --git a/drivers/soc/intel/keembay-ipc.c b/drivers/soc/intel/keembay-ipc.c
index 70a8d8b1f9a8..f097e92b1a99 100644
--- a/drivers/soc/intel/keembay-ipc.c
+++ b/drivers/soc/intel/keembay-ipc.c
@@ -1161,7 +1161,7 @@ int intel_keembay_ipc_open_channel(struct device *dev, u8 node_id, u16 chan_id)
 
 	return 0;
 }
-EXPORT_SYMBOL(intel_keembay_ipc_open_channel);
+EXPORT_SYMBOL_GPL(intel_keembay_ipc_open_channel);
 
 /**
  * intel_keembay_ipc_close_channel() - Close an IPC channel.
@@ -1192,7 +1192,7 @@ int intel_keembay_ipc_close_channel(struct device *dev, u8 node_id, u16 chan_id)
 
 	return 0;
 }
-EXPORT_SYMBOL(intel_keembay_ipc_close_channel);
+EXPORT_SYMBOL_GPL(intel_keembay_ipc_close_channel);
 
 /**
  * intel_keembay_ipc_send() - Send data via IPC.
@@ -1242,7 +1242,7 @@ int intel_keembay_ipc_send(struct device *dev, u8 node_id, u16 chan_id,
 	srcu_read_unlock(&link->srcu_sp[chan_id], idx);
 	return rc;
 }
-EXPORT_SYMBOL(intel_keembay_ipc_send);
+EXPORT_SYMBOL_GPL(intel_keembay_ipc_send);
 
 /**
  * intel_keembay_ipc_recv() - Read data via IPC
@@ -1356,7 +1356,7 @@ int intel_keembay_ipc_recv(struct device *dev, u8 node_id, u16 chan_id,
 	srcu_read_unlock(&link->srcu_sp[chan_id], idx);
 	return rc;
 }
-EXPORT_SYMBOL(intel_keembay_ipc_recv);
+EXPORT_SYMBOL_GPL(intel_keembay_ipc_recv);
 
 MODULE_DESCRIPTION("Keem Bay IPC Driver");
 MODULE_AUTHOR("Daniele Alessandrelli <daniele.alessandrelli@intel.com>");
diff --git a/drivers/soc/intel/keembay-vpu-ipc.c b/drivers/soc/intel/keembay-vpu-ipc.c
index bcf9bb4a225a..31b880195cac 100644
--- a/drivers/soc/intel/keembay-vpu-ipc.c
+++ b/drivers/soc/intel/keembay-vpu-ipc.c
@@ -1463,7 +1463,7 @@ int intel_keembay_vpu_ipc_open_channel(struct device *dev, u8 node_id,
 	return intel_keembay_ipc_open_channel(vpu_dev->ipc_dev, node_id,
 					      chan_id);
 }
-EXPORT_SYMBOL(intel_keembay_vpu_ipc_open_channel);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_ipc_open_channel);
 
 /**
  * intel_keembay_vpu_ipc_close_channel() - Close an IPC channel.
@@ -1487,7 +1487,7 @@ int intel_keembay_vpu_ipc_close_channel(struct device *dev, u8 node_id,
 	return intel_keembay_ipc_close_channel(vpu_dev->ipc_dev,
 					       node_id, chan_id);
 }
-EXPORT_SYMBOL(intel_keembay_vpu_ipc_close_channel);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_ipc_close_channel);
 
 /**
  * intel_keembay_vpu_ipc_send() - Send data via IPC.
@@ -1512,7 +1512,7 @@ int intel_keembay_vpu_ipc_send(struct device *dev, u8 node_id, u16 chan_id,
 	return intel_keembay_ipc_send(vpu_dev->ipc_dev, node_id, chan_id,
 				      vpu_addr, size);
 }
-EXPORT_SYMBOL(intel_keembay_vpu_ipc_send);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_ipc_send);
 
 /**
  * intel_keembay_vpu_ipc_recv() - Read data via IPC
@@ -1540,7 +1540,7 @@ int intel_keembay_vpu_ipc_recv(struct device *dev, u8 node_id, u16 chan_id,
 	return intel_keembay_ipc_recv(vpu_dev->ipc_dev, node_id, chan_id,
 				      vpu_addr, size, timeout);
 }
-EXPORT_SYMBOL(intel_keembay_vpu_ipc_recv);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_ipc_recv);
 
 /**
  * intel_keembay_vpu_startup() - Boot the VPU
@@ -1582,7 +1582,7 @@ int intel_keembay_vpu_startup(struct device *dev, const char *firmware_name)
 
 	return do_boot_sequence(vpu_dev);
 }
-EXPORT_SYMBOL(intel_keembay_vpu_startup);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_startup);
 
 /**
  * intel_keembay_vpu_reset() - Reset the VPU
@@ -1610,7 +1610,7 @@ int intel_keembay_vpu_reset(struct device *dev)
 
 	return do_boot_sequence(vpu_dev);
 }
-EXPORT_SYMBOL(intel_keembay_vpu_reset);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_reset);
 
 /**
  * intel_keembay_vpu_stop() - Stop the VPU
@@ -1659,7 +1659,7 @@ int intel_keembay_vpu_stop(struct device *dev)
 
 	return rc;
 }
-EXPORT_SYMBOL(intel_keembay_vpu_stop);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_stop);
 
 /**
  * intel_keembay_vpu_status() - Get the VPU state.
@@ -1678,7 +1678,7 @@ enum intel_keembay_vpu_state intel_keembay_vpu_status(struct device *dev)
 
 	return vpu_dev->state;
 }
-EXPORT_SYMBOL(intel_keembay_vpu_status);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_status);
 
 /**
  * intel_keembay_vpu_get_wdt_count() - Get the WDT count
@@ -1709,7 +1709,7 @@ int intel_keembay_vpu_get_wdt_count(struct device *dev,
 	}
 	return rc;
 }
-EXPORT_SYMBOL(intel_keembay_vpu_get_wdt_count);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_get_wdt_count);
 
 /**
  * intel_keembay_vpu_wait_for_ready() - Sleep until VPU is READY
@@ -1754,7 +1754,7 @@ int intel_keembay_vpu_wait_for_ready(struct device *dev, u32 timeout)
 
 	return rc;
 }
-EXPORT_SYMBOL(intel_keembay_vpu_wait_for_ready);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_wait_for_ready);
 
 /**
  * intel_keembay_vpu_register_for_events() - Register callback for event notification
@@ -1784,7 +1784,7 @@ int intel_keembay_vpu_register_for_events(struct device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(intel_keembay_vpu_register_for_events);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_register_for_events);
 
 /**
  * intel_keembay_vpu_unregister_for_events() - Unregister callback for event notification
@@ -1803,7 +1803,7 @@ int intel_keembay_vpu_unregister_for_events(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(intel_keembay_vpu_unregister_for_events);
+EXPORT_SYMBOL_GPL(intel_keembay_vpu_unregister_for_events);
 
 /* Probe() function for the VPU IPC platform driver. */
 static int keembay_vpu_ipc_probe(struct platform_device *pdev)
diff --git a/include/linux/xlink_drv_inf.h b/include/linux/xlink_drv_inf.h
index 5ca0ae1ae2e3..f20f69bd879a 100644
--- a/include/linux/xlink_drv_inf.h
+++ b/include/linux/xlink_drv_inf.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef _XLINK_DRV_INF_H_
 #define _XLINK_DRV_INF_H_
