Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576CA2311B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbgG1S2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 14:28:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:27787 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgG1S2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:28:41 -0400
IronPort-SDR: wO0AG7HgmpOTdZBKnkSb58Mb45TSdRfXFnuz7gb1rPEkpLyxrL5m7UmS0O5gvwvnfbRqGFv1VL
 hF3+PZMzvmBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="150454095"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="150454095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 11:28:40 -0700
IronPort-SDR: vFWg421+e6I6v69KoL5FPUb6j/UyEtTjmCltRwzqpg509efuSUD5oWSI6ti6FiIw3RPlGqx+x+
 40dtL3arX6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="490461913"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2020 11:28:39 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next V2] mei: add device kind to sysfs
Date:   Tue, 28 Jul 2020 21:28:36 +0300
Message-Id: <20200728182836.3112138-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Some of the mei device heads are not generic and have
a specific purpose, we need to announce it to the user space
so it is possible to detect the correct device node via
matching attributes.

Generic heads are marked as 'mei' while special purpose heads
have their own names. Currently we are adding 'itouch' string
for Intel IPTS 1.0, 2.0 devices.

This is done via new sysfs attribute 'kind'.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: Correct version of the patch.

 Documentation/ABI/testing/sysfs-class-mei | 13 +++++++++++
 drivers/misc/mei/hw-me.c                  | 22 ++++++++++++++----
 drivers/misc/mei/hw-me.h                  |  7 +++++-
 drivers/misc/mei/main.c                   | 27 +++++++++++++++++++++++
 drivers/misc/mei/mei_dev.h                |  4 ++++
 drivers/misc/mei/pci-me.c                 | 10 ++++-----
 6 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mei b/Documentation/ABI/testing/sysfs-class-mei
index e9dc110650ae..5c52372b43cb 100644
--- a/Documentation/ABI/testing/sysfs-class-mei
+++ b/Documentation/ABI/testing/sysfs-class-mei
@@ -90,3 +90,16 @@ Description:	Display trc status register content
 		The ME FW writes Glitch Detection HW (TRC)
 		status information into trc status register
 		for BIOS and OS to monitor fw health.
+
+What:		/sys/class/mei/meiN/kind
+Date:		Jul 2020
+KernelVersion:	5.8
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Display kind of the device
+
+		Generic devices are marked as "mei"
+		while special purpose have their own
+		names.
+		Available options:
+		- mei:  generic mei device.
+		- itouch:  itouch (ipts) mei device.
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 7692b69abcb5..cda0829ac589 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1430,6 +1430,9 @@ static bool mei_me_fw_type_sps(const struct pci_dev *pdev)
 	return fw_type == PCI_CFG_HFS_3_FW_SKU_SPS;
 }
 
+#define MEI_CFG_KIND_ITOUCH                     \
+	.kind = "itouch"
+
 #define MEI_CFG_FW_SPS                          \
 	.quirk_probe = mei_me_fw_type_sps
 
@@ -1499,6 +1502,13 @@ static const struct mei_cfg mei_me_pch8_cfg = {
 	MEI_CFG_FW_VER_SUPP,
 };
 
+/* PCH8 Lynx Point and newer devices - iTouch */
+static const struct mei_cfg mei_me_pch8_itouch_cfg = {
+	MEI_CFG_KIND_ITOUCH,
+	MEI_CFG_PCH8_HFS,
+	MEI_CFG_FW_VER_SUPP,
+};
+
 /* PCH8 Lynx Point with quirk for SPS Firmware exclusion */
 static const struct mei_cfg mei_me_pch8_sps_4_cfg = {
 	MEI_CFG_PCH8_HFS,
@@ -1528,10 +1538,11 @@ static const struct mei_cfg mei_me_pch12_sps_cfg = {
 	MEI_CFG_FW_SPS,
 };
 
-/* Cannon Lake with quirk for SPS 5.0 and newer Firmware exclusion
- * w/o DMA support
+/* Cannon Lake itouch with quirk for SPS 5.0 and newer Firmware exclusion
+ * w/o DMA support.
  */
-static const struct mei_cfg mei_me_pch12_nodma_sps_cfg = {
+static const struct mei_cfg mei_me_pch12_itouch_sps_cfg = {
+	MEI_CFG_KIND_ITOUCH,
 	MEI_CFG_PCH8_HFS,
 	MEI_CFG_FW_VER_SUPP,
 	MEI_CFG_FW_SPS,
@@ -1566,11 +1577,12 @@ static const struct mei_cfg *const mei_cfg_list[] = {
 	[MEI_ME_PCH7_CFG] = &mei_me_pch7_cfg,
 	[MEI_ME_PCH_CPT_PBG_CFG] = &mei_me_pch_cpt_pbg_cfg,
 	[MEI_ME_PCH8_CFG] = &mei_me_pch8_cfg,
+	[MEI_ME_PCH8_ITOUCH_CFG] = &mei_me_pch8_itouch_cfg,
 	[MEI_ME_PCH8_SPS_4_CFG] = &mei_me_pch8_sps_4_cfg,
 	[MEI_ME_PCH12_CFG] = &mei_me_pch12_cfg,
 	[MEI_ME_PCH12_SPS_4_CFG] = &mei_me_pch12_sps_4_cfg,
 	[MEI_ME_PCH12_SPS_CFG] = &mei_me_pch12_sps_cfg,
-	[MEI_ME_PCH12_SPS_NODMA_CFG] = &mei_me_pch12_nodma_sps_cfg,
+	[MEI_ME_PCH12_SPS_ITOUCH_CFG] = &mei_me_pch12_itouch_sps_cfg,
 	[MEI_ME_PCH15_CFG] = &mei_me_pch15_cfg,
 	[MEI_ME_PCH15_SPS_CFG] = &mei_me_pch15_sps_cfg,
 };
@@ -1614,6 +1626,8 @@ struct mei_device *mei_me_dev_init(struct device *parent,
 
 	dev->fw_f_fw_ver_supported = cfg->fw_ver_supported;
 
+	dev->kind = cfg->kind;
+
 	return dev;
 }
 
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 560c8ebb17be..00a7132ac7a2 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -19,6 +19,7 @@
  *
  * @fw_status: FW status
  * @quirk_probe: device exclusion quirk
+ * @kind: MEI head kind
  * @dma_size: device DMA buffers size
  * @fw_ver_supported: is fw version retrievable from FW
  * @hw_trc_supported: does the hw support trc register
@@ -26,6 +27,7 @@
 struct mei_cfg {
 	const struct mei_fw_status fw_status;
 	bool (*quirk_probe)(const struct pci_dev *pdev);
+	const char *kind;
 	size_t dma_size[DMA_DSCR_NUM];
 	u32 fw_ver_supported:1;
 	u32 hw_trc_supported:1;
@@ -76,6 +78,8 @@ struct mei_me_hw {
  *                         with quirk for Node Manager exclusion.
  * @MEI_ME_PCH8_CFG:       Platform Controller Hub Gen8 and newer
  *                         client platforms.
+ * @MEI_ME_PCH8_ITOUCH_CFG:Platform Controller Hub Gen8 and newer
+ *                         client platforms (iTouch).
  * @MEI_ME_PCH8_SPS_4_CFG: Platform Controller Hub Gen8 and newer
  *                         servers platforms with quirk for
  *                         SPS firmware exclusion.
@@ -100,11 +104,12 @@ enum mei_cfg_idx {
 	MEI_ME_PCH7_CFG,
 	MEI_ME_PCH_CPT_PBG_CFG,
 	MEI_ME_PCH8_CFG,
+	MEI_ME_PCH8_ITOUCH_CFG,
 	MEI_ME_PCH8_SPS_4_CFG,
 	MEI_ME_PCH12_CFG,
 	MEI_ME_PCH12_SPS_4_CFG,
 	MEI_ME_PCH12_SPS_CFG,
-	MEI_ME_PCH12_SPS_NODMA_CFG,
+	MEI_ME_PCH12_SPS_ITOUCH_CFG,
 	MEI_ME_PCH15_CFG,
 	MEI_ME_PCH15_SPS_CFG,
 	MEI_ME_NUM_CFG,
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 05e6ad6d4d54..3fd0d42e89c0 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -885,6 +885,32 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
 	}
 }
 
+/**
+ * kind_show - display device kind
+ *
+ * @device: device pointer
+ * @attr: attribute pointer
+ * @buf: char out buffer
+ *
+ * Return: number of the bytes printed into buf or error
+ */
+static ssize_t kind_show(struct device *device,
+			 struct device_attribute *attr, char *buf)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	ssize_t ret = 0;
+
+	mutex_lock(&dev->device_lock);
+	if (dev->kind)
+		ret = sprintf(buf, "%s\n", dev->kind);
+	else
+		ret = sprintf(buf, "%s\n", "mei");
+	mutex_unlock(&dev->device_lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(kind);
+
 static struct attribute *mei_attrs[] = {
 	&dev_attr_fw_status.attr,
 	&dev_attr_hbm_ver.attr,
@@ -893,6 +919,7 @@ static struct attribute *mei_attrs[] = {
 	&dev_attr_fw_ver.attr,
 	&dev_attr_dev_state.attr,
 	&dev_attr_trc.attr,
+	&dev_attr_kind.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(mei);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 3a29db07211d..d3a4f54c0ae7 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -445,6 +445,8 @@ struct mei_fw_version {
  * @device_list : mei client bus list
  * @cl_bus_lock : client bus list lock
  *
+ * @kind        : kind of mei device
+ *
  * @dbgfs_dir   : debugfs mei root directory
  *
  * @ops:        : hw specific operations
@@ -528,6 +530,8 @@ struct mei_device {
 	struct list_head device_list;
 	struct mutex cl_bus_lock;
 
+	const char *kind;
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 159e40a2505d..1de9ef7a272b 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -68,7 +68,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_3, MEI_ME_PCH8_ITOUCH_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_4_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_4_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_SPS_4_CFG)},
@@ -85,15 +85,15 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_3, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH12_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH12_SPS_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_3, MEI_ME_PCH12_SPS_NODMA_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_3, MEI_ME_PCH12_SPS_ITOUCH_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP, MEI_ME_PCH12_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_V, MEI_ME_PCH12_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H, MEI_ME_PCH12_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_ITOUCH_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
 
-- 
2.25.4

