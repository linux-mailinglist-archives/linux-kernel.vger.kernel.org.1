Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA172CB036
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgLAWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:37:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:28888 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgLAWhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:37:04 -0500
IronPort-SDR: zxNrXQEBQRkroMHL3e5kgP406kN8uw1Rq0GAdJdaa0CBXgJyGrgDUEOKbgJ9Gr6D1VyjBk4QWF
 sYFuif3STcrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191126597"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="191126597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:15 -0800
IronPort-SDR: nu77lkQci4/dFu/hPzD+tFI4X4QJhrq8bu5jQLhlqAZbmCqH++FwVP0qlaWxJsvMZ+xvlf06uQ
 8nmp2WJWc9/A==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="434847185"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:15 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 525C06363;
        Tue,  1 Dec 2020 14:35:15 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kkEEt-000H4s-69; Tue, 01 Dec 2020 14:35:15 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [PATCH 13/22] misc: xlink-pcie: Add XLink API interface
Date:   Tue,  1 Dec 2020 14:35:02 -0800
Message-Id: <20201201223511.65542-14-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201223511.65542-1-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Provide interface for XLink layer to interact with XLink PCIe transport
layer on both local host and remote host.

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

