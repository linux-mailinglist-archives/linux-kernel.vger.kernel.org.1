Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5F2A412A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgKCKGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:06:01 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59057 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCKGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604397960; x=1635933960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CpIQVbUPn7Qa9HKtqlGnFT7rJ7XYZdsaF2CbmGkma88=;
  b=bA/42TkTuiXLlPAEjJJQ4iD9rPooEfvwK/lrJkcm3jpJYbxfFcLTCvij
   uUQmlpRIdfzcgPzoR3jasTix5XfQ22db2g22tLxuMlWXqt2oJYt7yydhh
   PdIUJNPLgFli5piVh2F5lqNP670fmKWWbtie0NEF3qfDsbWFEkMoCYqZz
   e+NPz9wUaZ8hK0cisBjoqs+MyZ2yO62+a8lNuY0B28FhBVwa3raaexlt+
   /mw22flg6EwFMBUEqaqCrIDElI66MEl6xsh0VbK9UfbH6bIQDPCOD9cjN
   s7cFWUs27tTRQ6dxbQ+X3RNOkUkdGpasCPC3YSqhU8pYzQxTMvf14f6O1
   A==;
IronPort-SDR: vBlDUkTh34wc9Her5awDtIWlmIwQafxmUGuBMbNkIBXVq8t7Y9uVUulw53W0wcGPdJQM5ezvOt
 UmOCaFVxuOS18gbczcel9/SYdu0uqIxzxkIfmtKqTep6dJEuZooQI08M9ppkybrzgiaoUKzCLd
 yDg2SzWGergQwN5mtSI9yOCaqZvUD0afiiFvwJkANprOCuiiZqKOTeQ6NZ0TLNEuzlKszJS4mN
 G9n5jlZq7RUBBWMmaHPKVTuETCkF3sc8aNQGcUsDsUFOCKDMn/ZESA22LwanzcTtljjIfogmUJ
 apA=
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="32192205"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2020 03:06:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 03:06:00 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 3 Nov 2020 03:05:57 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ASoC: atmel-i2s: do not warn if muxclk is missing
Date:   Tue, 3 Nov 2020 12:05:54 +0200
Message-ID: <20201103100554.1307190-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the fact that muxclk is optional, muxclk can be set using
assigned-clocks, removing the need to set it in driver. The warning is
thus unneeded, so we can transform it in a debug print, eventually to just
reflect that muxclk was not set by the driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/atmel-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index bbe2b638abb5..232300dda548 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -563,8 +563,8 @@ static int atmel_i2s_sama5d2_mck_init(struct atmel_i2s_dev *dev,
 		err = PTR_ERR(muxclk);
 		if (err == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_warn(dev->dev,
-			 "failed to get the I2S clock control: %d\n", err);
+		dev_dbg(dev->dev,
+			"failed to get the I2S clock control: %d\n", err);
 		return 0;
 	}
 
-- 
2.25.1

