Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2810F3002D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbhAVMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:25:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27722 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbhAVMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611318188; x=1642854188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vw00xgEn68i9C4mmR34lRmSRWa9lb5jp8d2mih7WHzw=;
  b=XxtLdReB6jlwjePn+k8wcYF5r5lGrC2OaQR77/O6oa8F4enjMwpGrxoi
   DUemdc43VrNYI2k8rkU7flS8jdtRftK0ONNLoc8IuDI7EzB/ZSjSaVpt/
   UhGqbxj4H03M5lBlL1R/y5BM5uoDm4KdXxxprzODkA3PBh6B2kD29Dh6F
   +VXT9MCsR23hKf1e9eCijE8yHbc5GJrFknPTJANG5F1R5zSRQLV37p4qs
   EFRtD6PAiy6l6VtNHtad9ENv61FekV5hHUDg2AYzIZIQ7DeeRS3FSAdk0
   3QkQLRR5ZEXGLRGLpVtqOk1cH4T7OjinQrfB8+IKVxDaMl6Kzw1xvq4q2
   w==;
IronPort-SDR: xVQWQgeiiCEYOND7mGIgdrf6VCKbtQ6rJZinh3Gj/JMmIzdUNPHfqeU7hcI1y1m0lB5G8U9g0P
 enNSxh59Zl7Ft/bIl4R8QXPlrCf/mK1R6zcrTd0CeTou1E5MH08TobcPOidMVPdZcs+Umso0M9
 gfyOhUdISB59sxBlvcfv3fphaxZ7RmpOTt6A+MfSJfY9cXEqUhTDfMS+8kfB3bU5TdlwjBrjef
 e6zzbofHWADVWUiojCGXXdPIDsWyiKK2ppO/CAog/pWV4Iund+f7LX5cOQfV5G/K8OAsMugRU9
 zOc=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="106908940"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 05:21:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 05:21:52 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 05:21:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/7] drivers: soc: atmel: use GENMASK
Date:   Fri, 22 Jan 2021 14:21:32 +0200
Message-ID: <1611318097-8970-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GENMASK() to define CIDR match mask.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 1a6cb4bc7d67..ef591b622583 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -28,7 +28,7 @@
 #define AT91_CHIPID_EXID		0x04
 #define AT91_CIDR_VERSION(x)		((x) & 0x1f)
 #define AT91_CIDR_EXT			BIT(31)
-#define AT91_CIDR_MATCH_MASK		0x7fffffe0
+#define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)
 
 static const struct at91_soc __initconst socs[] = {
 #ifdef CONFIG_SOC_AT91RM9200
-- 
2.7.4

