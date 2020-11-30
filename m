Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3C2C9219
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgK3XI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:08:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:45754 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbgK3XIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:08:52 -0500
IronPort-SDR: TVFRcKY7gkPQoBXHXTs049VdPxL04rfceH4cLyBLRTnpx/IZ4sp9F5g9MHwl1yTXHssS9TjHYy
 W4W+1mDsvtxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172886544"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172886544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:11 -0800
IronPort-SDR: kWbDojGud1gGXcSjC/WnFquau6pTig+6knDQKqPewE6zqXxDOO6Pe2QeKmK+xxSRj2LG9g+7cd
 TCfoOOWLeHiA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="367296073"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 97CB7636B;
        Mon, 30 Nov 2020 15:07:10 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kjsGE-000C5H-EU; Mon, 30 Nov 2020 15:07:10 -0800
From:   mgross@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, mgross@linux.intel.com,
        adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 12/22] misc: xlink-pcie: rh: Add core communication logic
Date:   Mon, 30 Nov 2020 15:06:57 -0800
Message-Id: <20201130230707.46351-13-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Add logic to establish communication with the local host which is through
ring buffer management and MSI/Doorbell interrupts

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/misc/xlink-pcie/common/core.h        |  11 +-
 drivers/misc/xlink-pcie/remote_host/Makefile |   2 +
 drivers/misc/xlink-pcie/remote_host/core.c   | 647 +++++++++++++++++++
 drivers/misc/xlink-pcie/remote_host/pci.c    |  48 +-
 4 files changed, 696 insertions(+), 12 deletions(-)
 create mode 100644 drivers/misc/xlink-pcie/remote_host/core.c

diff --git a/drivers/misc/xlink-pcie/common/core.h b/drivers/misc/xlink-pcie/common/core.h
index 84985ef41a64..eec8566c19d9 100644
--- a/drivers/misc/xlink-pcie/common/core.h
+++ b/drivers/misc/xlink-pcie/common/core.h
@@ -10,15 +10,11 @@
 #ifndef XPCIE_CORE_HEADER_
 #define XPCIE_CORE_HEADER_
 
-#include <linux/io.h>
-#include <linux/types.h>
-#include <linux/workqueue.h>
-#include <linux/slab.h>
-#include <linux/mutex.h>
-#include <linux/mempool.h>
 #include <linux/dma-mapping.h>
-#include <linux/cache.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <linux/xlink_drv_inf.h>
 
@@ -64,6 +60,7 @@ struct xpcie_buf_desc {
 struct xpcie_stream {
 	size_t frag;
 	struct xpcie_pipe pipe;
+	struct xpcie_buf_desc **ddr;
 };
 
 struct xpcie_list {
diff --git a/drivers/misc/xlink-pcie/remote_host/Makefile b/drivers/misc/xlink-pcie/remote_host/Makefile
index 96374a43023e..e8074dbb1161 100644
--- a/drivers/misc/xlink-pcie/remote_host/Makefile
+++ b/drivers/misc/xlink-pcie/remote_host/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_XLINK_PCIE_RH_DRIVER) += mxlk.o
 mxlk-objs := main.o
 mxlk-objs += pci.o
+mxlk-objs += core.o
+mxlk-objs += ../common/util.o
diff --git a/drivers/misc/xlink-pcie/remote_host/core.c b/drivers/misc/xlink-pcie/remote_host/core.c
new file mode 100644
index 000000000000..668fded17e9c
--- /dev/null
+++ b/drivers/misc/xlink-pcie/remote_host/core.c
@@ -0,0 +1,647 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*****************************************************************************
+ *
+ * Intel Keem Bay XLink PCIe Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ ****************************************************************************/
+
+#include "pci.h"
+
+#include "../common/core.h"
+#include "../common/util.h"
+
+static int rx_pool_size = SZ_32M;
+module_param(rx_pool_size, int, 0664);
+MODULE_PARM_DESC(rx_pool_size, "receive pool size (default 32 MiB)");
+
+static int tx_pool_size = SZ_32M;
+module_param(tx_pool_size, int, 0664);
+MODULE_PARM_DESC(tx_pool_size, "transmit pool size (default 32 MiB)");
+
+static int intel_xpcie_version_check(struct xpcie *xpcie)
+{
+	struct xpcie_version version;
+
+	memcpy_fromio(&version,
+		      (void __iomem *)(xpcie->mmio + XPCIE_MMIO_VERSION),
+		      sizeof(version));
+
+	dev_dbg(xpcie_to_dev(xpcie), "ver: device %u.%u.%u, host %u.%u.%u\n",
+		version.major, version.minor, version.build,
+		XPCIE_VERSION_MAJOR, XPCIE_VERSION_MINOR, XPCIE_VERSION_BUILD);
+
+	if (intel_xpcie_ioread8(xpcie->mmio + XPCIE_MMIO_LEGACY_A0))
+		xpcie->legacy_a0 = true;
+
+	return 0;
+}
+
+static int intel_xpcie_map_dma(struct xpcie *xpcie, struct xpcie_buf_desc *bd,
+			       int direction)
+{
+	struct xpcie_dev *xdev = container_of(xpcie, struct xpcie_dev, xpcie);
+	struct device *dev = &xdev->pci->dev;
+
+	bd->phys = dma_map_single(dev, bd->data, bd->length, direction);
+
+	return dma_mapping_error(dev, bd->phys);
+}
+
+static void intel_xpcie_unmap_dma(struct xpcie *xpcie,
+				  struct xpcie_buf_desc *bd,
+				  int direction)
+{
+	struct xpcie_dev *xdev = container_of(xpcie, struct xpcie_dev, xpcie);
+	struct device *dev = &xdev->pci->dev;
+
+	dma_unmap_single(dev, bd->phys, bd->length, direction);
+}
+
+static void intel_xpcie_txrx_cleanup(struct xpcie *xpcie)
+{
+	struct xpcie_interface *inf = &xpcie->interfaces[0];
+	struct xpcie_stream *tx = &xpcie->tx;
+	struct xpcie_stream *rx = &xpcie->rx;
+	struct xpcie_buf_desc *bd;
+	int index;
+
+	xpcie->stop_flag = true;
+	xpcie->no_tx_buffer = false;
+	inf->data_avail = true;
+	wake_up_interruptible(&xpcie->tx_waitq);
+	wake_up_interruptible(&inf->rx_waitq);
+	mutex_lock(&xpcie->wlock);
+	mutex_lock(&inf->rlock);
+
+	if (tx->ddr) {
+		for (index = 0; index < tx->pipe.ndesc; index++) {
+			struct xpcie_transfer_desc *td = tx->pipe.tdr + index;
+
+			bd = tx->ddr[index];
+			if (bd) {
+				intel_xpcie_unmap_dma(xpcie, bd, DMA_TO_DEVICE);
+				intel_xpcie_free_tx_bd(xpcie, bd);
+				intel_xpcie_set_td_address(td, 0);
+				intel_xpcie_set_td_length(td, 0);
+			}
+		}
+		kfree(tx->ddr);
+	}
+
+	if (rx->ddr) {
+		for (index = 0; index < rx->pipe.ndesc; index++) {
+			struct xpcie_transfer_desc *td = rx->pipe.tdr + index;
+
+			bd = rx->ddr[index];
+			if (bd) {
+				intel_xpcie_unmap_dma(xpcie,
+						      bd, DMA_FROM_DEVICE);
+				intel_xpcie_free_rx_bd(xpcie, bd);
+				intel_xpcie_set_td_address(td, 0);
+				intel_xpcie_set_td_length(td, 0);
+			}
+		}
+		kfree(rx->ddr);
+	}
+
+	intel_xpcie_list_cleanup(&xpcie->tx_pool);
+	intel_xpcie_list_cleanup(&xpcie->rx_pool);
+
+	mutex_unlock(&inf->rlock);
+	mutex_unlock(&xpcie->wlock);
+}
+
+static int intel_xpcie_txrx_init(struct xpcie *xpcie,
+				 struct xpcie_cap_txrx *cap)
+{
+	struct xpcie_stream *tx = &xpcie->tx;
+	struct xpcie_stream *rx = &xpcie->rx;
+	struct xpcie_buf_desc *bd;
+	int rc, index, ndesc;
+
+	xpcie->txrx = cap;
+	xpcie->fragment_size = intel_xpcie_ioread32(&cap->fragment_size);
+	xpcie->stop_flag = false;
+
+	tx->pipe.ndesc = intel_xpcie_ioread32(&cap->tx.ndesc);
+	tx->pipe.head = &cap->tx.head;
+	tx->pipe.tail = &cap->tx.tail;
+	tx->pipe.old = intel_xpcie_ioread32(&cap->tx.tail);
+	tx->pipe.tdr = (struct xpcie_transfer_desc *)(xpcie->mmio +
+				intel_xpcie_ioread32(&cap->tx.ring));
+
+	tx->ddr = kcalloc(tx->pipe.ndesc, sizeof(struct xpcie_buf_desc *),
+			  GFP_KERNEL);
+	if (!tx->ddr) {
+		rc = -ENOMEM;
+		goto error;
+	}
+
+	rx->pipe.ndesc = intel_xpcie_ioread32(&cap->rx.ndesc);
+	rx->pipe.head = &cap->rx.head;
+	rx->pipe.tail = &cap->rx.tail;
+	rx->pipe.old = intel_xpcie_ioread32(&cap->rx.head);
+	rx->pipe.tdr = (struct xpcie_transfer_desc *)(xpcie->mmio +
+				intel_xpcie_ioread32(&cap->rx.ring));
+
+	rx->ddr = kcalloc(rx->pipe.ndesc, sizeof(struct xpcie_buf_desc *),
+			  GFP_KERNEL);
+	if (!rx->ddr) {
+		rc = -ENOMEM;
+		goto error;
+	}
+
+	intel_xpcie_list_init(&xpcie->rx_pool);
+	rx_pool_size = roundup(rx_pool_size, xpcie->fragment_size);
+	ndesc = rx_pool_size / xpcie->fragment_size;
+
+	for (index = 0; index < ndesc; index++) {
+		bd = intel_xpcie_alloc_bd(xpcie->fragment_size);
+		if (bd) {
+			intel_xpcie_list_put(&xpcie->rx_pool, bd);
+		} else {
+			rc = -ENOMEM;
+			goto error;
+		}
+	}
+
+	intel_xpcie_list_init(&xpcie->tx_pool);
+	tx_pool_size = roundup(tx_pool_size, xpcie->fragment_size);
+	ndesc = tx_pool_size / xpcie->fragment_size;
+
+	for (index = 0; index < ndesc; index++) {
+		bd = intel_xpcie_alloc_bd(xpcie->fragment_size);
+		if (bd) {
+			intel_xpcie_list_put(&xpcie->tx_pool, bd);
+		} else {
+			rc = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for (index = 0; index < rx->pipe.ndesc; index++) {
+		struct xpcie_transfer_desc *td = rx->pipe.tdr + index;
+
+		bd = intel_xpcie_alloc_rx_bd(xpcie);
+		if (!bd) {
+			rc = -ENOMEM;
+			goto error;
+		}
+
+		if (intel_xpcie_map_dma(xpcie, bd, DMA_FROM_DEVICE)) {
+			dev_err(xpcie_to_dev(xpcie), "failed to map rx bd\n");
+			rc = -ENOMEM;
+			goto error;
+		}
+
+		rx->ddr[index] = bd;
+		intel_xpcie_set_td_address(td, bd->phys);
+		intel_xpcie_set_td_length(td, bd->length);
+	}
+
+	return 0;
+
+error:
+	intel_xpcie_txrx_cleanup(xpcie);
+
+	return rc;
+}
+
+static int intel_xpcie_discover_txrx(struct xpcie *xpcie)
+{
+	struct xpcie_cap_txrx *cap;
+	int error;
+
+	cap = intel_xpcie_cap_find(xpcie, 0, XPCIE_CAP_TXRX);
+	if (cap)
+		error = intel_xpcie_txrx_init(xpcie, cap);
+	else
+		error = -EIO;
+
+	return error;
+}
+
+static void intel_xpcie_start_tx(struct xpcie *xpcie, unsigned long delay)
+{
+	queue_delayed_work(xpcie->tx_wq, &xpcie->tx_event, delay);
+}
+
+static void intel_xpcie_start_rx(struct xpcie *xpcie, unsigned long delay)
+{
+	queue_delayed_work(xpcie->rx_wq, &xpcie->rx_event, delay);
+}
+
+static void intel_xpcie_rx_event_handler(struct work_struct *work)
+{
+	struct xpcie *xpcie = container_of(work, struct xpcie, rx_event.work);
+	struct xpcie_dev *xdev = container_of(xpcie, struct xpcie_dev, xpcie);
+	struct xpcie_buf_desc *bd, *replacement = NULL;
+	unsigned long delay = msecs_to_jiffies(1);
+	struct xpcie_stream *rx = &xpcie->rx;
+	struct xpcie_transfer_desc *td;
+	u32 head, tail, ndesc, length;
+	u16 status, interface;
+	int rc;
+
+	if (intel_xpcie_get_device_status(xpcie) != XPCIE_STATUS_RUN)
+		return;
+
+	ndesc = rx->pipe.ndesc;
+	tail = intel_xpcie_get_tdr_tail(&rx->pipe);
+	head = intel_xpcie_get_tdr_head(&rx->pipe);
+
+	while (head != tail) {
+		td = rx->pipe.tdr + head;
+		bd = rx->ddr[head];
+
+		replacement = intel_xpcie_alloc_rx_bd(xpcie);
+		if (!replacement) {
+			delay = msecs_to_jiffies(20);
+			break;
+		}
+
+		rc = intel_xpcie_map_dma(xpcie, replacement, DMA_FROM_DEVICE);
+		if (rc) {
+			dev_err(xpcie_to_dev(xpcie),
+				"failed to map rx bd (%d)\n", rc);
+			intel_xpcie_free_rx_bd(xpcie, replacement);
+			break;
+		}
+
+		status = intel_xpcie_get_td_status(td);
+		interface = intel_xpcie_get_td_interface(td);
+		length = intel_xpcie_get_td_length(td);
+		intel_xpcie_unmap_dma(xpcie, bd, DMA_FROM_DEVICE);
+
+		if (unlikely(status != XPCIE_DESC_STATUS_SUCCESS) ||
+		    unlikely(interface >= XPCIE_NUM_INTERFACES)) {
+			dev_err(xpcie_to_dev(xpcie),
+				"rx desc failure, status(%u), interface(%u)\n",
+			status, interface);
+			intel_xpcie_free_rx_bd(xpcie, bd);
+		} else {
+			bd->interface = interface;
+			bd->length = length;
+			bd->next = NULL;
+
+			intel_xpcie_add_bd_to_interface(xpcie, bd);
+		}
+
+		rx->ddr[head] = replacement;
+		intel_xpcie_set_td_address(td, replacement->phys);
+		intel_xpcie_set_td_length(td, replacement->length);
+		head = XPCIE_CIRCULAR_INC(head, ndesc);
+	}
+
+	if (intel_xpcie_get_tdr_head(&rx->pipe) != head) {
+		intel_xpcie_set_tdr_head(&rx->pipe, head);
+		intel_xpcie_pci_raise_irq(xdev, DATA_RECEIVED, 1);
+	}
+
+	if (!replacement)
+		intel_xpcie_start_rx(xpcie, delay);
+}
+
+static void intel_xpcie_tx_event_handler(struct work_struct *work)
+{
+	struct xpcie *xpcie = container_of(work, struct xpcie, tx_event.work);
+	struct xpcie_dev *xdev = container_of(xpcie, struct xpcie_dev, xpcie);
+	struct xpcie_stream *tx = &xpcie->tx;
+	struct xpcie_transfer_desc *td;
+	u32 head, tail, old, ndesc;
+	struct xpcie_buf_desc *bd;
+	size_t bytes, buffers;
+	u16 status;
+
+	if (intel_xpcie_get_device_status(xpcie) != XPCIE_STATUS_RUN)
+		return;
+
+	ndesc = tx->pipe.ndesc;
+	old = tx->pipe.old;
+	tail = intel_xpcie_get_tdr_tail(&tx->pipe);
+	head = intel_xpcie_get_tdr_head(&tx->pipe);
+
+	/* clean old entries first */
+	while (old != head) {
+		bd = tx->ddr[old];
+		td = tx->pipe.tdr + old;
+		status = intel_xpcie_get_td_status(td);
+		if (status != XPCIE_DESC_STATUS_SUCCESS)
+			dev_err(xpcie_to_dev(xpcie),
+				"detected tx desc failure (%u)\n", status);
+
+		intel_xpcie_unmap_dma(xpcie, bd, DMA_TO_DEVICE);
+		intel_xpcie_free_tx_bd(xpcie, bd);
+		tx->ddr[old] = NULL;
+		old = XPCIE_CIRCULAR_INC(old, ndesc);
+	}
+	tx->pipe.old = old;
+
+	/* add new entries */
+	while (XPCIE_CIRCULAR_INC(tail, ndesc) != head) {
+		bd = intel_xpcie_list_get(&xpcie->write);
+		if (!bd)
+			break;
+
+		td = tx->pipe.tdr + tail;
+
+		if (intel_xpcie_map_dma(xpcie, bd, DMA_TO_DEVICE)) {
+			dev_err(xpcie_to_dev(xpcie),
+				"dma mapping error bd addr %p, size %zu\n",
+				bd->data, bd->length);
+			break;
+		}
+
+		tx->ddr[tail] = bd;
+		intel_xpcie_set_td_address(td, bd->phys);
+		intel_xpcie_set_td_length(td, bd->length);
+		intel_xpcie_set_td_interface(td, bd->interface);
+		intel_xpcie_set_td_status(td, XPCIE_DESC_STATUS_ERROR);
+
+		tail = XPCIE_CIRCULAR_INC(tail, ndesc);
+	}
+
+	if (intel_xpcie_get_tdr_tail(&tx->pipe) != tail) {
+		intel_xpcie_set_tdr_tail(&tx->pipe, tail);
+		intel_xpcie_pci_raise_irq(xdev, DATA_SENT, 1);
+	}
+
+	intel_xpcie_list_info(&xpcie->write, &bytes, &buffers);
+	if (buffers)
+		xpcie->tx_pending = true;
+	else
+		xpcie->tx_pending = false;
+}
+
+static irqreturn_t intel_xpcie_interrupt(int irq, void *args)
+{
+	struct xpcie_dev *xdev = args;
+	struct xpcie *xpcie;
+
+	xpcie = &xdev->xpcie;
+
+	if (intel_xpcie_get_doorbell(xpcie, FROM_DEVICE, DATA_SENT)) {
+		intel_xpcie_set_doorbell(xpcie, FROM_DEVICE, DATA_SENT, 0);
+		intel_xpcie_start_rx(xpcie, 0);
+	}
+	if (intel_xpcie_get_doorbell(xpcie, FROM_DEVICE, DATA_RECEIVED)) {
+		intel_xpcie_set_doorbell(xpcie, FROM_DEVICE, DATA_RECEIVED, 0);
+		if (xpcie->tx_pending)
+			intel_xpcie_start_tx(xpcie, 0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int intel_xpcie_events_init(struct xpcie *xpcie)
+{
+	xpcie->rx_wq = alloc_ordered_workqueue(XPCIE_DRIVER_NAME,
+					       WQ_MEM_RECLAIM | WQ_HIGHPRI);
+	if (!xpcie->rx_wq) {
+		dev_err(xpcie_to_dev(xpcie), "failed to allocate workqueue\n");
+		return -ENOMEM;
+	}
+
+	xpcie->tx_wq = alloc_ordered_workqueue(XPCIE_DRIVER_NAME,
+					       WQ_MEM_RECLAIM | WQ_HIGHPRI);
+	if (!xpcie->tx_wq) {
+		dev_err(xpcie_to_dev(xpcie), "failed to allocate workqueue\n");
+		destroy_workqueue(xpcie->rx_wq);
+		return -ENOMEM;
+	}
+
+	INIT_DELAYED_WORK(&xpcie->rx_event, intel_xpcie_rx_event_handler);
+	INIT_DELAYED_WORK(&xpcie->tx_event, intel_xpcie_tx_event_handler);
+
+	return 0;
+}
+
+static void intel_xpcie_events_cleanup(struct xpcie *xpcie)
+{
+	cancel_delayed_work_sync(&xpcie->rx_event);
+	cancel_delayed_work_sync(&xpcie->tx_event);
+
+	destroy_workqueue(xpcie->rx_wq);
+	destroy_workqueue(xpcie->tx_wq);
+}
+
+int intel_xpcie_core_init(struct xpcie *xpcie)
+{
+	struct xpcie_dev *xdev = container_of(xpcie, struct xpcie_dev, xpcie);
+	int status, rc;
+
+	status = intel_xpcie_get_device_status(xpcie);
+	if (status != XPCIE_STATUS_RUN) {
+		dev_err(&xdev->pci->dev,
+			"device status not RUNNING (%d)\n", status);
+		rc = -EBUSY;
+		return rc;
+	}
+
+	intel_xpcie_version_check(xpcie);
+
+	rc = intel_xpcie_events_init(xpcie);
+	if (rc)
+		return rc;
+
+	rc = intel_xpcie_discover_txrx(xpcie);
+	if (rc)
+		goto error_txrx;
+
+	intel_xpcie_interfaces_init(xpcie);
+
+	rc = intel_xpcie_pci_register_irq(xdev, &intel_xpcie_interrupt);
+	if (rc)
+		goto error_txrx;
+
+	intel_xpcie_set_host_status(xpcie, XPCIE_STATUS_RUN);
+
+	return 0;
+
+error_txrx:
+	intel_xpcie_events_cleanup(xpcie);
+	intel_xpcie_set_host_status(xpcie, XPCIE_STATUS_ERROR);
+
+	return rc;
+}
+
+void intel_xpcie_core_cleanup(struct xpcie *xpcie)
+{
+	if (xpcie->status == XPCIE_STATUS_RUN) {
+		intel_xpcie_set_host_status(xpcie, XPCIE_STATUS_UNINIT);
+		intel_xpcie_events_cleanup(xpcie);
+		intel_xpcie_interfaces_cleanup(xpcie);
+		intel_xpcie_txrx_cleanup(xpcie);
+	}
+}
+
+int intel_xpcie_core_read(struct xpcie *xpcie, void *buffer, size_t *length,
+			  uint32_t timeout_ms)
+{
+	long jiffies_timeout = (long)msecs_to_jiffies(timeout_ms);
+	struct xpcie_interface *inf = &xpcie->interfaces[0];
+	unsigned long jiffies_start = jiffies;
+	struct xpcie_buf_desc *bd;
+	size_t remaining, len;
+	long jiffies_passed = 0;
+	int ret;
+
+	if (*length == 0)
+		return -EINVAL;
+
+	if (xpcie->status != XPCIE_STATUS_RUN)
+		return -ENODEV;
+
+	len = *length;
+	remaining = len;
+	*length = 0;
+
+	ret = mutex_lock_interruptible(&inf->rlock);
+	if (ret < 0)
+		return -EINTR;
+
+	do {
+		while (!inf->data_avail) {
+			mutex_unlock(&inf->rlock);
+			if (timeout_ms == 0) {
+				ret = wait_event_interruptible(inf->rx_waitq,
+							       inf->data_avail);
+			} else {
+				ret =
+			wait_event_interruptible_timeout(inf->rx_waitq,
+							 inf->data_avail,
+							 jiffies_timeout -
+							 jiffies_passed);
+				if (ret == 0)
+					return -ETIME;
+			}
+			if (ret < 0 || xpcie->stop_flag)
+				return -EINTR;
+
+			ret = mutex_lock_interruptible(&inf->rlock);
+			if (ret < 0)
+				return -EINTR;
+		}
+
+		bd = (inf->partial_read) ? inf->partial_read :
+					   intel_xpcie_list_get(&inf->read);
+		while (remaining && bd) {
+			size_t bcopy;
+
+			bcopy = min(remaining, bd->length);
+			memcpy(buffer, bd->data, bcopy);
+
+			buffer += bcopy;
+			remaining -= bcopy;
+			bd->data += bcopy;
+			bd->length -= bcopy;
+
+			if (bd->length == 0) {
+				intel_xpcie_free_rx_bd(xpcie, bd);
+				bd = intel_xpcie_list_get(&inf->read);
+			}
+		}
+
+		/* save for next time */
+		inf->partial_read = bd;
+
+		if (!bd)
+			inf->data_avail = false;
+
+		*length = len - remaining;
+
+		jiffies_passed = (long)jiffies - (long)jiffies_start;
+	} while (remaining > 0 && (jiffies_passed < jiffies_timeout ||
+				   timeout_ms == 0));
+
+	mutex_unlock(&inf->rlock);
+
+	return 0;
+}
+
+int intel_xpcie_core_write(struct xpcie *xpcie, void *buffer, size_t *length,
+			   uint32_t timeout_ms)
+{
+	long jiffies_timeout = (long)msecs_to_jiffies(timeout_ms);
+	struct xpcie_interface *inf = &xpcie->interfaces[0];
+	unsigned long jiffies_start = jiffies;
+	struct xpcie_buf_desc *bd, *head;
+	long jiffies_passed = 0;
+	size_t remaining, len;
+	int ret;
+
+	if (*length == 0)
+		return -EINVAL;
+
+	if (xpcie->status != XPCIE_STATUS_RUN)
+		return -ENODEV;
+
+	len = *length;
+	remaining = len;
+	*length = 0;
+
+	ret = mutex_lock_interruptible(&xpcie->wlock);
+	if (ret < 0)
+		return -EINTR;
+
+	do {
+		bd = intel_xpcie_alloc_tx_bd(xpcie);
+		head = bd;
+		while (!head) {
+			mutex_unlock(&xpcie->wlock);
+			if (timeout_ms == 0) {
+				ret =
+				wait_event_interruptible(xpcie->tx_waitq,
+							 !xpcie->no_tx_buffer);
+			} else {
+				ret =
+			wait_event_interruptible_timeout(xpcie->tx_waitq,
+							 !xpcie->no_tx_buffer,
+							 jiffies_timeout -
+							 jiffies_passed);
+				if (ret == 0)
+					return -ETIME;
+			}
+			if (ret < 0 || xpcie->stop_flag)
+				return -EINTR;
+
+			ret = mutex_lock_interruptible(&xpcie->wlock);
+			if (ret < 0)
+				return -EINTR;
+
+			bd = intel_xpcie_alloc_tx_bd(xpcie);
+			head = bd;
+		}
+
+		while (remaining && bd) {
+			size_t bcopy;
+
+			bcopy = min(bd->length, remaining);
+			memcpy(bd->data, buffer, bcopy);
+
+			buffer += bcopy;
+			remaining -= bcopy;
+			bd->length = bcopy;
+			bd->interface = inf->id;
+
+			if (remaining) {
+				bd->next = intel_xpcie_alloc_tx_bd(xpcie);
+				bd = bd->next;
+			}
+		}
+
+		intel_xpcie_list_put(&xpcie->write, head);
+		intel_xpcie_start_tx(xpcie, 0);
+
+		*length = len - remaining;
+
+		jiffies_passed = (long)jiffies - (long)jiffies_start;
+	} while (remaining > 0 && (jiffies_passed < jiffies_timeout ||
+				   timeout_ms == 0));
+
+	mutex_unlock(&xpcie->wlock);
+
+	return 0;
+}
diff --git a/drivers/misc/xlink-pcie/remote_host/pci.c b/drivers/misc/xlink-pcie/remote_host/pci.c
index 0ca0755b591f..f92a78f41324 100644
--- a/drivers/misc/xlink-pcie/remote_host/pci.c
+++ b/drivers/misc/xlink-pcie/remote_host/pci.c
@@ -208,10 +208,8 @@ static void xpcie_device_poll(struct work_struct *work)
 {
 	struct xpcie_dev *xdev = container_of(work, struct xpcie_dev,
 					      wait_event.work);
-	u32 dev_status = intel_xpcie_ioread32(xdev->xpcie.mmio +
-					      XPCIE_MMIO_DEV_STATUS);
 
-	if (dev_status < XPCIE_STATUS_RUN)
+	if (intel_xpcie_get_device_status(&xdev->xpcie) < XPCIE_STATUS_RUN)
 		schedule_delayed_work(&xdev->wait_event,
 				      msecs_to_jiffies(100));
 	else
@@ -224,9 +222,10 @@ static int intel_xpcie_pci_prepare_dev_reset(struct xpcie_dev *xdev,
 	if (mutex_lock_interruptible(&xdev->lock))
 		return -EINTR;
 
-	if (xdev->core_irq_callback)
+	if (xdev->core_irq_callback) {
 		xdev->core_irq_callback = NULL;
-
+		intel_xpcie_core_cleanup(&xdev->xpcie);
+	}
 	xdev->xpcie.status = XPCIE_STATUS_OFF;
 	if (notify)
 		intel_xpcie_pci_raise_irq(xdev, DEV_EVENT, REQUEST_RESET);
@@ -326,6 +325,8 @@ int intel_xpcie_pci_cleanup(struct xpcie_dev *xdev)
 	xdev->core_irq_callback = NULL;
 	intel_xpcie_pci_irq_cleanup(xdev);
 
+	intel_xpcie_core_cleanup(&xdev->xpcie);
+
 	intel_xpcie_pci_unmap_bar(xdev);
 	pci_release_regions(xdev->pci);
 	pci_disable_device(xdev->pci);
@@ -359,6 +360,7 @@ int intel_xpcie_pci_raise_irq(struct xpcie_dev *xdev,
 {
 	u16 pci_status;
 
+	intel_xpcie_set_doorbell(&xdev->xpcie, TO_DEVICE, type, value);
 	pci_read_config_word(xdev->pci, PCI_STATUS, &pci_status);
 
 	return 0;
@@ -445,7 +447,43 @@ int intel_xpcie_pci_connect_device(u32 id)
 		goto connect_cleanup;
 	}
 
+	rc = intel_xpcie_core_init(&xdev->xpcie);
+	if (rc < 0) {
+		dev_err(&xdev->pci->dev, "failed to sync with device\n");
+		goto connect_cleanup;
+	}
+
 connect_cleanup:
 	mutex_unlock(&xdev->lock);
 	return rc;
 }
+
+int intel_xpcie_pci_read(u32 id, void *data, size_t *size, u32 timeout)
+{
+	struct xpcie_dev *xdev = intel_xpcie_get_device_by_id(id);
+
+	if (!xdev)
+		return -ENODEV;
+
+	return intel_xpcie_core_read(&xdev->xpcie, data, size, timeout);
+}
+
+int intel_xpcie_pci_write(u32 id, void *data, size_t *size, u32 timeout)
+{
+	struct xpcie_dev *xdev = intel_xpcie_get_device_by_id(id);
+
+	if (!xdev)
+		return -ENODEV;
+
+	return intel_xpcie_core_write(&xdev->xpcie, data, size, timeout);
+}
+
+int intel_xpcie_pci_reset_device(u32 id)
+{
+	struct xpcie_dev *xdev = intel_xpcie_get_device_by_id(id);
+
+	if (!xdev)
+		return -ENOMEM;
+
+	return intel_xpcie_pci_prepare_dev_reset(xdev, true);
+}
-- 
2.17.1

