Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025BB2ED19A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbhAGORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:17:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60844 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbhAGOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610029017; x=1641565017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0r6ZtrJr5p+eG//to76xKoSi5Qiv9tgIM+LgVgJD08U=;
  b=XsDo5L61K/KQBWy3D1v1Ayi4QQchBCvb8xFbyJmPehAJzV4GMZyZ+IB5
   lp4XJqn/uyWqdwRkU2kLy6It367hO+RvQYipnnONsoN8KMOmYINU7IPO3
   TuXj+bDfVVanYk7Kpa/DWCbRVeNIr+11o4fvAogzTcIVEzFI/27pw+Bmg
   Mc9yCIeXjQY6M2CKALdgpCZHoKM98/9uecdkUAFWoWKzdszCT/YwF4DR2
   Ft/qmuD4qka++NTw+BiRKFpvIojSy0kCdgFcTZmneCGe61VU5sNuDsDfZ
   1Iz0UTcR5UHmxfu5Usv5oUkT4LTjfDUgxGcOXN05KvEtyXoR+jRGn7846
   g==;
IronPort-SDR: 6vftMJsU8BfNSYQZXlRtTLne9EDb1uHQAN+Ck7bBk8z+zZwNnjgpk87S/Lg/zu06ISDHpC27P/
 wR+TCtYaqT9OOp9+wwiuB4r1w4XjHoHxWcVW8Xg3XhC2DxOyn2y3EYkfhzfto6UxwsyhaKyZYZ
 iKsKI75nUfuVgE7pFOd4KIk1U6sT313r+M5OWV7zdIYsOqbw4tDmR1lBi3JtTZZUdVHp9CTsER
 BOIcL1jbLegCUQdQMWqN0yuIzyZ4QOVjFJJu2P2yPHlTeCmsFxWre/8j+w4oGVobAl2zIX4mXH
 AxM=
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="99315412"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2021 07:15:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 07:15:41 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 7 Jan 2021 07:15:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] regulator: mcp16502: lpm pin can be optional on some platforms
Date:   Thu, 7 Jan 2021 16:15:26 +0200
Message-ID: <1610028927-9842-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
References: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platform (e.g. SAMA7G5) LPM pin should be optional as it can
be controlled explicitly (via shutdown controller registers) in the
platform specific power saving code to decrease the power consumption
while suspended as this SoC pin may be connected to other devices that
could take power saving actions based on its value.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 74ad92dc664a..88c6bd5b6c78 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -550,7 +550,7 @@ static int mcp16502_probe(struct i2c_client *client,
 	config.regmap = rmap;
 	config.driver_data = mcp;
 
-	mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
+	mcp->lpm = devm_gpiod_get_optional(dev, "lpm", GPIOD_OUT_LOW);
 	if (IS_ERR(mcp->lpm)) {
 		dev_err(dev, "failed to get lpm pin: %ld\n", PTR_ERR(mcp->lpm));
 		return PTR_ERR(mcp->lpm);
-- 
2.7.4

