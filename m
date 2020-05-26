Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE581D920C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgESIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 04:30:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:31993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgESIar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:30:47 -0400
IronPort-SDR: FgqzXGANHq4tn1V0BBGd6PO58rwgFcCfFmC55JAUUHKDfUVJOHNV2cCF6DtsL2zThPplPy8lFy
 WUxAK3XFyBaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 01:30:45 -0700
IronPort-SDR: V5XC9tv8exP3gG6P7AtGtNEHOBH6QMa/lM81dPQnQQsHOKFyzf8vBwrwsrFs7Gm7mxMe7AeXdz
 oqkGXyk3fpJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="264234012"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 01:30:40 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/3] soundwire: master: add sysfs support
Date:   Tue, 19 May 2020 04:35:50 +0800
Message-Id: <20200518203551.2053-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
References: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add the master properties as attributes. The description is directly
derived from the MIPI DisCo specification.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-soundwire-master    | 23 +++++
 drivers/soundwire/master.c                    | 84 +++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-master b/Documentation/ABI/testing/sysfs-bus-soundwire-master
new file mode 100644
index 000000000000..46ef038d8722
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-master
@@ -0,0 +1,23 @@
+What:		/sys/bus/soundwire/devices/sdw-master-N/revision
+		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
+		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
+		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
+		/sys/bus/soundwire/devices/sdw-master-N/default_col
+		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
+		/sys/bus/soundwire/devices/sdw-master-N/default_row
+		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
+		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
+		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq
+
+Date:		April 2020
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+		Bard Liao <yung-chuan.liao@linux.intel.com>
+		Vinod Koul <vkoul@kernel.org>
+
+Description:	SoundWire Master-N DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the Master
+		and are used by the bus to configure the Master. clk_stop_modes
+		is a bitmask for simplifications and combines the
+		clock-stop-mode0 and clock-stop-mode1 properties.
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 5411791e6aff..5f0b2189defe 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -8,6 +8,89 @@
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
 
+/*
+ * The sysfs for properties reflects the MIPI description as given
+ * in the MIPI DisCo spec
+ *
+ * Base file is:
+ *	sdw-master-N
+ *      |---- revision
+ *      |---- clk_stop_modes
+ *      |---- max_clk_freq
+ *      |---- clk_freq
+ *      |---- clk_gears
+ *      |---- default_row
+ *      |---- default_col
+ *      |---- dynamic_shape
+ *      |---- err_threshold
+ */
+
+#define sdw_master_attr(field, format_string)				\
+static ssize_t field##_show(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    char *buf)					\
+{									\
+	struct sdw_master_device *md = dev_to_sdw_master_device(dev);	\
+	return sprintf(buf, format_string, md->bus->prop.field);	\
+}									\
+static DEVICE_ATTR_RO(field)
+
+sdw_master_attr(revision, "0x%x\n");
+sdw_master_attr(clk_stop_modes, "0x%x\n");
+sdw_master_attr(max_clk_freq, "%d\n");
+sdw_master_attr(default_row, "%d\n");
+sdw_master_attr(default_col, "%d\n");
+sdw_master_attr(default_frame_rate, "%d\n");
+sdw_master_attr(dynamic_frame, "%d\n");
+sdw_master_attr(err_threshold, "%d\n");
+
+static ssize_t clock_frequencies_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct sdw_master_device *md = dev_to_sdw_master_device(dev);
+	ssize_t size = 0;
+	int i;
+
+	for (i = 0; i < md->bus->prop.num_clk_freq; i++)
+		size += sprintf(buf + size, "%8d ",
+				md->bus->prop.clk_freq[i]);
+	size += sprintf(buf + size, "\n");
+
+	return size;
+}
+static DEVICE_ATTR_RO(clock_frequencies);
+
+static ssize_t clock_gears_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sdw_master_device *md = dev_to_sdw_master_device(dev);
+	ssize_t size = 0;
+	int i;
+
+	for (i = 0; i < md->bus->prop.num_clk_gears; i++)
+		size += sprintf(buf + size, "%8d ",
+				md->bus->prop.clk_gears[i]);
+	size += sprintf(buf + size, "\n");
+
+	return size;
+}
+static DEVICE_ATTR_RO(clock_gears);
+
+static struct attribute *master_node_attrs[] = {
+	&dev_attr_revision.attr,
+	&dev_attr_clk_stop_modes.attr,
+	&dev_attr_max_clk_freq.attr,
+	&dev_attr_default_row.attr,
+	&dev_attr_default_col.attr,
+	&dev_attr_default_frame_rate.attr,
+	&dev_attr_dynamic_frame.attr,
+	&dev_attr_err_threshold.attr,
+	&dev_attr_clock_frequencies.attr,
+	&dev_attr_clock_gears.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(master_node);
+
 static void sdw_master_device_release(struct device *dev)
 {
 	struct sdw_master_device *md = dev_to_sdw_master_device(dev);
@@ -48,6 +131,7 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 	md->dev.bus = &sdw_bus_type;
 	md->dev.type = &sdw_master_type;
 	md->dev.parent = parent;
+	md->dev.groups = master_node_groups;
 	md->dev.of_node = parent->of_node;
 	md->dev.fwnode = fwnode;
 	md->dev.dma_mask = parent->dma_mask;
-- 
2.17.1

