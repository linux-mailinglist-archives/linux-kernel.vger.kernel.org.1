Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8974E3002EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbhAVM3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:29:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18204 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbhAVMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611318245; x=1642854245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xolhp4dgjUflUoqeBH1NUJ0euOxQfNgfon0sTm4wQ74=;
  b=AUrocmAztTq7rXwHvmsJP1jKeyiy6CUc+qMWltUdcbwRBBt3HRSsmMFo
   NUqXyIstq5uBv/voHtFKGJSbxhQK8Tl6RmIgej2m7RWM6e1tFd+GydkIS
   Jcpy1Gy8zqYfmOzjOkCwD92CZrkLiawBbpmej0qfyO1leRDp4urbqXmho
   L8+8XU443rWJh4tVEJxElwiIyN4BCCZ2+7QjczvU0uryTTOuR7kWZYY4K
   Nr+5sLkIQPHKAsz5szCCiNjBtFzQXPgkdANDH+S+shFgCD0EFl8IOhFnM
   X+DjeP15V+KbENp9ZEeM4LYN3nUp+ijmEE8PBS+fcGa+nZDuouL3/Dcpx
   w==;
IronPort-SDR: drbhi+s8XmtQVheCwa3Df3MK84J5Bz8OFYQvH3GUR6PUR5Eq1uGuolitiTbQcEoiaLJ81WEUTE
 9eYQHcx/bgX3YPbFXCrv2oz4WQAy5kConWvHW5tejynbmlCzU9YwQHhbGfjgRlLqRgpJFJOJFu
 Bz+vp9rvdWjXZn7Rvy0hjpA4TmkbMlciFx4Jz0PHoofz3szF8NyjqtDS1xSLtWGqFbkzubZUpw
 35KerdbVHoGmcTd83KBlP2k0bm1cWf9FQsl+E6zfl9T2HKZ6X1TgzC948PasWKD9oODeToICE/
 Maw=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="103833137"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 05:22:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 05:22:16 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 05:22:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 7/7] drivers: soc: atmel: add support for sama7g5
Date:   Fri, 22 Jan 2021 14:21:37 +0200
Message-ID: <1611318097-8970-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
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
index 54339b8243cc..fb9d9cf8faf2 100644
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
@@ -222,6 +224,20 @@ static const struct at91_soc socs[] __initconst = {
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
 
@@ -259,6 +275,7 @@ static int __init at91_get_cidr_exid_from_chipid(u32 *cidr, u32 *exid)
 	void __iomem *regs;
 	static const struct of_device_id chipids[] = {
 		{ .compatible = "atmel,sama5d2-chipid" },
+		{ .compatible = "microchip,sama7g5-chipid" },
 		{ },
 	};
 
@@ -346,6 +363,7 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 	{ .compatible = "atmel,at91sam9", },
 	{ .compatible = "atmel,sama5", },
 	{ .compatible = "atmel,samv7", },
+	{ .compatible = "microchip,sama7g5", },
 	{ }
 };
 
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 0d2d27c30172..b2824b49096d 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -49,6 +49,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
+#define SAMA7G5_CIDR_MATCH		0x00162100
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
 #define AT91SAM9M10_EXID_MATCH		0x00000002
@@ -70,6 +71,11 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAM9X60_D1G_EXID_MATCH		0x00000010
 #define SAM9X60_D6K_EXID_MATCH		0x00000011
 
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

