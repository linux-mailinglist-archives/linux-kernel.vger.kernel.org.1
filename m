Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55328749C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgJHMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:55:39 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:11247 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgJHMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602161738; x=1633697738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z3iAkvPKJ18aA0Co3RGVC+Xkck5i+HidXXW24mW2/Pc=;
  b=sCrUwIxXRbxxLOKf04lQYNsHuyhhnPbLNPJaj1VHrwqmPLbw+KTRD3TL
   PsgJ6lpnbJXng89xC5e/4Pohzhe0ARAFBvIBqMbPFBc2WUFMAJyoxMBOX
   pocQUN4IYXzXV3koRR83B2q+Y4riHM+161Mg5X03i2eRUE2KxgqrNe7tW
   CnVu+UgsGjW6pp1NVhuG2boHBonXqmywelvbYKkCNnPZc7/sKylO1lfxQ
   qQfk9MX6qafGSOsuo09il7TTdmUjSQosL12GAGR8S3wRzRoPMsGT2nogX
   l/f6p7JmD1OcGPgYDYYVl94Y7HA8PYuoEd2r/Pjv3tuG3jffWAOEUbImk
   Q==;
IronPort-SDR: q21pxIvhXmWhfuy3l/Yoex1M2Zr9Ivla3LNQoLSQjuorPpDOgsT0xAMg4r5hjKUyLTfLyHsqC6
 wLivUxa72cT06SA4kISbkYHPTj/jxkRzYNIqA3Vs6Lkzu2KEgv/5fTuoVZofeAXjB0ZtgjKELC
 nApuri5W7TdtC2XNAC2Zf32dlmIWAtp3aE+rCQh2JXqx6uGa9UsVQi2tl4hRcV3suCJNESUif1
 SeVzq3Vy7cyxZoJuVR/QO5tgyvBE0ghUQ1B9J3Ul51ZKw0PXC61vRtmeKBD7F2gPEwp9U3+zb6
 GBU=
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="89547880"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Oct 2020 05:55:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 05:55:37 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 8 Oct 2020 05:55:36 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Kai Stuhlemmer <kai.stuhlemmer@ebee.de>
Subject: [PATCH] ARM: at91: sam9x60 SiP types added to soc description
Date:   Thu, 8 Oct 2020 14:50:28 +0200
Message-ID: <20201008125028.21071-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Stuhlemmer <kai.stuhlemmer@ebee.de>

Adding SAM9X60 SIP variants to the soc description list.

Signed-off-by: Kai Stuhlemmer <kai.stuhlemmer@ebee.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/soc/atmel/soc.c | 6 ++++++
 drivers/soc/atmel/soc.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 55a1f57a4d8c..c4472b68b7c2 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -69,6 +69,12 @@ static const struct at91_soc __initconst socs[] = {
 #endif
 #ifdef CONFIG_SOC_SAM9X60
 	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_EXID_MATCH, "sam9x60", "sam9x60"),
+	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_D5M_EXID_MATCH,
+		 "sam9x60 64MiB DDR2 SiP", "sam9x60"),
+	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_D1G_EXID_MATCH,
+		 "sam9x60 128MiB DDR2 SiP", "sam9x60"),
+	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_D6K_EXID_MATCH,
+		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
 #endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D21CU_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index ee652e4841a5..5849846a69d6 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -60,6 +60,9 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9CN11_EXID_MATCH		0x00000009
 
 #define SAM9X60_EXID_MATCH		0x00000000
+#define SAM9X60_D5M_EXID_MATCH		0x00000001
+#define SAM9X60_D1G_EXID_MATCH		0x00000010
+#define SAM9X60_D6K_EXID_MATCH		0x00000011
 
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
-- 
2.28.0

