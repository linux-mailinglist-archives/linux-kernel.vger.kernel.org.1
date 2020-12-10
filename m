Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493602D5893
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbgLJKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389072AbgLJKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:49:13 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59333C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:48:03 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s21so3656633pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxDpVAARfEVSt1KTbBHSjn6Mvlgn7UqejTHAGTRSspo=;
        b=e0Cc9TN/PzgddXD+j32xAn9Hd5lPs6ih2YNT0QELyaOAq9jgUrSDzrE9GZ4XbEKewq
         bmg7pP5O8m/woX5pr0xvW0cDLsdHSIWqwaQjKqrlAoOqYxMRwAsUTDkUOxkkvHPxJARG
         1fdRHuBmq1crdb0xdJL+hBOt90Z92GCTVhEfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxDpVAARfEVSt1KTbBHSjn6Mvlgn7UqejTHAGTRSspo=;
        b=od6ygZzAHA4p21ajoiRN7gbLShbrrLzZJNnpRJW13jXdiIbBRlqXiBqGKzCDtnMWlQ
         vYw9TFEpCiypTYdPhS3oniKucXwswIiPEXGGcp8SyTYFaYM/sdU+cN6Y4iaFpLHjKlHq
         3vC6ppe00dOyzZPXSY6Cu1N+7zieKMqcNxOPDa1rIEOhm4+lmEkwYZ1gv0/hoptLS7YA
         url0+TVKnNT4v4jbZY3aRnHqnqshBhsRn+IfZ0N0u2Ojkm/Y4016YVeTRIkWDBxnYbXh
         XzxdyFy7m4iqU1XjwQyHBnFUDI16dnPLof1B4ib8pVm3C++uj3iz/iFVAvxxFwCLZKH5
         NmuA==
X-Gm-Message-State: AOAM531cFfgfO+O+k5nynJ5zWljEUbsxloRj4jcTp5IzFywBfOL5nFCU
        CiD9+m1g0OwHXdGJOzNOlLLfOg==
X-Google-Smtp-Source: ABdhPJyE3B8cGkZZsQXvMrexeiP/exDN9gqSU+j8uRjRb2OTN5I4nWrtU/HlMXKYhMqKggsYsnQwlg==
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr7076161pjq.13.1607597282900;
        Thu, 10 Dec 2020 02:48:02 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id y1sm6386658pff.17.2020.12.10.02.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:48:02 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Cc:     Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb: xhci-mtk: fix unreleased bandwidth data
Date:   Thu, 10 Dec 2020 18:47:47 +0800
Message-Id: <20201210184700.v2.3.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210104747.3416781-1-ikjn@chromium.org>
References: <20201210104747.3416781-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci-mtk has hooks on add_endpoint() and drop_endpoint() from xhci
to handle its own sw bandwidth managements and stores bandwidth data
into internal table every time add_endpoint() is called,
so when bandwidth allocation fails at one endpoint, all earlier
allocation from the same interface could still remain at the table.

This patch adds two more hooks from check_bandwidth() and
reset_bandwidth(), and make mtk-xhci to releases all failed endpoints
from reset_bandwidth().

Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

Changes in v2:
- fix wrong offset in mediatek hw flags
- fix 0-day warnings

 drivers/usb/host/xhci-mtk-sch.c | 120 ++++++++++++++++++++++----------
 drivers/usb/host/xhci-mtk.h     |  13 ++++
 drivers/usb/host/xhci.c         |   9 +++
 3 files changed, 107 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 439391f1dc78..102d8e0a50f1 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -583,6 +583,8 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 
 	mtk->sch_array = sch_array;
 
+	INIT_LIST_HEAD(&mtk->bw_ep_list_new);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_mtk_sch_init);
@@ -597,16 +599,14 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		struct usb_host_endpoint *ep)
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
-	struct xhci_hcd *xhci;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_virt_device *virt_dev;
 	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep;
 	unsigned int ep_index;
-	int ret = 0;
 
-	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 	ep_index = xhci_get_endpoint_index(&ep->desc);
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
@@ -637,42 +637,37 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	setup_sch_info(udev, ep_ctx, sch_ep);
 
-	ret = check_sch_bw(udev, sch_bw, sch_ep);
-	if (ret) {
-		xhci_err(xhci, "Not enough bandwidth!\n");
-		if (is_fs_or_ls(udev->speed))
-			drop_tt(udev);
-
-		kfree(sch_ep);
-		return -ENOSPC;
-	}
+	list_add_tail(&sch_ep->endpoint, &mtk->bw_ep_list_new);
 
-	list_add_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_mtk_add_ep_quirk);
 
-	ep_ctx->reserved[0] |= cpu_to_le32(EP_BPKTS(sch_ep->pkts)
-		| EP_BCSCOUNT(sch_ep->cs_count) | EP_BBM(sch_ep->burst_mode));
-	ep_ctx->reserved[1] |= cpu_to_le32(EP_BOFFSET(sch_ep->offset)
-		| EP_BREPEAT(sch_ep->repeat));
+static void xhci_mtk_drop_ep(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
+			     struct mu3h_sch_ep_info *sch_ep)
+{
+	struct mu3h_sch_bw_info *sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
 
-	xhci_dbg(xhci, " PKTS:%x, CSCOUNT:%x, BM:%x, OFFSET:%x, REPEAT:%x\n",
-			sch_ep->pkts, sch_ep->cs_count, sch_ep->burst_mode,
-			sch_ep->offset, sch_ep->repeat);
+	update_bus_bw(sch_bw, sch_ep, 0);
+	list_del(&sch_ep->endpoint);
 
-	return 0;
+	if (sch_ep->sch_tt) {
+		list_del(&sch_ep->tt_endpoint);
+		drop_tt(udev);
+	}
+	kfree(sch_ep);
 }
-EXPORT_SYMBOL_GPL(xhci_mtk_add_ep_quirk);
 
 void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep)
+			    struct usb_host_endpoint *ep)
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
-	struct xhci_hcd *xhci;
-	struct xhci_slot_ctx *slot_ctx;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_virt_device *virt_dev;
+	struct xhci_slot_ctx *slot_ctx;
 	struct mu3h_sch_bw_info *sch_bw;
-	struct mu3h_sch_ep_info *sch_ep;
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
 
-	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 
@@ -686,17 +681,72 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	sch_bw = get_bw_info(mtk, udev, ep);
 
-	list_for_each_entry(sch_ep, &sch_bw->bw_ep_list, endpoint) {
+	list_for_each_entry_safe(sch_ep, tmp, &sch_bw->bw_ep_list, endpoint) {
 		if (sch_ep->ep == ep) {
-			update_bus_bw(sch_bw, sch_ep, 0);
-			list_del(&sch_ep->endpoint);
-			if (is_fs_or_ls(udev->speed)) {
-				list_del(&sch_ep->tt_endpoint);
-				drop_tt(udev);
-			}
-			kfree(sch_ep);
+			xhci_mtk_drop_ep(mtk, udev, sch_ep);
 			break;
 		}
 	}
 }
 EXPORT_SYMBOL_GPL(xhci_mtk_drop_ep_quirk);
+
+int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
+{
+	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_virt_device *virt_dev = xhci->devs[udev->slot_id];
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
+
+	dev_dbg(&udev->dev, "%s\n", __func__);
+
+	list_for_each_entry(sch_ep, &mtk->bw_ep_list_new, endpoint) {
+		int ret;
+		struct mu3h_sch_bw_info *sch_bw;
+
+		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
+
+		ret = check_sch_bw(udev, sch_bw, sch_ep);
+		if (ret) {
+			xhci_err(xhci, "Not enough bandwidth!\n");
+			return ret;
+		}
+	}
+
+	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_list_new, endpoint) {
+		struct mu3h_sch_bw_info *sch_bw;
+		struct xhci_ep_ctx *ep_ctx;
+		struct usb_host_endpoint *ep = sch_ep->ep;
+		unsigned int ep_index = xhci_get_endpoint_index(&ep->desc);
+
+		sch_bw = get_bw_info(mtk, udev, ep);
+
+		list_move_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
+
+		ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
+		ep_ctx->reserved[0] |= cpu_to_le32(EP_BPKTS(sch_ep->pkts)
+			| EP_BCSCOUNT(sch_ep->cs_count)
+			| EP_BBM(sch_ep->burst_mode));
+		ep_ctx->reserved[1] |= cpu_to_le32(EP_BOFFSET(sch_ep->offset)
+			| EP_BREPEAT(sch_ep->repeat));
+
+		xhci_dbg(xhci, " PKTS:%x, CSCOUNT:%x, BM:%x, OFFSET:%x, REPEAT:%x\n",
+			sch_ep->pkts, sch_ep->cs_count, sch_ep->burst_mode,
+			sch_ep->offset, sch_ep->repeat);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_mtk_check_bandwidth);
+
+void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
+{
+	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
+
+	dev_dbg(&udev->dev, "%s\n", __func__);
+
+	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_list_new, endpoint) {
+		xhci_mtk_drop_ep(mtk, udev, sch_ep);
+	}
+}
+EXPORT_SYMBOL_GPL(xhci_mtk_reset_bandwidth);
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 8be8c5f7ff62..05ca989985fc 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -130,6 +130,7 @@ struct mu3c_ippc_regs {
 struct xhci_hcd_mtk {
 	struct device *dev;
 	struct usb_hcd *hcd;
+	struct list_head bw_ep_list_new;
 	struct mu3h_sch_bw_info *sch_array;
 	struct mu3c_ippc_regs __iomem *ippc_regs;
 	bool has_ippc;
@@ -165,6 +166,8 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		struct usb_host_endpoint *ep);
 void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		struct usb_host_endpoint *ep);
+int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
+void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 
 #else
 static inline int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd,
@@ -178,6 +181,16 @@ static inline void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd,
 {
 }
 
+static inline int xhci_mtk_check_bandwidth(struct usb_hcd *hcd,
+		struct usb_device *udev)
+{
+	return 0;
+}
+
+static inline void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd,
+		struct usb_device *udev)
+{
+}
 #endif
 
 #endif		/* _XHCI_MTK_H_ */
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 2bf6c526ac7a..5a9e01b33688 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2854,6 +2854,12 @@ static int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_dbg(xhci, "%s called for udev %p\n", __func__, udev);
 	virt_dev = xhci->devs[udev->slot_id];
 
+	if (xhci->quirks & XHCI_MTK_HOST) {
+		ret = xhci_mtk_check_bandwidth(hcd, udev);
+		if (ret < 0)
+			return ret;
+	}
+
 	command = xhci_alloc_command(xhci, true, GFP_KERNEL);
 	if (!command)
 		return -ENOMEM;
@@ -2941,6 +2947,9 @@ static void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 		return;
 	xhci = hcd_to_xhci(hcd);
 
+	if (xhci->quirks & XHCI_MTK_HOST)
+		xhci_mtk_reset_bandwidth(hcd, udev);
+
 	xhci_dbg(xhci, "%s called for udev %p\n", __func__, udev);
 	virt_dev = xhci->devs[udev->slot_id];
 	/* Free any rings allocated for added endpoints */
-- 
2.29.2.576.ga3fc446d84-goog

