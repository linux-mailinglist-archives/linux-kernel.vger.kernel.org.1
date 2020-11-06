Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B912A92A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgKFJ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:28:43 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56725 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgKFJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604654921; x=1636190921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jpoo8lswkA0HTqIME8fJoefP6IOmvgmdgVpF/Ams+UA=;
  b=PWoYHphCq6nar71ZuzTkOPd8rHMkBd366v5HWedPTlIEfTpgQ3PxAfT8
   vRv3V/Vz93k5DGyYGAFFI/JVCXrZncURYpccq51j8TXRit6a47eJILy/L
   3FWrn5VTmdBWGIQAbr2vHLbo3QWNly1T2zStmjDderKV+k6MbPsuGjDdy
   6Jsgua/dgovvGMuqLLJfsJAa6dO2dCU9z5jgdsPt/oT5vXS1uyeZAvWVz
   RVgRA8ErL2P91h5hSVlqxccjBvtl/NJVv2TFf8gjfg6xJyzsCfx4zOaoE
   F0gDMuZPKCWqy8WxcgoQzxm4NV+SR/Qe0fL8X9sjvJkEPFIG01f4uDOkw
   w==;
IronPort-SDR: RIrErMtxQQrdjS18MOl7nSMxJIZ58gX/nGIGWO6iFdoFl+HAzk9qXbsoYqIXFxIfG24vJ3EcVB
 Z8YEyEqrpcJ5TMUWYbor0nO94kZW7IN0AAH+tHdMX9HJ0meKvdxpiMn1xYqA4F1UFSskxe9F5w
 NEng4w8GyM67Xj/iseDg2VXDje5kE0o0X0lIVMBHeC7VdBBkwzclrZIy8W/TfG6BGNY+Tsq2gz
 S7nMVA5NshLpCoSCYLFg1dIQjVxTu6baFXhhL8eyC7wCbfdWmhMxiNQVsTorLJ6AZflXn9e3v/
 +4c=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="95340994"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:28:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:28:40 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:28:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 05/11] clk: at91: sama7g5: add 5th divisor for mck0 layout and characteristics
Date:   Fri, 6 Nov 2020 11:27:58 +0200
Message-ID: <1604654884-30339-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

This SoC has the 5th divisor for the mck0 master clock.
Adapt the characteristics accordingly.

Reported-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index d3c3469d47d9..d685e22b2014 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -775,13 +775,13 @@ static const struct clk_pll_characteristics pll_characteristics = {
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
 	.output = { .min = 140000000, .max = 200000000 },
-	.divisors = { 1, 2, 4, 3 },
+	.divisors = { 1, 2, 4, 3, 5 },
 	.have_div3_pres = 1,
 };
 
 /* MCK0 layout. */
 static const struct clk_master_layout mck0_layout = {
-	.mask = 0x373,
+	.mask = 0x773,
 	.pres_shift = 4,
 	.offset = 0x28,
 };
-- 
2.7.4

