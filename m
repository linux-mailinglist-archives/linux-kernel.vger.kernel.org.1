Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4272F6EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbhANXRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:17:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:15492 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbhANXRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:17:41 -0500
IronPort-SDR: HABRP6VezGNizk+iLwTgaWbtqoZBC6Bp3iL+8b0rFzsmb1kL8ImC0DpsNGNbhl0SQKH8ZjT1RV
 bv3rSIzAgvDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="242530598"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="242530598"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:17:01 -0800
IronPort-SDR: nK1/QCCksa6EoJzNvV7X4zHb3P4otsO8tYvLWH5R3drXaTLtBmneb/6SMc6I+EBv6ivWNZyphQ
 cLFv9NPVhg2w==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="352641202"
Received: from jbae-mobl.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.60.253])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:17:01 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 1/1] mfd: intel-m10-bmc: expose mac address and count
Date:   Thu, 14 Jan 2021 15:16:48 -0800
Message-Id: <20210114231648.199685-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114231648.199685-1-russell.h.weight@intel.com>
References: <20210114231648.199685-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create two sysfs entries for exposing the MAC address
and count from the MAX10 BMC register space. The MAC
address is the first in a sequential block of MAC addresses
reserved for the FPGA card. The MAC count is the number
of MAC addresses in the reserved block.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v4:
  - Changed local variables macaddr1 and macaddr2 to macaddr_low
    and macaddr_high
  - Change macros M10BMC_MACADDR1 and M10BMC_MACADDR2 to
    M10BMC_MAC_LOW and M10BMC_MAC_HIGH
v3:
  - Updated Date and KernelVersion in ABI documentation
v2:
  - Updated the documentation for the mac_address and mac_count
    sysfs nodes to clarify their usage.
  - Changed sysfs _show() functions to use sysfs_emit() instead
    of sprintf.
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc    | 21 +++++++++
 drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  9 ++++
 3 files changed, 73 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
index 979a2d62513f..9773925138af 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -13,3 +13,24 @@ Contact:	Xu Yilun <yilun.xu@intel.com>
 Description:	Read only. Returns the firmware version of Intel MAX10
 		BMC chip.
 		Format: "0x%x".
+
+What:		/sys/bus/spi/devices/.../mac_address
+Date:		January 2021
+KernelVersion:  5.12
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the first MAC address in a block
+		of sequential MAC addresses assigned to the board
+		that is managed by the Intel MAX10 BMC. It is stored in
+		FLASH storage and is mirrored in the MAX10 BMC register
+		space.
+		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
+
+What:		/sys/bus/spi/devices/.../mac_count
+Date:		January 2021
+KernelVersion:  5.12
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the number of sequential MAC
+		addresses assigned to the board managed by the Intel
+		MAX10 BMC. This value is stored in FLASH and is mirrored
+		in the MAX10 BMC register space.
+		Format: "%u".
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index b84579b7b4f0..06c977519479 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -60,9 +60,52 @@ static ssize_t bmcfw_version_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bmcfw_version);
 
+static ssize_t mac_address_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int macaddr_low, macaddr_high;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_MAC_LOW, &macaddr_low);
+	if (ret)
+		return ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr_high),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr_high));
+}
+static DEVICE_ATTR_RO(mac_address);
+
+static ssize_t mac_count_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int macaddr_high;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n",
+			  (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr_high));
+}
+static DEVICE_ATTR_RO(mac_count);
+
 static struct attribute *m10bmc_attrs[] = {
 	&dev_attr_bmc_version.attr,
 	&dev_attr_bmcfw_version.attr,
+	&dev_attr_mac_address.attr,
+	&dev_attr_mac_count.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(m10bmc);
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index c8ef2f1654a4..74d4e193966a 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -15,6 +15,15 @@
 
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
+#define M10BMC_MAC_LOW			0x10
+#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
+#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
+#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
+#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
+#define M10BMC_MAC_HIGH			0x14
+#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
+#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
+#define M10BMC_MAC_COUNT		GENMASK(23, 16)
 #define M10BMC_TEST_REG			0x3c
 #define M10BMC_BUILD_VER		0x68
 #define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
-- 
2.25.1

