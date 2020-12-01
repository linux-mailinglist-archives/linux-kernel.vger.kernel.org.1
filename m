Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C102CAD82
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgLAUhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:37:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:61686 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbgLAUhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:37:46 -0500
IronPort-SDR: 0uDNKCqLOeiguRk5QrSm1IoY9PCdFfKnxfPrgsYJxRcdg9douqXwGLkO92LpQ4qJjQEw9iYElj
 mRiTEXkWPOKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="234508958"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="234508958"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 12:36:50 -0800
IronPort-SDR: HAC9F3ALYyUTOtI9lPetrQPrzc4CCnWrew/FqWZpJK8eruS5KlmsXkgQ9FHb+BqC3IVTE8FElI
 oNBPEQwOysVQ==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="481254571"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.174.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 12:36:49 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 1/1] mfd: intel-m10-bmc: expose mac address and count
Date:   Tue,  1 Dec 2020 12:36:46 -0800
Message-Id: <20201201203646.200907-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201203646.200907-1-russell.h.weight@intel.com>
References: <20201201203646.200907-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create two sysfs entries for exposing the MAC address
and count from the MAX10 BMC register space.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc    | 20 +++++++++
 drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  9 ++++
 3 files changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
index 979a2d62513f..c4febaefe0a7 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -13,3 +13,23 @@ Contact:	Xu Yilun <yilun.xu@intel.com>
 Description:	Read only. Returns the firmware version of Intel MAX10
 		BMC chip.
 		Format: "0x%x".
+
+What:		/sys/bus/spi/devices/.../mac_address
+Date:		December 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the base mac address assigned to
+		the board managed by the Intel MAX10 BMC. It is
+		stored in flash and is mirrored in the MAX10 BMC
+		register space.
+		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
+
+What:		/sys/bus/spi/devices/.../mac_count
+Date:		December 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the number of mac addresses
+		assigned to the board managed by the Intel MAX10
+		BMC. This value is stored in flash and is mirrored
+		in the MAX10 BMC register space.
+		Format: "%u".
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index b84579b7b4f0..90720e84900e 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -60,9 +60,52 @@ static ssize_t bmcfw_version_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bmcfw_version);
 
+static ssize_t mac_address_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int macaddr1, macaddr2;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_MACADDR1, &macaddr1);
+	if (ret)
+		return ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
+		       (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr1),
+		       (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr1),
+		       (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr1),
+		       (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr1),
+		       (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr2),
+		       (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr2));
+}
+static DEVICE_ATTR_RO(mac_address);
+
+static ssize_t mac_count_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int macaddr2;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n",
+		       (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr2));
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
index c8ef2f1654a4..2279e34f0814 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -15,6 +15,15 @@
 
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
+#define M10BMC_MACADDR1			0x10
+#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
+#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
+#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
+#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
+#define M10BMC_MACADDR2			0x14
+#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
+#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
+#define M10BMC_MAC_COUNT		GENMASK(23, 16)
 #define M10BMC_TEST_REG			0x3c
 #define M10BMC_BUILD_VER		0x68
 #define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
-- 
2.25.1

