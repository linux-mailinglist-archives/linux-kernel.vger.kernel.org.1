Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607E3303B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392497AbhAZL3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:29:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:20082 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391306AbhAZJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611653942; x=1643189942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=13AMwCZ6qcfg0VkHbBn4I9vHrDIxJT8mXVzUrrVXQvo=;
  b=oV4HnHYQzc119a7Xuld7/hxFz54lxwgfuG+c6ZJm2qfmEiiKOEBK1Qxq
   9sGgtHpRY+yN5v+UheAnwN/DxMTAvQuMFVeHKKULSnrZ0/iwv12iYxpYl
   HaaJXkqRJKzg+viN8n1+I5V4HH6SYWN+8bQtmgydUTe+HzUXNBtdWmGn+
   28ImPEulQqmG2+TYAVanJJzOTeIOeAUXv6f4avCJO3BaJdnuMvkWSe4kt
   NNgNFfAj7d8WOigWgzcvaOYuNOyZEy9NuZNd4Xpr/Hvd7K/ITYWMkDkUx
   0Bo/QKTe9p7dRNFOk9YkZAiN5UFvn9KsvKHwdsBlQd4DCHJIh7DUN8Ag5
   A==;
IronPort-SDR: 8oi87UC4YRBuVdFxvpygPis0sAnwqN9N/qpI2vg0Pl76DvqVIoi3m03AabSAjECGHxgE/Wgagc
 ezvzcvJqYzp8EvuHPIfZZVXIYjJXJr0FiVFw923LBc03Zcy1Tnihl+ejaRUod+niITxJUGmCj4
 pDJopUxaa3zDj499dc+QF2ch4RSNg5AdjuYzKXDh6GLXiarYyEbUShkn/IsJ5bil+mPPlZgyZr
 6ec/5z+L1lzPCWSoeb7vM0kNhOCkvSFZ4two3g+8hwWcpOcIEkmwCc/hO//L87tvDy5T8omYMt
 mYA=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="101448962"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:37:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:37:03 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 26 Jan 2021 02:37:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 7/7] drivers: soc: atmel: add support for sama7g5
Date:   Tue, 26 Jan 2021 11:29:36 +0200
Message-ID: <1611653376-24168-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SAMA7G5 SoCs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 18 ++++++++++++++++++
 drivers/soc/atmel/soc.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 813052dc9fce..e7c873134f59 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -28,8 +28,10 @@
 #define AT91_CHIPID_EXID		0x04
 #define AT91_CIDR_VERSION(x, m)		((x) & (m))
 #define AT91_CIDR_VERSION_MASK		GENMASK(4, 0)
+#define AT91_CIDR_VERSION_MASK_SAMA7G5	GENMASK(3, 0)
 #define AT91_CIDR_EXT			BIT(31)
 #define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)
+#define AT91_CIDR_MASK_SAMA7G5		GENMASK(27, 5)
 
 static const struct at91_soc socs[] __initconst = {
 #ifdef CONFIG_SOC_AT91RM9200
@@ -212,6 +214,20 @@ static const struct at91_soc socs[] __initconst = {
 		 AT91_CIDR_VERSION_MASK, SAMV70Q19_EXID_MATCH,
 		 "samv70q19", "samv7"),
 #endif
+#ifdef CONFIG_SOC_SAMA7
+	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G51_EXID_MATCH,
+		 "sama7g51", "sama7g5"),
+	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G52_EXID_MATCH,
+		 "sama7g52", "sama7g5"),
+	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G53_EXID_MATCH,
+		 "sama7g53", "sama7g5"),
+	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G54_EXID_MATCH,
+		 "sama7g54", "sama7g5"),
+#endif
 	{ /* sentinel */ },
 };
 
@@ -249,6 +265,7 @@ static int __init at91_get_cidr_exid_from_chipid(u32 *cidr, u32 *exid)
 	void __iomem *regs;
 	static const struct of_device_id chipids[] = {
 		{ .compatible = "atmel,sama5d2-chipid" },
+		{ .compatible = "microchip,sama7g5-chipid" },
 		{ },
 	};
 
@@ -336,6 +353,7 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 	{ .compatible = "atmel,at91sam9", },
 	{ .compatible = "atmel,sama5", },
 	{ .compatible = "atmel,samv7", },
+	{ .compatible = "microchip,sama7g5", },
 	{ }
 };
 
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 8a51cd973103..14c249c98c49 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -49,6 +49,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
+#define SAMA7G5_CIDR_MATCH		0x00162100
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
 #define AT91SAM9M10_EXID_MATCH		0x00000002
@@ -67,6 +68,11 @@ at91_soc_init(const struct at91_soc *socs);
 
 #define SAM9X60_EXID_MATCH		0x00000000
 
+#define SAMA7G51_EXID_MATCH		0x3
+#define SAMA7G52_EXID_MATCH		0x2
+#define SAMA7G53_EXID_MATCH		0x1
+#define SAMA7G54_EXID_MATCH		0x0
+
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
 #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-- 
2.7.4

