Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04F22C922E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgK3XKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:10:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:45754 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbgK3XKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:10:08 -0500
IronPort-SDR: tfYlJdRshO+zZw641Fm1VQ9rtludxlDjMTb5qs0XDIewOR9ZR9cgiCFFZXzV8/Ew8YR9COWOIu
 VU3KQcPNZD/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172886545"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172886545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:11 -0800
IronPort-SDR: gb4rpkVbHFx0t9qgeGjBLyr2JD3Ig8UeYsrj+xQxjFGG05nVR4ImXfj9jEpjWX3IId3MwzvVKb
 MH4SDk0VX4ZQ==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="372683395"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id B3F5A636D;
        Mon, 30 Nov 2020 15:07:10 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kjsGE-000C5K-IH; Mon, 30 Nov 2020 15:07:10 -0800
From:   mgross@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, mgross@linux.intel.com,
        adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 13/22] misc: xlink-pcie: Add XLink API interface
Date:   Mon, 30 Nov 2020 15:06:58 -0800
Message-Id: <20201130230707.46351-14-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Provide interface for XLink layer to interact with XLink PCIe transport
layer on both local host and remote host.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/misc/xlink-pcie/common/interface.c   | 109 +++++++++++++++++++
 drivers/misc/xlink-pcie/local_host/Makefile  |   1 +
 drivers/misc/xlink-pcie/remote_host/Makefile |   1 +
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/misc/xlink-pcie/common/interface.c

diff --git a/drivers/misc/xlink-pcie/common/interface.c b/drivers/misc/xlink-pcie/common/interface.c
new file mode 100644
index 000000000000..56c1d9ed9d8f
--- /dev/null
+++ b/drivers/misc/xlink-pcie/common/interface.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*****************************************************************************
+ *
+ * Intel Keem Bay XLink PCIe Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ ****************************************************************************/
+
+#include <linux/xlink_drv_inf.h>
+
+#include "core.h"
+#include "xpcie.h"
+
+/* Define xpcie driver interface API */
+int xlink_pcie_get_device_list(u32 *sw_device_id_list, u32 *num_devices)
+{
+	if (!sw_device_id_list || !num_devices)
+		return -EINVAL;
+
+	*num_devices = intel_xpcie_get_device_num(sw_device_id_list);
+
+	return 0;
+}
+EXPORT_SYMBOL(xlink_pcie_get_device_list);
+
+int xlink_pcie_get_device_name(u32 sw_device_id, char *device_name,
+			       size_t name_size)
+{
+	if (!device_name)
+		return -EINVAL;
+
+	return intel_xpcie_get_device_name_by_id(sw_device_id,
+						 device_name, name_size);
+}
+EXPORT_SYMBOL(xlink_pcie_get_device_name);
+
+int xlink_pcie_get_device_status(u32 sw_device_id, u32 *device_status)
+{
+	u32 status;
+	int rc;
+
+	if (!device_status)
+		return -EINVAL;
+
+	rc = intel_xpcie_get_device_status_by_id(sw_device_id, &status);
+	if (rc)
+		return rc;
+
+	switch (status) {
+	case XPCIE_STATUS_READY:
+	case XPCIE_STATUS_RUN:
+		*device_status = _XLINK_DEV_READY;
+		break;
+	case XPCIE_STATUS_ERROR:
+		*device_status = _XLINK_DEV_ERROR;
+		break;
+	case XPCIE_STATUS_RECOVERY:
+		*device_status = _XLINK_DEV_RECOVERY;
+		break;
+	case XPCIE_STATUS_OFF:
+		*device_status = _XLINK_DEV_OFF;
+		break;
+	default:
+		*device_status = _XLINK_DEV_BUSY;
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(xlink_pcie_get_device_status);
+
+int xlink_pcie_boot_device(u32 sw_device_id, const char *binary_name)
+{
+	return 0;
+}
+EXPORT_SYMBOL(xlink_pcie_boot_device);
+
+int xlink_pcie_connect(u32 sw_device_id)
+{
+	return intel_xpcie_pci_connect_device(sw_device_id);
+}
+EXPORT_SYMBOL(xlink_pcie_connect);
+
+int xlink_pcie_read(u32 sw_device_id, void *data, size_t *const size,
+		    u32 timeout)
+{
+	if (!data || !size)
+		return -EINVAL;
+
+	return intel_xpcie_pci_read(sw_device_id, data, size, timeout);
+}
+EXPORT_SYMBOL(xlink_pcie_read);
+
+int xlink_pcie_write(u32 sw_device_id, void *data, size_t *const size,
+		     u32 timeout)
+{
+	if (!data || !size)
+		return -EINVAL;
+
+	return intel_xpcie_pci_write(sw_device_id, data, size, timeout);
+}
+EXPORT_SYMBOL(xlink_pcie_write);
+
+int xlink_pcie_reset_device(u32 sw_device_id)
+{
+	return intel_xpcie_pci_reset_device(sw_device_id);
+}
+EXPORT_SYMBOL(xlink_pcie_reset_device);
diff --git a/drivers/misc/xlink-pcie/local_host/Makefile b/drivers/misc/xlink-pcie/local_host/Makefile
index 65df94c7e860..16bb1e7345ac 100644
--- a/drivers/misc/xlink-pcie/local_host/Makefile
+++ b/drivers/misc/xlink-pcie/local_host/Makefile
@@ -3,3 +3,4 @@ mxlk_ep-objs := epf.o
 mxlk_ep-objs += dma.o
 mxlk_ep-objs += core.o
 mxlk_ep-objs += ../common/util.o
+mxlk_ep-objs += ../common/interface.o
diff --git a/drivers/misc/xlink-pcie/remote_host/Makefile b/drivers/misc/xlink-pcie/remote_host/Makefile
index e8074dbb1161..088e121ad46e 100644
--- a/drivers/misc/xlink-pcie/remote_host/Makefile
+++ b/drivers/misc/xlink-pcie/remote_host/Makefile
@@ -3,3 +3,4 @@ mxlk-objs := main.o
 mxlk-objs += pci.o
 mxlk-objs += core.o
 mxlk-objs += ../common/util.o
+mxlk-objs += ../common/interface.o
-- 
2.17.1

