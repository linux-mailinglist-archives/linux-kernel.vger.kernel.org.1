Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6942829E1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJDJqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 05:46:07 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58424 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 05:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601804766; x=1633340766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m8Hd3NJVgy0pMuGVmMZDY1WUDPw0wzQS5u6ANWw3p6k=;
  b=R5fvd+O7Hy4JOgCEmoH9WgThBfPucT+jNrcW2IoGhOPwvnZ0ho2s65OV
   M5IUuVXmHbMV4Od8XEg4MchHejpyqm/+tLK5A8M7f3R+NjHbZ0PmFn7XQ
   eq1pCEhCTPvQdZ/4g2OJrieqRlYRsX75z+2rDuVBBaLYgRuPTyBpzGFEx
   KARj+bbo2+CDyksRkJu4zEXFGPhULEqKehWnGXmIROG/ua8Ys30HfJxWS
   aXMXvL2SI9Giuf6DGLGHS6ZysU2cHmG92UkdWSkEpimsq5YXI5KT0vTB+
   iQ5AZS0qeVW4ob4jHlAt7b7/6ssG5xaP6v9Tvfap3QDTO2ECFXfE0CduQ
   w==;
IronPort-SDR: Ik2gpo+OGZphdE0IP9Co0VaoMz8ulnXnpmzAm9+wH5hpWmcXkJJyW+NWj3YvbmAGVQ+NMWEapY
 oH+hp9+t6dBgRySAyhT4ujFmPxr5w3dSxj/GaixHcZ0xp8otntx1CoDVoJSZwMKTHNT58koK0V
 Zc23IMQpjoapQvKEl8bNqr7Iuwg/UjHn/uhEdIFh+FYfhVS8Y84c0I+T9znAHubKFTC9D5m9Ts
 5FzWQ8Mtaw/sBuZbJG1hBWpdl7K8JPAuQ3HXagH487ynDV+EAc/avw7zoTAbTtOaXBIaj47LQ/
 nOQ=
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="scan'208";a="94131250"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2020 02:46:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 4 Oct 2020 02:46:05 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Sun, 4 Oct 2020 02:45:40 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ASoC: mchp-spdifrx: convert to devm_platform_get_and_ioremap_resource
Date:   Sun, 4 Oct 2020 12:45:05 +0300
Message-ID: <20201004094505.1041898-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper function that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index 6776d89d56df..726e4951d9a5 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -873,8 +873,7 @@ static int mchp_spdifrx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Map I/O registers. */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, mem);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.25.1

