Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4B2E082C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLVJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:35:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:64058 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbgLVJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:35:57 -0500
X-UUID: df371734ab3c44b999c85cbc534ca34f-20201222
X-UUID: df371734ab3c44b999c85cbc534ca34f-20201222
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1067787219; Tue, 22 Dec 2020 17:34:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 17:34:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 17:34:50 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhangyong.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Yaqii Wu <yaqii.wu@mediatek.com>
Subject: [RFC PATCH v3 1/5] usb: xhci-mtk: improve bandwidth scheduling with multi-TT
Date:   Tue, 22 Dec 2020 17:34:38 +0800
Message-ID: <1608629682-8535-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9F5E60664AA303661E69680B986883877310DF91EE64BD122A745F1CB41CA4E52000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhanyong Wang <zhanyong.wang@mediatek.com>

After inserted the usb type-c 3.5mm dongle with headset, dmesg showed:
usb 1-1.1: new full-speed USB device number 5 using xhci-mtk
usb 1-1.1: New USB device found, idVendor=05ac, idProduct=110a, bcdDevice=26.11
usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1.1: Product: USB-C to 3.5mm Headphone Jack Adapter
usb 1-1.1: Manufacturer: Apple, Inc.
usb 1-1.1: SerialNumber: DWH915501TFJKLTAM
xhci-mtk 11200000.xhci: Not enough bandwidth!
usb 1-1.1: can't set config #2, error -28

improve low-speed/full-speed INT/ISOC bandwidth scheduling with USB
muli-TT.

Signed-off-by: Yaqii Wu <yaqii.wu@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v3: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 91 ++++++++++++++++++++++++++++-----
 drivers/usb/host/xhci-mtk.h     |  8 ++-
 2 files changed, 84 insertions(+), 15 deletions(-)
 mode change 100644 => 100755 drivers/usb/host/xhci-mtk-sch.c

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
old mode 100644
new mode 100755
index 45c54d56ecbd..94292b9bbc63
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -383,7 +383,9 @@ static int check_sch_tt(struct usb_device *udev,
 	u32 fs_budget_start;
 	u32 start_ss, last_ss;
 	u32 start_cs, last_cs;
-	int i;
+	u32 num_esit, base;
+	int i, j;
+	u32 tmp;
 
 	start_ss = offset % 8;
 	fs_budget_start = (start_ss + 1) % 8;
@@ -398,10 +400,13 @@ static int check_sch_tt(struct usb_device *udev,
 		if (!(start_ss == 7 || last_ss < 6))
 			return -ERANGE;
 
-		for (i = 0; i < sch_ep->cs_count; i++)
-			if (test_bit(offset + i, tt->split_bit_map))
+		for (i = 0; i < sch_ep->cs_count; i++) {
+			if (test_bit(offset + i, tt->ss_bit_map))
 				return -ERANGE;
 
+			if (test_bit(offset + i, tt->cs_bit_map))
+				return -ERANGE;
+		}
 	} else {
 		u32 cs_count = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
 
@@ -428,8 +433,10 @@ static int check_sch_tt(struct usb_device *udev,
 		if (cs_count > 7)
 			cs_count = 7; /* HW limit */
 
-		for (i = 0; i < cs_count + 2; i++) {
-			if (test_bit(offset + i, tt->split_bit_map))
+		if (test_bit(offset, tt->ss_bit_map))
+			return -ERANGE;
+		for (i = 0; i < cs_count; i++) {
+			if (test_bit(offset + 2 + i, tt->cs_bit_map))
 				return -ERANGE;
 		}
 
@@ -445,11 +452,22 @@ static int check_sch_tt(struct usb_device *udev,
 			sch_ep->num_budget_microframes = sch_ep->esit;
 	}
 
+	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
+	for (i = 0; i < num_esit; i++) {
+		base = sch_ep->offset + i * sch_ep->esit;
+		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			tmp = tt->fs_bus_bw[base + j]
+			      + sch_ep->bw_cost_per_microframe;
+			if (tmp > FS_PAYLOAD_MAX)
+				return -ERANGE;
+		}
+	}
+
 	return 0;
 }
 
 static void update_sch_tt(struct usb_device *udev,
-	struct mu3h_sch_ep_info *sch_ep)
+	struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 base, num_esit;
@@ -458,11 +476,52 @@ static void update_sch_tt(struct usb_device *udev,
 	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
 	for (i = 0; i < num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
-		for (j = 0; j < sch_ep->num_budget_microframes; j++)
-			set_bit(base + j, tt->split_bit_map);
+		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			if (used)
+				set_bit(base + j, tt->split_bit_map);
+			else
+				clear_bit(base + j, tt->split_bit_map);
+		}
+
+		if (sch_ep->ep_type == ISOC_OUT_EP) {
+			for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+				if (used) {
+					set_bit(base + j, tt->ss_bit_map);
+					set_bit(base + j, tt->cs_bit_map);
+					tt->fs_bus_bw[base + j] +=
+						sch_ep->bw_cost_per_microframe;
+				} else {
+					clear_bit(base + j, tt->ss_bit_map);
+					clear_bit(base + j, tt->cs_bit_map);
+					tt->fs_bus_bw[base + j] -=
+						sch_ep->bw_cost_per_microframe;
+				}
+			}
+		} else {
+			if (used)
+				set_bit(base, tt->ss_bit_map);
+			else
+				clear_bit(base, tt->ss_bit_map);
+
+			for (j = 0; j < sch_ep->cs_count; j++) {
+				if (used) {
+					set_bit(base + 2 + j, tt->cs_bit_map);
+
+					tt->fs_bus_bw[base + 2 + j] +=
+						sch_ep->bw_cost_per_microframe;
+				} else {
+					clear_bit(base + 2 + j, tt->cs_bit_map);
+					tt->fs_bus_bw[base + 2 + j] -=
+						sch_ep->bw_cost_per_microframe;
+				}
+			}
+		}
 	}
 
-	list_add_tail(&sch_ep->tt_endpoint, &tt->ep_list);
+	if (used)
+		list_add_tail(&sch_ep->tt_endpoint, &tt->ep_list);
+	else
+		list_del(&sch_ep->tt_endpoint);
 }
 
 static int check_sch_bw(struct usb_device *udev,
@@ -470,6 +529,7 @@ static int check_sch_bw(struct usb_device *udev,
 {
 	u32 offset;
 	u32 esit;
+	u32 boundary;
 	u32 min_bw;
 	u32 min_index;
 	u32 worst_bw;
@@ -487,10 +547,13 @@ static int check_sch_bw(struct usb_device *udev,
 	 */
 	min_bw = ~0;
 	min_index = 0;
+	boundary = esit;
 	min_cs_count = sch_ep->cs_count;
 	min_num_budget = sch_ep->num_budget_microframes;
 	for (offset = 0; offset < esit; offset++) {
 		if (is_fs_or_ls(udev->speed)) {
+			if (sch_ep->ep_type != ISOC_OUT_EP)
+				boundary = esit + 1;
 			ret = check_sch_tt(udev, sch_ep, offset);
 			if (ret)
 				continue;
@@ -498,7 +561,7 @@ static int check_sch_bw(struct usb_device *udev,
 				tt_offset_ok = true;
 		}
 
-		if ((offset + sch_ep->num_budget_microframes) > sch_ep->esit)
+		if ((offset + sch_ep->num_budget_microframes) > boundary)
 			break;
 
 		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
@@ -532,7 +595,7 @@ static int check_sch_bw(struct usb_device *udev,
 		if (!tt_offset_ok)
 			return -ERANGE;
 
-		update_sch_tt(udev, sch_ep);
+		update_sch_tt(udev, sch_ep, 1);
 	}
 
 	/* update bus bandwidth info */
@@ -696,12 +759,12 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	list_for_each_entry(sch_ep, &sch_bw->bw_ep_list, endpoint) {
 		if (sch_ep->ep == ep) {
-			update_bus_bw(sch_bw, sch_ep, 0);
-			list_del(&sch_ep->endpoint);
 			if (is_fs_or_ls(udev->speed)) {
-				list_del(&sch_ep->tt_endpoint);
+				update_sch_tt(udev, sch_ep, 0);
 				drop_tt(udev);
 			}
+			update_bus_bw(sch_bw, sch_ep, 0);
+			list_del(&sch_ep->endpoint);
 			kfree(sch_ep);
 			break;
 		}
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index a93cfe817904..323b281933b9 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -21,12 +21,18 @@
 
 /**
  * @split_bit_map: used to avoid split microframes overlay
+ * @ss_bit_map: used to avoid start split microframes overlay
+ * @cs_bit_map: used to avoid complete split microframes overlay
+ * @fs_bus_bw: array to keep track of bandwidth already used at full speed
  * @ep_list: Endpoints using this TT
  * @usb_tt: usb TT related
  * @tt_port: TT port number
  */
 struct mu3h_sch_tt {
 	DECLARE_BITMAP(split_bit_map, XHCI_MTK_MAX_ESIT);
+	DECLARE_BITMAP(ss_bit_map, XHCI_MTK_MAX_ESIT);
+	DECLARE_BITMAP(cs_bit_map, XHCI_MTK_MAX_ESIT + 1);
+	u32 fs_bus_bw[XHCI_MTK_MAX_ESIT];
 	struct list_head ep_list;
 	struct usb_tt *usb_tt;
 	int tt_port;
@@ -42,7 +48,7 @@ struct mu3h_sch_tt {
  * two bandwidth domains, one for IN eps and another for OUT eps.
  */
 struct mu3h_sch_bw_info {
-	u32 bus_bw[XHCI_MTK_MAX_ESIT];
+	u32 bus_bw[XHCI_MTK_MAX_ESIT + 1];
 	struct list_head bw_ep_list;
 };
 
-- 
2.18.0

