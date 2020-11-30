Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3C2C7DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 06:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgK3FjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 00:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgK3FjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 00:39:05 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D29C0613D2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 21:38:25 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so5873495plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 21:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL7W7bxKclVcfCXYnw5M6huk4HO8ZkeYKEzmyZo3kWE=;
        b=CfgzZOpXHzWGN8X6YMIbpQ73T0/Qdc36DG/3osi3B2rIOjY1I6gRCXMuBFXQqT4t+7
         1OQL0oazZ4SUbcRz+zYG/W+xoaaBg37VyqrAp9rG3d58CJYUxT5gKpwpC7HaTJzmB9BR
         5vOklkXi5FNEaDDvB5ZI5DUexMioMGPraGU/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL7W7bxKclVcfCXYnw5M6huk4HO8ZkeYKEzmyZo3kWE=;
        b=lZfDfEAa3d29E3I+tqdYvXuXX8Y8Mpdgfr+VDxxlytH7EGOZ+hC6Tho2wpV8D1sVkY
         VHLJrcqv7+9y1JLSiFbfYhGLU/xEPJ8oZfdnLcCINjr0sTRzpEDOvS/t/Lzfq943ZjkS
         WkAEhppSUzPbTyNIoW1ISf7Pk9bykmNYuApHpdeOWcp7Unm9N84kZxQiBk8N7MyvPP5c
         +ujMgcS/rE4/nYr9RHnRrgLpIzS0Bd3Nrey1yAGqQjMxyk07gP/FPEEFx329y3bRYE0n
         KIdKbP+7+x+LOsTFo93dFey/TGrrfeVW+jmrRL3JiJ/YFoSJG8qgYrFWObW88R6SXIBE
         GIKQ==
X-Gm-Message-State: AOAM531JQoDfOGFriu+PQCvwr4IX802LA4pg3IyAquMfNCP+T1evldlw
        YxVcIAuKNmi776QVQUsaguKSSg==
X-Google-Smtp-Source: ABdhPJxY6znSmpUsdtMYd1Mth9p53BjWgZV+wg+irS6PgX3l8rgAQ8+rllSq74gMQWCA3tICvNwCgg==
X-Received: by 2002:a17:90a:f00f:: with SMTP id bt15mr6069033pjb.209.1606714704404;
        Sun, 29 Nov 2020 21:38:24 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id a17sm14442192pga.56.2020.11.29.21.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 21:38:23 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: xhci-mtk: fix unreleased bandwidth data
Date:   Mon, 30 Nov 2020 13:38:18 +0800
Message-Id: <20201130133405.1.I9b39c0765ef95f473b4b16b1f8c7714a1eed3842@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci-mtk has hooks on add_endpoint() and drop_endpoint() from xhci
to handle its own sw bandwidth managements and stores bandwidth data
into internal table every time add_endpoint() is called,
so when one endpoint's bandwidth allocation fails, all earlier
endpoints from same interface still remain at the table.

This patch adds two more hooks from check_bandwidth() and
reset_bandwidth(), so mtk-xhci can releases all remaining
allocations in reset_bandwidth().

Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/usb/host/xhci-mtk-sch.c | 163 ++++++++++++++++++++------------
 drivers/usb/host/xhci-mtk.h     |  13 +++
 drivers/usb/host/xhci.c         |   9 ++
 3 files changed, 123 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 45c54d56ecbd..6fdc7be29420 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -49,9 +49,11 @@ static int is_fs_or_ls(enum usb_device_speed speed)
 * so the bandwidth domain array is organized as follow for simplification:
 * SSport0-OUT, SSport0-IN, ..., SSportX-OUT, SSportX-IN, HSport0, ..., HSportY
 */
-static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
-	struct usb_host_endpoint *ep)
+static struct mu3h_sch_bw_info *get_bw_info(struct xhci_hcd_mtk *mtk,
+					     struct usb_device *udev,
+					     struct usb_host_endpoint *ep)
 {
+	struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
 	struct xhci_virt_device *virt_dev;
 	int bw_index;
 
@@ -67,7 +69,7 @@ static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
 		bw_index = virt_dev->real_port + xhci->usb3_rhub.num_ports - 1;
 	}
 
-	return bw_index;
+	return &mtk->sch_array[bw_index];
 }
 
 static u32 get_esit(struct xhci_ep_ctx *ep_ctx)
@@ -172,7 +174,6 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 	struct usb_host_endpoint *ep, struct xhci_ep_ctx *ep_ctx)
 {
 	struct mu3h_sch_ep_info *sch_ep;
-	struct mu3h_sch_tt *tt = NULL;
 	u32 len_bw_budget_table;
 	size_t mem_size;
 
@@ -190,15 +191,6 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 	if (!sch_ep)
 		return ERR_PTR(-ENOMEM);
 
-	if (is_fs_or_ls(udev->speed)) {
-		tt = find_tt(udev);
-		if (IS_ERR(tt)) {
-			kfree(sch_ep);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
-	sch_ep->sch_tt = tt;
 	sch_ep->ep = ep;
 
 	return sch_ep;
@@ -375,10 +367,10 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	}
 }
 
-static int check_sch_tt(struct usb_device *udev,
-	struct mu3h_sch_ep_info *sch_ep, u32 offset)
+static int check_sch_tt(struct mu3h_sch_tt *tt,
+			struct mu3h_sch_ep_info *sch_ep,
+			u32 offset)
 {
-	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 extra_cs_count;
 	u32 fs_budget_start;
 	u32 start_ss, last_ss;
@@ -448,10 +440,9 @@ static int check_sch_tt(struct usb_device *udev,
 	return 0;
 }
 
-static void update_sch_tt(struct usb_device *udev,
-	struct mu3h_sch_ep_info *sch_ep)
+static void update_sch_tt(struct mu3h_sch_tt *tt,
+			  struct mu3h_sch_ep_info *sch_ep)
 {
-	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 base, num_esit;
 	int i, j;
 
@@ -463,6 +454,7 @@ static void update_sch_tt(struct usb_device *udev,
 	}
 
 	list_add_tail(&sch_ep->tt_endpoint, &tt->ep_list);
+	sch_ep->sch_tt = tt;
 }
 
 static int check_sch_bw(struct usb_device *udev,
@@ -476,22 +468,28 @@ static int check_sch_bw(struct usb_device *udev,
 	u32 bw_boundary;
 	u32 min_num_budget;
 	u32 min_cs_count;
+	struct mu3h_sch_tt *tt = NULL;
 	bool tt_offset_ok = false;
 	int ret;
 
-	esit = sch_ep->esit;
+	if (is_fs_or_ls(udev->speed)) {
+		tt = find_tt(udev);
+		if (IS_ERR(tt))
+			return -ENOMEM;
+	}
 
 	/*
 	 * Search through all possible schedule microframes.
 	 * and find a microframe where its worst bandwidth is minimum.
 	 */
+	esit = sch_ep->esit;
 	min_bw = ~0;
 	min_index = 0;
 	min_cs_count = sch_ep->cs_count;
 	min_num_budget = sch_ep->num_budget_microframes;
 	for (offset = 0; offset < esit; offset++) {
 		if (is_fs_or_ls(udev->speed)) {
-			ret = check_sch_tt(udev, sch_ep, offset);
+			ret = check_sch_tt(tt, sch_ep, offset);
 			if (ret)
 				continue;
 			else
@@ -529,10 +527,11 @@ static int check_sch_bw(struct usb_device *udev,
 
 	if (is_fs_or_ls(udev->speed)) {
 		/* all offset for tt is not ok*/
-		if (!tt_offset_ok)
+		if (!tt_offset_ok) {
+			drop_tt(udev);
 			return -ERANGE;
-
-		update_sch_tt(udev, sch_ep);
+		}
+		update_sch_tt(tt, sch_ep);
 	}
 
 	/* update bus bandwidth info */
@@ -583,6 +582,8 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 
 	mtk->sch_array = sch_array;
 
+	INIT_LIST_HEAD(&mtk->bw_ep_list_new);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_mtk_sch_init);
@@ -597,18 +598,14 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		struct usb_host_endpoint *ep)
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
-	struct xhci_hcd *xhci;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_virt_device *virt_dev;
-	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep;
 	struct mu3h_sch_bw_info *sch_array;
 	unsigned int ep_index;
-	int bw_index;
-	int ret = 0;
 
-	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 	ep_index = xhci_get_endpoint_index(&ep->desc);
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
@@ -632,26 +629,14 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		return 0;
 	}
 
-	bw_index = get_bw_index(xhci, udev, ep);
-	sch_bw = &sch_array[bw_index];
-
 	sch_ep = create_sch_ep(udev, ep, ep_ctx);
+
 	if (IS_ERR_OR_NULL(sch_ep))
 		return -ENOMEM;
 
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
-
-	list_add_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
+	list_add_tail(&sch_ep->endpoint, &mtk->bw_ep_list_new);
 
 	ep_ctx->reserved[0] |= cpu_to_le32(EP_BPKTS(sch_ep->pkts)
 		| EP_BCSCOUNT(sch_ep->cs_count) | EP_BBM(sch_ep->burst_mode));
@@ -666,22 +651,17 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 }
 EXPORT_SYMBOL_GPL(xhci_mtk_add_ep_quirk);
 
-void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep)
+static void xhci_mtk_drop_ep(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
+			     struct mu3h_sch_ep_info *sch_ep)
 {
-	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
-	struct xhci_hcd *xhci;
+	struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
 	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_virt_device *virt_dev;
-	struct mu3h_sch_bw_info *sch_array;
 	struct mu3h_sch_bw_info *sch_bw;
-	struct mu3h_sch_ep_info *sch_ep;
-	int bw_index;
+	struct usb_host_endpoint *ep = sch_ep->ep;
 
-	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
-	sch_array = mtk->sch_array;
 
 	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpks:%d, dir:%d, ep:%p\n",
 		__func__, usb_endpoint_type(&ep->desc), udev->speed,
@@ -691,20 +671,79 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	if (!need_bw_sch(ep, udev->speed, slot_ctx->tt_info & TT_SLOT))
 		return;
 
-	bw_index = get_bw_index(xhci, udev, ep);
-	sch_bw = &sch_array[bw_index];
+	sch_bw = get_bw_info(mtk, udev, ep);
 
-	list_for_each_entry(sch_ep, &sch_bw->bw_ep_list, endpoint) {
+	update_bus_bw(sch_bw, sch_ep, 0);
+
+	list_del(&sch_ep->endpoint);
+
+	if (sch_ep->sch_tt) {
+		list_del(&sch_ep->tt_endpoint);
+		drop_tt(udev);
+	}
+	kfree(sch_ep);
+}
+
+void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
+		struct usb_host_endpoint *ep)
+{
+	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
+	struct mu3h_sch_bw_info *sch_bw;
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
+
+	sch_bw = get_bw_info(mtk, udev, ep);
+
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
+
+		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
+
+		list_move_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
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
index 5ac458b7d2e0..5ba25b62bf5b 100644
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
@@ -166,6 +167,8 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		struct usb_host_endpoint *ep);
 void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		struct usb_host_endpoint *ep);
+int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
+void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 
 #else
 static inline int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd,
@@ -179,6 +182,16 @@ static inline void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd,
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
index 0e297378063b..38c3c753bdbf 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2882,6 +2882,12 @@ static int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
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
@@ -2970,6 +2976,9 @@ static void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 		return;
 	xhci = hcd_to_xhci(hcd);
 
+	if (xhci->quirks & XHCI_MTK_HOST)
+		xhci_mtk_reset_bandwidth(hcd, udev);
+
 	xhci_dbg(xhci, "%s called for udev %p\n", __func__, udev);
 	virt_dev = xhci->devs[udev->slot_id];
 	/* Free any rings allocated for added endpoints */
-- 
2.29.2.454.gaff20da3a2-goog

