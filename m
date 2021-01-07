Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C716E2ED1B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbhAGOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:16:54 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60829 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbhAGOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610029012; x=1641565012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=L//+ipVMtry19HxS3lm/Lz4ZRAdxHYA5e8itIJykReU=;
  b=nQ3NPswMmKqyPniMWEHS6DcQ8N43/8NHmPBrzkw2s7T62/zJbyAA1aja
   xn4giKosSjkEJ1od46DqtmjRCggvG/yFjQEkQ02+ySM8w4KrHUVgd6tEN
   vWHT5n4J6XGptIOKeXcTNuJsIaoXZfUzAtWMQv8I539NBYr6bRSbyEngT
   dMK77Oimsy2DkcCa2dnYA+PVLtzvzwhYoPJPRk4H27g7e9zFH9CZxhonK
   0jwRvSejRCktZuCgIVhjUeOrmLwH7SN8+EnfrOsur+xFblQmapj8ncFyU
   UrwQfnRei48kO212jEoszdKPuQmBgYLvCXA5VaFqcq362STDhF1SBY9jh
   A==;
IronPort-SDR: 3F7v/TmC9PrVficNcCmINf62I839NAfl+BOE+li44DIW2TgH+4fbzajF5nSCYTv6k5Y2SI39es
 oi3ga6lZ2E6RIBXKco31h8lbv9gbW1OCbFBpTBCDbuHmlpdr284I5HIbdsLqIjeu1spFH6DiIk
 6Hoesh7DmUOn0oS1036MoMDKnMp4Qs442l+vtcQjj9Prgc1dEKkID+dFzZ4F2UIhrF1eM7LdSz
 zOes5qlCSb9uU0IKVhUNAVYhd58+WJI6JLox7AefduYTvl8DvI7JHWIT0tFxOfSW0GtTPHVJ5D
 b+Y=
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="99315398"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2021 07:15:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 07:15:37 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 7 Jan 2021 07:15:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] dt-bindings: regulator: mcp16502: document lpm as optional
Date:   Thu, 7 Jan 2021 16:15:25 +0200
Message-ID: <1610028927-9842-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
References: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document LPM pin as optional.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
index d86584ed4d93..451cc4e86b01 100644
--- a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -4,7 +4,8 @@ Required properties:
 - compatible: "microchip,mcp16502"
 - reg: I2C slave address
 - lpm-gpios: GPIO for LPM pin. Note that this GPIO *must* remain high during
-	     suspend-to-ram, keeping the PMIC into HIBERNATE mode.
+	     suspend-to-ram, keeping the PMIC into HIBERNATE mode; this
+	     property is optional;
 - regulators: A node that houses a sub-node for each regulator within
               the device. Each sub-node is identified using the node's
               name. The content of each sub-node is defined by the
-- 
2.7.4

