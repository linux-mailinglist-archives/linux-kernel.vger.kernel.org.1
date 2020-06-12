Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFD1F7BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFLQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 12:47:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:58958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgFLQrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:47:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93F95AC64;
        Fri, 12 Jun 2020 16:47:26 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 1/5] arm: rpi: Add function to trigger VL805's firmware load
Date:   Fri, 12 Jun 2020 18:46:29 +0200
Message-Id: <20200612164632.25648-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612164632.25648-1-nsaenzjulienne@suse.de>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's (a xHCI chip) firmware
may either be loaded directly from an EEPROM or, if not present, by the
SoC's VideCore (the SoC's co-processor). Introduce the function that
informs VideCore that VL805 may need its firmware loaded.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---
Changes since v1:
 - Rename function so it's not mistaken with regular firmware loading
---
 arch/arm/mach-bcm283x/include/mach/mbox.h | 13 +++++++
 arch/arm/mach-bcm283x/include/mach/msg.h  |  7 ++++
 arch/arm/mach-bcm283x/msg.c               | 46 +++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm/mach-bcm283x/include/mach/mbox.h b/arch/arm/mach-bcm283x/include/mach/mbox.h
index 60e226ce1d..2ae2d3d97c 100644
--- a/arch/arm/mach-bcm283x/include/mach/mbox.h
+++ b/arch/arm/mach-bcm283x/include/mach/mbox.h
@@ -491,6 +491,19 @@ struct bcm2835_mbox_tag_set_palette {
 	} body;
 };
 
+#define BCM2835_MBOX_TAG_NOTIFY_XHCI_RESET          0x00030058
+
+struct bcm2835_mbox_tag_pci_dev_addr {
+	struct bcm2835_mbox_tag_hdr tag_hdr;
+	union {
+		struct {
+			u32 dev_addr;
+		} req;
+		struct {
+		} resp;
+	} body;
+};
+
 /*
  * Pass a raw u32 message to the VC, and receive a raw u32 back.
  *
diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-bcm283x/include/mach/msg.h
index 4afb08631b..e45c1bf010 100644
--- a/arch/arm/mach-bcm283x/include/mach/msg.h
+++ b/arch/arm/mach-bcm283x/include/mach/msg.h
@@ -48,4 +48,11 @@ int bcm2835_set_video_params(int *widthp, int *heightp, int depth_bpp,
 			     int pixel_order, int alpha_mode, ulong *fb_basep,
 			     ulong *fb_sizep, int *pitchp);
 
+/**
+ * bcm2711_load_vl805_firmware() - get vl805's firmware loaded
+ *
+ * @return 0 if OK, -EIO on error
+ */
+int bcm2711_notify_vl805_reset(void);
+
 #endif
diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
index 94b75283f8..347aece3cd 100644
--- a/arch/arm/mach-bcm283x/msg.c
+++ b/arch/arm/mach-bcm283x/msg.c
@@ -7,6 +7,7 @@
 #include <memalign.h>
 #include <phys2bus.h>
 #include <asm/arch/mbox.h>
+#include <linux/delay.h>
 
 struct msg_set_power_state {
 	struct bcm2835_mbox_hdr hdr;
@@ -40,6 +41,12 @@ struct msg_setup {
 	u32 end_tag;
 };
 
+struct msg_notify_vl805_reset {
+	struct bcm2835_mbox_hdr hdr;
+	struct bcm2835_mbox_tag_pci_dev_addr dev_addr;
+	u32 end_tag;
+};
+
 int bcm2835_power_on_module(u32 module)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_power_state, msg_pwr, 1);
@@ -151,3 +158,42 @@ int bcm2835_set_video_params(int *widthp, int *heightp, int depth_bpp,
 
 	return 0;
 }
+
+/*
+ * On the Raspberry Pi 4, after a PCI reset, VL805's (the xHCI chip) firmware
+ * may either be loaded directly from an EEPROM or, if not present, by the
+ * SoC's VideoCore. This informs VideoCore that VL805 needs its firmware
+ * loaded.
+ */
+int bcm2711_notify_vl805_reset(void)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(struct msg_notify_vl805_reset,
+				 msg_notify_vl805_reset, 1);
+	int ret;
+
+	BCM2835_MBOX_INIT_HDR(msg_notify_vl805_reset);
+	BCM2835_MBOX_INIT_TAG(&msg_notify_vl805_reset->dev_addr,
+			      NOTIFY_XHCI_RESET);
+
+	/*
+	 * The pci device address is expected like this:
+	 *
+	 *   PCI_BUS << 20 | PCI_SLOT << 15 | PCI_FUNC << 12
+	 *
+	 * But since RPi4's PCIe setup is hardwired, we know the address in
+	 * advance.
+	 */
+	msg_notify_vl805_reset->dev_addr.body.req.dev_addr = 0x100000;
+
+	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN,
+				     &msg_notify_vl805_reset->hdr);
+	if (ret) {
+		printf("bcm2711: Faild to load vl805's firmware, %d\n", ret);
+		return -EIO;
+	}
+
+	udelay(200);
+
+	return 0;
+}
+
-- 
2.26.2

