Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA72F4847
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbhAMKF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbhAMKF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:05:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F08C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:05:18 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d4so789529plh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4435Xpxy2byoXpOE3RdPb+PJ3jUMEAD9x2tjKbDyqo=;
        b=NRGZFCUDrMZb5tJ65hUJZK4VVDYCIAvtqtjZBEvbTeLyztm3/7l0nlXOKrW9Bfk7KN
         A2VYZzvOVN9i07me0OeCbHdOEOdmT7QGwYaL8AGyfK6Mt57JwP5H1MKe6ODWlHiSympu
         +sUir5N0oy4EG9KWsE/T51SmX5x9LMMPlVu9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4435Xpxy2byoXpOE3RdPb+PJ3jUMEAD9x2tjKbDyqo=;
        b=YEfmn/kP/FO2rj+iR7U62yArGF0M7tpnF+cxCfWkffJnJrxHTyuH96PKhcqdXpWfQq
         isnakyZ5FlxmsDVPS8JUpEX3I5uxwvYnCDIPTRUY7s9z677udSGwche2cgIiN8Oe8fEZ
         Agqdw+MDlow3Dgox6/RFNxQHsNcqsPA3obZf71xjI8tr3KnUY0PiajBRzilzjCw+0ism
         W2Dt6eK/ZY8/DM5KuLlHcK9Bib0euXIGxFX6IIfcY3ve5U6R6fHUMTQUygZzxZqJEGjJ
         /M/fdjzg6SaQMPzrOJYdjGqWswXC7fb/SPAJGnl9fsHMY0YbD37ac1BRiw9pmARb7eVI
         7cOw==
X-Gm-Message-State: AOAM530xf3K9u0tIvnvY4zuTnv9b6j4GMFf4qCh6uhD8WaRO5oa4MbR6
        T7xhJN2sW9e7IEXyllzMs5jSqw==
X-Google-Smtp-Source: ABdhPJxxK+XiXYrUme2oI9JqFwbNHefVZlbkheVM5CqlWnkJAgIHBAX5kLsO/urUVdOxXDJS7Telow==
X-Received: by 2002:a17:90a:940e:: with SMTP id r14mr1533628pjo.105.1610532317674;
        Wed, 13 Jan 2021 02:05:17 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id r67sm1917889pfc.82.2021.01.13.02.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 02:05:17 -0800 (PST)
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
Subject: [PATCH v6] usb: xhci-mtk: fix unreleased bandwidth data
Date:   Wed, 13 Jan 2021 18:05:11 +0800
Message-Id: <20210113180444.v6.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci-mtk needs XHCI_MTK_HOST quirk functions in add_endpoint() and
drop_endpoint() to handle its own sw bandwidth management.

It stores bandwidth data into an internal table every time
add_endpoint() is called, and drops those in drop_endpoint().
But when bandwidth allocation fails at one endpoint, all earlier
allocation from the same interface could still remain at the table.

This patch moves bandwidth management codes to check_bandwidth() and
reset_bandwidth() path. To do so, this patch also adds those functions
to xhci_driver_overrides and lets mtk-xhci to release all failed
endpoints in reset_bandwidth() path.

Fixes: 08e469de87a2 ("usb: xhci-mtk: supports bandwidth scheduling with multi-TT")
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

Changes in v6:
- use xhci overrides instead of quirk functions for
  {check|reset}_bandwidth().

Changes in v5:
- Fix a wrong commit id in Fixes tag

Changes in v4:
- bugfix in v3, check_bandwidth() return uninitialized value
  when no new endpoints were added.
- change Fixes tag to keep dependency

Changes in v3:
- drop unrelated code cleanups
- change Fixes tag to keep dependency

Changes in v2:
- fix a 0-day warning from unused variable
- split one big patch into three patches
- fix wrong offset in mediatek hw flags

 drivers/usb/host/xhci-mtk-sch.c | 123 ++++++++++++++++++++++----------
 drivers/usb/host/xhci-mtk.c     |   2 +
 drivers/usb/host/xhci-mtk.h     |  13 ++++
 drivers/usb/host/xhci.c         |   8 ++-
 drivers/usb/host/xhci.h         |   4 ++
 5 files changed, 111 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 45c54d56ecbd..a313e75ff1c6 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -200,6 +200,7 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 
 	sch_ep->sch_tt = tt;
 	sch_ep->ep = ep;
+	INIT_LIST_HEAD(&sch_ep->tt_endpoint);
 
 	return sch_ep;
 }
@@ -583,6 +584,8 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 
 	mtk->sch_array = sch_array;
 
+	INIT_LIST_HEAD(&mtk->bw_ep_list_new);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_mtk_sch_init);
@@ -601,19 +604,14 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_virt_device *virt_dev;
-	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep;
-	struct mu3h_sch_bw_info *sch_array;
 	unsigned int ep_index;
-	int bw_index;
-	int ret = 0;
 
 	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 	ep_index = xhci_get_endpoint_index(&ep->desc);
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
-	sch_array = mtk->sch_array;
 
 	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpkt:%d, dir:%d, ep:%p\n",
 		__func__, usb_endpoint_type(&ep->desc), udev->speed,
@@ -632,39 +630,34 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		return 0;
 	}
 
-	bw_index = get_bw_index(xhci, udev, ep);
-	sch_bw = &sch_array[bw_index];
-
 	sch_ep = create_sch_ep(udev, ep, ep_ctx);
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
+	struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
+	int bw_index = get_bw_index(xhci, udev, sch_ep->ep);
+	struct mu3h_sch_bw_info *sch_bw = &mtk->sch_array[bw_index];
 
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
 		struct usb_host_endpoint *ep)
@@ -675,7 +668,7 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	struct xhci_virt_device *virt_dev;
 	struct mu3h_sch_bw_info *sch_array;
 	struct mu3h_sch_bw_info *sch_bw;
-	struct mu3h_sch_ep_info *sch_ep;
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
 	int bw_index;
 
 	xhci = hcd_to_xhci(hcd);
@@ -694,17 +687,73 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	bw_index = get_bw_index(xhci, udev, ep);
 	sch_bw = &sch_array[bw_index];
 
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
-			break;
+			xhci_mtk_drop_ep(mtk, udev, sch_ep);
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
+	struct mu3h_sch_bw_info *sch_bw;
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
+	int bw_index, ret;
+
+	dev_dbg(&udev->dev, "%s\n", __func__);
+
+	list_for_each_entry(sch_ep, &mtk->bw_ep_list_new, endpoint) {
+		bw_index = get_bw_index(xhci, udev, sch_ep->ep);
+		sch_bw = &mtk->sch_array[bw_index];
+
+		ret = check_sch_bw(udev, sch_bw, sch_ep);
+		if (ret) {
+			xhci_err(xhci, "Not enough bandwidth!\n");
+			return -ENOSPC;
+		}
+	}
+
+	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_list_new, endpoint) {
+		struct xhci_ep_ctx *ep_ctx;
+		struct usb_host_endpoint *ep = sch_ep->ep;
+		unsigned int ep_index = xhci_get_endpoint_index(&ep->desc);
+
+		bw_index = get_bw_index(xhci, udev, ep);
+		sch_bw = &mtk->sch_array[bw_index];
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
+	return xhci_check_bandwidth(hcd, udev);
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
+
+	xhci_reset_bandwidth(hcd, udev);
+}
+EXPORT_SYMBOL_GPL(xhci_mtk_reset_bandwidth);
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index ee9af03a9593..c9b7b3527642 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -359,6 +359,8 @@ static void usb_wakeup_set(struct xhci_hcd_mtk *mtk, bool enable)
 static int xhci_mtk_setup(struct usb_hcd *hcd);
 static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
 	.reset = xhci_mtk_setup,
+	.check_bandwidth = xhci_mtk_check_bandwidth,
+	.reset_bandwidth = xhci_mtk_reset_bandwidth,
 };
 
 static struct hc_driver __read_mostly xhci_mtk_hc_driver;
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
index 2bf6c526ac7a..90d7818dfc23 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2833,7 +2833,7 @@ static void xhci_check_bw_drop_ep_streams(struct xhci_hcd *xhci,
  * else should be touching the xhci->devs[slot_id] structure, so we
  * don't need to take the xhci->lock for manipulating that.
  */
-static int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
+int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 {
 	int i;
 	int ret = 0;
@@ -2930,7 +2930,7 @@ static int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	return ret;
 }
 
-static void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
+void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 {
 	struct xhci_hcd *xhci;
 	struct xhci_virt_device	*virt_dev;
@@ -5348,6 +5348,10 @@ void xhci_init_driver(struct hc_driver *drv,
 			drv->reset = over->reset;
 		if (over->start)
 			drv->start = over->start;
+		if (over->check_bandwidth)
+			drv->check_bandwidth = over->check_bandwidth;
+		if (over->reset_bandwidth)
+			drv->reset_bandwidth = over->reset_bandwidth;
 	}
 }
 EXPORT_SYMBOL_GPL(xhci_init_driver);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 31be8625b570..7fbe6cfc9f68 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1918,6 +1918,8 @@ struct xhci_driver_overrides {
 	size_t extra_priv_size;
 	int (*reset)(struct usb_hcd *hcd);
 	int (*start)(struct usb_hcd *hcd);
+	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
+	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
 };
 
 #define	XHCI_CFC_DELAY		10
@@ -2070,6 +2072,8 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
 void xhci_shutdown(struct usb_hcd *hcd);
 void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
+int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
+void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

