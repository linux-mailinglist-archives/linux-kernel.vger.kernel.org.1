Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE33002DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhAVM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:26:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37486 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbhAVMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611318211; x=1642854211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=poKO1QLD7vI0zCPnPL2EEcKhUF8lVOuEF/XvYo+LqT8=;
  b=PgwEP33rodw35pbEaZyh1OA6zBuGUBTbsVD55Dcs8VTToBlW8ly22Q5Z
   eLKnC1q9I3P2G2JfyPFTXqxe3nYfzKlVGk85UBtlYHv5ZxyBacWxPGxQJ
   1xP4cRr+0TTsis+XcAJs58+IikbLw80dcgSVcbuTiuOnrB2fDz7XESdLq
   ih9gIQ3fZyorUj04bvzc6fWrYJ8hzqkmRqhsLQLu3wO5Hz7jG2i/NmLhI
   cImRCQsYfCUAn/MaxM1R84mZ4/WxqCnxIFwqxWmrWv7jB1AicI+pEioVM
   VEwNpRkTgN5tJ/ueVwJqd10vpRdRef2hHO2d/9e6VKfigZHvpZa4lPeBl
   w==;
IronPort-SDR: zeRhjFLAE7mQi8FbHPLx8jxnmM5ZM41fqOs4fRI9fU/8qayj6MCjx0tJzB46e2pOABnVjsO4Xv
 pWbOOkpfb91iZBfXOMWHcs2TRZazjegbHHm6HCTKm94Knf/uEUWK3Bk8a1vKkfb8HsYZXfB5rk
 N987pAVQYkRYQ6g0qfSGohrxySZd06xMsKRyCwAAtw96JE4d+mMGxTZltsP33u1JWyJ4wIA+J0
 aTr7xDmRubEtN+5AYTLF6BYEwQGS+dqF/lzXM+FHXyQ0i9ZUZYIDcVj3hUlHlX0BRzRFRX8l9d
 wWo=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="106393561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 05:22:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 05:22:11 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 05:22:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/7] dt-bindings: atmel-sysreg: add "microchip,sama7g5-chipid"
Date:   Fri, 22 Jan 2021 14:21:36 +0200
Message-ID: <1611318097-8970-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding for SAMA7G5's CHIPID.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 62cd4e89817c..67719f15eb4c 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -1,7 +1,7 @@
 Atmel system registers
 
 Chipid required properties:
-- compatible: Should be "atmel,sama5d2-chipid"
+- compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
 - reg : Should contain registers location and length
 
 PIT Timer required properties:
-- 
2.7.4

