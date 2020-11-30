Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075A32C9213
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgK3XIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:08:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:58436 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbgK3XI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:08:28 -0500
IronPort-SDR: 419mN7z4MA2W0dBH5XiYcsBB61LcbK3pBzdachodZfR6dzQMhpKnqR0DjQoC7W4Fc/FunoRvPr
 Qwb6yU4+P92w==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="171941906"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="171941906"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
IronPort-SDR: k/T3wces5yNnvKRppoMBqMuuEDUqJZdv714T9Uq/1ObRlyuq167BbGBbsiXeMPpWx1nCC0as9q
 /oTuUneR8VKA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="364436857"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 0FC5C636D;
        Mon, 30 Nov 2020 15:07:10 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kjsGD-000C4z-Ta; Mon, 30 Nov 2020 15:07:09 -0800
From:   mgross@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, mgross@linux.intel.com,
        adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 06/22] misc: xlink-pcie: Add documentation for XLink PCIe driver
Date:   Mon, 30 Nov 2020 15:06:51 -0800
Message-Id: <20201130230707.46351-7-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Provide overview of XLink PCIe driver implementation

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 Documentation/vpu/index.rst      |  1 +
 Documentation/vpu/xlink-pcie.rst | 91 ++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/vpu/xlink-pcie.rst

diff --git a/Documentation/vpu/index.rst b/Documentation/vpu/index.rst
index 7e290e048910..661cc700ee45 100644
--- a/Documentation/vpu/index.rst
+++ b/Documentation/vpu/index.rst
@@ -14,3 +14,4 @@ This documentation contains information for the Intel VPU stack.
    :maxdepth: 2
 
    vpu-stack-overview
+   xlink-pcie
diff --git a/Documentation/vpu/xlink-pcie.rst b/Documentation/vpu/xlink-pcie.rst
new file mode 100644
index 000000000000..bc64b566989d
--- /dev/null
+++ b/Documentation/vpu/xlink-pcie.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver: xlink-pcie driver
+================================
+Supported chips:
+  * Intel Edge.AI Computer Vision platforms: Keem Bay
+    Suffix: Bay
+    Slave address: 6240
+    Datasheet: Publicly available at Intel
+
+Author: Srikanth Thokala Srikanth.Thokala@intel.com
+
+-------------
+Introduction:
+-------------
+The xlink-pcie driver in linux-5.4 provides transport layer implementation for
+the data transfers to support xlink protocol subsystem communication with the
+peer device. i.e, between remote host system and the local Keem Bay device.
+
+The Keem Bay device is an ARM based SOC that includes a vision processing
+unit (VPU) and deep learning, neural network core in the hardware.
+The xlink-pcie driver exports a functional device endpoint to the Keem Bay device
+and supports two-way communication with peer device.
+
+------------------------
+High-level architecture:
+------------------------
+Remote Host: IA CPU
+Local Host: ARM CPU (Keem Bay)::
+
+        +------------------------------------------------------------------------+
+        |  Remote Host IA CPU              | | Local Host ARM CPU (Keem Bay) |   |
+        +==================================+=+===============================+===+
+        |  User App                        | | User App                      |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink UAPI                     | | XLink UAPI                    |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink Core                     | | XLink Core                    |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink PCIe                     | | XLink PCIe                    |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink-PCIe Remote Host driver  | | XLink-PCIe Local Host driver  |   |
+        +----------------------------------+-+-------------------------------+---+
+        |-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|:|:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|
+        +----------------------------------+-+-------------------------------+---+
+        |     PCIe Host Controller         | | PCIe Device Controller        | HW|
+        +----------------------------------+-+-------------------------------+---+
+               ^                                             ^
+               |                                             |
+               |------------- PCIe x2 Link  -----------------|
+
+This XLink PCIe driver comprises of two variants:
+* Local Host driver
+
+  * Intended for ARM CPU
+  * It is based on PCI Endpoint Framework
+  * Driver path: {tree}/drivers/misc/xlink-pcie/local_host
+
+* Remote Host driver
+
+       * Intended for IA CPU
+       * It is a PCIe endpoint driver
+       * Driver path: {tree}/drivers/misc/xlink-pcie/remote_host
+
+XLink PCIe communication between local host and remote host is achieved through
+ring buffer management and MSI/Doorbell interrupts.
+
+The xlink-pcie driver subsystem registers Keem Bay device as an endpoint driver
+and provides standard linux pcie sysfs interface, # /sys/bus/pci/devices/xxxx:xx:xx.0/
+
+
+-------------------------
+XLink protocol subsystem:
+-------------------------
+xlink is an abstracted control and communication subsystem based on channel
+identification. It is intended to support VPU technology both at SoC level as
+well as at IP level, over multiple interfaces.
+
+- The xlink subsystem abstracts several types of communication channels
+  underneath, allowing the usage of different interfaces with the
+  same function call interface.
+- The Communication channels are full-duplex protocol channels allowing
+  concurrent bidirectional communication.
+- The xlink subsystem also supports control operations to VPU either
+  from standalone local system or from remote system based on communication
+  interface underneath.
+- The xlink subsystem supports following communication interfaces:
+    * USB CDC
+    * Gigabit Ethernet
+    * PCIe
+    * IPC
-- 
2.17.1

