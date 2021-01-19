Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D62FB74D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbhASKef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbhASKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:13:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:12:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 203so25042414ybz.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2Ry9b7PtA4XQ5tGK+lflCi58DS41JyI68UEiY/MK3Ds=;
        b=cnFbPV80yOCeyup7xQRxOgXGUBs0iWMzq0qncOfhs3tvvyrmV1rpNaMhzqBEkjnN5Z
         hJv09lyBgNd3H8798JqmZbkwh8o3WiNE7RVsNH1K9tBP+jZqvOLdKhU2rRQ64CtBmV5R
         vn/L9bGrLVdPjwNjG5kPeHw38yKXJSXr/sAPi/4nC8YEglUOChfzmMZa2sIcWeiNEuCC
         5n/tvMX74+bzMaoBaxwnBBbZ2M6AF8Y+DwZC14ONLY/pyj4aW+6aQUGm5mJfreRzFBRN
         TnHd7kq061IM0svU1TBHLmJ4+eTybyacvaHI0PTbbC5/FiVXSp84sMaRAiBFRt9ehBxe
         /7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Ry9b7PtA4XQ5tGK+lflCi58DS41JyI68UEiY/MK3Ds=;
        b=CN0tlLBkiKKbScCTUe3LjDqhLAYUvCMr2Ohz8lLHbk6bJZQK79RUnFfLhWiQIAylwK
         JHNhaF8OgcuDokJpvpPw++vzwHIKNlhJMZH5pxxF+zQ4wbkFcRTO2n/N6w7j+ob49o5I
         KT1QqIofX+2xNfOPT28eOrHAvlWay+KB3YKr/BF1dB8IQiMPY/n6YJ95Bi+4UXSAktB2
         sdCklpw48WVSrNzP5AWWTV+tPrt3XXHLMnlUjl6T/d2cXA6oJN5eSJw5JZRLtK/SemXE
         pMrTVtG+FclnFpFgcTkui0O8xggL14uNWLINAL725U2rK7jr0s81ws3zhoKSsiDMdbbH
         ymQw==
X-Gm-Message-State: AOAM530T0v3TG9hlc9Dh3vfRZ6RNjPLuszO/ibY1c5cbvWPa1PulD9/L
        FIWil58s108m1eKBQUtTy+lX6yhgJ+7Z+w0=
X-Google-Smtp-Source: ABdhPJw7Q1ASPWCvGQesEVdQ7hNvLOji+JPX3fFf+dROtis8dHQT15Ks89gaAljRyJc8hIiNK7WU3AtAYJrRFwY=
Sender: "howardyen via sendgmr" <howardyen@howardyen.ntc.corp.google.com>
X-Received: from howardyen.ntc.corp.google.com ([2401:fa00:fc:202:5d06:ba6f:6a89:a201])
 (user=howardyen job=sendgmr) by 2002:a25:bbc3:: with SMTP id
 c3mr4790995ybk.345.1611051140130; Tue, 19 Jan 2021 02:12:20 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:10:41 +0800
In-Reply-To: <20210119101044.1637023-1-howardyen@google.com>
Message-Id: <20210119101044.1637023-2-howardyen@google.com>
Mime-Version: 1.0
References: <20210119101044.1637023-1-howardyen@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/4] usb: host: add xhci hooks for USB offload
From:   Howard Yen <howardyen@google.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable supporting for USB offload, define "offload" in usb controller
node of device tree. "offload" value can be used to determine which type
of offload was been enabled in the SoC.

For example:

&usbdrd_dwc3 {
	...
	/* support usb offloading, 0: disabled, 1: audio */
	offload = <1>;
	...
};

There are several vendor_ops introduced by this patch:

struct xhci_vendor_ops - function callbacks for vendor specific operations
{
	@vendor_init:
		- called for vendor init process during xhci-plat-hcd
		  probe.
	@vendor_cleanup:
		- called for vendor cleanup process during xhci-plat-hcd
		  remove.
	@is_usb_offload_enabled:
		- called to check if usb offload enabled.
	@queue_irq_work:
		- called to queue vendor specific irq work.
	@alloc_dcbaa:
		- called when allocating vendor specific dcbaa during
		  memory initializtion.
	@free_dcbaa:
		- called to free vendor specific dcbaa when cleanup the
		  memory.
	@alloc_transfer_ring:
		- called when vendor specific transfer ring allocation is required
	@free_transfer_ring:
		- called to free vendor specific transfer ring
	@sync_dev_ctx:
		- called when synchronization for device context is required
}

The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_vendor_ops.
For example, vendor_init ops will be invoked by xhci_vendor_init() hook,
is_usb_offload_enabled ops will be invoked by
xhci_vendor_is_usb_offload_enabled(), and so on.

Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-hub.c  |  5 ++
 drivers/usb/host/xhci-mem.c  | 96 +++++++++++++++++++++++++++++++-----
 drivers/usb/host/xhci-plat.c | 25 +++++++++-
 drivers/usb/host/xhci-plat.h |  2 +
 drivers/usb/host/xhci-ring.c | 13 +++++
 drivers/usb/host/xhci.c      | 89 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h      | 38 ++++++++++++++
 7 files changed, 254 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index f37316d2c8fa..0eda5bb23ed8 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -448,8 +448,13 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 	    cmd->status == COMP_COMMAND_RING_STOPPED) {
 		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
 		ret = -ETIME;
+		goto cmd_cleanup;
 	}
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
+	if (ret)
+		xhci_warn(xhci, "Sync device context failed, ret=%d\n", ret);
+
 cmd_cleanup:
 	xhci_free_command(xhci, cmd);
 	return ret;
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 9764122c9cdf..f3dbc5956290 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -352,6 +352,37 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	return 0;
 }
 
+static struct xhci_ring *xhci_vendor_alloc_transfer_ring(struct xhci_hcd *xhci,
+		u32 endpoint_type, enum xhci_ring_type ring_type,
+		gfp_t mem_flags)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->alloc_transfer_ring)
+		return ops->alloc_transfer_ring(xhci, endpoint_type, ring_type,
+						mem_flags);
+	return 0;
+}
+
+static void xhci_vendor_free_transfer_ring(struct xhci_hcd *xhci,
+		struct xhci_virt_device *virt_dev, unsigned int ep_index)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->free_transfer_ring)
+		ops->free_transfer_ring(xhci, virt_dev, ep_index);
+}
+
+static bool xhci_vendor_is_usb_offload_enabled(struct xhci_hcd *xhci,
+		struct xhci_virt_device *virt_dev, unsigned int ep_index)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->is_usb_offload_enabled)
+		return ops->is_usb_offload_enabled(xhci, virt_dev, ep_index);
+	return false;
+}
+
 /**
  * Create a new ring with zero or more segments.
  *
@@ -403,7 +434,11 @@ void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index)
 {
-	xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, ep_index))
+		xhci_vendor_free_transfer_ring(xhci, virt_dev, ep_index);
+	else
+		xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
+
 	virt_dev->eps[ep_index].ring = NULL;
 }
 
@@ -897,7 +932,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	for (i = 0; i < 31; i++) {
 		if (dev->eps[i].ring)
-			xhci_ring_free(xhci, dev->eps[i].ring);
+			xhci_free_endpoint_ring(xhci, dev, i);
 		if (dev->eps[i].stream_info)
 			xhci_free_stream_info(xhci,
 					dev->eps[i].stream_info);
@@ -1492,8 +1527,15 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 		mult = 0;
 
 	/* Set up the endpoint ring */
-	virt_dev->eps[ep_index].new_ring =
-		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, ep_index) &&
+	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		virt_dev->eps[ep_index].new_ring =
+			xhci_vendor_alloc_transfer_ring(xhci, endpoint_type, ring_type, mem_flags);
+	} else {
+		virt_dev->eps[ep_index].new_ring =
+			xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
+	}
+
 	if (!virt_dev->eps[ep_index].new_ring)
 		return -ENOMEM;
 
@@ -1837,6 +1879,24 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 	erst->entries = NULL;
 }
 
+static struct xhci_device_context_array *xhci_vendor_alloc_dcbaa(
+		struct xhci_hcd *xhci, gfp_t flags)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->alloc_dcbaa)
+		return ops->alloc_dcbaa(xhci, flags);
+	return 0;
+}
+
+static void xhci_vendor_free_dcbaa(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->free_dcbaa)
+		ops->free_dcbaa(xhci);
+}
+
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
 	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
@@ -1891,9 +1951,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Freed medium stream array pool");
 
-	if (xhci->dcbaa)
-		dma_free_coherent(dev, sizeof(*xhci->dcbaa),
-				xhci->dcbaa, xhci->dcbaa->dma);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0)) {
+		xhci_vendor_free_dcbaa(xhci);
+	} else {
+		if (xhci->dcbaa)
+			dma_free_coherent(dev, sizeof(*xhci->dcbaa),
+					xhci->dcbaa, xhci->dcbaa->dma);
+	}
 	xhci->dcbaa = NULL;
 
 	scratchpad_free(xhci);
@@ -2420,15 +2484,21 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * xHCI section 5.4.6 - doorbell array must be
 	 * "physically contiguous and 64-byte (cache line) aligned".
 	 */
-	xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
-			flags);
-	if (!xhci->dcbaa)
-		goto fail;
-	xhci->dcbaa->dma = dma;
+	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0)) {
+		xhci->dcbaa = xhci_vendor_alloc_dcbaa(xhci, flags);
+		if (!xhci->dcbaa)
+			goto fail;
+	} else {
+		xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
+				flags);
+		if (!xhci->dcbaa)
+			goto fail;
+		xhci->dcbaa->dma = dma;
+	}
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"// Device context base array address = 0x%llx (DMA), %p (virt)",
 			(unsigned long long)xhci->dcbaa->dma, xhci->dcbaa);
-	xhci_write_64(xhci, dma, &xhci->op_regs->dcbaa_ptr);
+	xhci_write_64(xhci, xhci->dcbaa->dma, &xhci->op_regs->dcbaa_ptr);
 
 	/*
 	 * Initialize the ring segment pool.  The ring must be a contiguous
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index f6b4089bfc4a..5f8e69089654 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -163,6 +163,23 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+static int xhci_vendor_init(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->vendor_init)
+		return ops->vendor_init(xhci);
+	return 0;
+}
+
+static void xhci_vendor_cleanup(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->vendor_cleanup)
+		ops->vendor_cleanup(xhci);
+}
+
 static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct xhci_plat_priv *priv_match;
@@ -314,6 +331,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto put_usb3_hcd;
 	}
 
+	ret = xhci_vendor_init(xhci);
+	if (ret)
+		goto disable_usb_phy;
+
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 	xhci->shared_hcd->tpl_support = hcd->tpl_support;
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
@@ -380,8 +401,10 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_phy_shutdown(hcd->usb_phy);
 
 	usb_remove_hcd(hcd);
-	usb_put_hcd(shared_hcd);
 
+	xhci_vendor_cleanup(xhci);
+
+	usb_put_hcd(shared_hcd);
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index b49f6447bd3a..2b2d090c4c01 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -13,6 +13,8 @@
 struct xhci_plat_priv {
 	const char *firmware_name;
 	unsigned long long quirks;
+	struct xhci_vendor_ops *vendor_ops;
+	struct xhci_vendor_data *vendor_data;
 	void (*plat_start)(struct usb_hcd *);
 	int (*init_quirk)(struct usb_hcd *);
 	int (*resume_quirk)(struct usb_hcd *);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 2c255d0620b0..bfd653a1e5f6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2823,6 +2823,15 @@ static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 	xhci_write_64(xhci, temp_64, &xhci->ir_set->erst_dequeue);
 }
 
+static irqreturn_t xhci_vendor_queue_irq_work(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->queue_irq_work)
+		return ops->queue_irq_work(xhci);
+	return IRQ_NONE;
+}
+
 /*
  * xHCI spec says we can get an interrupt, and if the HC has an error condition,
  * we might get bad data out of the event ring.  Section 4.10.2.7 has a list of
@@ -2857,6 +2866,10 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		goto out;
 	}
 
+	ret = xhci_vendor_queue_irq_work(xhci);
+	if (ret == IRQ_HANDLED)
+		goto out;
+
 	/*
 	 * Clear the op reg interrupt status first,
 	 * so we can receive interrupts from other MSI-X interrupters.
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bee5deccc83d..59e1b8813ca4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -23,6 +23,7 @@
 #include "xhci-mtk.h"
 #include "xhci-debugfs.h"
 #include "xhci-dbgcap.h"
+#include "xhci-plat.h"
 
 #define DRIVER_AUTHOR "Sarah Sharp"
 #define DRIVER_DESC "'eXtensible' Host Controller (xHC) Driver"
@@ -1482,6 +1483,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		return -ENODEV;
 	}
 
+	if (xhci_vendor_usb_offload_skip_urb(xhci, urb)) {
+		xhci_dbg(xhci, "skip urb for usb offload\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
 		num_tds = urb->number_of_packets;
 	else if (usb_endpoint_is_bulk_out(&urb->ep->desc) &&
@@ -2832,6 +2838,14 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 			xhci_finish_resource_reservation(xhci, ctrl_ctx);
 		spin_unlock_irqrestore(&xhci->lock, flags);
 	}
+	if (ret)
+		goto failed;
+
+	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (ret)
+		xhci_warn(xhci, "sync device context failed, ret=%d", ret);
+
+failed:
 	return ret;
 }
 
@@ -3212,6 +3226,13 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(stop_cmd->completion);
 
+	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (err) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, err);
+		goto cleanup;
+	}
+
 	spin_lock_irqsave(&xhci->lock, flags);
 
 	/* config ep command clears toggle if add and drop ep flags are set */
@@ -3235,6 +3256,11 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(cfg_cmd->completion);
 
+	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (err)
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, err);
+
 	ep->ep_state &= ~EP_SOFT_CLEAR_TOGGLE;
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
@@ -3773,6 +3799,13 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 	/* Wait for the Reset Device command to finish */
 	wait_for_completion(reset_device_cmd->completion);
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		goto command_cleanup;
+	}
+
 	/* The Reset Device command can't fail, according to the 0.95/0.96 spec,
 	 * unless we tried to reset a slot ID that wasn't enabled,
 	 * or the device wasn't in the addressed or configured state.
@@ -4012,6 +4045,14 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 		xhci_warn(xhci, "Could not allocate xHCI USB device data structures\n");
 		goto disable_slot;
 	}
+
+	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		goto disable_slot;
+	}
+
 	vdev = xhci->devs[slot_id];
 	slot_ctx = xhci_get_slot_ctx(xhci, vdev->out_ctx);
 	trace_xhci_alloc_dev(slot_ctx);
@@ -4145,6 +4186,13 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	/* ctrl tx can take up to 5 sec; XXX: need more time for xHC? */
 	wait_for_completion(command->completion);
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		goto out;
+	}
+
 	/* FIXME: From section 4.3.4: "Software shall be responsible for timing
 	 * the SetAddress() "recovery interval" required by USB and aborting the
 	 * command on a timeout.
@@ -4291,6 +4339,14 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
 		return -ENOMEM;
 	}
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (ret) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		return ret;
+	}
+
 	xhci_slot_copy(xhci, command->in_ctx, virt_dev->out_ctx);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
@@ -4315,6 +4371,30 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
 	return ret;
 }
 
+struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci)
+{
+	return xhci_to_priv(xhci)->vendor_ops;
+}
+EXPORT_SYMBOL_GPL(xhci_vendor_get_ops);
+
+int xhci_vendor_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->sync_dev_ctx)
+		return ops->sync_dev_ctx(xhci, slot_id);
+	return 0;
+}
+
+bool xhci_vendor_usb_offload_skip_urb(struct xhci_hcd *xhci, struct urb *urb)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->usb_offload_skip_urb)
+		return ops->usb_offload_skip_urb(xhci, urb);
+	return false;
+}
+
 #ifdef CONFIG_PM
 
 /* BESL to HIRD Encoding array for USB2 LPM */
@@ -5048,6 +5128,15 @@ static int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 		return -ENOMEM;
 	}
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, hdev->slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		xhci_free_command(xhci, config_cmd);
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		return ret;
+	}
+
 	xhci_slot_copy(xhci, config_cmd->in_ctx, vdev->out_ctx);
 	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
 	slot_ctx = xhci_get_slot_ctx(xhci, config_cmd->in_ctx);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2c6c4f8d1ee1..4b110590561b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2177,6 +2177,44 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
 					urb->stream_id);
 }
 
+/**
+ * struct xhci_vendor_ops - function callbacks for vendor specific operations
+ * @vendor_init: called for vendor init process
+ * @vendor_cleanup: called for vendor cleanup process
+ * @is_usb_offload_enabled: called to check if usb offload enabled
+ * @queue_irq_work: called to queue vendor specific irq work
+ * @alloc_dcbaa: called when allocating vendor specific dcbaa
+ * @free_dcbaa: called to free vendor specific dcbaa
+ * @alloc_transfer_ring: called when remote transfer ring allocation is required
+ * @free_transfer_ring: called to free vendor specific transfer ring
+ * @sync_dev_ctx: called when synchronization for device context is required
+ */
+struct xhci_vendor_ops {
+	int (*vendor_init)(struct xhci_hcd *xhci);
+	void (*vendor_cleanup)(struct xhci_hcd *xhci);
+	bool (*is_usb_offload_enabled)(struct xhci_hcd *xhci,
+				       struct xhci_virt_device *vdev,
+				       unsigned int ep_index);
+	irqreturn_t (*queue_irq_work)(struct xhci_hcd *xhci);
+
+	struct xhci_device_context_array *(*alloc_dcbaa)(struct xhci_hcd *xhci,
+							 gfp_t flags);
+	void (*free_dcbaa)(struct xhci_hcd *xhci);
+
+	struct xhci_ring *(*alloc_transfer_ring)(struct xhci_hcd *xhci,
+			u32 endpoint_type, enum xhci_ring_type ring_type,
+			gfp_t mem_flags);
+	void (*free_transfer_ring)(struct xhci_hcd *xhci,
+			struct xhci_virt_device *virt_dev, unsigned int ep_index);
+	int (*sync_dev_ctx)(struct xhci_hcd *xhci, unsigned int slot_id);
+	bool (*usb_offload_skip_urb)(struct xhci_hcd *xhci, struct urb *urb);
+};
+
+struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci);
+
+int xhci_vendor_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id);
+bool xhci_vendor_usb_offload_skip_urb(struct xhci_hcd *xhci, struct urb *urb);
+
 /*
  * TODO: As per spec Isochronous IDT transmissions are supported. We bypass
  * them anyways as we where unable to find a device that matches the
-- 
2.30.0.284.gd98b1dd5eaa7-goog

