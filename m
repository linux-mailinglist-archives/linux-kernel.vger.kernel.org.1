Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F29C2CB038
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgLAWhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:37:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:46123 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgLAWg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:36:57 -0500
IronPort-SDR: xrWcR1Oqg/J1Fos49dWvhgwl5k7kJppPipYFH7JEqWYo+rY0TV4U249XVIhhQfGAuW0U7PgUeu
 shWNhVcdIQJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="237047790"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="237047790"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:15 -0800
IronPort-SDR: LJMfG6KhKFYswvp4JOoAJiMJ0iJKnXGBvb7JQ/xIzdtjbQUSimkyfXboTDmVLtoh94BRVdD/HX
 WxbEBi2I0DGg==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="367729869"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:14 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 39BF4636B;
        Tue,  1 Dec 2020 14:35:14 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kkEEs-000H4I-2i; Tue, 01 Dec 2020 14:35:14 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/22] Add Vision Processing Unit (VPU) documentation.
Date:   Tue,  1 Dec 2020 14:34:50 -0800
Message-Id: <20201201223511.65542-2-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201223511.65542-1-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mark gross <mgross@linux.intel.com>

The Intel VPU needs a complicated SW stack to make it work.  Add a
directory to hold VPU related documentation including an architectural
overview of the SW stack that the patches implement.

Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 Documentation/index.rst                  |   3 +-
 Documentation/vpu/index.rst              |  16 ++
 Documentation/vpu/vpu-stack-overview.rst | 267 +++++++++++++++++++++++
 3 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/vpu/index.rst
 create mode 100644 Documentation/vpu/vpu-stack-overview.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 57719744774c..0a2cc0204e8f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0-only
 
 
 .. The Linux Kernel documentation master file, created by
@@ -137,6 +137,7 @@ needed).
    misc-devices/index
    scheduler/index
    mhi/index
+   vpu/index
 
 Architecture-agnostic documentation
 -----------------------------------
diff --git a/Documentation/vpu/index.rst b/Documentation/vpu/index.rst
new file mode 100644
index 000000000000..7e290e048910
--- /dev/null
+++ b/Documentation/vpu/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+============================================
+Vision Processor Unit Documentation
+============================================
+
+This documentation contains information for the Intel VPU stack.
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   vpu-stack-overview
diff --git a/Documentation/vpu/vpu-stack-overview.rst b/Documentation/vpu/vpu-stack-overview.rst
new file mode 100644
index 000000000000..53c06a7d9a52
--- /dev/null
+++ b/Documentation/vpu/vpu-stack-overview.rst
@@ -0,0 +1,267 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+======================
+Intel VPU architecture
+======================
+
+Overview
+========
+
+The Intel Movidius acquisition has developed a Vision Processing Unit (VPU)
+roadmap of products starting with Keem Bay (KMB).  The HW configurations the
+VPU can support include:
+
+1. Standalone smart camera that does local CV processing in camera
+2. Standalone appliance or SBC device connected to a network and tethered
+   cameras doing local CV processing
+3. Embedded in a USB dongle or M.2 as an CV accelerator.
+4. Multiple VPU enabled SOC's on a PCIE card as a CV accelerator in a larger IA
+   box or server.
+
+Keem Bay is the first instance of this family of products. This document
+provides an architectural overview of the SW stack supporting the VPU enabled
+products.
+
+Keem Bay (KMB) is a Computer Vision AI processing SoC based on ARM A53 CPU that
+provides Edge neural network acceleration (inference) and includes a Vision
+Processing Unit (VPU) hardware.  The ARM CPU SubSystem (CPUSS) interfaces
+locally to the VPU and enables integration/interfacing with a remote host over
+PCIe or USB or Ethernet interfaces. The interface between the CPUSS and the VPU
+is implemented with HW FIFOs (Control) and coherent memory mapping (Data) such
+that zero copy processing can happen within the VPU.
+
+The KMB can be used in all 4 of the above classes of designs.
+
+We refer to the 'local host' as being the ARM part of the SoC, while the
+'remote host' as the IA system hosting the KMB device(s).  The KMB SoC boots
+from an eMMC via uBoot and ARM Linux compatible device tree interface with an
+expectation to fully boot within hundreds of milliseconds.  There is also
+support for downloading the kernel and root file system image from a remote
+host.
+
+The eMMC can be updated with standard mender update process.
+See https://github.com/mendersoftware/mender
+
+The VPU is started and controlled from the A53 local host.  Its firmware image
+is loaded using the drive FW helper KAPI's.
+
+The VPU IP FW payload consists of a SPARC ISA RTEMS bootloader and/or
+application binary.
+
+The interface allowing (remote or local) host clients  to access VPU IP
+capabilities is realized through an abstracted programming model, which
+provides Remote Proxy APIs for a host CPU application to dynamically create and
+execute CV and NN workloads on the VPU. All frameworks exposed through
+programming model’s APIs are contained in the pre-compiled standard firmware
+image.
+
+There is a significant SW stack built up to support KMB and the use cases.  The
+rest of this documentation provides an overview of the components of the stack.
+
+Keem Bay IPC
+============
+
+Directly interfaces with the KMB HW FIFOs to provide zero copy processing from
+the VPU.  It implements the lowest level protocol for interacting with the VPU.
+
+The Keem Bay IPC mechanism is based on shared memory and hardware FIFOs,
+specifically there are:
+
+* Two 128-entry HW FIFOs, one for the CPU and one for the VPU.
+* Two shared memory regions, used as memory pool for allocating IPC buffers
+
+An IPC channel is a software abstraction allowing communication multiplexing,
+so that multiple applications / users can concurrently communicated to the VPU.
+IPC channels area conceptually similar to socket ports.
+
+There is a total of 1024 channels, each one identified by a channel ID, ranging
+from 0 to 1023.
+
+Channels are divided in two categories:
+
+* High-Speed (HS) channels, having IDs in the 0-9 range.
+* General-Purpose (GP) channels, having IDs in the 10-1023 range.
+
+HS channels have higher priority over GP channels and can be used by
+applications requiring higher throughput or lower latency.
+
+Since all the channels share the same HW resources (i.e., the HW FIFOs and the
+IPC memory pools), the Keem Bay IPC driver uses software queues to give a
+higher priority to HS channels.
+
+The driver supports a build-time configurable number of communication channels
+defined in a so called Channel Mapping Table.
+
+An IPC channel is full duplex: a pending operation from a certain channel does
+not block other operations on the same channel, regardless of their operation
+mode (blocking or non-blocking).
+
+Operation mode is individually selectable for each channel, per operation
+direction (read or write). All operations for that direction comply to
+selection.
+
+
+Keem Bay-VPU-IPC
+================
+
+This is the MMIO driver of the VPU IP block inside the SOC. It is a control
+driver mapping IPC channel communication to Xlink virtual channels.
+
+This driver provides the following functionality to other drivers in the
+communication stack:
+
+* VPU IP execution control (firmware load, start, reset)
+* VPU IP event notifications (device connected, device disconnected, WDT event)
+* VPU IP device status query (OFF, BUSY, READY, ERROR, RECOVERY)
+* Communication via the IPC protocol (wrapping the Keem Bay IPC driver and
+  exposing it to higher level Xlink layer)
+
+In addition to the above, the driver exposes SoC information (like stepping,
+device ID, etc.) to user-space via sysfs.
+
+This driver depends on the 'Keem Bay IPC' driver, which enables the Keem Bay
+IPC communication protocol.
+
+The driver uses the Firmware API to load the VPU firmware from user-space.
+
+Xlink-IPC
+=========
+This component is implementing the IPC specific Xlink protocol. It maps channel
+IDs to HW FIFO entries, using the Keem Bay VPU IPC driver.
+
+Some of the main functions this driver provides:
+
+* establishing a connection with an IPC device
+* obtaining a list with the available devices
+* obtaining the status for a device
+* booting a device
+* resetting a device
+* opening and closing channels
+* issuing read and write operations
+
+Xlink-core
+==========
+
+This component implements an abstracted set of control and communication APIs
+based on channel identification. It is intended to support VPU technology both
+at SoC level as well as at IP level, over multiple interfaces.
+
+It provides symmetrical services, where the producer and the consumer have
+the same privileges.
+
+Xlink driver has the ability to abstract several types of communication
+channels underneath, allowing the usage of different interfaces with the same
+function calls.
+
+Xlink services are available to both kernel and user space clients and include:
+
+* interface abstract control and communication API
+* multi device support
+* concurrent communication across 4096 communication channels (from 0 to
+  0xFFF), with customizable properties
+* full duplex channels with multiprocess and multithread support
+* channel IDs can be mapped to desired physical interface (PCIE, USB, ETH, IPC)
+  via a Channel Mapping Table
+* asynchronous fast pass through mode: remote host data packets are directly
+  dispatched using interrupt systems running on local host to IPC calls for low
+  overhead
+* channel handshaking mechanism for peer to peer communication, without the
+  need of static channel preallocation
+* channel resource management
+* asynchronous data and device notifications to subscribers
+
+Xlink transports: PCIe, USB, ETH, IPCXLink-PCIe
+
+XLink-PCIE
+==========
+This is an endpoint driver that is mapping Xlink channel IDs to PCIE channels.
+
+This component ensures (remote)host-to-(local)host communication, and VPU IP
+communication via an asynchronous pass through mode, where PCIE data loads are
+directly dispatched to Xlink-IPC.
+
+The component builds and advertises Device IDs that can are used by local host
+application in case of multi device scenarios.
+
+XLink-USB
+==========
+This is an endpoint driver that is mapping Xlink channel IDs to bidirectional
+USB endpoints and supports CDC USB class protocol. More than one Xlink channels
+can be mapped to a single USB endpoint.
+
+This component ensures host-to-host communication, and, as well, asynchronous
+pass through communication, where USB transfer packets are directly dispatched
+to Xlink-IPC.
+
+The component builds and advertises Device IDs that can are used by local host
+application in case of multi device scenarios.
+
+XLink-ETH
+=========
+
+This is an endpoint driver that is mapping Xlink channel IDs to Ethernet
+sockets.
+
+This component ensures host-to-host communication, and, as well, asynchronous
+pass through communication, where Ethernet data loads are directly dispatched to
+Xlink-IPC.
+
+The component builds and advertises Device IDs that can are used by local host
+application in case of multi device scenarios.
+
+Assorted drivers that depend on this stack:
+
+Xlink-SMB
+=========
+The Intel Edge.AI Computer Vision platforms have to be monitored using platform
+devices like sensors, fan controller, IO expander etc. Some of these devices
+are memory mapped and some are i2c based. Either of these devices are not
+directly accessible to the host.
+
+The host here refers to the server to which the vision accelerators are
+connected over PCIe Interface. The Host needs to do a consolidated action based
+on the parameters of platform devices. In general, most of the standard devices
+(includes sensors, fan controller, IO expander etc) are I2C/SMBus based and are
+used to provide the status of the accelerator. Standard drivers for these
+devices are available based on i2c/smbus APIs.
+
+Instead of changing the sensor drivers to adapt to PCIe interface, a generic
+i2c adapter "xlink-smbus" which underneath uses xlink as physical medium is
+used. With xlink-smbus, the drivers for the platform devices doesn't need to
+undergo any interface change.
+
+TSEN
+====
+
+Thermal sensor driver for exporting thermal events to the local Arm64 host as
+well as to the remote X86 host if in the PCIe add in CV accelerator
+configuration.
+
+The driver receiving the junction temperature from different heating points
+inside the SOC. The driver will receive the temperature on SMBUS connection and
+forward over xlink-smb when in a remote host configuration.
+
+In Keem Bay, the four thermal junction temperature points are, Media Subsystem
+(mss), NN subsystem (nce), Compute subsystem (cse) and SOC(Maximum of mss, nce
+and cse)
+
+HDDL
+====
+
+- Exports details of temperature sensor, current sensor and fan controller
+  present in Intel Edge.AI Computer Vision platforms to IA host.
+- Enable Time sync of Intel Edge.AI Computer Vision platform with IA host.
+- Handles device connect and disconnect events.
+- Receives slave address from the IA host for memory mapped thermal sensors
+  present in SoC (Documentation/hwmon/intel_tsens_sensors.rst).
+- Registers i2c slave device for slaves present in Intel Edge.AI Computer
+  Vision platform
+
+
+VPUMGR (VPU Manager)
+====================
+
+Bridges firmware on VPU side and applications on CPU user-space, it assists
+firmware on VPU side serving multiple user space application processes on CPU
+side concurrently while also performing necessary data buffer management on
+behalf of VPU IP.
-- 
2.17.1

